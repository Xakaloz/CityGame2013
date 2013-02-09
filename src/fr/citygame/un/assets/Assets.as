package fr.citygame.un.assets 
{
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author Jon Lucas
	 */
	public class Assets 
	{
		
		[Embed(source="../../../../../bin/assets/images/interfaceSplashComplete.jpg")]
		public static const SPLASH_SCREEN:Class;
		
		[Embed(source="../../../../../bin/assets/images/pseudoScreen.jpg")]
		public static const LOG_SCREEN:Class;
		
		[Embed(source="../../../../../bin/assets/images/carte.jpg")]
		public static const MAP:Class;
		
		[Embed(source="../../../../../bin/assets/images/carre2.jpg")]
		public static const SQUARE:Class;
		
		[Embed(source="../../../../../bin/assets/images/carre.jpg")]
		public static const SQUARE_RED:Class;
		
		[Embed(source = "../../../../../bin/assets/images/tiretteButton.png")]
		public static const TIRETTE_BT:Class;
		
		[Embed(source = "../../../../../bin/assets/images/tiretteArrow.png")]
		public static const TIRETTE_ARROW:Class;
		
		[Embed(source = "../../../../../bin/assets/images/tiretteRuller.png")]
		public static const TIRETTE_RULLER:Class;
		
		[Embed(source = "../../../../../bin/assets/images/tiretteRuller.png")]
		public static const IMPACT:Class;
		
		public static var textureImpact:Texture = Texture.fromBitmap(new IMPACT());
		
		[Embed(source="../../../../../bin/assets/images/pictosJoueurs.png")]
		public static const PICTO_MONKEY:Class;
		
		public static var textureMonkey:Texture = Texture.fromBitmap(new PICTO_MONKEY());
		
		[Embed(source="../../../../../bin/assets/images/pictosJoueursEl.png")]
		public static const PICTO_ELEPHANT:Class;
		
		public static var textureElephant:Texture = Texture.fromBitmap(new PICTO_ELEPHANT());
	}

}