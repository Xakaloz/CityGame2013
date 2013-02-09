package fr.citygame.un.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Félix Ardeois // Opixido
	 */
	public class CompassEvent extends Event 
	{
		static public const UPDATE:String = "update";
		public var level:int;
		
		public function CompassEvent(type:String, bubbles:Boolean=false, data:Object=null) 
		{
			super(type, bubbles, data);
			
		}
		
	}

}