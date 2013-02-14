package fr.citygame.un.view 
{
	import fr.citygame.un.assets.Assets;
	import fr.citygame.un.data.Data;
	import fr.citygame.un.model.PlayerVO;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.rad2deg;
	
	/**
	 * ...
	 * @author Félix Ardeois
	 */
	public class Player extends Sprite 
	{
		private var _playerVo:PlayerVO;
		private var _filtre:Quad;
		private var _filtreBlack:Quad;
		private var _image:MovieClip;
		
		public function Player(playerVo:PlayerVO) 
		{
			_playerVo = playerVo;
			
			if (_playerVo.idTeam == 1)
				_image = new MovieClip(Assets.texAtlasImpact.getTextures("pictoElephant"), 30);
			else
				_image = new MovieClip(Assets.texAtlasImpact.getTextures("pictoSinge"), 30);
			
			Starling.juggler.add(_image);
			
			addEventListener(Event.REMOVED_FROM_STAGE, onRemove);
			
			addChild(_image);
			
			_image.pivotX = _image.width / 2;
			_image.pivotY = _image.height / 2;
			
			_filtreBlack = new Quad(_image.width - 20, 7);
			_filtreBlack.color = 0x000000;
			_filtreBlack.alpha = .8;
			addChild(_filtreBlack);
			
			_filtreBlack.pivotX = _filtreBlack.width / 2;
			_filtreBlack.y = -29;
			
			_filtre = new Quad(_image.width - 22, 5);
			_filtre.color = 0x00d805;
			_filtre.alpha = .8;
			addChild(_filtre);
			
			_filtre.y = -28;
			_filtre.x = _filtreBlack.x - _filtreBlack.width / 2 + 1;
			
			update(_playerVo);
		}
		
		public function update(playerVo:PlayerVO):void
		{
			_playerVo = playerVo;
			_playerVo.localisation.setGeolocValues(_playerVo.localisation.latitude, _playerVo.localisation.longitude);
			
			this.x = _playerVo.localisation.x;
			this.y = _playerVo.localisation.y;
			
			_filtre.scaleX = _playerVo.life > 0 ? _playerVo.life / 100 : 0;
			if (Data.playerVo.life > 0) {
				alpha = 1;
			} else {
				alpha = .2;
			}
			this.rotation = -Data.rotation;
		}
		
		private function onRemove(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemove);
			
			if (_image) {
				Starling.juggler.remove(_image);
				
				removeChild(_filtreBlack);
				_filtreBlack = null;
				
				removeChild(_filtre);
				_filtre = null;
			}
		}
		
		public function get id():uint 
		{
			return _playerVo.id;
		}
		
	}

}