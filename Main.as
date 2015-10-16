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
		public var baseListaCel:MovieClip;
		public var baseListaCel_dist:DistortImageWrapper;
		public var telaSistema_dist:DistortImageWrapper;
		public var celmsg_dist:DistortImageWrapper;
		public var nome:TextField;
		public var nomeSistema:TextField;
		public var isAvatarReady:Boolean = false;
		public var desejos:Array = [];

		
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
			ExternalInterface.addCallback("playVideo", playVideo);
			ExternalInterface.addCallback("setDesejos",setDesejos);

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
			baseListaCel = new BaseListaCel();
			
			setEmail('loremipsom@gmail.com');
			
		}
		
		public function setDesejos(desejos:Array) {
			for (var i:int = 0; i < desejos.length; i++) 
			{
				var itemLista:MovieClip = new ItemListaCel();
				
				var produto = new TextField();
				produto.width = 196;
				produto.height = 20;
				produto.text = desejos[i];
				var nomeFormat = new TextFormat('Arial', 14, 0x000000);
				nomeFormat.align = 'left';
				produto.setTextFormat(nomeFormat);
				itemLista.addChild(produto);
				produto.x = 63;
				produto.y = 12;
				
				var numero = new TextField();
				numero.width = 28;
				numero.height = 25;
				numero.text = i+1;
				nomeFormat = new TextFormat('Arial', 18, 0x000000);
				nomeFormat.align = 'center';
				numero.setTextFormat(nomeFormat);
				itemLista.addChild(numero);
				numero.x = 19;
				numero.y = 13;
				
				baseListaCel.addChild(itemLista);
				itemLista.x = 0;
				itemLista.y = (i * 53) + 94;
				
				
			}
		}
		
		
		public function playVideo() {
			addEventListener(Event.ENTER_FRAME, checkReady);
		}
		
		public function checkReady(e) {
			if (isAvatarReady) {
				removeEventListener(Event.ENTER_FRAME, checkReady);
				video.addEventListener("playProgress", checkTime);
				baseListaCel_dist = new DistortImageWrapper(baseListaCel,5,5);
				celmsg_dist = new DistortImageWrapper(celmsg_mc, 5, 5);
				telaSistema_dist = new DistortImageWrapper(telaSistema,5,5);
				stage.addChild(baseListaCel_dist);
				stage.addChild(celmsg_dist);
				stage.addChild(telaSistema_dist);
				baseListaCel_dist.alpha = 0;
				celmsg_dist.alpha = 0;
				telaSistema_dist.alpha = 0;
				video.playVideo();	
				video.volume = 0;
			}
		}
		
		public function setEmail(value) {
			var emailListaCel = new TextField();
			emailListaCel.width = 191;
			emailListaCel.height = 20;
			emailListaCel.text = value;
			var nomeFormat = new TextFormat('Arial', 10, 0xffffff);
			nomeFormat.align = 'left';
			emailListaCel.setTextFormat(nomeFormat);
			baseListaCel.addChild(emailListaCel);
			emailListaCel.x = 63;
			emailListaCel.y = 65;
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
			
			var nomeListaCel = new TextField();
			nomeListaCel.width = 191;
			nomeListaCel.height = 20;
			nomeListaCel.text = value;
			nomeFormat = new TextFormat('Arial', 16, 0xffffff);
			nomeFormat.align = 'left';
			nomeListaCel.setTextFormat(nomeFormat);
			baseListaCel.addChild(nomeListaCel);
			nomeListaCel.x = 63;
			nomeListaCel.y = 50;
			
			
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
			avatar = new Bitmap(Bitmap(LoaderInfo(event.target).content).bitmapData);
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
			circle.y = avatar.y + 36;
			
			var avatarListaCel:Bitmap = new Bitmap(Bitmap(LoaderInfo(event.target).content).bitmapData);
			avatarListaCel.width = 40;
			avatarListaCel.height = 40;
			avatarListaCel.smoothing = true;
				
			baseListaCel.addChild(avatarListaCel);
			
			var circleListaCel:Sprite = new Sprite();
			circleListaCel.graphics.lineStyle(1, 0x000000); 
			circleListaCel.graphics.beginFill(0x0000ff); 
			circleListaCel.graphics.drawCircle(0, 0, 20); 
			circleListaCel.graphics.endFill(); 
			baseListaCel.addChild(circleListaCel);
			avatarListaCel.cacheAsBitmap = true;
			circleListaCel.cacheAsBitmap = true;
			avatarListaCel.mask = circleListaCel;

			avatarListaCel.x = 13;
			avatarListaCel.y = 47;
			circleListaCel.x = avatarListaCel.x+20;
			circleListaCel.y = avatarListaCel.y + 20;

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
			}else if (video.videoTime >= 12.345 && video.videoTime <= 15.965) 
			{
				baseListaCel_dist.alpha = 0.8;
				baseListaCel_dist.blendMode = "multiply";
				baseListaCel_dist.tlX = 927.25; baseListaCel_dist.tlY = 211.7; baseListaCel_dist.trX = 1173.15; baseListaCel_dist.trY = 251; baseListaCel_dist.blX = 864.75; baseListaCel_dist.blY = 652.1; baseListaCel_dist.brX = 1108.65; baseListaCel_dist.brY = 696.45;
			}else if (video.videoTime >= 37.337 && video.videoTime <= 39.345) 
			{
				telaSistema_dist.alpha = 0.7;
				telaSistema_dist.blendMode = "multiply";
				telaSistema_dist.tlX=350.75;telaSistema_dist.tlY=84.7;telaSistema_dist.trX=1224.55;telaSistema_dist.trY=77.65;telaSistema_dist.blX=363.85;telaSistema_dist.blY=576.55;telaSistema_dist.brX=1219.55;telaSistema_dist.brY=567.45

				//telaSistema_dist.tlX = 351.75;
				//telaSistema_dist.tlY = 88.7;
				//telaSistema_dist.trX = 1223.55;
				//telaSistema_dist.trY = 82.65;
				//telaSistema_dist.blX = 365.85;
				//telaSistema_dist.blY = 572.5;
				//telaSistema_dist.brX = 1215.5;
				//telaSistema_dist.brY = 565.45;
			}else {
				telaSistema_dist.alpha = 0;
				celmsg_dist.alpha = 0;	
				baseListaCel_dist.alpha = 0;
			}
		}
		

	}
	
}