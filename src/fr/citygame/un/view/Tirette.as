package fr.citygame.un.view 
{
	import com.greensock.TweenNano;
	import com.jonlucas.utils.Trigonometrie;
	import flash.geom.Point;
	import fr.citygame.un.assets.Assets;
	import fr.citygame.un.data.Data;
	import fr.citygame.un.events.AppEvent;
	import fr.citygame.un.events.NavigationEvent;
	import fr.citygame.un.model.Config;
	import fr.citygame.un.model.ImpactVO;
	import fr.citygame.un.model.LocalisationVO;
	import fr.citygame.un.model.ScreenType;
	import fr.citygame.un.utils.SendReceive;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author Jon Lucas
	 */
	public class Tirette extends Sprite 
	{
		private var _touch:Touch;
		private var _tirette:Image;
		private var _point:Point;
		private var _fleche:Image;
		private var _ruller:Image;
		
		private var _startY:Number;
		
		private var _startTouchY:Number;
		private var _distance:Number;
		
		
		public function Tirette() 
		{	
			_ruller = new Image(Texture.fromBitmap(new Assets.TIRETTE_RULLER()));
			addChild(_ruller);
			_ruller.x = -_ruller.width * .5;
			
			_fleche = new Image(Texture.fromBitmap(new Assets.TIRETTE_ARROW()));
			addChild(_fleche);
			_fleche.x = -_fleche.width * .5;
			_fleche.y = -_fleche.height;
			
			_tirette = new Image(Texture.fromBitmap(new Assets.TIRETTE_BT()));
			_tirette.touchable = true;
			addChild(_tirette);
			//_tirette.scaleX = _tirette.scaleY = 2;
			_tirette.x = -_tirette.width * .5;
			_startY = -_tirette.height * .5;
			_tirette.y = _startY;
		}
		
		public function activateTirette():void
		{
			trace("activateTirette()");
			_tirette.addEventListener(TouchEvent.TOUCH, _touchHandler);
		}
		
		public function deactivateTirette():void
		{
			trace("deactivateTirette()");
			_tirette.removeEventListener(TouchEvent.TOUCH, _touchHandler);
		}
		
		private function _touchHandler(e:TouchEvent):void 
		{
			//trace("TIRETTE : " + e);
			
			_touch = e.getTouch(_tirette);
			
			//trace("TOUCH :: " + _touch);
			
			if(_touch){
			
				switch(_touch.phase) {
					
					case TouchPhase.BEGAN :
						_startTouchY = _touch.globalY;
						break;
						
					case TouchPhase.MOVED :
						_distance = _startTouchY - _touch.globalY;
						_tirette.y = _startY - _distance > _startY ? _startY - _distance : _tirette.y;
						_fleche.y = -_tirette.y -_fleche.height*2;
						break;
						
					case TouchPhase.ENDED :
						if(_tirette.y > _startY + 5){
							deactivateTirette();
							TweenNano.to(_tirette, 0.2, { y: _startY, onComplete:
									function():void
									{
										dispatchEvent(new AppEvent(AppEvent.PLAYER_SHOOTED, true));
									}
							} );
							SendReceive.getInstance().sendShot(1, 1, Data.rotation, Math.abs(_distance)*Config.power);
							/*var point:Object = Trigonometrie.calculCoordonneesPointSurCercle(Data.playerVo.localisation.x, Data.playerVo.localisation.y, _distance, 180, 360);
							trace(Data.playerVo.localisation.x, Data.playerVo.localisation.y, point.x, point.y);
							Data.impactsVo = new Vector.<ImpactVO>();
							Data.impactsVo.push(new ImpactVO(1, 1, new LocalisationVO(0, 0, point.x, point.y), 100));*/
						}
						break;
					
				}
			}
		}
		
	}

}