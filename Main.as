package 
{
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.VideoLoader;
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	import ws.outset.display.DistortImageWrapper;
	import flash.system.Security;
	import flash.external.ExternalInterface;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Main extends MovieClip 
	{
		public var video:VideoLoader;
		public var celmsg_mc:MovieClip;
		public var telaSistema:MovieClip;
		public var telaSistema_dist:DistortImageWrapper;
		public var celmsg_dist:DistortImageWrapper;
		public var nome:TextField;
		public var nomeSistema:TextField;
		public var isAvatarReady:Boolean = false;

		
		var avatar:Bitmap;
		
		public function Main() {
			
			Security.loadPolicyFile("https://fbcdn-profile-a.akamaihd.net/crossdomain.xml");
			Security.allowDomain('*');
			Security.allowInsecureDomain('*');
			//Security.loadPolicyFile("http://profile.ak.fbcdn.net/crossdomain.xml");
			this.addEventListener("addedToStage", init);
			ExternalInterface.call("console.log", LoaderInfo(this.root.loaderInfo).parameters['one']);
			ExternalInterface.call("console.log", root.loaderInfo.parameters.one);
			ExternalInterface.addCallback("setAvatar", setAvatar);
			ExternalInterface.addCallback("setNome", setNome);
			ExternalInterface.addCallback("playVideo",playVideo);

		}
		
		function init(e:Event = null) {
			
			
			video = new VideoLoader('clipe.mp4',{
				"width":1280,
				"height":720,
				"autoPlay":false,
				"smoothing":true,
				"bufferTime":2,
				"container":stage,
				"volume":1
			});


			video.load();
			
			celmsg_mc = new CelMsg();
			telaSistema = new TelaSistema();
			
			
			
		}
		
		
		public function playVideo() {
			addEventListener(Event.ENTER_FRAME, checkReady);
		}
		
		public function checkReady(e) {
			if (isAvatarReady) {
				removeEventListener(Event.ENTER_FRAME, checkReady);
				video.addEventListener("playProgress", checkTime);
				celmsg_dist = new DistortImageWrapper(celmsg_mc,5,5);
				stage.addChild(celmsg_dist);
				stage.addChild(telaSistema_dist);
				celmsg_dist.alpha = 0;
				telaSistema_dist.alpha = 0;
				video.playVideo();	
			}
		}
		
		public function setNome(value) {
			nome = new TextField();
			nome.width = 150;
			nome.height = 72;
			nome.multiline = true;
			nome.wordWrap = true;
			nome.autoSize = TextFieldAutoSize.CENTER;
			nome.text = value;
			nome.appendText(" acabou de enviar uma lista de desejos.");
			var nomeFormat:TextFormat = new TextFormat('Arial', 14, 0x000000);
			nomeFormat.align = 'left';
			nome.setTextFormat(nomeFormat);
			celmsg_mc.addChild(nome);
			nome.x = 100;
			nome.y = 120;
			
			nomeSistema = new TextField();
			nomeSistema.width = 478;
			nomeSistema.height = 24;
			nomeSistema.text = value;
			nomeFormat = new TextFormat('Arial', 20, 0x000000);
			nomeFormat.align = 'left';
			nomeSistema.setTextFormat(nomeFormat);
			telaSistema.addChild(nomeSistema);
			nomeSistema.x = 128;
			nomeSistema.y = 546;
			
			telaSistema_dist = new DistortImageWrapper(telaSistema,5,5);
			return true;
		}
		
		public function setAvatar(url) {
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onCompleteAvatar);
			var context: LoaderContext = new LoaderContext();
			context.checkPolicyFile = true;
			ExternalInterface.call("console.log",'temp_avatar_url');
			loader.load(new URLRequest(url), context);
			return true
		}
		
		
		function onCompleteAvatar (event:Event):void
		{
			isAvatarReady = true;
			// get your loaded bitmap
			avatar = Bitmap(LoaderInfo(event.target).content);
			avatar.width = 72;
			avatar.height = 72;
			avatar.smoothing = true;
				
			celmsg_mc.addChild(avatar);
			
			var circle:Sprite = new Sprite();
			circle.graphics.lineStyle(1, 0x000000); 
			circle.graphics.beginFill(0x0000ff); 
			circle.graphics.drawCircle(0, 0, 34); 
			circle.graphics.endFill(); 
			celmsg_mc.addChild(circle);
			avatar.cacheAsBitmap = true;
			circle.cacheAsBitmap = true;
			avatar.mask = circle;

			avatar.x = 18;
			avatar.y = 108;
			circle.x = avatar.x+36;
			circle.y = avatar.y+36;
		}
		
		public function checkTime(e:LoaderEvent = null) {
			if (video.videoTime >= 4.36 && video.videoTime < 8.785) {
				celmsg_dist.alpha = 0.8;
				celmsg_dist.blendMode = "multiply";
				celmsg_dist.tlX = 768;
				celmsg_dist.tlY = 207.65;
				celmsg_dist.trX = 962.5;
				celmsg_dist.trY = 255;
				celmsg_dist.blX = 668.25;
				celmsg_dist.blY = 522.1;
				celmsg_dist.brX = 871.8;
				celmsg_dist.brY = 575.5;
			}else if (video.videoTime >= 37.786 && video.videoTime <= 39.757) 
			{
				telaSistema_dist.alpha = 0.7;
				telaSistema_dist.blendMode = "multiply";
				telaSistema_dist.tlX = 351.75;
				telaSistema_dist.tlY = 88.7;
				telaSistema_dist.trX = 1223.55;
				telaSistema_dist.trY = 82.65;
				telaSistema_dist.blX = 365.85;
				telaSistema_dist.blY = 572.5;
				telaSistema_dist.brX = 1215.5;
				telaSistema_dist.brY = 565.45;
			}else {
				telaSistema_dist.alpha = 0;
				celmsg_dist.alpha = 0;	
			}
		}
		

	}
	
}