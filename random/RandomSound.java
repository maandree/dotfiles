/**
 * Random sound player used at a party on Nightmare Night 2011
 */
import java.io.*;

public class RandomSound
{
    public static void main(final String... files)
    {
	for (;;)
	    try
	    {
		play(files[(int)(Math.random() * files.length)]);
		int wait = (int)(Math.random() * 20 * 1000) + 5000;
		System.out.println("waiting for " + wait);
	        Thread.sleep(wait);
	    }
	    catch (final Throwable err)
	    {
	    }
    }


    public static void play(final String file) throws Throwable
    {
	System.out.println(file);
	final Process process = (new ProcessBuilder("mplayer", file)).start();
        final InputStream stream = process.getInputStream();
        int c;
        while ((c = stream.read()) != -1)
             ;
    }

}

