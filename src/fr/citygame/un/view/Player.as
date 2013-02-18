package fr.citygame.un.view 
{
	import com.jonlucas.utils.Utils;
	import fr.citygame.un.assets.Assets;
	import fr.citygame.un.data.Data;
	import fr.citygame.un.model.PlayerVO;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Félix Ardeois
	 */
	public class Player extends Sprite implements IPlayer
	{
		private var _id:uint;
		
		private var _playerVo:PlayerVO;
		private var _lifeBar:LifeBar;
		private var _image:MovieClip;
		
		public function Player(pPlayerVo:PlayerVO) 
		{
			addEventListener(Event.REMOVED_FROM_STAGE, onRemove);
			
			_playerVo = pPlayerVo;
			_id = _playerVo.id;
			
			if (_playerVo.idTeam == 1)
				_image = new MovieClip(Assets.texAtlasImpact.getTextures("pictoElephant"), 30);
			else
				_image = new MovieClip(Assets.texAtlasImpact.getTextures("pictoSinge"), 30);
			
			Starling.juggler.add(_image);			
			addChild(_image);
			
			_image.pivotX = _image.width / 2;
			_image.pivotY = _image.height / 2;
			
			_lifeBar = new LifeBar(_image.width - 20);
			addChild(_lifeBar);
			
			update(_playerVo);
		}
		
		public function update(playerVo:PlayerVO):void
		{
			_playerVo = playerVo;
			_playerVo.localisation.setGeolocValues(_playerVo.localisation.latitude, _playerVo.localisation.longitude);
			
			this.x = _playerVo.localisation.x;
			this.y = _playerVo.localisation.y;
			
			if (_playerVo.life > 0) {
				alpha = 1;
			} else {
				alpha = .2;
			}
			this.rotation = -Data.rotation;
			
			_lifeBar.update(_playerVo.life);
		}
		
		private function onRemove(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemove);
			
			if (_image) {
				Starling.juggler.remove(_image);
				_image = null;
				
				_lifeBar = Utils.removeChild(_lifeBar, this);
			}
		}
		
		public function get id():uint 
		{
			return _id;
		}
		
		public function get playerVO():PlayerVO 
		{
			return _playerVo;
		}
		
	}

}