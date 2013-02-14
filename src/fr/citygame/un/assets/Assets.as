package fr.citygame.un.assets 
{
	import flash.display.MovieClip;
	import fr.citygame.un.utils.UnpackEmbed;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	/**
	 * ...
	 * @author Jon Lucas
	 */
	public class Assets 
	{	
		
		/**
		 * 
		 * SWF
		 * 
		 */
		[Embed(source = "../../../../../bin/assets/swf/singe-attack.swf")]
		public static const SINGE_ATTAK 	: Class;
		public static var mcSingeAttak	 	: UnpackEmbed = new UnpackEmbed(SINGE_ATTAK);
		
		/**
		 * 
		 * MP3
		 * 
		 */
		[Embed(source="../../../../../bin/assets/music/theme.mp3")] 
		public static const THEME 			: Class; 
		
		
		/**
		 *  
		 * SCREENS
		 * 
		 */
		[Embed(source="../../../../../bin/assets/images/interfaceSplashComplete.jpg")]
		public static const SPLASH_SCREEN	: Class;
		
		[Embed(source="../../../../../bin/assets/images/pseudoScreen.jpg")]
		public static const LOG_SCREEN		: Class;
		
		[Embed(source="../../../../../bin/assets/images/patientezOverlay.png")]
		public static const SCREEN_WAIT:Class;
		public static var texWait:Texture = Texture.fromBitmap(new SCREEN_WAIT());
		
		
		/**
		 * 
		 * Graphics
		 * 
		 */
		[Embed(source="../../../../../bin/assets/images/carte.jpg")]
		public static const MAP:Class;
		public static var texMap:Texture = Texture.fromBitmap(new MAP());
		
		/*[Embed(source="../../../../../bin/assets/images/pictosJoueursSi.png")]
		public static const PICTO_MONKEY:Class;
		public static var texMonkey:Texture;
		
		[Embed(source="../../../../../bin/assets/images/pictosJoueursEl.png")]
		public static const PICTO_ELEPHANT:Class;
		public static var texElephant:Texture;	*/
		
		/**
		 * 
		 * SpriteSheets
		 * 
		 */
		[Embed(source="../../../../../bin/assets/images/explosions.png")]
		public static const IMPACT_SPRITE_SHEET:Class;
		
		[Embed(source="../../../../../bin/assets/xml/explosions.xml", mimeType = "application/octet-stream")]
		public static const IMPACT_XML:Class;
		public static var texAtlasImpact:TextureAtlas = new TextureAtlas(Texture.fromBitmap(new IMPACT_SPRITE_SHEET()), XML(new IMPACT_XML()));
		
		
		/**
		 * 
		 * UI
		 * 
		 */
		[Embed(source = "../../../../../bin/assets/images/tiretteButton.png")]
		public static const TIRETTE_BT		:Class;
		public static var texTiretteButton:Texture = Texture.fromBitmap(new TIRETTE_BT());
		
		[Embed(source = "../../../../../bin/assets/images/tiretteArrow.png")]
		public static const TIRETTE_ARROW	:Class;
		public static var texTiretteArrow:Texture = Texture.fromBitmap(new TIRETTE_ARROW()); 
		
		[Embed(source = "../../../../../bin/assets/images/tiretteRuller.png")]
		public static const TIRETTE_RULLER	:Class;
		public static var texTiretteRuller:Texture = Texture.fromBitmap(new TIRETTE_RULLER());	 
		
		[Embed(source="../../../../../bin/assets/images/btnStartUp.png")]
		public static const BTN_START_UP:Class;
		public static var texBtnStartUp:Texture = Texture.fromBitmap(new BTN_START_UP());	
		
		[Embed(source="../../../../../bin/assets/images/btnStartDown.png")]
		public static const BTN_START_DOWN:Class;
		public static var texBtnStartDown:Texture = Texture.fromBitmap(new BTN_START_DOWN());
		
	}

}