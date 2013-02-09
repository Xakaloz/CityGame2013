package fr.citygame.un.view 
{
	import com.greensock.TweenNano;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	import fr.citygame.un.data.Data;
	import fr.citygame.un.events.CompassEvent;
	import fr.citygame.un.events.GpsEvent;
	import fr.citygame.un.model.Config;
	import fr.citygame.un.model.LocalisationVO;
	import fr.citygame.un.utils.CompassUtils;
	import fr.citygame.un.utils.GeolocUtils;
	import fr.citygame.un.utils.SendReceive;
	import starling.display.Sprite;
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
		private var _localisationVo:LocalisationVO;
		private var _timer:Timer;
		private var _player:Player;
		private var _tabPlayers:Vector.<Player>;
		
		private var temp:int;
		private var i:int;
		
		public function MapContainer() 
		{
			scaleX *= 1;
			scaleY *= 1;
			
			_tabPlayers = new Vector.<Player>();
			
			_localisationVo = new LocalisationVO(0, 0, 0, 0);
			_localisationVo.setGeolocValues(47.205555, -1.566658);
			
			_timer = new Timer(Config.DELAY);
			
			updatePosition(_localisationVo.x, _localisationVo.y);
			
			_map = new Map();
			addChild(_map);	
			
			_compassUtils = new CompassUtils();
			
			_gpsUtils = new GeolocUtils();
			_gpsUtils.start();
			
			//createPlayer(47.203541, -1.565986);
			//createPlayer(47.204503,-1.568303);
			//createPlayer(47.205898,-1.567742);
		}
		
		private function onGpsUpdate(e:GpsEvent):void 
		{
			trace("UDPATE GPS");
			//_localisationVo = new LocalisationVO(0, 0, 0, 0);
			//_localisationVo.setGeolocValues(47.204979, -1.563289);
			//_localisationVo.setGeolocValues(47.205898,-1.567731);
			
			_localisationVo.setGeolocValues(e.latitude, e.longitude);
			
			updatePosition(_localisationVo.x, _localisationVo.y);
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
			
		private function onTick(e:TimerEvent = null):void 
		{
			temp = _tabPlayers.length;
			for (i = 0; i < temp; i++)
			{
				removeChild(_tabPlayers[i]);
			}
			
			if (Data.playersVo && Data.playersVo.length > 0)
			{
				temp = Data.playersVo.length;
				for (i = 0; i < temp; i++)
				{
					_player = new Player(Data.playersVo[i]);
					addChild(_player);
					
					_tabPlayers.push(_player);
				}
			}
			
			SendReceive.getInstance().getJoueurs();
			
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
			
			alpha = 0;
			
			TweenNano.to(this, .5, { alpha: 1 } );
			
			onTick();
			
			_timer.start();
			addListeners();
		}
		
		public function transiOut():void 
		{
			_timer.reset();
			removeListeners();
			
			TweenNano.to(this, 0.5, { alpha : 0 } );
		}
		
		public function addListeners():void 
		{
			_gpsUtils.addEventListener(GpsEvent.UPDATE, onGpsUpdate);
			_compassUtils.addEventListener(CompassEvent.UPDATE, onCompassUpdate);
			
			_timer.addEventListener(TimerEvent.TIMER, onTick);
		}
		
		public function removeListeners():void 
		{
			_gpsUtils.removeEventListener(GpsEvent.UPDATE, onGpsUpdate);
			_compassUtils.removeEventListener(CompassEvent.UPDATE, onCompassUpdate);
			
			_timer.removeEventListener(TimerEvent.TIMER, onTick);
		}
		
		public function initPosition():void 
		{
			x = Config.stageWidth * .5;
			y = Config.playerYposition;
		}
	}

}