package fr.citygame.un.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Jon Lucas
	 */
	public class AppEvent extends Event 
	{
		public static const PLAY_CINEMATIC	:String = "play_cinematic";
		
		
		public function AppEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new AppEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("AppEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}