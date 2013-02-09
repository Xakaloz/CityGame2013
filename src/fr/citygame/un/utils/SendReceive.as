package fr.citygame.un.utils 
{
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import fr.citygame.un.model.Config;
	import fr.citygame.un.model.LocalisationVO;
	
	/**
	 * ...
	 * @author Jon Lucas
	 */
	public class SendReceive 
	{		
		private var _loader						:URLLoader;
		private var _urlVars					:URLVariables;
		private var _request					:URLRequest;
		
		//SINGLETON vars
		private static var instance             :SendReceive;  //holds the singleton instance
		private static var allowInstance        :Boolean;      //indicates if singleton instance was already created

	   
		/**
		 * SINGLETON - class constructor
		 * this class constructor can be called only once by the getInstance() method which sets allowInstance to true
		 * other calls outside this class like "new Model()" will result in an error
		 */        
		public function SendReceive() {
			if(allowInstance == false) {
				//throw new Error("Error: use ModelLocator.getInstance() instead of new keyword");
			}
		}
		
		public function initGame(pPseudo:String):void
		{
			_urlVars = new URLVariables();
			_urlVars.pseudo = pPseudo;
			
			_request = new URLRequest(Config.URL + "getDatasInit");
			_request.data = _urlVars;
			_request.method = URLRequestMethod.POST;
			
			_send(_request);
           
        }
		
		private function _send(pRequest:URLRequest):void 
		{
			if(_loader == null){
				_loader = new URLLoader();
				configureListeners(_loader);
			}
			
			try {
                _loader.load(pRequest);
            } catch (error:Error) {
                trace("Unable to load requested document.");
            }
		}
		
		public function getJoueurs():void
		{
			_request = new URLRequest(Config.URL + "getJoueurs");
			_request.method = URLRequestMethod.POST;
            
			_send(_request);
        }
		
		
		public function sendPlayerMove(pIdPlayer:uint, pLocalisation:LocalisationVO):void
		{
			_urlVars = new URLVariables();
			_urlVars.id_joueur = 1;
			_urlVars.latitude = pLocalisation.x;
			_urlVars.longitude = pLocalisation.y;
			
            _request = new URLRequest(Config.URL + "deplacement");
			_request.data = _urlVars;
			_request.method = URLRequestMethod.POST;
			
           _send(_request);
        }
		
		public function sendShot(pIdPlayer:uint, pIdWeapon:uint, pDirection:Number, pPuissance:Number):void
		{
			_urlVars = new URLVariables();
			_urlVars.id_joueur = pIdPlayer;
			_urlVars.id_arme = pIdWeapon;
			_urlVars.direction = pDirection;
			_urlVars.puissance = pPuissance;
			
            _request = new URLRequest(Config.URL + "tir");
			_request.data = _urlVars;
			_request.method = URLRequestMethod.POST;
			
           _send(_request);
        }
 
        private function configureListeners(dispatcher:IEventDispatcher):void {
            dispatcher.addEventListener(Event.COMPLETE, completeHandler);
            dispatcher.addEventListener(Event.OPEN, openHandler);
            dispatcher.addEventListener(ProgressEvent.PROGRESS, progressHandler);
            dispatcher.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
            dispatcher.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
            dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
        }
 
        private function completeHandler(event:Event):void {
            trace("completeHandler: " + _loader.data);
        }
 
        private function openHandler(event:Event):void {
            trace("openHandler: " + event);
        }
 
        private function progressHandler(event:ProgressEvent):void {
            trace("progressHandler loaded:" + event.bytesLoaded + " total: " + event.bytesTotal);
        }
 
        private function securityErrorHandler(event:SecurityErrorEvent):void {
            trace("securityErrorHandler: " + event);
        }
 
        private function httpStatusHandler(event:HTTPStatusEvent):void {
            trace("httpStatusHandler: " + event);
        }
 
        private function ioErrorHandler(event:IOErrorEvent):void {
            trace("ioErrorHandler: " + event);
        }
		
		/**
		 * SINGLETON - get instance
		 * this function makes sure the singleton instance exists only once
		 * if the getInstance() is called the first time, an instance of Singleton will be created
		 * the existing instance is returned
		 */        
		public static function getInstance():SendReceive
		{
			if(instance == null) {
				allowInstance = true;
				instance = new SendReceive();
				//trace("ModelLocator instance created");
				allowInstance = false;
			}
			else{
				//trace("ModelLocator instance already exists.");
			}
			return instance;
		}
		
	}

}