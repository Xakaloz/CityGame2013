package fr.citygame.un.model 
{
	/**
	 * ...
	 * @author Jon Lucas
	 */
	public class TeamVO 
	{
		private var _id		:uint;
		
		private var _name	:String;
		
		private var _color	:Number;
		
		private var _score	:Number;
		
		
		public function TeamVO(pId:uint, pName:String, pColor:Number, pScore:Number) 
		{
			id = pId;
			
			name = pName;
			
			color = pColor;
			
			score = pScore;
		}
		
		public function get id():uint 
		{
			return _id;
		}
		
		public function set id(value:uint):void 
		{
			_id = value;
		}
		
		public function get name():String 
		{
			return _name;
		}
		
		public function set name(value:String):void 
		{
			_name = value;
		}
		
		public function get color():Number 
		{
			return _color;
		}
		
		public function set color(value:Number):void 
		{
			_color = value;
		}
		
		public function get score():Number 
		{
			return _score;
		}
		
		public function set score(value:Number):void 
		{
			_score = value;
		}
		
	}

}