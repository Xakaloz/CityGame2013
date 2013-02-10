package fr.citygame.un.view 
{
	import fr.citygame.un.assets.Assets;
	import fr.citygame.un.model.PlayerVO;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Quad;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author Félix Ardeois // Opixido
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
			
			//this.scaleX = scaleY = 0.75;
			
			if (_playerVo.idTeam == 1)
			//_image = new Image(Assets.textureMonkey);
			_image = new MovieClip(Assets.impactTextureAltas.getTextures("pictoElephant"), 30);
			else
			_image = new MovieClip(Assets.impactTextureAltas.getTextures("pictoSinge"), 30);
			//_image = new Image(Assets.textureElephant);
			
			Starling.juggler.add(_image);
			
			addChild(_image);
			
			_image.pivotX = _image.width / 2;
			_image.pivotY = _image.height / 2;
			
			_playerVo.localisation.setGeolocValues(_playerVo.localisation.latitude, _playerVo.localisation.longitude);
			
			this.x = _playerVo.localisation.x;
			this.y = _playerVo.localisation.y;
			
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
			
			//_filtre.pivotX = _filtre.width / 2;
			
			_filtre.y = -28;
			
			//trace("life " + _playerVo.pseudo);
			_filtre.scaleX = _playerVo.life / 100;
			
			_filtre.x = _filtreBlack.x - _filtreBlack.width / 2 + 1;
		}
		
	}

}