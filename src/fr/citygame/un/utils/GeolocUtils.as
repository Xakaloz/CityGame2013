package fr.citygame.un.utils 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.GeolocationEvent;
	import flash.events.StatusEvent;
	import flash.geom.Point;
	import flash.sensors.Geolocation;
	import fr.citygame.un.events.GpsEvent;
	import fr.citygame.un.model.Config;
	import fr.citygame.un.model.LocalisationVO;
	/**
	 * ...
	 * @author Jon Lucas
	 */
	public class GeolocUtils extends EventDispatcher
	{
		static private var _geo:Geolocation;
		static private var posX:Number;
		static private var posY:Number;
		static public var pointPlayer:Point;
		
		private var evt:GpsEvent;
		
		public function start():void
		{
			trace("startGeoloc");
			if (Geolocation.isSupported) 
            { 
				trace("isSupported");
                _geo = new Geolocation(); 
                if (!_geo.muted) 
                { 
					trace("!muted");
					_geo.setRequestedUpdateInterval(2000);
                    _geo.addEventListener(GeolocationEvent.UPDATE, geoUpdateHandler); 
                } 
                //_geo.addEventListener(StatusEvent.STATUS, geoStatusHandler);
            }
		}
		
		private function geoUpdateHandler(event:GeolocationEvent):void 
        { 
			evt = new GpsEvent(GpsEvent.UPDATE);
			evt.latitude = event.latitude;
			evt.longitude = event.longitude;
			evt.horizontalAccuracy = event.horizontalAccuracy;
			dispatchEvent(evt);
           //trace("latitude : " + event.latitude.toString()); 
           //trace("longitude : " + event.longitude.toString());
           //trace("longitude : " + event.horizontalAccuracy.toString());
        } 
        
        private function geoStatusHandler(event:StatusEvent):void 
        { 
            if (_geo.muted)
                _geo.removeEventListener(GeolocationEvent.UPDATE, geoUpdateHandler);
            else
                _geo.addEventListener(GeolocationEvent.UPDATE, geoStatusHandler);
        }
		
		public static function convertGeolocToXY(pLocalisationVO:LocalisationVO):LocalisationVO
		{
			pointPlayer = new Point(pLocalisationVO.longitude, pLocalisationVO.latitude);
			
			pointPlayer.x -= Config.pointHG.x;
			pointPlayer.y -= Config.pointHG.y;
			
			posX = pointPlayer.x * Config.ratioX;
			posY = pointPlayer.y * Config.ratioY ;
			
			pLocalisationVO.x = posX;
			pLocalisationVO.y = posY;
			
			return pLocalisationVO;
		}
		
	}

}