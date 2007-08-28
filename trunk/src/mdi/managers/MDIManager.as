/*
Copyright (c) 2007 FlexMDI Contributors.  See:
    http://code.google.com/p/flexmdi/wiki/ProjectContributors

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/


package mdi.managers
{	

	import flash.display.DisplayObject;
	import flash.events.ContextMenuEvent;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	
	import mdi.containers.MDIWindow;
	import mdi.events.MDIWindowEvent;
	import mdi.effects.IMDIEffectsDescriptor;
	import mdi.effects.MDIBaseEffects;
	
	import mx.containers.Panel;
	import mx.controls.Alert;
	import mx.core.Application;
	import mx.core.Container;
	import mx.core.IFlexDisplayObject;
	import mx.core.UIComponent;
	import mx.effects.Effect;
	import mx.effects.WipeDown;
	import mx.utils.ArrayUtil;
	import mx.core.IUIComponent;
	import mx.managers.PopUpManager;
	import mx.managers.PopUpManagerChildList;

	import mx.collections.ArrayCollection;
	import mdi.effects.effectClasses.MDIGroupEffectItem;

	
	
	public class MDIManager extends EventDispatcher
	{
		
		private static var globalMDIManager : MDIManager;
		public static function get global():MDIManager
		{
			if( MDIManager.globalMDIManager == null)
				globalMDIManager = new MDIManager(Application.application as UIComponent);
				globalMDIManager.isGlobal = true;
			return MDIManager.globalMDIManager;
		}
		
		private var isGlobal : Boolean = false;

		private var tiledWindows:ArrayCollection;
		private var tileMinimize:Boolean = true;
		private var tileMinimizeWidth:int = 200;
		private var showMinimizedTiles:Boolean = true;
		
		public var effects : IMDIEffectsDescriptor = new MDIBaseEffects();
		
		/**
     	*   Contstructor()
     	*/
		public function MDIManager(container:UIComponent,effects:IMDIEffectsDescriptor=null):void
		{
			this.container = container;
			if( effects != null)
				this.effects = effects;
			if(tileMinimize)
				tiledWindows = new ArrayCollection();	
		}
		
		
		private var _container : UIComponent;
		public function get container():UIComponent
		{
			return _container;
		}
		public function set container(value:UIComponent):void
		{
			this._container = value;
		}
		

		/**
     	*  @private
     	*  the managed window stack
     	*/
		public var windowList:Array = new Array();

		public function add(window:MDIWindow):void
		{
			window.windowManager = this;
			
			this.addListeners(window);
			
			this.windowList.push(window);
			
			this.addContextMenu(window);

			
			if(this.isGlobal)
			{
				PopUpManager.addPopUp( window,Application.application as DisplayObject);
				
			}
			else
			{
				// to accomodate mxml impl
				if(window.parent == null)
				{
					this.container.addChild(window);
					this.position(window);
					this.bringToFront(window);
				}
			} 		
	
			this.position(window); 

			this.effects.playShowEffects(window,this);

		}
		
		/**
		 *  Positions a window on the screen 
		 *  
		 * 	<p>This is primarly used as the default space on the screen to position the window.</p>
		 * 
		 *  @param window:MDIWindow Window to position
		 */
		public function position(window:MDIWindow):void
		{	
			window.x = this.windowList.length * 30;
			window.y = this.windowList.length * 30;

			if( (window.x + window.width) > container.width ) window.x = 40;
			if( (window.y + window.height) > container.height ) window.y = 40; 	
		}
		
		public function addContextMenu(window:MDIWindow,contextMenu:ContextMenu=null):void
		{
			// add default context menu 
			if(contextMenu == null)
			{
				var defaultContextMenu : ContextMenu = new ContextMenu();
					defaultContextMenu.hideBuiltInItems();

			
				var item1:ContextMenuItem = new ContextMenuItem("Auto Arrange");
			  		item1.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, menuItemSelectHandler);
					defaultContextMenu.customItems.push(item1);

           	 	var item2:ContextMenuItem = new ContextMenuItem("Auto Arrange Fill");
			  		item2.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, menuItemSelectHandler);
                   	defaultContextMenu.customItems.push(item2);  
                   	
                var item3:ContextMenuItem = new ContextMenuItem("Cascade");
			  		item3.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, menuItemSelectHandler);
                   	defaultContextMenu.customItems.push(item3);
                   	
                var item4:ContextMenuItem = new ContextMenuItem("Close");
			  		item4.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, menuItemSelectHandler);
                   	defaultContextMenu.customItems.push(item4);  
            	     
            	window.contextMenu = defaultContextMenu;
			}
			else
			{	
				// add passed in context menu
				window.contextMenu = contextMenu;
			}
		}
		
		
		private function menuItemSelectHandler(event:ContextMenuEvent):void
		{
			switch(event.target.caption)
			{
				case("Auto Arrange"):
					this.tile();
				break;
				
				case("Auto Arrange Fill"):
					this.tile(true);
				break;
				
				case("Cascade"):
					this.cascade();
				break;
				
				case("Close"):
					this.remove(event.contextMenuOwner as MDIWindow);
				break;
			}
		}
		
		private function windowMoveEventHandler(event:MDIWindowEvent):void
		{
			this.effects.playMoveEffects(event.window,this);
		}

		private function windowResizeEventHandler(event:MDIWindowEvent):void
		{
			this.effects.playResizeEffects(event.window,this);
		}
		
		private function windowFocusInEventHandler(event:MDIWindowEvent):void
		{
			this.effects.playFocusInEffects(event.window,this);
		}
		
		private function windowFocusOutEventHandler(event:MDIWindowEvent):void
		{
			this.effects.playFocusOutEffects(event.window,this);
		}
		
		private function windowResizeStartEventHandler(event:MDIWindowEvent):void
		{
			// implement minimize functionality
		}
		
		private function windowResizeEndEventHandler(event:MDIWindowEvent):void
		{
			// implement minimize funrighctionality
		}
		
		
		
		
		/**
		 * Gets the left placement of a tiled window
		 * 
		 *  @param tileIndex The index value of the current tile instance we're placing
		 * 
		 *  @param maxTiles The maximum number of tiles that can be placed horizontally across the container given the minimimum width of each tile
		 * 
		 *  @param minWinWidth The width of the window tile when minimized
		 * 
		 *  @param padding The padding accordance to place between minimized tile window instances
		 * 
		 * */
		private function getLeftOffsetPosition(tileIndex:int, maxTiles:int, minWinWidth:Number, padding:Number):Number
		{
			var tileModPos:int = tileIndex % maxTiles;
			if(tileModPos == 0)
				return padding;
			else
				return (tileModPos * minWinWidth) + ((tileModPos + 1) * padding);
		}
		
		
		/**
		 * Gets the bottom placement of a tiled window
		 * 
		 *  @param maxTiles The maximum number of tiles that can be placed horizontally across the container given the minimimum width of each tile
		 * 
		 *  @param minWinHeight The height of the window tile instance when minimized -- probably the height of the titleBar instance of the Panel
		 * 
		 * 	@param padding The padding accordance to place between minimized tile window instances
		 * 
		 * */
		private function getBottomTilePosition(maxTiles:int, minWindowHeight:Number, padding:Number):Number
		{
			var numRows:int = Math.floor(this.tiledWindows.length / maxTiles);
			return ((numRows + 1) * minWindowHeight) + ((numRows + 1) * padding);
		}
		
		
		/**
		 * Gets the height accordance for tiled windows along bottom to be used in the maximizing of other windows -- leaves space at bottom of maximize height so tiled windows still show
		 * 
		 *  @param maxTiles The maximum number of tiles that can be placed horizontally across the container given the minimimum width of each tile
		 * 
		 *  @param minWinHeight The height of the window tile instance when minimized -- probably the height of the titleBar instance of the Panel
		 * 
		 * 	@param padding The padding accordance to place between minimized tile window instances
		 * 
		 * */
		private function getBottomOffsetHeight(maxTiles:int, minWindowHeight:Number, padding:Number):Number
		{
			var numRows:int = Math.floor(this.tiledWindows.length / maxTiles);
			//if we have some rows get their combined heights... if not, return 0 so maximized window takes up full height of container
			if(numRows != 0)
				return ((numRows + 1) * minWindowHeight) + ((numRows + 1) * padding);
			else
				return 0;
		}
		
		/**
		 * Retiles the remaining minimized tile instances if one of them gets restored or maximized
		 * 
		 * */
		private function reTileWindows():void
		{
			var maxTiles:int = this.container.width / this.tileMinimizeWidth;
			for(var i:int = 0; i < tiledWindows.length; i++)
			{
				var currentWindow:MDIWindow = tiledWindows.getItemAt(i) as MDIWindow;
				var xPos:Number = getLeftOffsetPosition(i, maxTiles, this.tileMinimizeWidth, 5);
				var yPos:Number = this.container.height - getBottomTilePosition(maxTiles, currentWindow.minimizeHeight, 5);
				var movePoint:Point = new Point(xPos, yPos);
				this.effects.reTileMinWindowsEffects(currentWindow, this, movePoint);
			}	
		}
		
		
		/**
		 * Minimizing of Window
		 * 
		 *  @param event MDIWindowEvent instance containing even type and window instance that is being handled
		 * 
		 * */
		private function windowMinimizeHandler(event:MDIWindowEvent):void
		{
			var maxTiles:int = this.container.width / this.tileMinimizeWidth;
			var xPos:Number = getLeftOffsetPosition(this.tiledWindows.length, maxTiles, this.tileMinimizeWidth, 5);
			var yPos:Number = this.container.height - getBottomTilePosition(maxTiles, event.window.minimizeHeight, 5);
			var minimizePoint:Point = new Point(xPos, yPos);
			this.effects.playMinimizeEffects(event.window, this, minimizePoint);
			this.tiledWindows.addItem(event.window);
		}
		
		
		/**
		 * Restoring of Window
		 * 
		 *  @param event MDIWindowEvent instance containing even type and window instance that is being handled
		 * 
		 * */
		private function windowRestoreEventHandler(event:MDIWindowEvent):void
		{
			for(var i:int = 0; i < tiledWindows.length; i++)
			{
				if(tiledWindows.getItemAt(i) == event.window)
				{
					tiledWindows.removeItemAt(i);
					reTileWindows();
				}
			}
			var restorePoint:Point = new Point(event.window.dragStartPanelX, event.window.dragStartPanelY);
			this.effects.playRestoreEffects(event.window, this, restorePoint);
		}
		
		/**
		 * Maximizing of Window
		 * 
		 *  @param event MDIWindowEvent instance containing even type and window instance that is being handled
		 * 
		 * */
		private function windowMaximizeEventHandler(event:MDIWindowEvent):void
		{
			for(var i:int = 0; i < tiledWindows.length; i++)
			{
				if(tiledWindows.getItemAt(i) == event.window)
				{
					tiledWindows.removeItemAt(i);
					reTileWindows();
				}
			}
			var maxTiles:int = this.container.width / this.tileMinimizeWidth;
			if(showMinimizedTiles)
				this.effects.playMaximizeEffects(event.window,this,getBottomOffsetHeight(maxTiles, event.window.minimizeHeight, 5) + 5);
			else
				this.effects.playMaximizeEffects(event.window,this);
		}
		
		
		/**
		 * Closing of Window
		 * 
		 *  @param event MDIWindowEvent instance containing even type and window instance that is being handled
		 * 
		 * */
		private function windowCloseEventHandler(event:MDIWindowEvent):void
		{
			this.effects.playCloseEffects(event.window,this,this.remove);
		}


		
		public function addCenter(window:MDIWindow):void
		{
			this.add(window);
			this.center(window);
		}
		
		
		/**
		 * Brings a window to the front of the screen. 
		 * 
		 *  @param win Window to bring to front
		 * */
		public function bringToFront(window:MDIWindow):void
		{	
			if(this.isGlobal)
			{
				PopUpManager.bringToFront(window as IFlexDisplayObject);
			}
			else
			{
				this.container.setChildIndex(window, this.container.numChildren - 1);
			}
			
		}
		
		
		/**
		 * Positions a window in the center of the available screen. 
		 * 
		 *  @param window:MDIWindow to center
		 * */
		public function center(window:MDIWindow):void
		{
			window.x = this.container.width / 2 - window.width;
			window.y = this.container.height / 2 - window.height;
		}
		
		/**
		 * Removes all windows from managed window stack; 
		 * */
		public function removeAll():void
		{	
		
			for each(var window:MDIWindow in windowList)
			{
				if(this.isGlobal)
				{
					PopUpManager.removePopUp( window as IFlexDisplayObject);
				}
				else
				{
					container.removeChild(window);
				}
				
				this.removeListeners(window);
			}
			
			this.windowList = new Array();
		}
		
		/**
		 *  @private
		 * 
		 *  Adds listeners 
		 *  @param window:MDIWindow  
		 */
		
		private function addListeners(window:MDIWindow):void
		{
					
			window.addEventListener(MDIWindowEvent.MOVE, this.windowMoveEventHandler );
			window.addEventListener(MDIWindowEvent.RESIZE, this.windowResizeEventHandler);
			window.addEventListener(MDIWindowEvent.FOCUS_IN, this.windowFocusInEventHandler);
			window.addEventListener(MDIWindowEvent.FOCUS_OUT, this.windowFocusOutEventHandler);
			window.addEventListener(MDIWindowEvent.MINIMIZE,this.windowMinimizeHandler);
			window.addEventListener(MDIWindowEvent.RESTORE,this.windowRestoreEventHandler);
			window.addEventListener(MDIWindowEvent.MAXIMIZE,this.windowMaximizeEventHandler);
			window.addEventListener(MDIWindowEvent.CLOSE,this.windowCloseEventHandler);
			window.addEventListener(MDIWindowEvent.RESIZE_END,this.windowResizeEndEventHandler);
			window.addEventListener(MDIWindowEvent.RESIZE_START,this.windowResizeStartEventHandler); 
		}


		/**
		 * 	@private
		 * 
		 *  Removes listeners
		 *  
		 *  @param window:MDIWindow 
		 */
		private function removeListeners(window:MDIWindow):void
		{
			window.removeEventListener(MDIWindowEvent.MOVE, this.windowMoveEventHandler );
			window.removeEventListener(MDIWindowEvent.RESIZE, this.windowResizeEventHandler);
			window.removeEventListener(MDIWindowEvent.FOCUS_IN, this.windowFocusInEventHandler);
			window.removeEventListener(MDIWindowEvent.FOCUS_OUT, this.windowFocusOutEventHandler);
			window.removeEventListener(MDIWindowEvent.MINIMIZE,this.windowMinimizeHandler);
			window.removeEventListener(MDIWindowEvent.RESTORE,this.windowRestoreEventHandler);
			window.removeEventListener(MDIWindowEvent.MAXIMIZE,this.windowMaximizeEventHandler);
			window.removeEventListener(MDIWindowEvent.CLOSE,this.windowCloseEventHandler);
			window.removeEventListener(MDIWindowEvent.RESIZE_END,this.windowResizeEndEventHandler);
			window.removeEventListener(MDIWindowEvent.RESIZE_START,this.windowResizeStartEventHandler); 
		}
		
		
		
		
		/**
		 *  Removes a window instance from the managed window stack 
		 *  @param window:MDIWindow Window to remove 
		 */
		public function remove(window:MDIWindow):void
		{	
			
			var index:int = ArrayUtil.getItemIndex(window, this.windowList);
			
			windowList.splice(index, 1);
			
			if(this.isGlobal)
			{
				PopUpManager.removePopUp(window as IFlexDisplayObject);
			}
			else
			{
				container.removeChild(window);
			}
			
			this.removeListeners(window);
		}
		
		
				
		
		/**
		 * Pushes a window onto the managed window stack 
		 * 
		 *  @param win Window:MDIWindow to push onto managed windows stack 
		 * */
		public function manage(window:MDIWindow):void
		{	
			if(window != null)
				windowList.push(window);
		}
		
		/**
		 *  Positions a window in an absolute position 
		 * 
		 *  @param win:MDIWindow Window to position
		 * 
		 *  @param x:int The x position of the window
		 * 
		 *  @param y:int The y position of the window 
		 */
		public function absPos(window:MDIWindow,x:int,y:int):void
		{
			window.x = x;
			window.y = y;		
		}
		
		/**
		 *  @private getOpenWindowList():Array
		 * 
		 *  gets a list of open windows for scenarios when only open windows need to be managed
		 * 
		 */
		private function getOpenWindowList():Array
		{	
			var array : Array = [];
			for(var i:int = 0; i < windowList.length; i++)
			{
				if(!MDIWindow(windowList[i]).minimized)
				{
					array.push(windowList[i]);
				}
			}
			return array;
		}
		
		/**
		 *  Tiles the window across the screen
		 *  
		 *  <p>By default, windows will be tiled to all the same size and use only the space they can accomodate.
		 *  If you set fillAvailableSpace = true, tile will use all the space available to tile the windows with
		 *  the windows being arranged by varying heights and widths. 
     	 *  </p>
		 * 
		 *  @param fillAvailableSpace:Boolean Variable to determine whether to use the fill the entire available screen
		 * 
		 */
		public function tile(fillAvailableSpace:Boolean = false,gap:int = 0):void
		{
			
			var openWinList:Array = getOpenWindowList();
				
			var numWindows:int = openWinList.length;
			
			var sqrt:int = Math.round(Math.sqrt(numWindows));
			var numCols:int = Math.ceil(numWindows / sqrt);
			var numRows:int = Math.ceil(numWindows / numCols);
			var col:int = 0;
			var row:int = 0;
			var availWidth:Number = this.container.width;
			var availHeight:Number = this.container.height;
			var targetWidth:Number = availWidth / numCols - ((gap * (numCols - 1)) / numCols);
			var targetHeight:Number = availHeight / numRows - ((gap * (numRows - 1)) / numRows);
			
			var effectItems : Array = [];
				
			for(var i:int = 0; i < openWinList.length; i++)
			{
				
				var win:MDIWindow = openWinList[i];
				
				var item : MDIGroupEffectItem = new MDIGroupEffectItem(win);
				
				item.widthTo = targetWidth;
				item.heightTo = targetHeight;
				
				//win.width = targetWidth;
				//win.height = targetHeight;
				
				if(i % numCols == 0 && i > 0)
				{
					row++;
					col = 0;
				}
				else if(i > 0)
				{
					col++;
				}

				item.moveTo = new Point( (col * targetWidth), (row * targetHeight) ); 
		
				//pushing out by gap
				if(col > 0) 
					item.moveTo.x += gap * col;
				
				if(row > 0) 
					item.moveTo.y += gap * row;

				effectItems.push( item );

			}
			

			if(col < numCols && fillAvailableSpace)
			{
				var numOrphans:int = numWindows % numCols;
				var orphanWidth:Number = availWidth / numOrphans - ((gap * (numOrphans - 1)) / numOrphans);
				//var orphanWidth:Number = availWidth / numOrphans;
				var orphanCount:int = 0
				for(var j:int = numWindows - numOrphans; j < numWindows; j++)
				{
					//var orphan:MDIWindow = openWinList[j];
					var orphan : MDIGroupEffectItem = effectItems[j];
					
					orphan.widthTo = orphanWidth;
					//orphan.window.width = orphanWidth;
					
					orphan.moveTo.x = (j - (numWindows - numOrphans)) * orphanWidth;
					if(orphanCount > 0) 
						orphan.moveTo.x += gap * orphanCount;
					orphanCount++;
				}
			} 
			
			this.effects.playTileEffects( effectItems,this);
		}
		
		// set a min. width/height
		public function resize(window:MDIWindow):void
		{	
		
			var w:int = this.container.width * .6;
			var h:int = this.container.height * .6
			if( w > window.width )
				window.width = w;
			if( h > window.height )
				window.height=h;
		}
		
		
		
		
		
		
		
		/**
		 *  Maximizes a window to use all available space
		 * 
		 *  @param window:MDIWindow Window to maximize
		 */
		public function maximize(window:MDIWindow):void
		{					
			
			window.x=10;
			window.y=40;
			window.width = this.container.width - 20;
			window.height = this.container.height - 60;
	
			this.bringToFront(window);
		}
		
		
		
		
		
		
		/**
		 *  Cascades all managed windows from top left to bottom right 
		 * 
		 *  @param window:MDIWindow Window to maximize
		 */	
		public function cascade():void
		{
			
			
			var effectItems : Array = [];
			
			var windows:Array = getOpenWindowList();
			
			for(var i:int=0; i < windows.length; i++)
			{
				var window : MDIWindow = windows[i] as MDIWindow;
				
				this.bringToFront(window);
					
				var item : MDIGroupEffectItem = new MIDGroupEffectItem(window);
		
					item.moveTo =  new Point( openCount * 40,  openCount * 40);
					item.heightFrom = window.height;
					item.heightTo = window.height;
					item.widthFrom = window.width;
					item.widthTo = window.width;
					
				effectItems.push(item);
			
			}
			
			this.effects.playCascadeEffects( effectItems, this );
		}
		
			
	}
}