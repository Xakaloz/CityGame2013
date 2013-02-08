package fr.citygame.un
{
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import fr.citygame.un.controller.ScreenManager;
	import fr.citygame.un.view.Game;
	import starling.core.Starling;
	
	/**
	 * ...
	 * @author Jon Lucas
	 */
	public class Main extends Sprite 
	{
		
		private var _starling:Starling;
		
		public function Main():void 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(Event.DEACTIVATE, deactivate);
			
			// touch or gesture?
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			
			_starling = new Starling(Game, stage);
			// show the stats window (draw calls, memory)
			_starling.showStats = true;
			// set anti-aliasing (higher the better quality but slower performance)
			_starling.antiAliasing = 1;
		}
		
		private function deactivate(e:Event):void 
		{
			// auto-close
			NativeApplication.nativeApplication.exit();
		}
		
	}
	
}