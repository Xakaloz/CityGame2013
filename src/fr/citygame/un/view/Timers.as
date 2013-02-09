package fr.citygame.un.view 
{
	import fr.citygame.un.data.Data;
	import fr.citygame.un.events.AppEvent;
	import fr.citygame.un.events.NavigationEvent;
	import fr.citygame.un.model.Config;
	import fr.citygame.un.model.ScreenType;
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
			_tempsTir = new TextField(100, 40, "--:--", "Verdana", 14, 0xFFFFFF, true);
			addChild(_tempsTir);
			
			_tempsTotal = new TextField(100, 40, "--:--", "Verdana", 14, 0xFFFFFF, true);
			_tempsTotal.x = Config.stageWidth - 100;
			addChild(_tempsTotal);
		}
		
		public function onTick():void
		{
			if(Data.gameVo){
				Data.gameVo.tpsRestantTir--;
				Data.gameVo.tpsRestantPartie--;
				_tempsTotal.text = Data.gameVo.stringRestantPartie;
				_tempsTir.text = Data.gameVo.stringRestantTir;
				
				if (Data.gameVo.tpsRestantTir == 0) {
					dispatchEvent(new NavigationEvent(NavigationEvent.GOTO_SCREEN, ScreenType.CINEMATICS, true));
				}
			}
		}
		
	}

}