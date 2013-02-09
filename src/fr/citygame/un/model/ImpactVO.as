package fr.citygame.un.model 
{
	/**
	 * ...
	 * @author Jon Lucas
	 */
	public class ImpactVO 
	{
		
		private var _id			:uint;
		
		private var _idPlayer	:uint;
		
		private var _localisation	:LocalisationVO;
		
		private var _rayon		:Number;
		
		
		public function ImpactVO(pId:uint, pIdPlayer:uint, pLocalisation:LocalisationVO, pRayon:Number) 
		{
			id = pId;
			idPlayer = pIdPlayer;
			localisation = pLocalisation;
			rayon = pRayon;
		}
		
		public function get id():uint 
		{
			return _id;
		}
		
		public function set id(value:uint):void 
		{
			_id = value;
		}
		
		public function get idPlayer():uint 
		{
			return _idPlayer;
		}
		
		public function set idPlayer(value:uint):void 
		{
			_idPlayer = value;
		}
		
		public function get rayon():Number 
		{
			return _rayon;
		}
		
		public function set rayon(value:Number):void 
		{
			_rayon = value;
		}
		
		public function get localisation():LocalisationVO 
		{
			return _localisation;
		}
		
		public function set localisation(value:LocalisationVO):void 
		{
			_localisation = value;
		}
		
	}

}