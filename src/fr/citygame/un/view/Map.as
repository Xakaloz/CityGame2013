package fr.citygame.un.view 
{
	import fr.citygame.un.assets.Assets;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author Félix Ardeois
	 */
	public class Map extends Sprite
	{
		
		private var _image:Image;
		
		public function Map() 
		{
			this.touchable = false;
			
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		private function addedToStageHandler(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			
			_image = new Image(Texture.fromBitmap(new Assets.MAP()));
			addChild(_image);
		}
		
		public function centerMap(x:Number, y:Number):void
		{
			
		}
	}

}