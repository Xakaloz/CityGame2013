package fr.citygame.un.model 
{
	import flash.display.BitmapData;
	/**
	 * ...
	 * @author Jon Lucas
	 */
	public class PlayerVO 
	{
		
		private var _id			:uint;
		
		private var _pseudo		:String;
		
		private var _idTeam		:uint;
		
		private var _idWeapons	:Vector.<uint>;
		
		private var _localisation	:LocalisationVO;
		
		private var _avatar		:BitmapData;
		
		private var _life		:Number;
		
		
		public function PlayerVO(pID:uint, pPseudo:String, pIdTeam:uint, pIdWeapons:Vector.<uint>, pLocalisation:LocalisationVO, pLife:Number, pAvatar:BitmapData = null)
		{
			id = pID;
			pseudo = pPseudo;
			idTeam = pIdTeam;
			idWeapons = pIdWeapons;
			localisation = pLocalisation;
			avatar = pAvatar;
			life = pLife;
		}
		
		public function get id():uint 
		{
			return _id;
		}
		
		public function set id(value:uint):void 
		{
			_id = value;
		}
		
		public function get pseudo():String 
		{
			return _pseudo;
		}
		
		public function set pseudo(value:String):void 
		{
			_pseudo = value;
		}
		
		public function get idTeam():uint 
		{
			return _idTeam;
		}
		
		public function set idTeam(value:uint):void 
		{
			_idTeam = value;
		}
		
		public function get idWeapons():Vector.<uint> 
		{
			return _idWeapons;
		}
		
		public function set idWeapons(value:Vector.<uint>):void 
		{
			_idWeapons = value;
		}
		
		public function get avatar():BitmapData 
		{
			return _avatar;
		}
		
		public function set avatar(value:BitmapData):void 
		{
			_avatar = value;
		}
		
		public function get life():Number 
		{
			return _life;
		}
		
		public function set life(value:Number):void 
		{
			_life = value;
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