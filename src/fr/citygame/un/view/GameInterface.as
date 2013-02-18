package fr.citygame.un.view 
{
	import com.greensock.TweenNano;
	import com.jonlucas.utils.Utils;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import fr.citygame.un.assets.Assets;
	import fr.citygame.un.data.Data;
	import fr.citygame.un.events.AppEvent;
	import fr.citygame.un.model.Config;
	import fr.citygame.un.model.PhasesDeJeu;
	import fr.citygame.un.utils.SendReceive;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	import starling.utils.deg2rad;
	import starling.utils.rad2deg;
	
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
		//private var _image:Image;
		
		private var btLeft:Button;
		private var btRight:Button;
		private var _count:uint;
		
		private var _sr:SendReceive;
		
		public function GameInterface() 
		{			
			Config.playerYposition = Config.stageHeight * 2 / 3;
			
			_sr = SendReceive.getInstance();
			
			_timer = new Timer(Config.TIMER_DELAY);
			
			_map = new MapContainer();			
			_map.initPosition();
			addChild(_map);
			
			btLeft = new Button(Texture.fromColor(40, 40, 0xCCFFFFFF), "<", null);
			btLeft.x = 60;
			btLeft.y = Config.stageHeight - 280;
			addChild(btLeft);
			
			btRight = new Button(Texture.fromColor(40, 40, 0xCCFFFFFF), ">", null);
			btRight.x = Config.stageWidth - 20 - 80;
			btRight.y = Config.stageHeight - 280;
			addChild(btRight);
			
			_timers = new Timers();
			_timers.y = 10;
			addChild(_timers);
		}
		
		public function onTick(event:TimerEvent = null):void 
		{
			_count++;
			
			_map.onTick();
			
			_timers.onTick();
			
			if (_count == Config.REFRESH_PLAYERS_DELAY) {
				_sr.sendPlayerMove();
				_sr.getPlayers();
				_count = 0;
			}
		}
		
		private function _activateFireMode():void
		{
			if (_tirette == null) {
				_tirette = new Tirette();
				_tirette.x = Config.stageWidth * .5;
				_tirette.y = Config.playerYposition;
				_tirette.alpha = 0;
				addChild(_tirette);
			}
			
			TweenNano.to(_tirette, .5, { alpha:1, onComplete:
				function():void
				{
					_tirette.activateTirette();
					_tirette.addEventListener(AppEvent.PLAYER_SHOOTED, onPlayerShootedHandler);
				}
			} );
		}
		
		private function onPlayerShootedHandler(e:AppEvent):void 
		{
			_tirette.removeEventListener(AppEvent.PLAYER_SHOOTED, onPlayerShootedHandler);
			
			_deactivateFireMode();
			
			/*_image = new Image(Assets.textureWait);
			addChild(_image);*/
		}
		
		private function _deactivateFireMode():void
		{
			if (_tirette) {
				_tirette.deactivateTirette();
				_tirette.removeEventListener(AppEvent.PLAYER_SHOOTED, onPlayerShootedHandler);
				TweenNano.to(_tirette, .5, { alpha: 0 } );
			}
		}
		
		/* INTERFACE fr.citygame.un.view.IScreen */
		public function transiIn(params:Object = null):void 
		{
			this.alpha = 0;
			x = Config.stageWidth;
			_count = 0;
			
			// Déclenche le onTick avant de lancer le compteur pour récupérer les joueurs au démarrage.
			onTick();
					
			TweenNano.to(this, .5, { alpha: 1, x: 0, onComplete:
				function():void {
					_map.transiIn();
					addListeners();
					if(Data.playerVo.life > 0)	_activateFireMode();
					else 						_deactivateFireMode();
					_timer.start();
				}
			} );
		}
		
		public function transiOut():void 
		{
			TweenNano.to(this, 0.5, { alpha: 0, x: -width } );
			
			_deactivateFireMode();
			
			removeListeners();
			
			_timer.reset();
			
			_map.transiOut();
			
			//_image = Utils.removeChild(_image, this);
		}
		
		public function addListeners():void 
		{
			_timer.addEventListener(TimerEvent.TIMER, onTick);
			btLeft.addEventListener(TouchEvent.TOUCH, _btLeftTouchHandler);
			btRight.addEventListener(TouchEvent.TOUCH, _btRightTouchHandler);
		}
		
		private function _btLeftTouchHandler(e:TouchEvent):void 
		{
			var touch:Touch = e.getTouch(btLeft);
			
			if(touch){
				switch(touch.phase) {
					
					case TouchPhase.BEGAN :
						_map.rotation = deg2rad(rad2deg(_map.rotation) - 1);
						Data.rotation = _map.rotation;
						break;
					
					default : break;
				}
			}
		}
		
		private function _btRightTouchHandler(e:TouchEvent):void 
		{
			var touch:Touch = e.getTouch(btRight);
			
			if(touch){
				switch(touch.phase) {
					
					case TouchPhase.BEGAN :
						_map.rotation = deg2rad(rad2deg(_map.rotation) + 1);
						Data.rotation = _map.rotation;
						break;
					
					default : break;
				}
			}
		}
		
		public function removeListeners():void 
		{
			_timer.removeEventListener(TimerEvent.TIMER, onTick);
			
			btLeft.removeEventListener(TouchEvent.TOUCH, _btLeftTouchHandler);
			btRight.removeEventListener(TouchEvent.TOUCH, _btRightTouchHandler);			
		}

		
	}

}