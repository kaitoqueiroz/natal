package ws.outset.display {
	
	/*
	
	http://www.rubenswieringa.com/blog/distortimage
	
	*/
	
	import flash.display.MovieClip;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.geom.Point;
	import org.flashsandy.display.DistortImage;

	public class DistortImageWrapper extends MovieClip {
		
		private var _content:MovieClip;
		private var _hSegments:int = 3;
		private var _vSegments:int = 3;
		private var _tlX:Number;
		private var _tlY:Number;
		private var _trX:Number;
		private var _trY:Number;
		private var _blX:Number;
		private var _blY:Number;
		private var _brX:Number;
		private var _brY:Number;
		private var _shape:Shape;
		private var _bd:BitmapData;
		private var _showGrid:Boolean = false;
		
		public function DistortImageWrapper(content:MovieClip, hSegmentsP:int = 3, vSegmentsP:int = 3, showGridP:Boolean = false) {
			_content = content;
			_hSegments = hSegmentsP;
			_vSegments = vSegmentsP;
			_showGrid = showGridP;
			_tlX = 0;
			_tlY = 0;
			_trX = _content.width;
			_trY = 0;
			_blX = 0;
			_blY = _content.height;
			_brX = _content.width;
			_brY = _content.height;
			_shape = new Shape();
			_bd = new BitmapData(_content.width, _content.height);
			_bd.draw(_content);
			drawContent();
		}
		public function get hSegments():int {
			return _hSegments;
		}
		public function set hSegments(value:int):void {
			_hSegments = value;
		}
		public function get vSegments():int {
			return _vSegments;
		}
		public function set vSegments(value:int):void {
			_vSegments = value;
		}
		public function get tlX():Number {
			return _tlX;
		}
		public function set tlX(value:Number):void {
			_tlX = value;
			drawContent();
		}
		public function get tlY():Number {
			return _tlY;
		}
		public function set tlY(value:Number):void {
			_tlY = value;
			drawContent();
		}
		public function get trX():Number {
			return _trX;
		}
		public function set trX(value:Number):void {
			_trX = value;
			drawContent();
		}
		public function get trY():Number {
			return _trY;
		}
		public function set trY(value:Number):void {
			_trY = value;
			drawContent();
		}
		public function get blX():Number {
			return _blX;
		}
		public function set blX(value:Number):void {
			_blX = value;
			drawContent();
		}
		public function get blY():Number {
			return _blY;
		}
		public function set blY(value:Number):void {
			_blY = value;
			drawContent();
		}
		public function get brX():Number {
			return _brX;
		}
		public function set brX(value:Number):void {
			_brX = value;
			drawContent();
		}
		public function get brY():Number {
			return _brY;
		}
		public function set brY(value:Number):void {
			_brY = value;
			drawContent();
		}
		public function get showGrid():Boolean {
			return _showGrid;
		}
		public function set showGrid(value:Boolean):void {
			_showGrid = value;
		}
		private function drawContent():void {
			
			if(_shape && contains(_shape)) {
				removeChild(_shape);
			}
			
			_shape.graphics.clear();
			if(_showGrid) {
				_shape.graphics.lineStyle(1, 0x00FF00);
			}
			
			var distortion:DistortImage = new DistortImage(_content.width, _content.height, _hSegments, _vSegments);
			distortion.setTransform(
				_shape.graphics,
				_bd,
				new Point(_tlX, _tlY),
				new Point(_trX, _trY),
				new Point(_brX, _brY),
				new Point(_blX, _blY)
			);			
			
			addChild(_shape);
		}
		
	}

}