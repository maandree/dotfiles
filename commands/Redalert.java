import java.util.*;


public class Redalert
{
    public static void main(final String... args) throws Throwable
    {
	final Calendar now = Calendar.getInstance();

	int year   = now.get(Calendar.YEAR);
	int month  = now.get(Calendar.MONTH);
	int day    = now.get(Calendar.DAY_OF_MONTH);
	int hour   = now.get(Calendar.HOUR_OF_DAY);
	int minute = now.get(Calendar.MINUTE);
	int second = now.get(Calendar.SECOND);

	long timeD = ((year * 12) + month) * 31 + day;
	long timeT = ((hour * 60) + minute) * 60 + second;

	long timeN = timeD * 24 * 60 * 60 + timeT;


	year   = Integer.parseInt(args[0]);
	month  = Integer.parseInt(args[1]);
	day    = Integer.parseInt(args[2]);
	hour   = Integer.parseInt(args[3]);
	minute = Integer.parseInt(args[4]);
	second = Integer.parseInt(args[5]);
	
	timeD = ((year * 12) + (month - 1)) * 31 + day;
	timeT = ((hour * 60) + minute) * 60 + second;
	
	long timeX = timeD * 24 * 60 * 60 + timeT;
	
	if (timeN >= timeX)
	{
	    System.out.print("\033[H\033[2J\033[0;41;1m");
	    System.out.print((args[6] + "\\n").replace("\\n", "\033[K\n"));
	    System.out.println("\033[K\033[m");
	}
    }

}

