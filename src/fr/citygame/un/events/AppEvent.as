package fr.citygame.un.events 
{
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Jon Lucas
	 */
	public class AppEvent extends Event
	{
		public static const PLAY_CINEMATIC	:String = "play_cinematic";
		
		public static const PLAYER_SHOOTED	:String = "play_shooted";
		
		
		public function AppEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		}
		
	}
	
}