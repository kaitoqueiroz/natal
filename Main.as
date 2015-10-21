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
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Main extends MovieClip 
	{
		public var video:VideoLoader;
		public var comentarios:MovieClip;
		public var celmsg_mc:MovieClip;
		public var telaSistema:MovieClip;
		public var baseListaCel:MovieClip;
		public var facebookCapa:MovieClip;
		public var facebookFoto:MovieClip;
		public var facebookFoto_dist:DistortImageWrapper;
		public var facebookCapa_dist:DistortImageWrapper;
		public var baseListaCel_dist:DistortImageWrapper;
		public var telaSistema_dist:DistortImageWrapper;
		public var celmsg_dist:DistortImageWrapper;
		public var nome:TextField;
		public var nomeSistema:TextField;
		public var isAvatarReady:Boolean = false;
		public var isFotoPerfilReady:Boolean = false;
		public var desejos:Array = [];

		
		var avatar:Bitmap;
		
		public function Main() {
			
			Security.loadPolicyFile("https://fbcdn-profile-a.akamaihd.net/crossdomain.xml");
			Security.allowDomain('*');
			Security.allowInsecureDomain('*');
			//Security.loadPolicyFile("http://profile.ak.fbcdn.net/crossdomain.xml");
			this.addEventListener("addedToStage", init);
			ExternalInterface.addCallback("setAvatar", setAvatar);
			ExternalInterface.addCallback("setNome", setNome);
			ExternalInterface.addCallback("playVideo", playVideo);
			ExternalInterface.addCallback("setDesejos", setDesejos);
			ExternalInterface.addCallback("setFotoPerfil",setFotoPerfil);

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
			facebookCapa = new FacebookCapa();
			facebookFoto = new FacebookFoto();
			
			//setEmail('loremipsom@gmail.com');
			
		}
		
		public function setDesejos(desejos:Array) {

			var itemLista:MovieClip = new ItemListaCel();
			
			var texto_inicial = new TextField();
			texto_inicial.multiline = true;
			texto_inicial.wordWrap = true;
			texto_inicial.autoSize = TextFieldAutoSize.CENTER;
			texto_inicial.width = 171;
			texto_inicial.height = 49;
			texto_inicial.text = 'Queridos Daniel e Papai Noel segue a minha lista de desejos pra viver o natal mais azul do Brasil na Gazin:';
			var nomeFormat = new TextFormat('Arial', 12, 0x000000);
			nomeFormat.align = 'left';
			texto_inicial.setTextFormat(nomeFormat);
			baseListaCel.addChild(texto_inicial);
			texto_inicial.x = 29;
			texto_inicial.y = 100;	
			
			var desejos_txt = '';
			
			for (var i:int = 0; i < desejos.length; i++) 
			{
				desejos_txt += desejos[i]+', ';
				
				var produto = new TextField();
				produto.width = 171;
				produto.height = 18;
				produto.text = '- '+desejos[i];
				nomeFormat = new TextFormat('Arial', 12, 0x000000);
				nomeFormat.align = 'left';
				produto.setTextFormat(nomeFormat);
				baseListaCel.addChild(produto);
				produto.x = 28;
				produto.y = 173+(i*18);
				
				//var produto = new TextField();
				//produto.width = 196;
				//produto.height = 20;
				//produto.text = desejos[i];
				//var nomeFormat = new TextFormat('Arial', 14, 0x000000);
				//nomeFormat.align = 'left';
				//produto.setTextFormat(nomeFormat);
				//itemLista.addChild(produto);
				//produto.x = 63;
				//produto.y = 12;
				
				//var numero = new TextField();
				//numero.width = 28;
				//numero.height = 25;
				//numero.text = i+1;
				//nomeFormat = new TextFormat('Arial', 18, 0x000000);
				//nomeFormat.align = 'center';
				//numero.setTextFormat(nomeFormat);
				//itemLista.addChild(numero);
				//numero.x = 19;
				//numero.y = 13;
				
				//baseListaCel.addChild(itemLista);
				//itemLista.x = 0;
				//itemLista.y = (i * 53) + 94;
				
				
			}
			
				var desejosSistema = new TextField();
				desejosSistema.width = 861;
				desejosSistema.height = 39;
				desejosSistema.text = desejos_txt;
				nomeFormat = new TextFormat('Arial', 20, 0x000000);
				nomeFormat.align = 'left';
				desejosSistema.setTextFormat(nomeFormat);
				telaSistema.addChild(desejosSistema);
				desejosSistema.x = 81;
				desejosSistema.y = 630;
		}
		
		
		public function playVideo() {
			addEventListener(Event.ENTER_FRAME, checkReady);
		}
		
		public function checkReady(e) {
			if (isAvatarReady && isFotoPerfilReady) {
				removeEventListener(Event.ENTER_FRAME, checkReady);
				video.addEventListener("playProgress", checkTime);
				baseListaCel_dist = new DistortImageWrapper(baseListaCel,5,5);
				celmsg_dist = new DistortImageWrapper(celmsg_mc, 5, 5);
				telaSistema_dist = new DistortImageWrapper(telaSistema, 5, 5);
				facebookCapa_dist = new DistortImageWrapper(facebookCapa, 10, 10);
				facebookFoto_dist = new DistortImageWrapper(facebookFoto,10,10);
				stage.addChild(baseListaCel_dist);
				stage.addChild(celmsg_dist);
				stage.addChild(telaSistema_dist);
				stage.addChild(facebookCapa_dist);
				stage.addChild(facebookFoto_dist);
				facebookFoto_dist.alpha = 0;
				facebookCapa_dist.alpha = 0;
				baseListaCel_dist.alpha = 0;
				celmsg_dist.alpha = 0;
				telaSistema_dist.alpha = 0;
				video.playVideo();	
				stage.addEventListener(MouseEvent.CLICK, pausar);
				
				video.volume = 1;
			}
		}
		
		public function pausar(e) {

			if(video.videoPaused){
				video.playVideo();
			}else {	
				video.pauseVideo();
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
			
			var nomeFaceCapa = new TextField();
			nomeFaceCapa.width = 514;
			nomeFaceCapa.height = 38;
			nomeFaceCapa.text = value;
			nomeFormat = new TextFormat('Arial', 26, 0x000000);
			nomeFormat.align = 'left';
			nomeFaceCapa.setTextFormat(nomeFormat);
			facebookCapa.addChild(nomeFaceCapa);
			nomeFaceCapa.x = 240;
			nomeFaceCapa.y = 461;
			
			
			//var nomeFacePesquisa = new TextField();
			//nomeFacePesquisa.width = 315;
			//nomeFacePesquisa.height = 25;
			//nomeFacePesquisa.text = value;
			//var nomeFaceFormat = new TextFormat('Arial', 20, 0xffffff);
			//nomeFaceFormat.align = 'left';
			//nomeFacePesquisa.setTextFormat(nomeFaceFormat);
			//facebookCapa.addChild(nomeFacePesquisa);
			//nomeFacePesquisa.x = 242;
			//nomeFacePesquisa.y = 30;
			
			var nomeFaceFotoPesquisa = new TextField();
			nomeFaceFotoPesquisa.width = 315;
			nomeFaceFotoPesquisa.height = 25;
			nomeFaceFotoPesquisa.text = value;
			var nomeFaceFotoFormat = new TextFormat('Arial', 20, 0xffffff);
			nomeFaceFotoFormat.align = 'left';
			nomeFaceFotoPesquisa.setTextFormat(nomeFaceFotoFormat);
			facebookFoto.addChild(nomeFaceFotoPesquisa);
			nomeFaceFotoPesquisa.x = 242;
			nomeFaceFotoPesquisa.y = 30;
			
			var breadcumbFotosPerfil_txt = 'Retornar ao álbum · Fotos de ' + value+'· Linha do Tempo de ' + value;
			
			var breadcumbFotosPerfil = new TextField();
			breadcumbFotosPerfil.width = 694;
			breadcumbFotosPerfil.height = 17;
			breadcumbFotosPerfil.text = breadcumbFotosPerfil_txt;
			var breadcumbFotosPerfilFormat = new TextFormat('Arial', 18, 0x3b5998);
			breadcumbFotosPerfilFormat.align = 'left';
			breadcumbFotosPerfil.setTextFormat(breadcumbFotosPerfilFormat);
			facebookFoto.addChild(breadcumbFotosPerfil);
			breadcumbFotosPerfil.x = 64;
			breadcumbFotosPerfil.y = 104;
			
			//var nomeListaCel = new TextField();
			//nomeListaCel.width = 191;
			//nomeListaCel.height = 20;
			//nomeListaCel.text = value;
			//nomeFormat = new TextFormat('Arial', 16, 0xffffff);
			//nomeFormat.align = 'left';
			//nomeListaCel.setTextFormat(nomeFormat);
			//baseListaCel.addChild(nomeListaCel);
			//nomeListaCel.x = 63;
			//nomeListaCel.y = 50;
			
			var nome_titulo = new TextField();
			nome_titulo.width = 127;
			nome_titulo.height = 22;
			nome_titulo.text = value;
			nomeFormat = new TextFormat('Arial', 14, 0x000000);
			nomeFormat.align = 'center';
			nome_titulo.setTextFormat(nomeFormat);
			baseListaCel.addChild(nome_titulo);
			nome_titulo.x = 83;
			nome_titulo.y = 18;
			
			
			return true;
		}
		
		
		public function setFotoPerfil(url) {
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onCompleteFotoPerfil);
			var context: LoaderContext = new LoaderContext();
			context.checkPolicyFile = true;
			ExternalInterface.call("console.log",'temp_avatar_url');
			loader.load(new URLRequest(url), context);
			return true
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
		
		public function onCompleteFotoPerfil(event:Event){
			isFotoPerfilReady = true;
			var extra_x = 0;
			var proporcao = 0;
			var fotoPerfil:Bitmap = new Bitmap(Bitmap(LoaderInfo(event.target).content).bitmapData);
			if(fotoPerfil.width>fotoPerfil.height){
				proporcao = fotoPerfil.height / fotoPerfil.width;
				fotoPerfil.width = 636;
				fotoPerfil.height = fotoPerfil.width * proporcao;
			}else {
				proporcao = fotoPerfil.width / fotoPerfil.height;
				
				fotoPerfil.height = 636;
				fotoPerfil.width = fotoPerfil.height * proporcao;
				extra_x = (636 - fotoPerfil.width) / 2;
				
			}
			fotoPerfil.smoothing = true;
			facebookFoto.addChild(fotoPerfil);
			fotoPerfil.x = 66+extra_x;
			fotoPerfil.y = 139;
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
			
			//var avatarListaCel:Bitmap = new Bitmap(Bitmap(LoaderInfo(event.target).content).bitmapData);
			//avatarListaCel.width = 40;
			//avatarListaCel.height = 40;
			//avatarListaCel.smoothing = true;
				
			//baseListaCel.addChild(avatarListaCel);
			
			//var circleListaCel:Sprite = new Sprite();
			//circleListaCel.graphics.lineStyle(1, 0x000000); 
			//circleListaCel.graphics.beginFill(0x0000ff); 
			//circleListaCel.graphics.drawCircle(0, 0, 20); 
			//circleListaCel.graphics.endFill(); 
			//baseListaCel.addChild(circleListaCel);
			//avatarListaCel.cacheAsBitmap = true;
			//circleListaCel.cacheAsBitmap = true;
			//avatarListaCel.mask = circleListaCel;

			//avatarListaCel.x = 13;
			//avatarListaCel.y = 47;
			//circleListaCel.x = avatarListaCel.x+20;
			//circleListaCel.y = avatarListaCel.y + 20;
			
			var fotoFace = new Bitmap(Bitmap(LoaderInfo(event.target).content).bitmapData);
			fotoFace.width = 180;
			fotoFace.height = 180;
			fotoFace.smoothing = true;
				
			facebookCapa.addChild(fotoFace);

			fotoFace.x = 33;
			fotoFace.y = 369;
			
			
			//var avatarComent = new Bitmap(Bitmap(LoaderInfo(event.target).content).bitmapData);
			//avatarComent.width = 50;
			//avatarComent.height = 50;
			//avatarComent.smoothing = true;
				
			//comentarios.addChild(avatarComent);

			//avatarComent.x = 0;
			//avatarComent.y = 0;

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
			}else if (video.videoTime >= 12.346 && video.videoTime <= 15.965) 
			{
				baseListaCel_dist.alpha = 0.8;
				baseListaCel_dist.blendMode = "multiply";
				baseListaCel_dist.tlX = 927.25; baseListaCel_dist.tlY = 211.7; baseListaCel_dist.trX = 1173.15; baseListaCel_dist.trY = 251; baseListaCel_dist.blX = 864.75; baseListaCel_dist.blY = 652.1; baseListaCel_dist.brX = 1108.65; baseListaCel_dist.brY = 696.45;
			}else if (video.videoTime >= 23 && video.videoTime <= 28.196) 
			{
				facebookCapa_dist.alpha = 0.8;
				facebookCapa_dist.blendMode = "multiply";
				facebookCapa_dist.tlX=710.65;facebookCapa_dist.tlY=14.25;facebookCapa_dist.trX=1167.15;facebookCapa_dist.trY=81.35;facebookCapa_dist.blX=623.2;facebookCapa_dist.blY=612.05;facebookCapa_dist.brX=1057.35;facebookCapa_dist.brY=705.6
			}else if (video.videoTime >= 30.954 && video.videoTime <= 33.76) 
			{
				facebookFoto_dist.alpha = 0.7;
				facebookFoto_dist.blendMode = "multiply";
				facebookFoto_dist.tlX = 550.3;
				facebookFoto_dist.tlY = 212.7;
				facebookFoto_dist.trX = 839.55;
				facebookFoto_dist.trY = 207.65;
				facebookFoto_dist.blX = 547.3;
				facebookFoto_dist.blY = 587.6;
				facebookFoto_dist.brX = 843.6;
				facebookFoto_dist.brY = 585.6;
			}else if (video.videoTime >= 37.337 && video.videoTime <= 39.345) 
			{
				telaSistema_dist.alpha = 0.7;
				telaSistema_dist.blendMode = "multiply";
				telaSistema_dist.tlX=350.75;telaSistema_dist.tlY=84.7;telaSistema_dist.trX=1224.55;telaSistema_dist.trY=77.65;telaSistema_dist.blX=363.85;telaSistema_dist.blY=576.55;telaSistema_dist.brX=1219.55;telaSistema_dist.brY=567.45
			}else {
				facebookCapa_dist.alpha = 0;
				telaSistema_dist.alpha = 0;
				celmsg_dist.alpha = 0;	
				baseListaCel_dist.alpha = 0;
				facebookFoto_dist.alpha = 0;
			}
		}
		

	}
	
}