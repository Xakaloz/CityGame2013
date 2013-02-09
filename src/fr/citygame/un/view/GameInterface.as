package fr.citygame.un.view 
{
	import com.greensock.TweenNano;
	import flash.events.TimerEvent;
	import flash.events.TouchEvent;
	import flash.utils.Timer;
	import fr.citygame.un.data.Data;
	import fr.citygame.un.events.AppEvent;
	import fr.citygame.un.model.Config;
	import fr.citygame.un.utils.SendReceive;
	import starling.display.Quad;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author Jon Lucas
	 */
	public class GameInterface extends Sprite implements IScreen
	{
		private var _map:MapContainer;
		private var _tirette:Tirette;
		
		private var _timers:Timers;
		
		private var _timer:Timer;
		private var _filtre:Quad;
		
		public function GameInterface() 
		{
			Config.playerYposition = Config.stageHeight * 2 / 3;
			
			_timer = new Timer(Config.TIMER_DELAY);
			
			_map = new MapContainer();
			_map.initPosition();
			addChild(_map);
			
			_timers = new Timers();
			_timers.y = 50;
			addChild(_timers);
		}
		
		public function onTick(event:TimerEvent = null):void 
		{
			_map.onTick();
			
			_timers.onTick();
		}
		
		private function _activateFireMode():void
		{
			if (_tirette == null) {
				_tirette = new Tirette();
				_tirette.x = Config.stageWidth * .5;
				_tirette.y = Config.playerYposition;
				addChild(_tirette);
			}
			
			_tirette.activateTirette();
			
			_tirette.addEventListener(AppEvent.PLAYER_SHOOTED, onPlayerShootedHandler);
		}
		
		private function onPlayerShootedHandler(e:AppEvent):void 
		{
			_tirette.removeEventListener(AppEvent.PLAYER_SHOOTED, onPlayerShootedHandler);
			
			_filtre = new Quad(Config.stageWidth, Config.stageHeight);
			_filtre.color = 0x000000;
			_filtre.alpha = .8;
			addChild(_filtre);
		}
		
		private function _deactivateFireMode():void
		{
			if (_tirette) {
				_tirette.deactivateTirette();
				_tirette.removeEventListener(AppEvent.PLAYER_SHOOTED, onPlayerShootedHandler);
			}
		}
		
		/* INTERFACE fr.citygame.un.view.IScreen */
		public function transiIn(params:Object = null):void 
		{
			this.alpha = 0;
			x = Config.stageWidth;
			
			TweenNano.to(this, .5, { alpha: 1, x: 0, onComplete:
				function():void {
					_map.transiIn();
					addListeners();
					// Déclenche le onTick avavnt de lancer le compeur pour récupérer les joueurs au démarrage.
					onTick();
					_timer.start();
				}
			} );
		}
		
		public function transiOut():void 
		{
			TweenNano.to(this, 0.5, { alpha: 0, x: -width } );
			
			removeListeners();
			
			_timer.reset();
			
			_map.transiOut();
		}
		
		public function addListeners():void 
		{
			_timer.addEventListener(TimerEvent.TIMER, onTick);
			
			_activateFireMode();
		}
		
		public function removeListeners():void 
		{
			_timer.removeEventListener(TimerEvent.TIMER, onTick);
			
			_deactivateFireMode();
		}

		
	}

}