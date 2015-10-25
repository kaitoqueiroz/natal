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
    import flash.net.navigateToURL;
    import flash.net.URLRequest;
    import flash.net.URLVariables;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Main extends MovieClip 
	{
		public var video:VideoLoader;
		public var carregando_mc:MovieClip;
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
		public var isFotoCapaReady:Boolean = false;
		public var offset:Number = 0;
		public var desejos:Array = [];
		public var temCapa = true;
		
		public var fotoCapa:Bitmap;
		public var fotoFace:Bitmap;
		
		public var isBaseListaCel_onStage:Boolean = false;
		public var isCelmsg_onStage:Boolean = false;
		public var isTelaSistema_onStage:Boolean = false;
		public var isFacebookCapa_onStage:Boolean = false;
		public var isFacebookFoto_onStage:Boolean = false;
		public var isBufferFull:Boolean = false;

		
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
			ExternalInterface.addCallback("setFotoCapa",setFotoCapa);
			ExternalInterface.addCallback("setLocal",setLocal);
			ExternalInterface.addCallback("setEnsino",setEnsino);
			ExternalInterface.addCallback("setRelacionamento",setRelacionamento);

		}
		
		
		public function setLocal(local){
			ExternalInterface.call("console.log", local);
			var local_tf = new TextField();
			local_tf.width = 642;
			local_tf.height = 24;
			local_tf.text = local;
			var format_local:TextFormat = new TextFormat('Arial', 18, 0x556fa6);
			format_local.align = 'left';
			local_tf.setTextFormat(format_local);
			facebookCapa.addChild(local_tf);
			local_tf.x = 117;
			local_tf.y = 563;
			
			var localSist_tf = new TextField();
			localSist_tf.width = 217;
			localSist_tf.height = 24;
			localSist_tf.text = local;
			var localSistFormat = new TextFormat('Arial', 20, 0x000000);
			localSistFormat.align = 'left';
			localSist_tf.setTextFormat(localSistFormat);
			telaSistema.addChild(localSist_tf);
			localSist_tf.x = 717;
			localSist_tf.y = 547;
		}
		
		public function setEnsino(inst){
			ExternalInterface.call("console.log", inst);
			var inst_tf = new TextField();
			inst_tf.width = 455;
			inst_tf.height = 24;
			inst_tf.text = inst;
			var format_inst:TextFormat = new TextFormat('Arial', 18, 0x556fa6);
			format_inst.align = 'left';
			inst_tf.setTextFormat(format_inst);
			facebookCapa.addChild(inst_tf);
			inst_tf.x = 303;
			inst_tf.y = 606;
		}
		
		public function setRelacionamento(status){
			ExternalInterface.call("console.log", status);
			var rel_tf = new TextField();
			rel_tf.width = 488;
			rel_tf.height = 24;
			rel_tf.text = status;
			var format_rel:TextFormat = new TextFormat('Arial', 18, 0x556fa6);
			format_rel.align = 'left';
			rel_tf.setTextFormat(format_rel);
			facebookCapa.addChild(rel_tf);
			rel_tf.x = 32;
			rel_tf.y = 647;
		}
		
		public function videoCompleto(e) {
			navigateToURL( new URLRequest( '/compartilhar' ),'_self' );
		}
		
		public function videoBufferFull(e){
			isBufferFull = true;
			stage.removeChild(carregando_mc);
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
			
			video.addEventListener("videoComplete",videoCompleto),
			video.addEventListener("videoBufferFull",videoBufferFull),

		
			video.load();
			celmsg_mc = new CelMsg();
			telaSistema = new TelaSistema();
			baseListaCel = new BaseListaCel();
			facebookCapa = new FacebookCapa();
			facebookFoto = new FacebookFoto();
			
			carregando_mc =  new Carregando();
			stage.addChild(carregando_mc);
			carregando_mc.y = stage.height / 2;
			carregando_mc.x = 0;
			//setEmail('loremipsom@gmail.com');
			
		}
		
		public function setDesejos(desejos:Array) {
			
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
				desejos_txt += desejos[i] ;
				
				if (i == desejos.length-1) 
				{
					desejos_txt +=  '. ';
				}else {
					desejos_txt +=  ', ';
				}
				
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
			var proporcao = 0;
			if (isAvatarReady && isFotoPerfilReady && isFotoCapaReady && isBufferFull) {
				
				if(temCapa){
					proporcao = fotoCapa.height / fotoCapa.width;
					fotoCapa.width = 768;
					fotoCapa.height = fotoCapa.width * proporcao;
						
					fotoCapa.smoothing = true;
					facebookCapa.addChild(fotoCapa);
					fotoCapa.y = 88-offset;
					fotoCapa.x = 0;
					
					var baseCapa:Sprite = new Sprite();
					baseCapa.graphics.lineStyle(1, 0x000000); 
					baseCapa.graphics.beginFill(0x0000ff); 
					baseCapa.graphics.drawRect(0, 88, 768, 367); 
					baseCapa.graphics.endFill(); 
					facebookCapa.addChild(baseCapa);
					fotoCapa.cacheAsBitmap = true;
					baseCapa.cacheAsBitmap = true;
					fotoCapa.mask = baseCapa;
				}
				
				var fundoFoto:MovieClip = new FundoFotoFace();
				
				facebookCapa.addChild(fundoFoto);
				fundoFoto.x = 29;
				fundoFoto.y = 365;
				
				fotoFace.width = 180;
				fotoFace.height = 180;
				fotoFace.smoothing = true;
					
				facebookCapa.addChild(fotoFace);

				fotoFace.x = 33;
				fotoFace.y = 369;
			
				removeEventListener(Event.ENTER_FRAME, checkReady);
				video.addEventListener("playProgress", checkTime);
				baseListaCel_dist = new DistortImageWrapper(baseListaCel,5,5);
				celmsg_dist = new DistortImageWrapper(celmsg_mc, 5, 5);
				telaSistema_dist = new DistortImageWrapper(telaSistema, 5, 5);
				facebookCapa_dist = new DistortImageWrapper(facebookCapa, 10, 10);
				facebookFoto_dist = new DistortImageWrapper(facebookFoto,10,10);

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
			loader.load(new URLRequest(url), context);
			return true
		}		
		public function setFotoCapa(url, ofst) {
			if (url == null) {
				isFotoCapaReady = true;
				temCapa = false;
				return true;
			}
			offset = ofst;
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onCompleteFotoCapa);
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
				
				fotoPerfil.height = 570;
				fotoPerfil.width = fotoPerfil.height * proporcao;
				extra_x = (636 - fotoPerfil.width) / 2;
				
			}
			fotoPerfil.smoothing = true;
			facebookFoto.addChild(fotoPerfil);
			fotoPerfil.x = 66+extra_x;
			fotoPerfil.y = 139;
		}		
		
		public function onCompleteFotoCapa(event:Event){
			isFotoCapaReady = true;
			fotoCapa = new Bitmap(Bitmap(LoaderInfo(event.target).content).bitmapData);
			

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
			

			
			fotoFace = new Bitmap(Bitmap(LoaderInfo(event.target).content).bitmapData);

			
		}
		
		public function checkTime(e:LoaderEvent = null) {
			
				
			if (video.videoTime >= 4.36 && video.videoTime < 8.785) {
				if (!isCelmsg_onStage) {
					isCelmsg_onStage = true
					stage.addChild(celmsg_dist);
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
				}

			}else if (video.videoTime >= 12.346 && video.videoTime <= 15.965) 
			{
				if (!isBaseListaCel_onStage) 
				{
					isBaseListaCel_onStage = true;
					stage.addChild(baseListaCel_dist);
					baseListaCel_dist.alpha = 0.8;
					baseListaCel_dist.blendMode = "multiply";
					baseListaCel_dist.tlX = 927.25; baseListaCel_dist.tlY = 211.7; baseListaCel_dist.trX = 1173.15; baseListaCel_dist.trY = 251; baseListaCel_dist.blX = 864.75; baseListaCel_dist.blY = 652.1; baseListaCel_dist.brX = 1108.65; baseListaCel_dist.brY = 696.45;
				}
			
			}else if (video.videoTime >= 23 && video.videoTime <= 28.196) 
			{
				if (!isFacebookCapa_onStage) 
				{
					isFacebookCapa_onStage = true;
					stage.addChild(facebookCapa_dist);
					facebookCapa_dist.alpha = 0.8;
					facebookCapa_dist.blendMode = "multiply";
					facebookCapa_dist.tlX = 710.65; facebookCapa_dist.tlY = 14.25; facebookCapa_dist.trX = 1167.15; facebookCapa_dist.trY = 81.35; facebookCapa_dist.blX = 623.2; facebookCapa_dist.blY = 612.05; facebookCapa_dist.brX = 1057.35; facebookCapa_dist.brY = 705.6;

				}
			}else if (video.videoTime >= 30.954 && video.videoTime <= 33.76) 
			{
				if (!isFacebookFoto_onStage) 
				{
					isFacebookFoto_onStage = true;
					stage.addChild(facebookFoto_dist);
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
				}

			}else if (video.videoTime >= 37.337 && video.videoTime <= 39.345) 
			{
				if (!isTelaSistema_onStage) {
					isTelaSistema_onStage = true;
					stage.addChild(telaSistema_dist);
					telaSistema_dist.alpha = 0.7;
					telaSistema_dist.blendMode = "multiply";
					telaSistema_dist.tlX = 350.75; telaSistema_dist.tlY = 84.7; telaSistema_dist.trX = 1224.55; telaSistema_dist.trY = 77.65; telaSistema_dist.blX = 363.85; telaSistema_dist.blY = 576.55; telaSistema_dist.brX = 1219.55; telaSistema_dist.brY = 567.45;
				}
			}else {
				if (isCelmsg_onStage) { stage.removeChild(celmsg_dist); isCelmsg_onStage = false; }
				if (isBaseListaCel_onStage) { stage.removeChild(baseListaCel_dist); isBaseListaCel_onStage = false; }
				if (isFacebookCapa_onStage) { stage.removeChild(facebookCapa_dist); isFacebookCapa_onStage=false}
				if (isFacebookFoto_onStage) { stage.removeChild(facebookFoto_dist); isFacebookFoto_onStage = false; }
				if (isTelaSistema_onStage) { stage.removeChild(telaSistema_dist); isTelaSistema_onStage = false; }
			}
		}
		

	}
	
}