package fr.citygame.un.assets 
{
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	/**
	 * ...
	 * @author Jon Lucas
	 */
	public class Assets 
	{
		[Embed(source="../../../../../bin/assets/music/theme.mp3")] 
		public static const THEME : Class; 		 
		
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
		
		//////////////// NEW
		
		[Embed(source="../../../../../bin/assets/images/explosions.png")]
		public static const SPRITE_SHEET_IMPACT:Class;
		
		public static var textureImpact:Texture = Texture.fromBitmap(new SPRITE_SHEET_IMPACT());
		
		[Embed(source="../../../../../bin/assets/xml/explosions.xml", mimeType = "application/octet-stream")]
		public static const SPRITE_SHEET_XML:Class;
		
		public static var xml:XML = XML(new Assets.SPRITE_SHEET_XML());
		public static var impactTextureAltas:TextureAtlas = new TextureAtlas(textureImpact, xml);
		
		[Embed(source="../../../../../bin/assets/images/pictosJoueursSi.png")]
		public static const PICTO_MONKEY:Class;
		
		public static var textureMonkey:Texture = Texture.fromBitmap(new PICTO_MONKEY());
		
		[Embed(source="../../../../../bin/assets/images/pictosJoueursEl.png")]
		public static const PICTO_ELEPHANT:Class;
		
		public static var textureElephant:Texture = Texture.fromBitmap(new PICTO_ELEPHANT());
		
		[Embed(source="../../../../../bin/assets/images/btnStartUp.png")]
		public static const BTN_UP:Class;
		
		[Embed(source="../../../../../bin/assets/images/btnStartDown.png")]
		public static const BTN_DOWN:Class;
		
		[Embed(source="../../../../../bin/assets/images/patientezOverlay.png")]
		public static const SCREEN_WAIT:Class;
		
		public static var textureWait:Texture = Texture.fromBitmap(new SCREEN_WAIT());
	}

}