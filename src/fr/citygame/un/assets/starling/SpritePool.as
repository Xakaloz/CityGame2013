package fr.citygame.un.assets.starling 
{
	import starling.display.DisplayObject;
	/**
	 * ...
	 * @author Jon Lucas
	 */
	public class SpritePool implements ISpritePool 
	{
		private var _pool:Array;
		private var _counter:int;
		
		
		public function SpritePool(pType:Class, pLength:int) 
		{
			_pool = new Array();
			_counter = pLength;
			
			var i:int = pLength;
			while (--i > -1)
				_pool[i] = new pType();
		}
		
		/* INTERFACE fr.citygame.un.assets.ISpritePool */
		
		public function getSprite():DisplayObject 
		{
			if (_counter > 0) {
				return _pool[--_counter];
			} else {
				throw new Error("SpritePool exhausted!");
			}
		}
		
		public function returnSprite(pSprite:DisplayObject):void 
		{
			_pool[_counter++] = pSprite;
		}
		
		public function dispose():void 
		{
			while (_pool.length > 0)
			{
				_pool[0] = null;
				delete _pool[0];
			}
			_pool = null;
		}
		
	}

}