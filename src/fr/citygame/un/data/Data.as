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
		
		public static var playerVo:PlayerVO;
		
		public static var phaseDeJeu	:String;
		
		public static function getPlayerVO(pId:uint):PlayerVO
		{
			for each(var p:PlayerVO in playersVo) {
				if (p.id == pId)	return p;
			}
			return null;
		}
	}

}