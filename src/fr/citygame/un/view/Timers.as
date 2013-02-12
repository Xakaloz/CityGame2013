package fr.citygame.un.view 
{
	import flash.events.Event;
	import fr.citygame.un.data.Data;
	import fr.citygame.un.events.AppEvent;
	import fr.citygame.un.events.NavigationEvent;
	import fr.citygame.un.model.Config;
	import fr.citygame.un.model.PhasesDeJeu;
	import fr.citygame.un.model.ScreenType;
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.text.TextField;
	
	/**
	 * ...
	 * @author Jon Lucas
	 */
	public class Timers extends Sprite 
	{
		private var _tempsTir:TextField;
		
		private var _tempsTotal:TextField;
		
		
		public function Timers() 
		{
			_tempsTir = new TextField(200, 40, "--s", "Verdana", 20, 0xFFFFFF, true);
			_tempsTir.x = 8;
			_tempsTir.hAlign = "left";
			addChild(_tempsTir);
			
			_tempsTotal = new TextField(100, 40, "--:--", "Verdana", 16, 0xFFFFFF, true);
			_tempsTotal.x = Config.stageWidth - 100 - 8;
			_tempsTotal.hAlign = "right";
			addChild(_tempsTotal);
		}
		
		public function onTick():void
		{
			if(Data.gameVo){
				Data.gameVo.tpsRestantTir--;
				Data.gameVo.tpsRestantPartie--;
				
				_tempsTotal.text = Data.gameVo.stringRestantPartie;
				_tempsTir.text = "Prochain tir : " + Data.gameVo.stringRestantTir;
				trace(Data.gameVo.tpsRestantTir);
				if (Data.gameVo.tpsRestantTir == 0) {
					Data.phaseDeJeu = PhasesDeJeu.ANIM_ARMES;
					dispatchEvent(new NavigationEvent(NavigationEvent.GOTO_SCREEN, ScreenType.CINEMATICS, true));
				}
			}
		}
		
	}	

}