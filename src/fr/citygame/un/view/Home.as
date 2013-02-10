package fr.citygame.un.view 
{
	import com.greensock.TweenNano;
	import com.jonlucas.controller.ScreenManager;
	import fr.citygame.un.assets.Assets;
	import fr.citygame.un.data.Data;
	import fr.citygame.un.events.NavigationEvent;
	import fr.citygame.un.model.Config;
	import fr.citygame.un.model.PhasesDeJeu;
	import fr.citygame.un.model.ScreenType;
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
	public class Home extends Sprite implements IScreen 
	{
		
		private var _screen:Image;
		private var _touch:Touch;
		
		public function Home() 
		{
			_screen = new Image(Texture.fromBitmap(new Assets.SPLASH_SCREEN));
			addChild(_screen);
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
			
			TweenNano.to(this, .5, {alpha: 0,  x: -width } );
		}
		
		public function addListeners():void 
		{
			_screen.addEventListener(TouchEvent.TOUCH, _touchHandler);
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
						Data.phaseDeJeu = PhasesDeJeu.INTRO;
						dispatchEvent(new NavigationEvent(NavigationEvent.GOTO_SCREEN, ScreenType.CINEMATICS, true, true));
						//dispatchEvent(new NavigationEvent(NavigationEvent.GOTO_SCREEN, ScreenType.MAIN_MENU, true, true));
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