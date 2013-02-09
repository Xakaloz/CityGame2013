package fr.citygame.un.model 
{
	/**
	 * ...
	 * @author Jon Lucas
	 */
	public class WeaponVO 
	{
		
		private var _id		:uint;
		
		private var _name	:String;
		
		private var _rayon	:Number;
		
		private var _minDistance	:Number;
		
		private var _maxDistance	:Number;
		
		private var _nbrShots		:uint;
		
		private var _randomPrecision	:Number;
		
		
		public function WeaponVO(pId:uint, pName:String, pRayon:Number, pMinDistance:Number, pMaxDistance:Number, pNbrShots:uint, pRandomPrecision:Number) 
		{
			id = pId;
			name = pName;
			rayon = pRayon;
			minDistance = pMinDistance;
			maxDistance = pMaxDistance;
			nbrShots = pNbrShots;
			randomPrecision = pRandomPrecision;
		}
		
		public function get id():uint 
		{
			return _id;
		}
		
		public function set id(value:uint):void 
		{
			_id = value;
		}
		
		public function get name():String 
		{
			return _name;
		}
		
		public function set name(value:String):void 
		{
			_name = value;
		}
		
		public function get rayon():Number 
		{
			return _rayon;
		}
		
		public function set rayon(value:Number):void 
		{
			_rayon = value;
		}
		
		public function get minDistance():Number 
		{
			return _minDistance;
		}
		
		public function set minDistance(value:Number):void 
		{
			_minDistance = value;
		}
		
		public function get maxDistance():Number 
		{
			return _maxDistance;
		}
		
		public function set maxDistance(value:Number):void 
		{
			_maxDistance = value;
		}
		
		public function get nbrShots():uint 
		{
			return _nbrShots;
		}
		
		public function set nbrShots(value:uint):void 
		{
			_nbrShots = value;
		}
		
		public function get randomPrecision():Number 
		{
			return _randomPrecision;
		}
		
		public function set randomPrecision(value:Number):void 
		{
			_randomPrecision = value;
		}
		
	}

}