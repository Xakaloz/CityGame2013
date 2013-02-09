package fr.citygame.un.model 
{
	/**
	 * ...
	 * @author Jon Lucas
	 */
	public class VideoVO 
	{
		
		private var _path:String;
		
		
		public function VideoVO(pPath:String) 
		{
			path = pPath;
		}
		
		public function get path():String 
		{
			return _path;
		}
		
		public function set path(value:String):void 
		{
			_path = value;
		}
		
	}

}