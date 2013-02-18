package fr.citygame.un.view 
{
	import com.greensock.TweenNano;
	import com.jonlucas.controller.ScreenManager;
	import flash.events.Event;
	import fr.citygame.un.assets.Assets;
	import fr.citygame.un.events.DataEvent;
	import fr.citygame.un.events.NavigationEvent;
	import fr.citygame.un.model.Config;
	import fr.citygame.un.model.ScreenType;
	import fr.citygame.un.utils.SendReceive;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author Jon Lucas
	 */
	public class MainMenu extends Sprite implements IScreen 
	{
		
		private var _screen:Image;
		private var _touch:Touch;
		
		private var _sr:SendReceive;
		
		public function MainMenu() 
		{
			_sr = SendReceive.getInstance();
			
			_screen = new Image(Texture.fromBitmap(new Assets.LOG_SCREEN()));
			addChild(_screen);
		}
		
		private function onPlayerCreated(e:DataEvent):void 
		{
			_sr.getPlayers();
		}
		
		private function onInitComplete(e:DataEvent):void 
		{
			dispatchEvent(new NavigationEvent(NavigationEvent.GOTO_SCREEN, ScreenType.GAME_INTERFACE, true, true));
		}
		
		private function _touchHandler(e:TouchEvent):void 
		{
			_touch = e.getTouch(this);
			
			if(_touch){
			
				switch(_touch.phase) {
					
					case TouchPhase.BEGAN :
						break;
						
					case TouchPhase.MOVED :
						break;
						
					case TouchPhase.ENDED :
						dispatchEvent(new NavigationEvent(NavigationEvent.GOTO_SCREEN, ScreenType.GAME_INTERFACE, true, true));
						break;
					
				}
			}
		}
		
		/* INTERFACE fr.citygame.un.view.IScreen */
		
		public function transiIn(params:Object = null):void 
		{
			this.alpha = 0;
			x = Config.stageWidth;
			
			TweenNano.to(this, 0.5, { alpha: 1, x: 0, onComplete:
				function():void {
					addListeners();
					_sr.createPlayer("pseudo_" + new Date().getTime());
				}
			} );
		}
		
		public function transiOut():void 
		{
			trace("Home :: transiOut()");
			
			removeListeners();
			
			TweenNano.to(this, .5, { alpha: 0, x: -width } );
		}
		
		public function addListeners():void 
		{
			_sr.addEventListener(DataEvent.PLAYER_CREATED, onPlayerCreated);
			_sr.addEventListener(DataEvent.PLAYERS_REFRESHED, onInitComplete);
		}
		
		public function removeListeners():void 
		{
			_screen.removeEventListener(TouchEvent.TOUCH, _touchHandler);
			
			_sr.removeEventListener(DataEvent.PLAYER_CREATED, onPlayerCreated);
			_sr.removeEventListener(DataEvent.PLAYERS_REFRESHED, onInitComplete);
		}
		
	}

}