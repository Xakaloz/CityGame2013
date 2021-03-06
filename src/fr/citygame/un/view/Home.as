package fr.citygame.un.view 
{
	import com.greensock.TweenNano;
	import com.jonlucas.controller.ScreenManager;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import fr.citygame.un.assets.Assets;
	import fr.citygame.un.events.NavigationEvent;
	import fr.citygame.un.model.Config;
	import fr.citygame.un.model.ScreenType;
	import starling.display.Button;
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
		private var _btn:Button;
		
		private var sound : Sound; // not MySound! 
		private var soundTransform:SoundChannel;
		
		public function Home() 
		{
			_screen = new Image(Texture.fromBitmap(new Assets.SPLASH_SCREEN));
			addChild(_screen);
			
			_btn = new Button(Texture.fromBitmap(new Assets.BTN_START_DOWN),"", Texture.fromBitmap(new Assets.BTN_START_UP));
			addChild(_btn);
			
			_btn.pivotX = _btn.width / 2;
			_btn.pivotY = _btn.height / 2;
			
			_btn.x = Config.stageWidth * 0.5;
			_btn.y = Config.stageHeight * 11 / 12;
			
			
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
			
			sound = (new Assets.THEME) as Sound;
			soundTransform = sound.play(0, 10);	     
		}
		
		public function transiOut():void 
		{
			trace("Home :: transiOut()");
			
			removeListeners();
			
			TweenNano.to(this, .5, { alpha: 0,  x: -width } );
			if (soundTransform) {
				soundTransform.stop();
				soundTransform = null;
				sound = null;
			}
		}
		
		public function addListeners():void 
		{
			_btn.addEventListener(TouchEvent.TOUCH, _touchHandler);
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
						dispatchEvent(new NavigationEvent(NavigationEvent.GOTO_SCREEN, ScreenType.MAIN_MENU, true, true));
						break;
					
				}
			}
		}
		
		public function removeListeners():void 
		{
			_btn.removeEventListener(TouchEvent.TOUCH, _touchHandler);
		}
		
	}

}