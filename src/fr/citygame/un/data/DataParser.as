package fr.citygame.un.data 
{
	import flash.events.EventDispatcher;
	import fr.citygame.un.model.LocalisationVO;
	import fr.citygame.un.model.PlayerVO;
	
	/**
	 * ...
	 * @author Jon Lucas
	 */
	public class DataParser extends EventDispatcher 
	{
		
		private var xmlListeEquipe:XMLList;
		private var xmlListeJoueur:XMLList;
		private var itemEquipe:XML;
		private var itemJoueur:XML;
		
		private var localisationVo:LocalisationVO;
		
		private var playerVO:PlayerVO;
		
		public function DataParser()
		{
			
		}
		
		public function parseJoueurs(xml:XML):void 
		{
			Data.playersVo = new Vector.<PlayerVO>;
			
			xmlListeEquipe = xml.equipe;
			for each(itemEquipe in xmlListeEquipe)
			{
				xmlListeJoueur = itemEquipe.joueur;
				for each(itemJoueur in xmlListeJoueur)
				{
					localisationVo = new LocalisationVO(itemJoueur.lat, itemJoueur.long, 0, 0);
					
					playerVO = new PlayerVO(itemJoueur.@id, itemJoueur.pseudo, itemEquipe.@id, null, localisationVo, itemJoueur.vie);
					
					Data.playersVo.push(playerVO);
				}
			}
		}
		
		public function parseImpacts(xml:XML):void 
		{
			
		}
		
	}

}