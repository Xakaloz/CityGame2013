package fr.citygame.un.view 
{
	import flash.geom.Point;
	import fr.citygame.un.assets.Assets;
	import fr.citygame.un.data.Data;
	import fr.citygame.un.events.CompassEvent;
	import fr.citygame.un.events.GpsEvent;
	import fr.citygame.un.model.Config;
	import fr.citygame.un.model.LocalisationVO;
	import fr.citygame.un.utils.CompassUtils;
	import fr.citygame.un.utils.GeolocUtils;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	import starling.utils.deg2rad;
	
	
	/**
	 * ...
	 * @author Jon Lucas
	 */
	public class MapContainer extends Sprite implements IScreen
	{
		
		private var _compassUtils:CompassUtils;
		
		private var _map:Map;
		private var _gpsUtils:GeolocUtils;
		private var _player:Image;
		private var _localisationVo:LocalisationVO;
		
		
		public function MapContainer() 
		{
			scaleX *= 2;
			scaleY *= 2;
			
			_localisationVo = new LocalisationVO(0, 0, 0, 0);
			//_localisationVo.setGeolocValues(47.204979, -1.563289);
			
			//updatePosition(_localisationVo.x, _localisationVo.y);
			
			_map = new Map();
			addChild(_map);	
			
			_compassUtils = new CompassUtils();
			
			_gpsUtils = new GeolocUtils();
			_gpsUtils.start();
			
			
			_player = new Image(Texture.fromBitmap(new Assets.SQUARE_RED()));
			addChild(_player);
			
			_player.pivotX = _player.width / 2;
			_player.pivotY = _player.height / 2;
			
			_player.x = _localisationVo.x;
			_player.y = _localisationVo.y;
			
			//createPlayer(47.203541, -1.565986);
			//createPlayer(47.204503,-1.568303);
			//createPlayer(47.205898,-1.567742);
		}
		
		private function createPlayer(longitude:Number, lattitude:Number):void 
		{
			var localisationVoP:LocalisationVO = new LocalisationVO(0, 0, 0, 0);
			localisationVoP.setGeolocValues(longitude, lattitude);
			
			var player:Image = new Image(Texture.fromBitmap(new Assets.SQUARE()));
			addChild(player);
			
			player.pivotX = player.width / 2;
			player.pivotY = player.height / 2;
			
			player.x = localisationVoP.x;
			player.y = localisationVoP.y;
		}
		
		private function onGpsUpdate(e:GpsEvent):void 
		{
			trace("UDPATE GPS");
			//_localisationVo = new LocalisationVO(0, 0, 0, 0);
			//_localisationVo.setGeolocValues(47.204979, -1.563289);
			//_localisationVo.setGeolocValues(47.205898,-1.567731);
			
			_localisationVo.setGeolocValues(e.latitude, e.longitude);
			
			updatePosition(_localisationVo.x, _localisationVo.y);
			
			_player.x = _localisationVo.x;
			_player.y = _localisationVo.y;
		}
		
		private function updatePosition(x:Number, y:Number):void
		{
			var memX:Number = this.pivotX;
			var memY:Number = this.pivotY;
			
			var memPoint:Point = new Point(memX, memY);
			memPoint = this.localToGlobal(memPoint);
			
			var point:Point = new Point(x, y);
			point = this.localToGlobal(point);
			
			this.pivotX = x;
			this.pivotY = y;
			
			trace(point.x - memPoint.x);
			
			//this.x += point.x - memPoint.x;
			//this.y += point.y - memPoint.y;
			
			//trace("X : " + this.x);
			//trace("pivot X : "+this.pivotX);
		}
		
		private function onCompassUpdate(e:CompassEvent):void 
		{
			//trace(e.level);
			
			//TweenMax.to(this, 0.2, { shortRotation:{ rotation: deg2rad(e.level), useRadians:true}, overwrite: true } );
			
			this.rotation = deg2rad(e.level);
			
			Data.rotation = this.rotation;
		}
		
		/* INTERFACE fr.citygame.un.view.IScreen */
		
		public function transiIn(params:Object = null):void 
		{
			//TweenNano.to(this, 0.2, { alpha : 1 } );
			
			trace("transiIn()");
			
			addListeners();
		}
		
		public function transiOut():void 
		{
			removeListeners();
			
			//TweenNano.to(this, 0.2, { alpha : 0 } );
		}
		
		public function addListeners():void 
		{
			_gpsUtils.addEventListener(GpsEvent.UPDATE, onGpsUpdate);
			_compassUtils.addEventListener(CompassEvent.UPDATE, onCompassUpdate);
		}
		
		public function removeListeners():void 
		{
			_gpsUtils.removeEventListener(GpsEvent.UPDATE, onGpsUpdate);
			_compassUtils.removeEventListener(CompassEvent.UPDATE, onCompassUpdate);
		}
		
		public function initPosition():void 
		{
			x = Config.stageWidth * .5;
			y = Config.playerYposition;
		}
	}

}