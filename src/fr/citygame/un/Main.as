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
		private var swf:MovieClip;
		
		
		public function Main():void 
		{
			Config.STAGE = stage;
			
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
			_starling.showStats = false;
			// set anti-aliasing (higher the better quality but slower performance)
			_starling.antiAliasing = 1;
			
			//_starling.viewPort.height = Config.stageHeight;
			
			_starling.start();
			
			stage.addEventListener(FlashEvent.PLAY_VIDEO, showCinematics);
			
			/*var vb:Vibration = new Vibration();
			vb.vibrate(500);*/
		}
		
		private function showCinematics(event:Event):void 
		{
			trace("showCinematics(" + Data.phaseDeJeu + ")");
			
			var params:Object = new Object();
			
			trace("IDTEAM :: " + Data.playerVo.idTeam);
			
			switch(Data.phaseDeJeu) {
				
				case PhasesDeJeu.INTRO:
					params.videoFile = Data.playerVo.idTeam == 1 ? "assets/videos/elephant-att2.mp4" : "assets/videos/singe-att2.mp4";
					break;
					
				case PhasesDeJeu.ANIM_ARMES:
					trace("ANIM_ARMES");
					swf = Assets.SINGE_ATTAK_MC.content;
					params.videoFile = Data.playerVo.idTeam == 1 ? "assets/videos/elephant-attak-stretched.mp4" : "assets/videos/sing-attak-stretched.mp4";
					break;
					
				case PhasesDeJeu.ANIM_IMPACTS:
					swf = Assets.SINGE_ATTAK_MC.content;
					params.videoFile = Math.round(Math.random()+1) ? "assets/videos/choc-elephant-streched.mp4" : "assets/videos/choc-singe-stretch.mp4";
					break;
					
				case PhasesDeJeu.FIN:
					params.videoFile = Data.playerVo.idTeam == 1 ? "assets/videos/elephant-att2.mp4" : "assets/videos/singe-att2.mp4";
					break;
			}
			
			onComplete(null);
		}
		
		private function onComplete(e:Event):void 
		{
			_starling.stop();
			swf.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			addChild(swf);
			swf.play();
		}
		
		private function onEnterFrame(e:Event):void 
		{
			if (swf.currentFrame == swf.totalFrames - 12) {
				swf.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
				removeChild(swf);
				swf.gotoAndStop(0);
				onVideoComplete(null);
			}
		}
		
		private function onVideoComplete(e:Event):void 
		{
			_starling.start();
			
			if (Data.phaseDeJeu == PhasesDeJeu.ANIM_ARMES) {
				Data.phaseDeJeu = PhasesDeJeu.ANIM_IMPACTS;
				_starling.root.dispatchEvent(new NavigationEvent(NavigationEvent.GOTO_SCREEN, ScreenType.CINEMATICS));
			} else {
				
				switch(Data.phaseDeJeu) {
					
					case PhasesDeJeu.ANIM_IMPACTS :
						_starling.root.dispatchEvent(new NavigationEvent(NavigationEvent.GOTO_SCREEN, ScreenType.GAME_INTERFACE));
						break;
					
				}
			}
		}
		
		private function deactivate(e:Event):void 
		{
			// auto-close
			NativeApplication.nativeApplication.exit();
		}
		
	}
	
}