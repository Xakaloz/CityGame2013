package fr.citygame.un.view 
{
	import com.greensock.TweenNano;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author Jon Lucas
	 */
	public class GameInterface extends Sprite implements IScreen 
	{
		private var _map:Map;
		
		public function GameInterface() 
		{
			_map = new Map();
			addChild(_map);
		}
		
		/* INTERFACE fr.citygame.un.view.IScreen */
		
		public function transiIn(params:Object = null):void 
		{
			//TweenNano.to(this, 0.2, { alpha : 1 } );
		}
		
		public function transiOut():void 
		{
			//TweenNano.to(this, 0.2, { alpha : 0 } );
		}
		
		public function addListeners():void 
		{
			
		}
		
		public function removeListeners():void 
		{
			
		}

		
	}

}