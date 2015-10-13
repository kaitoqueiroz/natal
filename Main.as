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
		public var celmsg_dist:DistortImageWrapper;
		public var nome:TextField;

		
		var avatar:Bitmap;
		
		public function Main() {
			
			Security.loadPolicyFile("https://fbcdn-profile-a.akamaihd.net/crossdomain.xml");
			//Security.loadPolicyFile("http://profile.ak.fbcdn.net/crossdomain.xml");
			this.addEventListener("addedToStage", init);
			ExternalInterface.call("console.log", stage.loaderInfo.parameters.__gda__);

		}
		
		function init(e:Event = null) {
			
			var temp_avatar_url:String = stage.loaderInfo.parameters.avatar;
			temp_avatar_url += '&oe=';
			temp_avatar_url += stage.loaderInfo.parameters.oe;
			temp_avatar_url += '&__gda__=';
			temp_avatar_url += stage.loaderInfo.parameters.__gda__;
			nome = new TextField();
			nome.width = 150;
			nome.height = 72;
			nome.multiline = true;
			nome.wordWrap = true;
			nome.autoSize = TextFieldAutoSize.CENTER;
			
			nome.text = stage.loaderInfo.parameters.nome;
			//nome.text = 'ADRIANO';
			nome.appendText(" acabou de enviar uma lista de desejos.");
			var nomeFormat:TextFormat = new TextFormat('Arial', 14, 0x000000);
			nomeFormat.align = 'left';
			nome.setTextFormat(nomeFormat);
			
			
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
			
			
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onCompleteAvatar);
			//loader.load(new URLRequest("https://fbcdn-profile-a.akamaihd.net/hprofile-ak-xpa1/v/t1.0-1/c0.2.100.100/p100x100/10456263_791904277507848_6068742428636275508_n.jpg?oh=c5ba41175c4d3dd8698b1e1df9c67dfc&oe=569A8823&__gda__=1451994333_c35e3a682ccea1ba5acd8679c4b91b8e"));
			var context: LoaderContext = new LoaderContext();
			context.checkPolicyFile = true;
			ExternalInterface.call("console.log",'temp_avatar_url');
			loader.load(new URLRequest(temp_avatar_url),context);


			
			video.addEventListener("playProgress", checkTime);
		}
		
		function onCompleteAvatar (event:Event):void
		{
			// get your loaded bitmap
			avatar = Bitmap(LoaderInfo(event.target).content);
			avatar.width = 72;
			avatar.height = 72;
			avatar.smoothing = true;
			
			
			celmsg_mc = new CelMsg();
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
			celmsg_mc.addChild(nome);
			nome.x = 100;
			nome.y = 120;
			celmsg_dist = new DistortImageWrapper(celmsg_mc,5,5);
			stage.addChild(celmsg_dist);
			celmsg_dist.alpha = 0;
			video.playVideo();
			

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
			}else {
				celmsg_dist.alpha = 0;	
			}
		}
		

	}
	
}