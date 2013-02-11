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
		
		private var _player:Player;
		private var _tabPlayers:Vector.<Player>;
		
		private var _impact:Impact;
		private var _tabImpacts:Vector.<Impact>;
		
		private var _count:uint;
		
		private var temp:int;
		private var i:int;
		
		public function MapContainer() 
		{
			alpha = 0;
			
			/*scaleX *= .5;
			scaleY *= .5;*/
			
			_tabPlayers = new Vector.<Player>();
			
			_tabImpacts = new Vector.<Impact>();
			
			Data.playerVo.localisation = new LocalisationVO(0, 0, 0, 0);
			Data.playerVo.localisation.setGeolocValues(47.205555, -1.566658);
			
			updatePosition(Data.playerVo.localisation.x, Data.playerVo.localisation.y);
			
			_map = new Map();
			addChild(_map);	
			
			this.rotation = deg2rad(0);
			
			Data.rotation = this.rotation;
			
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
			//Data.playerVo.localisation = new LocalisationVO(0, 0, 0, 0);
			//Data.playerVo.localisation.setGeolocValues(47.204979, -1.563289);
			//Data.playerVo.localisation.setGeolocValues(47.205898,-1.567731);
			
			Data.playerVo.localisation.setGeolocValues(e.latitude, e.longitude);
			
			updatePosition(Data.playerVo.localisation.x, Data.playerVo.localisation.y);
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
			
		public function onTick():void 
		{
			_count ++;
			
			while (_tabPlayers.length > 0)
			{
				removeChild(_tabPlayers[0]);
				_tabPlayers.shift();
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
			
			temp = _tabImpacts.length;
			for (i = 0; i < temp; i++)
			{
				removeChild(_tabImpacts[i]);
			}

			if (Data.impactsVo){			
				while(Data.impactsVo.length > 0){
					_impact = new Impact(Data.impactsVo[0]);
					addChild(_impact);
					
					Data.impactsVo.shift();
					
					_tabImpacts.push(_impact);
				}
			}

			if (_count == Config.REFRESH_PLAYERS_DELAY) {
				SendReceive.getInstance().sendPlayerMove();
				SendReceive.getInstance().getJoueurs();
				//SendReceive.getInstance().getImpacts();
				_count = 0;
			}
			
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
			trace("transiIn()");
			
			alpha = 0;
			
			TweenNano.to(this, .5, { alpha: 1 } );
			
			_count = 0;
			
			SendReceive.getInstance().getImpacts();
			
			addListeners();
		}
		
		public function transiOut():void 
		{
			removeListeners();
			
			TweenNano.to(this, 0.5, { alpha : 0 } );
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