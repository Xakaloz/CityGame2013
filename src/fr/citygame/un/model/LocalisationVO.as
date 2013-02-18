package fr.citygame.un.model 
{
	import fr.citygame.un.utils.GeolocUtils;
	/**
	 * ...
	 * @author Jon Lucas
	 */
	public class LocalisationVO 
	{
		
		private var _latitude		:Number;
		private var _longitude		:Number;	
		private var _x				:Number;	
		private var _y				:Number;
		
		public function LocalisationVO(pLatitude:Number, pLongitude:Number) 
		{
			latitude = pLatitude;
			longitude = pLongitude;
			
			GeolocUtils.convertGeolocToXY(this);
		}
		
		public function setGeolocValues(pLatitude:Number, pLongitude:Number):void
		{
			latitude = pLatitude;
			longitude = pLongitude;
			
			GeolocUtils.convertGeolocToXY(this);
		}
		
		public function setXYValues(pX:Number, pY:Number):void
		{
			x= pX;
			y = pY;
		}
		
		public function get latitude():Number 
		{
			return _latitude;
		}
		
		public function set latitude(value:Number):void 
		{
			_latitude = value;
		}
		
		public function get longitude():Number 
		{
			return _longitude;
		}
		
		public function set longitude(value:Number):void 
		{
			_longitude = value;
		}
		
		public function get x():Number 
		{
			return _x;
		}
		
		public function set x(value:Number):void 
		{
			_x = value;
		}
		
		public function get y():Number 
		{
			return _y;
		}
		
		public function set y(value:Number):void 
		{
			_y = value;
		}
		
	}

}