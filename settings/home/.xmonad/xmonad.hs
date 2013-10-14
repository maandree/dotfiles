-- -*- mode: haskell -*-
import XMonad hiding ( (|||) )
import qualified XMonad.StackSet as W -- hiding ( workspaces, focus )

import XMonad.Actions.CycleWS
import XMonad.Actions.UpdatePointer
import XMonad.Actions.MouseResize
import XMonad.Actions.WindowMenu

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.UrgencyHook

import XMonad.Layout.IM
import XMonad.Layout.LayoutCombinators
import XMonad.Layout.LayoutHints
import XMonad.Layout.LayoutCombinators
import XMonad.Layout.NoBorders
import XMonad.Layout.PerWorkspace
import XMonad.Layout.ResizableTile
import XMonad.Layout.Grid
import XMonad.Layout.Accordion
import XMonad.Layout.Circle
import XMonad.Layout.WindowArranger
import XMonad.Layout.SimpleFloat

import XMonad.Util.EZConfig
import XMonad.Util.Loggers
import XMonad.Util.Run
import XMonad.Util.Scratchpad
import XMonad.Util.WindowProperties
import XMonad.Util.WorkspaceCompare
import XMonad.Util.Replace
import XMonad.Util.Themes

import XMonad.Layout.Tabbed
import XMonad.Layout.DecorationMadness
import XMonad.Layout.DecorationAddons
import XMonad.Layout.Decoration
import XMonad.Layout.SimpleDecoration
import XMonad.Layout.DwmStyle
import XMonad.Layout.TabBarDecoration
import XMonad.Layout.ImageButtonDecoration
import XMonad.Layout.BorderResize
import XMonad.Layout.SimpleFloat
import XMonad.Layout.Maximize
import XMonad.Layout.Minimize

import qualified Data.Map as M


---- ==== Keypad numbers ==== ----
numPadKeys = [ xK_KP_End,  xK_KP_Down,  xK_KP_Page_Down -- 1, 2, 3
             , xK_KP_Left, xK_KP_Begin, xK_KP_Right     -- 4, 5, 6
             , xK_KP_Home, xK_KP_Up,    xK_KP_Page_Up   -- 7, 8, 9
             , xK_KP_Insert]                            -- 0

---- ==== Kill panels and restart ==== ----
myClean =   "for x in `pgrep ^conky\\$`     ; do kill -9 $x; done ; " ++
            "for x in `pgrep ^xmobar\\$`    ; do kill -9 $x; done ; " ++
            "for x in `pgrep ^dzen2\\$`     ; do kill -9 $x; done ; " ++
            "for x in `pgrep ^trayer\\$`    ; do kill -9 $x; done"

myRestart = myClean ++ " ; " ++
            "(xmonad --recompile && xmonad --restart)"


---- ==== Naming of workspaces ==== ----
myWorkspaces = ["1-term","2-web","3","4","5","6","7-misc","8-mail","9-video"]


---- ==== Mouse bindings ==== ----
stackRotate (W.Stack f [] rs)   = W.Stack f [] rs
stackRotate (W.Stack f ls rs)  = W.Stack l (f:(reverse ls')) rs
                               where
                                 (l:ls') = reverse ls

stackUnrotate (W.Stack f [] rs)     = W.Stack f [] rs
stackUnrotate (W.Stack f (l:ls) rs) = W.Stack l (ls ++ [f]) rs

stackUnrotateRight (W.Stack f ls [])   = W.Stack f ls []
stackUnrotateRight (W.Stack f ls rs)  = W.Stack r ls (f:(reverse rs'))
                               where
                                 (r:rs') = reverse rs

stackRotateRight (W.Stack f ls [])     = W.Stack f ls []
stackRotateRight (W.Stack f ls (r:rs)) = W.Stack r ls (rs ++ [f])



myMouse = [ (( mod4Mask, button4), (\w -> focus w >> windows (W.modify' stackRotate)))
          , (( mod4Mask, button5), (\w -> focus w >> windows (W.modify' stackUnrotate)))
          , (( mod4Mask .|. controlMask, button4), (\w -> focus w >> windows (W.modify' stackRotateRight)))
          , (( mod4Mask .|. controlMask, button5), (\w -> focus w >> windows (W.modify' stackUnrotateRight)))
          ]


---- ==== Mane method ==== ----
main = do
  ---- System status panel
  d <- spawnPipe "dzen2 -p -xs 1 -ta l -e 'onstart=lower' -fn 'fixed-8' -bg black -fg grey"
  
  ---- System monitor
  -- spawn $ "conky -c ~/.xmonad/data/conky/dzen | dzen2 -p -xs 2 ta -r -e 'onstart=lower'"
  spawn "xmobar"
  
  ---- Tray icon panel
  -- spawn "trayer --SetPartialStrut true --SetDockType true --transparent true --alpha 0 --tint 0x00000 --edge top"

  ---- Dude… settings
  xmonad $ defaultConfig                         -- Modify settings with inherited default settings
    { terminal          = "terminator"           --   Splitable terminal
    , focusFollowsMouse = True                   --   Hover for focus
    , modMask           = mod4Mask               --   Super_L
    , borderWidth       = 0                      --   No F:ing borders
    , workspaces        = myWorkspaces           --   Name my workspaces
    , logHook           = myLogHook d            --   Top(system) panel hook
    , manageHook        = myManageHook           --   Manage hook
    , layoutHook        = myLayoutHook           --   Layout algorithms
    , mouseBindings     = \x -> M.union (mouseBindings defaultConfig x) (M.fromList myMouse)
    }`additionalKeys`                            -- Modifiy keybindings
    [ (( mod4Mask, xK_F4), kill)                 --   <Super>F4   ::  Kill window
    , (( mod4Mask, xK_F12), spawn "terminator")  --   <Super>F12  ::  Open terminal
    , (( mod4Mask, xK_q), spawn myRestart)       --   modified restart command
    , (( mod4Mask, xK_F5), sendMessage $ JumpToLayout (decoName ++ " Tall"))
    , (( mod4Mask, xK_F6), sendMessage $ JumpToLayout (decoName ++ " Mirror Tall"))
    , (( mod4Mask, xK_F7), sendMessage $ JumpToLayout (decoName ++ " Grid"))
    , (( mod4Mask, xK_F8), sendMessage $ JumpToLayout "Full")
    , (( mod4Mask .|. controlMask, xK_m), withFocused (sendMessage . maximizeRestore))
    , (( mod4Mask, xK_m), withFocused minimizeWindow)
    , (( mod4Mask .|. shiftMask , xK_m), sendMessage RestoreNextMinimizedWin)
    ]



---- ==== layout settigns ==== ----
ratios = [ toRational (2/(1 + sqrt 5 :: Double)) -- golden ratio
         , toRational (sqrt 2 - 1 :: Double)     -- silver ratio
         , 1 / 2                                 -- half
         ]

myTheme = {- Theme -} defaultThemeWithImageButtons { activeColor = "#333333"
                , inactiveColor = "#000000"
                , urgentColor = "#880000"
                , activeBorderColor = "#888888"
                , inactiveBorderColor = "#888888"
                , urgentBorderColor = "#FF0000"
                , activeTextColor = "#EEEEEE"
                , inactiveTextColor = "#EEEEEE"
                , urgentTextColor = "#FFFFFF"
                , fontName = "-misc-fixed-*-*-*-*-10-*-*-*-*-*-*-*"
                , decoWidth = 100
                , decoHeight = 14
                , windowTitleAddons = []
                {- , windowTitleIcons = [] -}
                }

--deco l = decoration shrinkText defaultThemeWithButtons DefaultDecoration l
--deco l = decoration shrinkText defaultThemeWithButtons (Simple True) l
--deco l = decoration shrinkText myTheme DefaultDecoration l
--deco l = imageButtonDeco shrinkText defaultThemeWithImageButtons (maximize $ minimize l)
deco l = imageButtonDeco shrinkText myTheme (maximize $ minimize l)
--deco l = l

decoName = "ImageButtonDeco Maximize Minimize"

-- http://xmonad.org/xmonad-docs/xmonad-contrib/XMonad-Layout-Decoration.html
-- http://xmonad.org/xmonad-docs/xmonad-contrib/XMonad-Layout-DecorationMadness.html

myManageHook = manageDocks <+> manageHook defaultConfig
myLayoutHook = avoidStruts $ myLayouts
myLayouts    = deco (tiled 2) ||| deco (Mirror (tiled 2)) ||| full ||| deco Grid ||| deco (Mirror Grid) ||| full
             -- Accordion ||| Circle
tiled n      = Tall nmaster delta (ratios!!n)
full         = noBorders Full
nmaster      = 1
delta        = 1/100
--myFloat      = floatSimpleDefault
--myFloat      = deco $ borderResize SimpleFloat


---- ==== dzen2 (top panel) settings ==== ----
myLogHook h = dynamicLogWithPP $ defaultPP
  { ppCurrent         = dzenColor "#303030" "#909090" . pad
  , ppHidden          = dzenColor "#909090" "" . pad
  , ppHiddenNoWindows = dzenColor "#606060" "" . pad
  , ppLayout          = dzenColor "#909090" "" . pad
  , ppUrgent          = dzenColor "#ff0000" "" . pad . dzenStrip
  , ppTitle           = shorten 100
  , ppWsSep           = ""
  , ppSep             = "  "
  , ppOutput          = hPutStrLn h
  }

-- http://xmonad.org/xmonad-docs/xmonad-contrib/XMonad-Layout-WindowArranger.html
