package fr.citygame.un.model 
{
	import flash.display.Stage;
	import flash.geom.Point;
	import flash.media.StageVideo;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	/**
	 * ...
	 * @author Jon Lucas
	 */
	public class Config 
	{
		static public var STAGE:Stage;
		
		public static const URL				:String = "http://city-game.appus.fr/air/";
		
		// Temps en millisecondes du timer principal.
		public static const TIMER_DELAY			:uint = 1000;
		
		// Temps de raffraîchissement en secondes des requêtes au serveur.
		public static const REFRESH_PLAYERS_DELAY			:uint = 3;
		
		public static var stageWidth		:Number;
		public static var stageHeight		:Number;
		
		public static var stageVideo		:StageVideo;
		public static var ns				:NetStream;
		public static var nc				:NetConnection;
		
		public static var playerYposition	:Number;
		
		/*
		 * Lattitude longitude
		 * y  		 x
		bas gauche : 47.199175,-1.574628
		bas -droite : 47.199175,-1.560981

		haut droite : 47.208433,-1.560981
		haut gauche : 47.208433,-1.574628
		
		47.205928, -1.567721
		*/
		
		public static var pointHG			:Point 	= new Point( -1.574628, 47.208433);
		public static var pointHD			:Point = new Point( -1.560981, 47.208433);
			
		public static var pointBG			:Point = new Point( -1.574628, 47.199175);
		public static var pointBD			:Point = new Point( -1.560981, 47.199175);
		
		public static var pointAmplitude	:Point = new Point(Config.pointBD.x - Config.pointHG.x, Config.pointBD.y - Config.pointHG.y);
		
		public static var ratioX:Number = 1024 / pointAmplitude.x;
		public static var ratioY:Number = 1024 / pointAmplitude.y;
		
		public static var power:Number = 2;
		
	}

}