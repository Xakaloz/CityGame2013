package fr.citygame.un.model 
{
	import flash.media.StageVideo;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	/**
	 * ...
	 * @author Jon Lucas
	 */
	public class Config 
	{
		
		public static const URL				:String = "http://addn.cleverapps.io/air/";
		
		public static var stageWidth		:Number;
		public static var stageHeight		:Number;
		
		public static var stageVideo		:StageVideo;
		
		public static var ns				:NetStream;
		
		public static var nc				:NetConnection;
		
	}

}