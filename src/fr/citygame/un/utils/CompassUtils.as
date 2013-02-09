package fr.citygame.un.utils 
{
	import com.christiancantrell.extensions.Compass;
	import flash.events.EventDispatcher;
	import flash.events.StatusEvent;
	import fr.citygame.un.events.CompassEvent;
	/**
	 * ...
	 * @author Félix Ardeois
	 */
	public class CompassUtils extends EventDispatcher
	{
		private var _compass:Compass;
		
		public function CompassUtils() 
		{
			_compass = new Compass();
			_compass.register();
			_compass.addEventListener(StatusEvent.STATUS, onStatusUpdate);
		}
		
		private function onStatusUpdate(e:StatusEvent):void 
		{
			var level:Number = e.level.split("&")[0];
			
			var evt:CompassEvent = new CompassEvent(CompassEvent.UPDATE);
			evt.level = -level;
			dispatchEvent(evt);
		}
		
	}

}