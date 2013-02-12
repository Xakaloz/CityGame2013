package fr.citygame.un.data 
{
	import flash.events.EventDispatcher;
	import fr.citygame.un.model.GameVO;
	import fr.citygame.un.model.ImpactVO;
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
		private var xmlListe:XMLList;
		
		private var itemEquipe:XML;
		private var itemJoueur:XML;
		private var item:XML;
		
		private var localisationVo:LocalisationVO;
		
		private var playerVO:PlayerVO;
		private var impactVO:ImpactVO;
		
		public function DataParser()
		{
			
		}
		
		public function parseJoueurs(xml:XML):void 
		{
			if (Data.gameVo == null) {
				Data.gameVo = new GameVO(xml.partie.restant_tir, xml.partie.restant_partie, xml.partie.prochain_tir);
			} else {
				Data.gameVo.tpsRestantPartie = xml.partie.restant_partie;
				Data.gameVo.tpsProchainTir = xml.partie.prochain_tir;
				Data.gameVo.tpsRestantTir = xml.partie.restant_tir;
			}
			
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
					
					/*if (Data.playersVoObjects[playerVO.id]) {
						PlayerVO(Data.playersVoObjects[playerVO.id]).localisation = localisationVo;
						PlayerVO(Data.playersVoObjects[playerVO.id]).life = playerVO.vie;
					} else {
						Data.playersVoObjects[playerVO.id] = playerVO;
					}*/
					
					if (Data.playersVo.length == 10 || Data.playersVo.length == 20) break;
				}
			}
		}
		
		public function parseImpacts(xml:XML):void 
		{
			Data.impactsVo = new Vector.<ImpactVO>();
			
			xmlListe = xml.impacts;
			
			//for each(item in xmlListe)
			for each (var i:XML in xml..impact)
			{
				localisationVo = new LocalisationVO(i.latitude, i.longitude, 0, 0);
				impactVO = new ImpactVO(i.@id, 0, localisationVo, i.rayon);
				
				Data.impactsVo.push(impactVO);
			}
		}
		
		public function parseCreatePlayer(xml:XML):void 
		{
			Data.playerVo = new PlayerVO(xml.id, xml.pseudo, xml.id_equipe, null, Data.playerVo.localisation, 100, null);
		}
		
	}

}