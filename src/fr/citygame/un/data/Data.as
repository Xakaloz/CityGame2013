package fr.citygame.un.data 
{
	import fr.citygame.un.model.GameVO;
	import fr.citygame.un.model.ImpactVO;
	import fr.citygame.un.model.PlayerVO;
	/**
	 * ...
	 * @author Jon Lucas
	 */
	public class Data 
	{
		public static var rotation:Number;
		public static var playersVo:Vector.<PlayerVO>;
		public static var impactsVo:Vector.<ImpactVO>;
		public static var gameVo:GameVO;
		public static var playerVo:PlayerVO = new PlayerVO(0, "", 0, null, null, 0);
		
		public static var phaseDeJeu	:String;
	}

}