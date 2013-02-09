package fr.citygame.un.view 
{
	import com.greensock.TweenNano;
	import flash.events.TouchEvent;
	import fr.citygame.un.model.Config;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author Jon Lucas
	 */
	public class GameInterface extends Sprite implements IScreen 
	{
		private var _map:MapContainer;
		private var _tirette:Tirette;
		
		public function GameInterface() 
		{
			
			Config.playerYposition = Config.stageHeight * 2 / 3;
			
			_map = new MapContainer();
			_map.initPosition();
			addChild(_map);
			
			_activateFireMode();
		}
		
		private function _activateFireMode():void
		{
			if (_tirette == null) {
				_tirette = new Tirette();
				_tirette.x = Config.stageWidth * .5;
				_tirette.y = Config.playerYposition;
				addChild(_tirette);
			}
			
			_tirette.activateTirette();
		}
		
		/* INTERFACE fr.citygame.un.view.IScreen */
		
		public function transiIn(params:Object = null):void 
		{
			//TweenNano.to(this, 0.2, { alpha : 1 } );
			_map.transiIn();
		}
		
		public function transiOut():void 
		{
			//TweenNano.to(this, 0.2, { alpha : 0 } );
			
			_map.transiOut();
		}
		
		public function addListeners():void 
		{
			
		}
		
		public function removeListeners():void 
		{
			
		}

		
	}

}