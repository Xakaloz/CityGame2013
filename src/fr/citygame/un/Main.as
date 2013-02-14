package fr.citygame.un
{
	import com.adobe.nativeExtensions.Vibration;
	import com.greensock.loading.display.ContentDisplay;
	import com.greensock.loading.SWFLoader;
	import flash.desktop.NativeApplication;
	import flash.desktop.SystemIdleMode;
	import flash.display.MovieClip;
	import flash.display.StageDisplayState;
	import flash.display3D.Context3DRenderMode;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.geom.Rectangle;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import flash.utils.setTimeout;
	import fr.citygame.un.assets.Assets;
	import fr.citygame.un.controller.ScreenManager;
	import fr.citygame.un.data.Data;
	import fr.citygame.un.events.FlashEvent;
	import fr.citygame.un.events.NavigationEvent;
	import fr.citygame.un.model.Config;
	import fr.citygame.un.model.LocalisationVO;
	import fr.citygame.un.model.PhasesDeJeu;
	import fr.citygame.un.model.ScreenType;
	import fr.citygame.un.utils.SendReceive;
	import fr.citygame.un.view.Cinematics;
	import fr.citygame.un.view.Game;
	import fr.citygame.un.view.SWFPlayer;
	import starling.core.Starling;
	
	/**
	 * ...
	 * @author Jon Lucas
	 */
	[SWF(frameRate="60")]
	public class Main extends Sprite 
	{
		private var _starling:Starling;
		
		private var _swfPlayer:SWFPlayer;
		
		
		public function Main():void 
		{			
			Config.STAGE = stage;
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(Event.DEACTIVATE, deactivate);
			
			stage.color = 0x000000;
			
			NativeApplication.nativeApplication.systemIdleMode = SystemIdleMode.KEEP_AWAKE;
			
			Config.stageWidth = stage.stageWidth;
			Config.stageHeight = stage.stageHeight;
			
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			
			_starling = new Starling(Game, stage);
			_starling.showStats = false;
			_starling.antiAliasing = 1;
			
			_starling.start();
			
			_swfPlayer = new SWFPlayer(stage, _starling);
		}
		
		
		private function deactivate(e:Event):void 
		{
			// auto-close
			NativeApplication.nativeApplication.exit();
		}
		
	}
	
}