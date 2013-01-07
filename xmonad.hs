-- -*- mode: haskell -*-
import XMonad hiding ( (|||) )

import XMonad.Actions.CycleWS
import XMonad.Actions.UpdatePointer

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

import XMonad.Util.EZConfig
import XMonad.Util.Loggers
import XMonad.Util.Run
import XMonad.Util.Scratchpad
import XMonad.Util.WindowProperties
import XMonad.Util.WorkspaceCompare
import XMonad.Util.Replace


---- ==== Keypad numbers ==== ----
numPadKeys = [ xK_KP_End,  xK_KP_Down,  xK_KP_Page_Down -- 1, 2, 3
             , xK_KP_Left, xK_KP_Begin, xK_KP_Right     -- 4, 5, 6
             , xK_KP_Home, xK_KP_Up,    xK_KP_Page_Up   -- 7, 8, 9
             , xK_KP_Insert]                            -- 0

---- ==== Kill panels and restart ==== ----
myClean =   "for x in `pgrep conky`     ; do kill -9 $x; done ; " ++
            "for x in `pgrep xmobar`    ; do kill -9 $x; done ; " ++
            "for x in `pgrep dzen2`     ; do kill -9 $x; done ; " ++
            "for x in `pgrep trayer`    ; do kill -9 $x; done ; " ++
            "for x in `pgrep appenddate`; do kill -9 $x; done"

myRestart = myClean ++ " ; " ++
            "(xmonad --recompile && xmonad --restart)"


------ ==== X-server stuff ==== ----
--myXSet = "xrandr --output DVI-0 --gamma 0.97:0.97:0.97 --brightness 1.00 --mode 1600x1200 --rate 85 --primary " ++          -- Right(primary) screen layout, resulotion and calibration
--                "--output VGA-0 --gamma 0.99:0.99:0.99 --brightness 0.85 --mode 1600x1200 --rate 75 --left-of DVI-0 ; " ++  -- Left(secondary(video &c)) screen layout, resulotion and calibration
--         "xrdb -load /etc/X11/xinitrc/.Xresources ; " ++                                                                    -- Font settings are here
--         "xcompmgr -r 12 -o 0.75 -l 5 -t 5 -I 0.1 -O 0.1 -D 10 -cfn ; " ++                                                  -- Composition manager (allows transparancy)
--         "setxkbmap -rules evdev " ++                                                                                       -- Keyboard
--                   "-model pc105 " ++                                                                                       --   105-key PC keyboard
--                   "-layout se,gr,se -variant ,,svdvorak " ++                                                               --   Layouts: swedish, greek, swedish(svdvordak)
--                   "-option terminate:ctrl_alt_bksp,ctrl:capsswap,compose:rwin,grp:lctrl_lshift_toggle,keypad:future " ++   --   Awesome additional settings
--                   "-types complete -compat complete " ++                                                                   --   Something else
--                   "-synch ; " ++                                                                                           --   Force synchronisation with x-server
--         "xmodmap /etc/X11/xinit/.Xmodmap ; " ++                                                                            -- Keyboard modification
--         "feh --bg-max ~/p1000222.jpg"                                                                                      -- Background



---- ==== Naming of workspaces ==== ----
myWorkspaces = ["1-term","2-web","3","4","5","6","7-misc","8-mail","9-video"]


---- ==== Mane method ==== ----
main = do
  ---- Reset x-server stuff
  --spawn myXSet
  
  
  ---- System status panel
  d <- spawnPipe "dzen2 -p -xs 1 -ta l -e 'onstart=lower' -fn 'fixed-8'"
  
  ---- System monitor
  -- spawn $ "conky -c ~/.xmonad/data/conky/dzen | dzen2 -p -xs 2 ta -r -e 'onstart=lower'"
  spawn "xmobar"
  
  ---- Tray icon panel
  --spawn "trayer --SetPartialStrut true --SetDockType true --transparent true --alpha 0 --tint 0x00000 --edge bottom"
  
  
  ---- Dude… settings
  xmonad $ defaultConfig                         -- Modify settings with inherited default settings
    { terminal    = "terminator"                 --   Splitable terminal
    , modMask     = mod4Mask                     --   Super_L
    , borderWidth = 0                            --   No F:ing borders
    , workspaces  = myWorkspaces                 --   Name my workspaces
    , logHook     = myLogHook d                  --   Top(system) panel hook
    , manageHook  = myManageHook                 --   Manage hook
    , layoutHook  = myLayoutHook                 --   Layout algorithms
    }`additionalKeys`                            -- Modifiy keybindings
    [ (( mod4Mask, xK_F4), kill)                 --   <Super>F4   ::  Kill window
    , (( mod4Mask, xK_T), spawn "terminator")    --   <Super>F12  ::  Open terminal
    , (( mod4Mask, xK_Q), spawn myRestart)       --   modified restart command
    ]



---- ==== layout settigns ==== ----
ratios = [ toRational (2/(1 + sqrt 5 :: Double)) -- golden ratio
         , toRational (sqrt 2 - 1 :: Double)     -- silver ratio
         , 1 / 2                                 -- half
         ]

myManageHook = manageDocks <+> manageHook defaultConfig
myLayoutHook = avoidStruts $ myLayouts
myLayouts    = tiled 2 ||| Mirror (tiled 2) ||| full ||| Grid ||| Mirror Grid ||| full
tiled n      = Tall nmaster delta (ratios!!n)
full         = noBorders Full
nmaster      = 1
delta        = 1/100


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

