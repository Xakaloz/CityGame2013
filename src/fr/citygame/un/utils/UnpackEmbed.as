package fr.citygame.un.utils 
{

	import flash.events.EventDispatcher;
	import mx.core.MovieClipAsset;

	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.events.Event;

	public class UnpackEmbed extends EventDispatcher
	{

		private var _asset:MovieClipAsset;
		private var _content:MovieClip;
		private var _info:LoaderInfo;
		private var _loader:Loader;

		public function UnpackEmbed(assetClass:Class)
		{
			_asset = new assetClass();

			_loader = Loader(_asset.getChildAt(0));
			_info = _loader.contentLoaderInfo;
			_info.addEventListener(Event.COMPLETE, onLoadComplete);
		}

		private function onLoadComplete(event:Event):void
		{
			_info.removeEventListener(Event.COMPLETE, onLoadComplete);
			_content = MovieClip(_info.loader.content);
			_content.gotoAndStop(0);
			dispatchEvent(new Event(Event.COMPLETE));
		}

		public function get content():MovieClip
		{
			return _content;
		}

		public function get asset():MovieClipAsset
		{
			return _asset;
		}
	}

}