package fr.citygame.un.view 
{
	import flash.events.Event;
	import flash.utils.setTimeout;
	import fr.citygame.un.controller.ScreenManager;
	import fr.citygame.un.events.FlashEvent;
	import fr.citygame.un.events.NavigationEvent;
	import fr.citygame.un.model.ScreenType;
	import starling.core.Starling;
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
		
		private function init(e:Object):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			_screenManager = new ScreenManager(this);
			_screenManager.addScreen(ScreenType.HOME, 				new Home(), 			[ScreenType.MAIN_MENU, ScreenType.CINEMATICS]);
			_screenManager.addScreen(ScreenType.MAIN_MENU, 			new MainMenu(), 		[ScreenType.GAME_INTERFACE]);
			_screenManager.addScreen(ScreenType.GAME_INTERFACE, 	new GameInterface(), 	[ScreenType.MAIN_MENU, ScreenType.CINEMATICS, ScreenType.SCORES, ScreenType.CINEMATICS]);
			_screenManager.addScreen(ScreenType.SCORES, 			new Scores(), 			[ScreenType.CREDITS]);
			_screenManager.addScreen(ScreenType.CREDITS, 			new Credits(), 			[ScreenType.HOME]); 4
			_screenManager.addScreen(ScreenType.CINEMATICS, 		new EmptyScreen(), 		[ScreenType.HOME, ScreenType.MAIN_MENU,ScreenType.GAME_INTERFACE]);
			_screenManager.setScreen(ScreenType.HOME);
			
			addEventListener(NavigationEvent.GOTO_SCREEN, gotoScreen);
		}
		
		private function gotoScreen(e:NavigationEvent):void
		{
			trace("Game :: gotoScreen(" + e.screenName + ")");
			_screenManager.setScreen(e.screenName);
			if (e.screenName == ScreenType.CINEMATICS) {
				//_screenManager.getCurrent().transiOut();
				//Starling.current.nativeStage.dispatchEvent(new FlashEvent(FlashEvent.PLAY_VIDEO));
				
				setTimeout(showImpacts, 500);
			}
		}
		
		private function showImpacts():void 
		{
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