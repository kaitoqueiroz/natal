package ws.outset.managers.menu {
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.ContextMenuEvent;
	import flash.net.URLRequest;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuBuiltInItems;
	import flash.ui.ContextMenuItem;
	import ws.outset.utils.Debug;
	import flash.net.navigateToURL;

	public class MenuManager {
		
		private var _clip:*;
		private var _menu:ContextMenu;
		private var _items:Array;
		
		public function MenuManager(clip:*) {
			_clip = clip;
			_items = new Array();
		}
		private function update():void {
			if(_clip.contextMenu) {
				_clip.contextMenu.customItems = [];
			} else {
				_menu = new ContextMenu();
				_menu.builtInItems.forwardAndBack = false;
				_menu.builtInItems.loop = false;
				_menu.builtInItems.play = false;
				_menu.builtInItems.print = false;
				_menu.builtInItems.quality = false;
				_menu.builtInItems.rewind = false;
				_menu.builtInItems.save = false;
				_menu.builtInItems.zoom = false;
				_clip.contextMenu = _menu;
				_clip.contextMenu.customItems = [];
			}
			var numberOfItems:Number = _items.length;
			for (var i:Number = 0; i < numberOfItems; i++) {
				var item:ContextMenuItem = new ContextMenuItem(_items[i].label);					
				if(_items[i].separatorBefore) {
					item.separatorBefore = true;
				}
				_clip.contextMenu.customItems.push(item);
				item.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, onClick);
				item.addEventListener(ContextMenuEvent.MENU_SELECT, onClick);
				_items[i].item = item;				
			}
		}
		private function onClick(e:ContextMenuEvent):void {
			var numberOfItems:Number = _items.length;
			for (var i:Number = 0; i < numberOfItems; i++) {
				if (_items[i].item == e.target) {
					switch(typeof(_items[i].link)) {
						case "string":
							navigateToURL(new URLRequest(_items[i].link));
						break;
						case "function":
							_items[i].link();
						break;
					}
				}
			}
		}
		public function addItem(label:String, link: *, separatorBefore:Boolean = false):void {
			_items.push(
				{
					label:label,
					link:link,
					item:null,
					separatorBefore:separatorBefore
				}
			);
			update();
		}
		public function setEnabled(index:Number, enabled:Boolean):void {
			_items[index].item.enabled = enabled;
		}
		public function disableAll():void {
			var numberOfItems:Number = _items.length;
			for (var i:Number = 0; i < numberOfItems; i++) {
				_items[i].item.enabled = false;
			}
		}
		public function enableAll():void {
			var numberOfItems:Number = _items.length;
			for (var i:Number = 0; i < numberOfItems; i++) {
				_items[i].item.enabled = true;
			}
		}
	}
	
}
