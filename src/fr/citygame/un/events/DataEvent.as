package fr.citygame.un.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Jon Lucas
	 */
	public class DataEvent extends Event 
	{
		public static const PLAYERS_REFRESHED :String = "playersRefreshed";
		static public const IMPACTS_REFRESHED:String = "impactsRefreshed";
		static public const PLAYER_CREATED:String = "playerCreated";
		
		
		public function DataEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new DataEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("DataEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}