package fr.citygame.un
{
	import com.adobe.nativeExtensions.Vibration;
	import flash.desktop.NativeApplication;
	import flash.desktop.SystemIdleMode;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.geom.Rectangle;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import flash.utils.setTimeout;
	import fr.citygame.un.controller.ScreenManager;
	import fr.citygame.un.model.Config;
	import fr.citygame.un.model.LocalisationVO;
	import fr.citygame.un.utils.SendReceive;
	import fr.citygame.un.view.Cinematics;
	import fr.citygame.un.view.Game;
	import starling.core.Starling;
	
	/**
	 * ...
	 * @author Jon Lucas
	 */
	[SWF(frameRate="60")]
	public class Main extends Sprite 
	{
		private var _starling:Starling;
		
		public function Main():void 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(Event.DEACTIVATE, deactivate);
			
			NativeApplication.nativeApplication.systemIdleMode = SystemIdleMode.KEEP_AWAKE;
			
			/*if (stage.allowsFullScreenInteractive) {
				stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
			}*/
			
			Config.stageWidth = stage.stageWidth;
			Config.stageHeight = stage.stageHeight;
			
			// touch or gesture?
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			
			_starling = new Starling(Game, stage);
			// show the stats window (draw calls, memory)
			_starling.showStats = true;
			// set anti-aliasing (higher the better quality but slower performance)
			_starling.antiAliasing = 1;
			
			_starling.viewPort.height = Config.stageHeight;
			
			_starling.start();
			
			//setTimeout(_stopStarling, 10000);			
			
			//setTimeout(function():void { _starling.viewPort = new Rectangle(-32, -32, 32, 32); }, 2000);
			
			//SendReceive.getInstance().getJoueurs();
			
			/*var vb:Vibration = new Vibration();
			vb.vibrate(500);*/
		}
		
		private function _stopStarling():void 
		{
			/*var nRect:Rectangle = new Rectangle( , , 32, 32 );
			_starling.viewPort = nRect;*/
			
			_starling.stop();
			
			/*var _cinematics:Cinematics = new Cinematics();
			addChild(_cinematics);
			_cinematics.transiIn( { videoFile:"/assets/videos/splash450x800.mp4" } ); //videoTest.mp4"});*/
		}
		
		private function deactivate(e:Event):void 
		{
			// auto-close
			NativeApplication.nativeApplication.exit();
		}
		
	}
	
}