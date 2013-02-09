package fr.citygame.un.view 
{
	import flash.geom.Point;
	import fr.citygame.un.events.CompassEvent;
	import fr.citygame.un.utils.CompassUtils;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	import starling.utils.deg2rad;
	
	/**
	 * ...
	 * @author Félix Ardeois // Opixido
	 */
	public class Map extends Sprite 
	{
		
		[Embed(source="../../../../../bin/assets/images/carte1024.jpg")]
		public static const MAP:Class;
		
		private var _image:Image;
		private var _compassUtils:CompassUtils;
		
		public function Map() 
		{
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		private function addedToStageHandler(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			
			_image = new Image(Texture.fromBitmap(new MAP()));
			addChild(_image);
			
			//_image.pivotX = _image.width / 2;
			//_image.pivotY = _image.height / 2;
			
			this.pivotX = this.width / 2;
			this.pivotY = this.height / 2;
			
			this.addEventListener(TouchEvent.TOUCH, onTouch);
			
			_compassUtils = new CompassUtils();
			_compassUtils.addEventListener(fr.citygame.un.events.CompassEvent.UPDATE, onCompassUpdate);
		}
		
		private function onCompassUpdate(e:CompassEvent):void 
		{
			this.rotation = deg2rad(e.level);
		}
		
		public function centerMap(x:Number, y:Number):void
		{
			
		}
		
		private function onTouch(e:TouchEvent):void 
		{
			var touch:Touch = e.getTouch(this);
			if(touch.phase == TouchPhase.ENDED)
			{
				var memX:Number = this.pivotX;
				var memY:Number = this.pivotY;
				
				var memPoint:Point = new Point(memX, memY);
				memPoint = this.localToGlobal(memPoint);
				
				var point:Point = new Point(touch.globalX, touch.globalY);
				point = this.globalToLocal(point);
				
				this.pivotX = point.x;
				this.pivotY = point.y;
				
				this.x += touch.globalX - memPoint.x;
				this.y += touch.globalY - memPoint.y;
				
				trace("Pivot X "+this.pivotX);
				trace("Pivot Y "+this.pivotY);
				trace("______");
				trace("");
			}
			/*
			if(Vibration.isSupported)
			{
				var vb:Vibration = new Vibration();
				vb.vibrate(2000);
			}
			*/
		}
	}

}