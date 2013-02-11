package fr.citygame.un.view 
{
	import com.greensock.TweenNano;
	import com.jonlucas.controller.ScreenManager;
	import flash.events.Event;
	import fr.citygame.un.assets.Assets;
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
		
		public function MainMenu() 
		{			
			_screen = new Image(Texture.fromBitmap(new Assets.LOG_SCREEN()));
			addChild(_screen);
		}
		
		private function onInitComplete(e:Event):void 
		{
			SendReceive.getInstance().removeEventListener(Event.COMPLETE, onInitComplete);
			
			dispatchEvent(new NavigationEvent(NavigationEvent.GOTO_SCREEN, ScreenType.GAME_INTERFACE, true, true));
		}
		
		/* INTERFACE fr.citygame.un.view.IScreen */
		
		public function transiIn(params:Object = null):void 
		{
			this.alpha = 0;
			x = Config.stageWidth;
			
			TweenNano.to(this, 0.5, { alpha: 1, x: 0, onComplete:
				function():void {
					addListeners();
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
			SendReceive.getInstance().addEventListener(Event.COMPLETE, onPlayerComplete);
			SendReceive.getInstance().createPlayer("pseudo");
		}
		
		private function onPlayerComplete(e:Event):void 
		{
			SendReceive.getInstance().removeEventListener(Event.COMPLETE, onPlayerComplete);
			SendReceive.getInstance().getJoueurs();
			SendReceive.getInstance().addEventListener(Event.COMPLETE, onInitComplete);
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
		
		public function removeListeners():void 
		{
			_screen.removeEventListener(TouchEvent.TOUCH, _touchHandler);
		}
		
	}

}