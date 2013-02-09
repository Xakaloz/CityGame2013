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
		
		public static function convertSecondsToHMS(value:uint):String
		{			
			minutes = value > 60 ? Math.round(value / 60) : 0;
			secondes = value % 60;
			
			trace(value, minutes, secondes);
			
			return minutes + " : " + secondes;
		}
		
	}

}