package fr.citygame.un.view 
{
	import starling.display.Quad;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author Jon Lucas
	 */
	public class LifeBar extends Sprite 
	{
		private var _filtre:Quad;
		private var _filtreBlack:Quad;
		
		private var _oldLife:Number;
		
		private var _lifePoints:LifePoints;
		
		private var _width:Number;
		
		
		public function LifeBar(pWidth:Number) 
		{
			_width = pWidth;
			
			_filtreBlack = new Quad(_width, 7);
			_filtreBlack.color = 0x000000;
			_filtreBlack.alpha = .8;
			addChild(_filtreBlack);
			
			_filtreBlack.pivotX = _width / 2;
			_filtreBlack.y = -29;
			
			_filtre = new Quad(_width - 2, 5);
			_filtre.color = 0x00d805;
			_filtre.alpha = .8;
			addChild(_filtre);
			
			_filtre.x = _filtreBlack.x - _width / 2 + 1;
			_filtre.y = -28;
			
			_oldLife = 100;
		}
		
		public function update(pLife:Number):void
		{
			if (_oldLife > pLife) {
				if (_lifePoints == null) {
					_lifePoints = new LifePoints();
					_lifePoints.y = -10;
					addChild(_lifePoints);
				}
				_lifePoints.animate(String(pLife - _oldLife));
			}
			
			_filtre.scaleX = pLife > 0 ? pLife / 100 : 0;
		}
		
	}

}