package fr.citygame.un.view 
{
	import fr.citygame.un.assets.Assets;
	import fr.citygame.un.model.PlayerVO;
	import starling.display.Image;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author Félix Ardeois // Opixido
	 */
	public class Player extends Sprite 
	{
		private var _playerVo:PlayerVO;
		
		public function Player(playerVo:PlayerVO) 
		{
			_playerVo = playerVo;
			
			//this.scaleX = scaleY = 0.75;
			
			var _image:Image;
			
			if (_playerVo.idTeam == 1)
			_image = new Image(Assets.textureMonkey);
			else
			_image = new Image(Assets.textureElephant);
			
			addChild(_image);
			
			_image.pivotX = _image.width / 2;
			_image.pivotY = _image.height / 2;
			
			_playerVo.localisation.setGeolocValues(_playerVo.localisation.latitude, _playerVo.localisation.longitude);
			
			this.x = _playerVo.localisation.x;
			this.y = _playerVo.localisation.y;
		}
		
	}

}