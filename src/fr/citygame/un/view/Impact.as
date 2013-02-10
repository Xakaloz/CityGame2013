package fr.citygame.un.view 
{
	import fr.citygame.un.assets.Assets;
	import fr.citygame.un.model.ImpactVO;
	import fr.citygame.un.model.PlayerVO;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.TextureAtlas;
	
	/**
	 * ...
	 * @author Félix Ardeois // Opixido
	 */
	public class Impact extends Sprite 
	{
		private var _impactVo:ImpactVO;
		private var _movie:MovieClip;
		
		public function Impact(impactVo:ImpactVO) 
		{
			_impactVo = impactVo;
			
			//this.scaleX = scaleY = 0.75;
			
			_movie = new MovieClip(Assets.impactTextureAltas.getTextures("elephant"), 30);
			addChild(_movie);
			
			_movie.loop = false;
			
			Starling.juggler.add(_movie);
			
			_movie.pivotX = _movie.width / 2;
			_movie.pivotY = _movie.height / 2;
			
			//_impactVo.localisation.setGeolocValues(_impactVo.localisation.latitude, _impactVo.localisation.longitude);
			
			this.x = _impactVo.localisation.x;
			this.y = _impactVo.localisation.y;
		}
		
	}

}