package fr.citygame.un.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Jon Lucas
	 */
	public class FlashEvent extends Event 
	{
		public static const PLAY_VIDEO:String = "play_video";
		
		
		public function FlashEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new FlashEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("FlashEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}