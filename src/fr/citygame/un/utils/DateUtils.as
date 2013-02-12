package fr.citygame.un.utils 
{
	/**
	 * ...
	 * @author Jon Lucas
	 */
	public class DateUtils 
	{
		static private var minutes:Number;
		static private var secondes:Number;
		
		public static function convertSecondsToMS(value:Number):String
		{			
			minutes = value > 60 ? Math.round(value / 60) : 0;
			secondes = value % 60;
			
			return (minutes < 10 ? 0 + "" + minutes : minutes) + ":" + (secondes < 10 ? 0 + "" + secondes : secondes);
		}
		
	}

}