 package fr.citygame.un.view
{
        import com.greensock.TweenNano;
        import com.jonlucas.utils.Utils;
		import fr.citygame.un.controller.ViewController;
		import fr.citygame.un.model.Config;
       
        import flash.display.Sprite;
        import flash.events.Event;
        import flash.events.IOErrorEvent;
        import flash.events.MouseEvent;
        import flash.events.NetStatusEvent;
        import flash.events.StageVideoAvailabilityEvent;
        import flash.events.StageVideoEvent;
        import flash.geom.Rectangle;
        import flash.media.StageVideo;
        import flash.media.StageVideoAvailability;
        import flash.media.Video;
        import flash.net.NetConnection;
        import flash.net.NetStream;
       
        public class Cinematics extends Sprite implements IScreen
        {
                private var _viewController:ViewController;
               
                private var _myStageVideo:StageVideo;
               
                private var _myVideo:Video;
               
                private var _nc:NetConnection;
               
                private var _ns:NetStream;
               
                private var _rapportVideo:Number;
               
                private var _videoFile:String;
               
                private var _buffer:Buffer;
               
                private var _endMenu:Boolean;
               
                private var _playOnAdded:Boolean = false;
                private var _sWidth:int;
                private var _sHeight:int;
                private var _rapportStage:Number;
                private var _vWidth:int;
                private var _vHeight:int;
                private var _decX:int;
                private var _decY:int;
                private var _lastRapportVideo:Number;
                private var _playing:Boolean;
               
                public function VideoPlayer()
                {
                        _viewController = new ViewController();
                       
                        _sWidth = Config.stageVideo;
                        _sHeight = Config.stageHeight;
                       
                        _rapportVideo = 1280 / 720;
                       
                        alpha = 0;
                       
                        if(stage){
                                init();
                        } else {
                                addEventListener(Event.ADDED_TO_STAGE, init);
                        }
                }
               
               
                protected function init(event:Event = null):void
                {
                        removeEventListener(Event.ADDED_TO_STAGE, init);
                }
               
               
                private function onStageVideoAvailibility(event:StageVideoAvailabilityEvent):void
                {                      
                        trace("VideoPlayer :: " + event.availability);
                        stage.removeEventListener(StageVideoAvailabilityEvent.STAGE_VIDEO_AVAILABILITY, onStageVideoAvailibility);
                       
                        if(Config.nc == null)   Config.nc = new NetConnection();
                       
                        _nc = Config.nc;
                        _nc.addEventListener(NetStatusEvent.NET_STATUS, onNetStatus);
                        _nc.connect(null);
                       
                        if(_model.ns == null){
                                Config.ns = new NetStream(_nc);
                                Config.ns.client = this;
                                //_model.ns.bufferTime = 5;
                        }
                       
                        _ns = _model.ns;
                        _ns.addEventListener(NetStatusEvent.NET_STATUS, onNetStatus);
                        _ns.addEventListener(IOErrorEvent.IO_ERROR, onIoErrorEvent);
                       
                        if (event.availability == StageVideoAvailability.AVAILABLE) {
                                trace("VideoPlayer :: StageVideo");
                               
                                if(Config.stageVideo == null){
                                        Config.stageVideo = stage.stageVideos[0];
                                        Config.stageVideo.attachNetStream(_ns);
                                }
                               
                                _myStageVideo = Config.stageVideo;
                                _myStageVideo.addEventListener( StageVideoEvent.RENDER_STATE, stageVideoStateChange );
                        } else {
                                //use Video API for displaying the video
                                trace("VideoPlayer :: Video API");
                               
                                _myVideo = new Video();
                               
                                _myVideo.x = _decX > 0 ? _decX : 0;
                                _myVideo.y = _decY > 0 ? _decY : 0;
                                _myVideo.width = _vWidth > 0 ? _vWidth : _sWidth;
                                _myVideo.height = _vHeight > 0 ? _vHeight : _sHeight;
                               
                                _myVideo.attachNetStream(_ns);
                               
                                addChildAt(_myVideo, 0);
                        }
                       
                        if(_playOnAdded){
                                _ns.play(_videoFile);
                                _playOnAdded = false;
                        }
                }

               
                protected function onIoErrorEvent(event:IOErrorEvent):void
                {
                        trace("VideoPlayer :: onIoErrorEvent(" + event + ")");
                }
               
                protected function stageVideoStateChange( event : StageVideoEvent ) : void
                {
                        trace("VideoPlayer :: stageVideoStateChange( " + event.status + " )");
                        if(_playing)    resize();
                }
               
                /**
                 * Redimensionnement proportionnel de la vidéo.
                 */
                private function resize(event:Event = null, fullfill:Boolean = false) : void
                {
                        if(isNaN(_rapportStage)){
                                _rapportStage = _sWidth / _sHeight;
                               
                                _vWidth = _sWidth;
                                _vHeight = _sHeight;
                               
                                // Calcul de la taille de la vidéo pour qu'elle remplisse toujours l'écran en gardant ses proportions.
                                if(_rapportStage < _rapportVideo){     
                                        if(fullfill)    _vWidth = _vHeight * _rapportVideo;
                                        else                    _vHeight = _vWidth / _rapportVideo;    
                                } else {       
                                        if(fullfill)    _vHeight = _vWidth / _rapportVideo;
                                        else                    _vWidth = _vHeight * _rapportVideo;
                                }
                               
                                // Calcul du décalage sur x et y pour que la vidéo soit toujours centrée.
                                _decX = (_sWidth - _vWidth) * .5;
                                _decY = (_sHeight - _vHeight) * .5;
                        }      
                       
                        if(_myStageVideo){
                                _myStageVideo.viewPort = new Rectangle(_decX, _decY, _vWidth, _vHeight);
                        }
                       
                        if(_myVideo){
                                _myVideo.x = _decX;
                                _myVideo.y = _decY;
                                _myVideo.width = _vWidth;
                                _myVideo.height = _vHeight;
                        }
                }
               
               
                public function onMetaData(meta:Object):void
                {
                        trace("VideoPlayer :: onMetaData(" + meta.width + " " + meta.height + ")");
                        //_rapportVideo = meta.width / meta.height;
                        if(_playing)    resize();
                }
               
               
                public function onXMPData(meta:Object):void
                {      
                        trace("VideoPlayer :: onXMPData(" + meta + ")");
                        //_rapportVideo = meta.width / meta.height;
                        if(_playing)    resize();
                }
               
               
                public function onPlayStatus(infoObject:Object):void
                {
                        trace("VideoPlayer :: onPlayStatus(" + infoObject + ")");
                        var key:String;
                        for (key in infoObject)
                        {
                                trace(key + ": " + infoObject[key]);
                        }
                }
               
               
                public function onCuePoint(infoObject:Object):void
                {
                        /*var key:String;
                        for (key in infoObject)
                        {
                                trace(key + ": " + infoObject[key]);
                        }*/
                }
               
               
                private function onNetStatus(event:NetStatusEvent):void
                {
                        trace("VideoPlayer :: onNetStatus : " + event.info.code);
                       
                        switch (event.info.code) {
                                case "NetStream.Play.Start":
                                        //trace("VideoPlayer :: NetStream.Play.Start");
                                        removeBuffer();
                                        break;
                               
                                case "NetStream.Play.Stop":
                                        //trace("VideoPlayer :: NetStream.Play.Stop");
                                        removeBuffer();
                                        _viewController.playVideo();
                                        break;
                               
                                case "NetStream.Play.StreamNotFound":
                                        //trace("VideoPlayer :: NetStream.Play.StreamNotFound");
                                        break;
                               
                                case "NetStream.Buffer.Empty":
                                        //showBuffer();
                                        break;
                               
                                case "NetStream.Buffer.Flush":                         
                                case "NetStream.Buffer.Full":
                                        //trace("VideoPlayer :: NetStream.Buffer.Full");
                                        removeBuffer();
                                        break;
                               
                        }
                }
               
               
                /**
                 * Lit une vidéo.
                 */
                public function playVideo(videoFile:String, endMenu:Boolean = false):void
                {      
                        trace("VideoPlayer :: playVideo(" + videoFile + ")");
                               
                        _videoFile = videoFile;
                       
                        _endMenu = endMenu;
                       
                        _playing = true;
                       
                        if(_ns){
                                _ns.play(_videoFile);
                        } else {
                                _playOnAdded = true;
                        }
                }
               
               
                private function showBuffer():void
                {      
                        if(_buffer == null){
                                _buffer = new Buffer();
                                addChild(_buffer);                     
                        }
                        _buffer.x = _sWidth/2;
                        _buffer.y = _sHeight/2;
                        _buffer.scaleX = 0;
                        _buffer.scaleY = 0;
                        _buffer.alpha = 0;
                        TweenNano.to(_buffer, 0.2, { alpha: 0.5, scaleX: 1, scaleY: 1 } );
                }
               
                private function removeBuffer():void
                {              
                        if(_buffer != null){
                                TweenNano.to(_buffer, 0.2, { alpha: 0, scaleX: 0, scaleY: 0, onComplete:
                                        function(_this:Sprite):void
                                        {
                                                Utils.removeChild(_buffer, _this);
                                        },
                                        onCompleteParams: [this]       
                                } );
                        }
                }
               
                public function transiIn(params:Object=null):void
                {
                        addChild(_bt_retour);
                       
                        TweenNano.to(this, 0.5, { alpha:1, onComplete:
                                function():void
                                {
                                        addListeners();
                                       
                                        showBuffer();

                                        playVideo(params.videoFile);
                                }
                        });
                }
               
                public function transiOut():void
                {
                        onRemove();
                       
                        TweenNano.to(this, 0.5, { alpha:0, onComplete:
                                function(_this):void
                                {
                                        parent.removeChild(_this);
                                }
                                , onCompleteParams: [this]
                        });
                }
               
                public function addListeners():void
                {
                        addEventListener(Event.REMOVED_FROM_STAGE, onRemove);
                       
                        stage.addEventListener(StageVideoAvailabilityEvent.STAGE_VIDEO_AVAILABILITY, onStageVideoAvailibility);
                       
                        //onStageVideoAvailibility(null);
                }
               
                public function removeListeners():void
                {
                        removeEventListener(Event.REMOVED_FROM_STAGE, onRemove);
                       
                        stage.removeEventListener(StageVideoAvailabilityEvent.STAGE_VIDEO_AVAILABILITY, onStageVideoAvailibility);
                       
                        _nc.removeEventListener(NetStatusEvent.NET_STATUS, onNetStatus);
                        _ns.removeEventListener(NetStatusEvent.NET_STATUS, onNetStatus);
                        _ns.removeEventListener(IOErrorEvent.IO_ERROR, onIoErrorEvent);
                       
                        if(_myStageVideo)       _myStageVideo.removeEventListener( StageVideoEvent.RENDER_STATE, stageVideoStateChange );
                }
               
                protected function onRemove(event:Event = null):void
                {
                        trace("VideoPlayer :: onRemove()");
                       
                        _playing = false;
                       
                        removeListeners();
                       
                        if(_myStageVideo)               _myStageVideo.viewPort = new Rectangle(-32, -32, 32, 32);
                       
                        if(_myVideo){
                                _myVideo = Utils.removeChild(_myVideo, this);  
                        }
                       
                        _ns.seek(0);
                        _ns.pause();
                       
                        removeBuffer();
                       
                        Utils.removeChild(_bt_retour, this);
                }
        }
} 