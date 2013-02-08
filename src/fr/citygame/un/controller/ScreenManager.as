package fr.citygame.un.controller
{
	

	import flash.display.Sprite;
	import fr.citygame.un.view.IScreen;
	
	
	/**
	 * ...
	 * @author Jon Lucas
	 */
	public class ScreenManager
	{
		public var current:String;
		public var previous:String;
		
		private var _screens:Object;
		
		private var _view:Sprite;
		
		/**
		 * 
		 * @param	view
		 */
		public function ScreenManager(view:Sprite)
		{
			_view = view;
			
			_screens = new Object();
		}
		
		/**
		 * Affiche l'écran correspondant au nom passé en paramètre
		 * s'il n'est pas déjà affiché et que l'on peut y accéder depuis
		 * l'écran en cours.
		 * 
		 * @param	name	: Nom de l'écran à afficher.
		 * @param	params	: Object
		 * @param	depth	: Position sur z
		 */
		public function setScreen(name:String, params:Object = null, depth:uint = 0):void
		{
			// Premier écran affiché.
			if (current == null)
			{
				current = name;
				_screens[current].screen.transiIn(params);
				// Ajout de l'écran sur la scène.
				if(!_view.contains(_screens[current].screen)){
					trace("Ajout de l'écran " + name + " sur la scène.");
					_view.addChildAt(_screens[current].screen, depth);
				}
				return;
			}
			
			// Ecran en cours.
			if (current == name)
			{
				trace("L'écran " + name + " est déjà affiché.");
				return;
			}
			
			// Vérifie que l'écran appelé peut être affiché depuis l'écran actuel.
			if (_screens[current].from.indexOf(name) != -1 )
			{
				_screens[current].screen.transiOut();
				previous = current;
				current = name;
			}
			else
			{
				trace("L'écran " + name + " ne peut pas être affiché depuis l'écran actuel " + current + ".");
				return;
			}
			
			// Lance la transition d'introduction de l'écran.
			_screens[current].screen.transiIn(params);
			// Ajout de l'écran sur la scène.
			if(!_view.contains(_screens[current].screen)){
				trace("Ajout de l'écran " + name + " sur la scène.");
				_view.addChildAt(_screens[current].screen, depth);
			}
		}
		
		
		/**
		 * Ajoute un écran.
		 * 
		 * @param	name		: Nom unique de l'écran.
		 * @param	screenObj 	: Ecran à ajouter.
		 * @param	fromScreens : Array contenant les écrans depuis lesquelles on peut accéder à cet écran.
		 */
		public function addScreen(name:String, screenObj:IScreen, fromScreens:Array):void
		{			
			_screens[name] = { screen:screenObj, from:fromScreens.toString() };
		}
		
		/**
		 * Renvoie l'écran actuel.
		 */
		public function getCurrent():IScreen
		{
			return _screens[current].screen;
		}
		
	}

}