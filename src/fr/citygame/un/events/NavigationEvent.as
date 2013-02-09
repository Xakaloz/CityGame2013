package fr.citygame.un.events 
{
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Jon Lucas
	 */
	public class NavigationEvent extends Event 
	{
		public static const GOTO_SCREEN :String = "goto_screen";
		
		public var screenName:String;
		
		
		public function NavigationEvent(type:String, pScreenName:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
			screenName = pScreenName;
		} 

		
	}
	
}