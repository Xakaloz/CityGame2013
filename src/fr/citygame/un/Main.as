package fr.citygame.un
{
	import com.adobe.nativeExtensions.Vibration;
	import flash.desktop.NativeApplication;
	import flash.desktop.SystemIdleMode;
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
	import fr.citygame.un.controller.ScreenManager;
	import fr.citygame.un.data.Data;
	import fr.citygame.un.events.NavigationEvent;
	import fr.citygame.un.model.Config;
	import fr.citygame.un.model.LocalisationVO;
	import fr.citygame.un.model.PhasesDeJeu;
	import fr.citygame.un.model.ScreenType;
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
		
		private var _cinematic:Cinematics;
		private var _cinematicVisible:Boolean;
		
		
		public function Main():void 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(Event.DEACTIVATE, deactivate);
			
			stage.color = 0x000000;
			
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
			
			stage.addEventListener(Event.COMPLETE, _gotoScreenHandler);
			
			/*var vb:Vibration = new Vibration();
			vb.vibrate(500);*/
		}
		
		private function _gotoScreenHandler(e:Event):void 
		{
			showCinematics();
		}
		
		private function hideCinematics():void 
		{
			_cinematicVisible = false;
			_cinematic.transiOut();
		}
		
		private function showCinematics():void 
		{
			trace("showCinematics()");
			
			_starling.stop();
			
			if (_cinematic == null) {
				_cinematic = new Cinematics();
				addChild(_cinematic);
			}
			_cinematicVisible = true;
			
			var params:Object = new Object();
			
			switch(Data.phaseDeJeu) {
				
				case PhasesDeJeu.INTRO:
					params.videoFile = "assets/videos/elephant-attak_1.flv";
					break;
					
				case PhasesDeJeu.ANIM_ARMES:
					params.videoFile = "assets/videos/sing-attak.mp4";
					break;
					
				case PhasesDeJeu.ANIM_IMPACTS:
					params.videoFile = "";
					break;
					
				case PhasesDeJeu.FIN:
					params.videoFile = "";
					break;
				
				
			}
			
			_cinematic.addEventListener(Event.COMPLETE, onVideoComplete);
			_cinematic.transiIn(params);
		}
		
		private function onVideoComplete(e:Event):void 
		{
			hideCinematics();
			
			_starling.start();
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