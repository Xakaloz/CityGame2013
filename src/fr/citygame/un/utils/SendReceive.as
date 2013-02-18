package fr.citygame.un.utils 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
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
	import fr.citygame.un.data.Data;
	import fr.citygame.un.data.DataParser;
	import fr.citygame.un.events.DataEvent;
	import fr.citygame.un.model.Config;
	import fr.citygame.un.model.LocalisationVO;
	import starling.utils.rad2deg;
	
	/**
	 * ...
	 * @author Jon Lucas
	 */
	public class SendReceive extends EventDispatcher
	{	
		private static const INIT_GAME			:String = "getDatasInit";
		
		private static const CREATE_PLAYER		:String = "creationJoueur";
		private static const GET_PLAYERS		:String = "getJoueurs";
		private static const GET_IMPACTS		:String = "getImpacts";
		
		private static const SEND_SHOT			:String = "tir";
		private static const SEND_MOVE			:String = "deplacement";
		
		
		private var _loader						:URLLoader;
		private var _loaderJoueurs				:URLLoader;
		private var _loaderImpacts				:URLLoader;
		private var _loaderPseudo				:URLLoader;
		private var _loaderMove					:URLLoader;
		private var _loaderShot					:URLLoader;
		private var _urlVars					:URLVariables;
		private var _request					:URLRequest;
		
		//SINGLETON vars
		private static var instance             :SendReceive;  //holds the singleton instance
		private static var allowInstance        :Boolean;      //indicates if singleton instance was already created
		private static var parser				:DataParser
		
		private var _firstCallPlayers:Boolean = true;

	   
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
		
		private function _send(loader:URLLoader, pRequest:URLRequest, name:String = ""):void 
		{
			if(loader == null){
				loader = new URLLoader();
				loader.dataFormat = name;
				configureListeners(loader);
			}
			
			if (parser == null)
			{
				parser = new DataParser();
			}
			
			try {
                loader.load(pRequest);
            } catch (error:Error) {
                trace("Unable to load requested document.");
            }
		}
		
		public function initGame(pPseudo:String):void
		{
			_urlVars = new URLVariables();
			_urlVars.pseudo = pPseudo;
			
			_request = new URLRequest(Config.URL + INIT_GAME);
			_request.data = _urlVars;
			_request.method = URLRequestMethod.POST;
			
			_send(_loader, _request);
        }
		
		public function createPlayer(pPseudo:String):void
		{
			_urlVars = new URLVariables();
			_urlVars.pseudo = pPseudo;
			
			_request = new URLRequest(Config.URL + CREATE_PLAYER);
			_request.data = _urlVars;
			_request.method = URLRequestMethod.POST;
			
			_send(_loaderPseudo, _request, CREATE_PLAYER);  
        }
		
		public function getPlayers():void
		{
			_request = new URLRequest(Config.URL + GET_PLAYERS);
			_request.method = URLRequestMethod.POST;
            
			_send(_loaderJoueurs, _request, GET_PLAYERS);
        }
		
		public function getImpacts():void
		{
			_request = new URLRequest(Config.URL + GET_IMPACTS);
			_request.method = URLRequestMethod.POST;
            
			_send(_loaderImpacts, _request, GET_IMPACTS);
        }
		
		public function sendPlayerMove():void
		{
			_urlVars = new URLVariables();
			_urlVars.id_joueur = Data.playerVo.id;
			_urlVars.latitude = Data.playerVo.localisation.latitude;
			_urlVars.longitude = Data.playerVo.localisation.longitude;
			_urlVars.direction = rad2deg(Data.rotation);
			
            _request = new URLRequest(Config.URL + SEND_MOVE);
			_request.data = _urlVars;
			_request.method = URLRequestMethod.POST;
			
           _send(_loaderMove, _request);
        }
		
		public function sendShot(pIdPlayer:uint, pIdWeapon:uint, pDirection:Number, pPuissance:Number):void
		{
			_urlVars = new URLVariables();
			_urlVars.id_joueur = Data.playerVo.id;
			_urlVars.id_arme = pIdWeapon;
			_urlVars.direction = rad2deg(Data.rotation);
			_urlVars.puissance = pPuissance;
			
            _request = new URLRequest(Config.URL + SEND_SHOT);
			_request.data = _urlVars;
			_request.method = URLRequestMethod.POST;
			
           _send(_loaderShot, _request);
        }
 
        private function configureListeners(dispatcher:IEventDispatcher):void {
            dispatcher.addEventListener(Event.COMPLETE, completeHandler);
            dispatcher.addEventListener(Event.OPEN, openHandler);
            dispatcher.addEventListener(ProgressEvent.PROGRESS, progressHandler);
            dispatcher.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
            dispatcher.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
            dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
        }
 
        private function completeHandler(event:Event):void
		{
            trace("completeHandler: " + event.currentTarget.data);
			
			switch(URLLoader(event.currentTarget).dataFormat)
			{				
				case GET_PLAYERS :
					parser.parsePlayers(XML(event.currentTarget.data));
					if (_firstCallPlayers) {
						_firstCallPlayers = false;
						dispatchEvent(new DataEvent(DataEvent.PLAYERS_REFRESHED));
					}
					break;
					
				case GET_IMPACTS :
					parser.parseImpacts(XML(event.currentTarget.data));
					dispatchEvent(new DataEvent(DataEvent.IMPACTS_REFRESHED));
					break;
					
				case CREATE_PLAYER :
					parser.parseCreatePlayer(XML(event.currentTarget.data));
					dispatchEvent(new DataEvent(DataEvent.PLAYER_CREATED));
					break;
			}
			
        }
 
        private function openHandler(event:Event):void {
            //trace("openHandler: " + event);
        }
 
        private function progressHandler(event:ProgressEvent):void {
           // trace("progressHandler loaded:" + event.bytesLoaded + " total: " + event.bytesTotal);
        }
 
        private function securityErrorHandler(event:SecurityErrorEvent):void {
           // trace("securityErrorHandler: " + event);
        }
 
        private function httpStatusHandler(event:HTTPStatusEvent):void {
           // trace("httpStatusHandler: " + event);
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