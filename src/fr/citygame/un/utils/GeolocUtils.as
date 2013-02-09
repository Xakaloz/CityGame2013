package fr.citygame.un.utils 
{
	import fr.citygame.un.model.LocalisationVO;
	/**
	 * ...
	 * @author Jon Lucas
	 */
	public class GeolocUtils 
	{
		
		public static function convertGeolocToXY(pLocalisationVO:LocalisationVO):LocalisationVO
		{
			return new LocalisationVO(0,0,0,0);
		}
		
	}

}