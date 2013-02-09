package fr.citygame.un.view 
{
	import fr.citygame.un.controller.ScreenManager;
	import fr.citygame.un.model.ScreenType;
	import starling.display.Sprite;
	import starling.events.Event;
	
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
			_screenManager.addScreen(ScreenType.HOME, 				new Home(), 			[ScreenType.MAIN_MENU, ScreenType.CINEMATICS]);
			_screenManager.addScreen(ScreenType.MAIN_MENU, 			new Home(), 			[ScreenType.GAME_INTERFACE]);
			_screenManager.addScreen(ScreenType.GAME_INTERFACE, 	new GameInterface(), 	[ScreenType.CINEMATICS, ScreenType.SCORES]);
			_screenManager.addScreen(ScreenType.CINEMATICS, 		new Home(), 			[ScreenType.MAIN_MENU, ScreenType.GAME_INTERFACE, ScreenType.CREDITS, ScreenType.SCORES]);
			_screenManager.addScreen(ScreenType.SCORES, 			new Home(), 			[ScreenType.CREDITS]);
			_screenManager.addScreen(ScreenType.CREDITS, 			new Home(), 			[ScreenType.HOME]);
			_screenManager.setScreen(ScreenType.GAME_INTERFACE);
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