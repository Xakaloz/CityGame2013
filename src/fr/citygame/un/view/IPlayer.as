package fr.citygame.un.view 
{
	import fr.citygame.un.model.PlayerVO;
	
	/**
	 * ...
	 * @author Jon Lucas
	 */
	public interface IPlayer 
	{
		function get id():uint;
		
		function get playerVO():PlayerVO;
		
		function update(pPlayerVO:PlayerVO):void;
	}
	
}