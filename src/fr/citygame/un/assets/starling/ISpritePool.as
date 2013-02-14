package fr.citygame.un.assets.starling 
{
	import starling.display.DisplayObject;
	
	/**
	 * ...
	 * @author Jon Lucas
	 */
	public interface ISpritePool 
	{				
		function getSprite():DisplayObject;
		
		function returnSprite(pSprite:DisplayObject):void;
		
		function dispose():void;
	}
	
}