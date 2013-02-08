package fr.citygame.un.view 
{
	import flash.events.Event;
	import fr.citygame.un.controller.ScreenManager;
	import fr.citygame.un.model.ScreenType;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author Jon Lucas
	 */
	public class Game extends Sprite implements IScreen 
	{
		private var _screenManager:ScreenManager;
		
		public function Game() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			_screenManager = new ScreenManager(this);
			_screenManager.addScreen(ScreenType.HOME, 				new Home(), 	null);
			_screenManager.addScreen(ScreenType.MAIN_MENU, 			new Home(), 	null);
			_screenManager.addScreen(ScreenType.GAME_INTERFACE, 	new Home(), 	null);
			_screenManager.addScreen(ScreenType.CINEMATICS, 		new Home(), 	null);
			_screenManager.addScreen(ScreenType.SCORES, 			new Home(), 	null);
			_screenManager.addScreen(ScreenType.CREDITS, 			new Home(), 	null);
			_screenManager.setScreen(ScreenType.HOME);
		}
		
		/* INTERFACE fr.citygame.un.view.IScreen */
		
		public function transiIn(params:Object = null):void 
		{
			
		}
		
		public function transiOut():void 
		{
			
		}
		
		public function addListeners():void 
		{
			
		}
		
		public function removeListeners():void 
		{
			
		}
		
	}

}