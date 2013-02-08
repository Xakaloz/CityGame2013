package fr.citygame.un.view
{
	
	/**
	 * 
	 * ...
	 * @author Jon Lucas
	 */
	public interface IScreen
	{
		function transiIn(params:Object = null):void;
		
		function transiOut():void;
		
		function addListeners():void;
		
		function removeListeners():void;
		
		function dispose():void;
	}
}