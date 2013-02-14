package fr.citygame.un.view 
{
	import com.jonlucas.utils.Utils;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import fr.citygame.un.assets.Assets;
	import fr.citygame.un.data.Data;
	import fr.citygame.un.events.FlashEvent;
	import fr.citygame.un.events.NavigationEvent;
	import fr.citygame.un.model.PhasesDeJeu;
	import fr.citygame.un.model.ScreenType;
	import starling.core.Starling;
	
	/**
	 * ...
	 * @author Jon Lucas
	 */
	public class SWFPlayer 
	{
		
		private var _stage:Stage;
		
		private var _starling:Starling;
		
		private var _swf:MovieClip;
		
		
		public function SWFPlayer(pStage:Stage, pStarling:Starling) 
		{
			_stage = pStage;
			_starling = pStarling;
			
			_stage.addEventListener(FlashEvent.PLAY_VIDEO, _play);
		}
		
		
		private function _play(event:FlashEvent):void
		{
			trace("showCinematics(" + Data.phaseDeJeu + ")");
			
			switch(Data.phaseDeJeu) {
				
				case PhasesDeJeu.INTRO:
					//params.videoFile = Data.playerVo.idTeam == 1 ? "assets/videos/elephant-att2.mp4" : "assets/videos/singe-att2.mp4";
					break;
					
				case PhasesDeJeu.ANIM_ARMES:
					_swf = Assets.mcSingeAttak.content;
					//params.videoFile = Data.playerVo.idTeam == 1 ? "assets/videos/elephant-attak-stretched.mp4" : "assets/videos/sing-attak-stretched.mp4";
					break;
					
				case PhasesDeJeu.ANIM_IMPACTS:
					//params.videoFile = Math.round(Math.random()+1) ? "assets/videos/choc-elephant-streched.mp4" : "assets/videos/choc-singe-stretch.mp4";
					break;
					
				case PhasesDeJeu.FIN:
					//params.videoFile = Data.playerVo.idTeam == 1 ? "assets/videos/elephant-att2.mp4" : "assets/videos/singe-att2.mp4";
					break;
			}
				
			//_starling.stop();
			_swf.addEventListener(Event.ENTER_FRAME, _onEnterFrame);
			_stage.addChild(_swf);
			_swf.play();
		}
		
		private function _onEnterFrame(e:Event):void 
		{
			if (_swf.currentFrame == _swf.totalFrames - 12)
			{
				_swf.removeEventListener(Event.ENTER_FRAME, _onEnterFrame);
				_stage.removeChild(_swf);
				_swf.gotoAndStop(0);
				_onComplete();
			}
		}
		
		private function _onComplete():void 
		{
			//_starling.start();
			
			/*if (Data.phaseDeJeu == PhasesDeJeu.ANIM_ARMES) {*/
				Data.phaseDeJeu = PhasesDeJeu.ANIM_IMPACTS;
				/*_starling.root.dispatchEvent(new NavigationEvent(NavigationEvent.GOTO_SCREEN, ScreenType.CINEMATICS));
			} else {
				switch(Data.phaseDeJeu) {	
					case PhasesDeJeu.ANIM_IMPACTS :*/
						_starling.root.dispatchEvent(new NavigationEvent(NavigationEvent.GOTO_SCREEN, ScreenType.GAME_INTERFACE));
						/*break;
					
				/*}
			}*/
		}
		
		public function dispose():void 
		{
			if (_swf) {
				_swf.removeEventListener(Event.ENTER_FRAME, _onEnterFrame);
				_swf = Utils.removeChild(_swf, _stage);
			}
			
			_stage.removeEventListener(FlashEvent.PLAY_VIDEO, _play);
			
			_stage = null;
			_starling = null;
		}
		
	}

}