package fr.citygame.un.view 
{
	import com.greensock.easing.Linear;
	import com.greensock.TweenNano;
	import starling.display.Sprite;
	import starling.text.TextField;
	
	/**
	 * ...
	 * @author Jon Lucas
	 */
	public class LifePoints extends Sprite 
	{
		
		private var _tf:TextField;
		
		public function LifePoints() 
		{			
			pivotX = 50;
			pivotY = 40;
			
			_tf = new TextField(100, 40, "", "Verdana", 16, 0x000000, true);
			_tf.hAlign = "center";
			_tf.border = true;
			addChild(_tf);
		}
		
		public function animate(pValue:String):void
		{
			clear();
			
			_tf.text = pValue;
			
			TweenNano.to(this, 1, { alpha: 1, scaleX: 1, scaleY: 1, y: -50, ease: Linear.easeNone, onComplete: fadeOut} );
		}
		
		public function fadeOut():void 
		{
			TweenNano.to(this, .5, {alpha: 0, y: -60, onComplete: clear, ease: Linear.easeNone  } )
		}
		
		public function clear():void 
		{
			_tf.text = "";
			y = 0;
			alpha = 0;
			scaleX = scaleY = 0;
		}
		
	}

}