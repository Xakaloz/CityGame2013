package fr.citygame.un.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Félix Ardeois // Opixido
	 */
	public class GpsEvent extends Event 
	{
		static public const UPDATE:String = "update";
		public var level:int;
		public var latitude:Number;
		public var longitude:Number;
		public var horizontalAccuracy:Number;
		
		public function GpsEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
			
		}
		
	}

}