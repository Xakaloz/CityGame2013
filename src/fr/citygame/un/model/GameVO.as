package fr.citygame.un.model 
{
	import fr.citygame.un.utils.DateUtils;
	/**
	 * ...
	 * @author Jon Lucas
	 */
	public class GameVO 
	{
		private var _tpsRestantTir:uint;
		private var _tpsRestantPartie:uint;
		private var _tpsProchainTir:uint;
		
		public var stringRestantTir:String;
		public var stringRestantPartie:String;
		public var stringProchainTir:String;
		
		
		public function GameVO(pTpsRestantTir:Number, pTpsRestantPartie:Number, pTpsProchainTir:Number) 
		{
			tpsRestantTir = pTpsRestantTir;
			tpsRestantPartie = pTpsRestantPartie;
			tpsProchainTir = pTpsProchainTir;
		}
		
		public function get tpsRestantTir():uint 
		{
			return _tpsRestantTir;
		}
		
		public function set tpsRestantTir(value:uint):void 
		{
			_tpsRestantTir = value%30;
			stringRestantTir = String(_tpsRestantTir) + "s"; //DateUtils.convertSecondsToHMS(value);
		}
		
		public function get tpsRestantPartie():uint 
		{
			return _tpsRestantPartie;
		}
		
		public function set tpsRestantPartie(value:uint):void 
		{
			_tpsRestantPartie = value;
			stringRestantPartie = DateUtils.convertSecondsToMS(value);
		}
		
		public function get tpsProchainTir():uint 
		{
			return _tpsProchainTir;
		}
		
		public function set tpsProchainTir(value:uint):void 
		{
			_tpsProchainTir = value;
			stringProchainTir = DateUtils.convertSecondsToMS(value);
		}
		
	}

}