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
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	
	import mdi.containers.MDIWindow;
	import mdi.containers.MDIWindowState;
	import mdi.effects.IMDIEffectsDescriptor;
	import mdi.effects.MDIBaseEffects;
	import mdi.effects.effectClasses.MDIGroupEffectItem;
	import mdi.events.MDIManagerEvent;
	import mdi.events.MDIWindowEvent;
	
	import mx.collections.ArrayCollection;
	import mx.core.Application;
	import mx.core.IFlexDisplayObject;
	import mx.core.UIComponent;
	import mx.events.EffectEvent;
	import mx.events.ResizeEvent;
	import mx.managers.PopUpManager;
	import mx.utils.ArrayUtil;
	
	
	public class MDIManager extends EventDispatcher
	{
		
		private static var globalMDIManager:MDIManager;
		public static function get global():MDIManager
		{
			if(MDIManager.globalMDIManager == null)
			{
				globalMDIManager = new MDIManager(Application.application as UIComponent);
				globalMDIManager.isGlobal = true;
			}
			return MDIManager.globalMDIManager;
		}
		
		private var isGlobal:Boolean = false;

		private var tiledWindows:ArrayCollection;
		public var tileMinimize:Boolean = true;
		public var tileMinimizeWidth:int = 200;
		public var showMinimizedTiles:Boolean = false;
		public var tilePadding:Number = 8;
		public var minTilePadding:Number = 5;
		
		public var effects:IMDIEffectsDescriptor = new MDIBaseEffects();
		
		/**
     	*   Contstructor()
     	*/
		public function MDIManager(container:UIComponent,effects:IMDIEffectsDescriptor=null):void
		{
			this.container = container;
			if(effects != null)
			{
				this.effects = effects;
			}
			if(tileMinimize)
			{
				tiledWindows = new ArrayCollection();
			}
			this.container.addEventListener(ResizeEvent.RESIZE, containerResizeHandler);
			
			// these handlers execute default behaviors
			addEventListener(MDIWindowEvent.MINIMIZE, defaultWindowEventHandler, false, -1);
			addEventListener(MDIWindowEvent.RESTORE, defaultWindowEventHandler, false, -1);
			addEventListener(MDIWindowEvent.MAXIMIZE, defaultWindowEventHandler, false, -1);
			addEventListener(MDIWindowEvent.CLOSE, defaultWindowEventHandler, false, -1);
			
			addEventListener(MDIWindowEvent.FOCUS_START, defaultWindowEventHandler, false, -1);
			addEventListener(MDIWindowEvent.FOCUS_END, defaultWindowEventHandler, false, -1);
			addEventListener(MDIWindowEvent.MOVE, defaultWindowEventHandler, false, -1);
			addEventListener(MDIWindowEvent.RESIZE_START, defaultWindowEventHandler, false, -1);
			addEventListener(MDIWindowEvent.RESIZE, defaultWindowEventHandler, false, -1);
			addEventListener(MDIWindowEvent.RESIZE_END, defaultWindowEventHandler, false, -1);
		}
		
		private var _container:UIComponent;
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
				PopUpManager.addPopUp(window,Application.application as DisplayObject);
				this.position(window);
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
			
			window.setMDIWindowFocus();
			this.effects.getShowEffect(window, this).play();
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

			if((window.x + window.width) > container.width) window.x = 40;
			if((window.y + window.height) > container.height) window.y = 40; 	
		}
		
		public function addContextMenu(window:MDIWindow,contextMenu:ContextMenu=null):void
		{
			// add default context menu 
			if(contextMenu == null)
			{
				var defaultContextMenu:ContextMenu = new ContextMenu();
					defaultContextMenu.hideBuiltInItems();
				
				var arrangeItem:ContextMenuItem = new ContextMenuItem("Auto Arrange");
			  		arrangeItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, menuItemSelectHandler);	
			  		defaultContextMenu.customItems.push(arrangeItem);

           	 	var arrangeFillItem:ContextMenuItem = new ContextMenuItem("Auto Arrange Fill");
			  		arrangeFillItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, menuItemSelectHandler);  	
			  		defaultContextMenu.customItems.push(arrangeFillItem);   
                
                var showAllItem:ContextMenuItem = new ContextMenuItem("Show All Windows");
			  		showAllItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, menuItemSelectHandler);
			  		defaultContextMenu.customItems.push(showAllItem);  
                
                var cascadeItem:ContextMenuItem = new ContextMenuItem("Cascade");
			  		cascadeItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, menuItemSelectHandler);
			  		defaultContextMenu.customItems.push(cascadeItem);  
			  		
			  	
                   	
            	this.container.contextMenu = defaultContextMenu;
			}
			else
			{	
				// add passed in context menu
				window.contextMenu = contextMenu;
			}
		}
		
		
		private function menuItemSelectHandler(event:ContextMenuEvent):void
		{
			var win:MDIWindow = event.contextMenuOwner as MDIWindow;
			switch(event.target.caption)
			{	
				case("Auto Arrange"):
					this.tile(false, this.tilePadding);
				break;
				
				case("Auto Arrange Fill"):
					this.tile(true, this.tilePadding);
				break;
				
				case("Cascade"):
					this.cascade();
				break;
				
				case("Show All Windows"):
					this.showAllWindows();
				break;
			}
		}
		
		private function windowEventProxy(event:Event):void
		{
			if(event is MDIWindowEvent)
			{
				var winEvent:MDIWindowEvent = event as MDIWindowEvent;
				var mgrEvent:MDIManagerEvent = new MDIManagerEvent(winEvent.type, winEvent.window, this);
				
				switch(winEvent.type)
				{
					case MDIWindowEvent.MINIMIZE:
						var maxTiles:int = Math.floor(this.container.width / (this.tileMinimizeWidth + this.tilePadding));
						var xPos:Number = getLeftOffsetPosition(this.tiledWindows.length, maxTiles, this.tileMinimizeWidth, this.minTilePadding);
						var yPos:Number = this.container.height - getBottomTilePosition(this.tiledWindows.length, maxTiles, mgrEvent.window.minimizeHeight, this.minTilePadding);
						var minimizePoint:Point = new Point(xPos, yPos);
						mgrEvent.effect = this.effects.getMinimizeEffect(mgrEvent.window, this, minimizePoint);
					break;
					
					case MDIWindowEvent.RESTORE:
						var restorePoint:Point = new Point(winEvent.window.dragStartPanelX, winEvent.window.dragStartPanelY);
						mgrEvent.effect = this.effects.getRestoreEffect(winEvent.window, this, restorePoint);
					break;
					
					case MDIWindowEvent.MAXIMIZE:
						mgrEvent.effect = this.effects.getMaximizeEffect(winEvent.window, this);
					break;
					
					case MDIWindowEvent.CLOSE:
						mgrEvent.effect = this.effects.getCloseEffect(mgrEvent.window, this);
					break;
					
					case MDIWindowEvent.FOCUS_START:
						mgrEvent.effect = this.effects.getFocusInEffect(winEvent.window, this);
					break;
					
					case MDIWindowEvent.FOCUS_END:
						mgrEvent.effect = this.effects.getFocusOutEffect(winEvent.window, this);
					break;
		
					case MDIWindowEvent.MOVE:
						mgrEvent.effect = this.effects.getMoveEffect(winEvent.window, this);
					break;
					
					case MDIWindowEvent.RESIZE_START:
						// future implementation of resize start
					break;
					
					case MDIWindowEvent.RESIZE:
						mgrEvent.effect = this.effects.getResizeEffect(winEvent.window, this);
					break;
					
					case MDIWindowEvent.RESIZE_END:
						// future implementation of a resize end
					break;
				}
				
				dispatchEvent(mgrEvent);
			}			
		}
		
		private function defaultWindowEventHandler(event:Event):void
		{
			if(event is MDIManagerEvent)
			{
				var mgrEvent:MDIManagerEvent = event as MDIManagerEvent;
				
				switch(mgrEvent.type)
				{					
					case MDIWindowEvent.MINIMIZE:
						tiledWindows.addItem(mgrEvent.window);				
						reTileWindows();
						mgrEvent.effect.play();
					break;
					
					case MDIWindowEvent.RESTORE:
						removeTileInstance(mgrEvent.window);
						mgrEvent.effect.play();
					break;
					
					case MDIWindowEvent.MAXIMIZE:
						removeTileInstance(mgrEvent.window);
						maximizeWindow(mgrEvent.window);
					break;
					
					case MDIWindowEvent.CLOSE:
						removeTileInstance(mgrEvent.window);
						mgrEvent.effect.addEventListener(EffectEvent.EFFECT_END, onCloseEffectEnd);
						mgrEvent.effect.play();
					break;
					
					case MDIWindowEvent.FOCUS_START:
						mgrEvent.window.styleName = "mdiWindowFocus";
						mgrEvent.effect.play();
					break;
					
					case MDIWindowEvent.FOCUS_END:
						mgrEvent.window.styleName = "mdiWindowNoFocus";
						mgrEvent.effect.play();
					break;
		
					case MDIWindowEvent.MOVE:
						mgrEvent.effect.play();
					break;
					
					case MDIWindowEvent.RESIZE_START:
						//
					break;
					
					case MDIWindowEvent.RESIZE:
						mgrEvent.effect.play();
					break;
					
					case MDIWindowEvent.RESIZE_END:
						//
					break;
				}
			}			
		}
		
		private function onCloseEffectEnd(event:EffectEvent):void
		{
			remove(event.effectInstance.target as MDIWindow);
		}
				
		
		/**
		 * Handles resizing of container to reposition elements
		 * 
		 *  @param event The ResizeEvent object from event dispatch
		 * 
		 * */
		private function containerResizeHandler(event:ResizeEvent):void
		{	
			//repositions any minimized tiled windows to bottom left in their rows
			reTileWindows();
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
		private function getBottomTilePosition(tileIndex:int, maxTiles:int, minWindowHeight:Number, padding:Number):Number
		{
			var numRows:int = Math.floor(tileIndex / maxTiles);
			if(numRows == 0)
				return minWindowHeight + padding;
			else
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
			var numRows:int = Math.ceil(this.tiledWindows.length / maxTiles);
			//if we have some rows get their combined heights... if not, return 0 so maximized window takes up full height of container
			if(this.tiledWindows.length != 0)
				return ((numRows) * minWindowHeight) + ((numRows + 1) * padding);
			else
				return 0;
		}
		
		/**
		 * Retiles the remaining minimized tile instances if one of them gets restored or maximized
		 * 
		 * */
		private function reTileWindows():void
		{
			var maxTiles:int = Math.floor(this.container.width / (this.tileMinimizeWidth + this.tilePadding));
			
			//we've just removed/added a row from the tiles, so we tell any maximized windows to change their height
			
			if(this.tiledWindows.length % maxTiles == 0 || (this.tiledWindows.length - 1) % maxTiles == 0)
			{
				var openWins:Array = getOpenWindowList();
				for(var winIndex:int = 0; winIndex < openWins.length; winIndex++)
				{
					if(MDIWindow(openWins[winIndex]).windowState == MDIWindowState.MAXIMIZED)
						maximizeWindow(MDIWindow(openWins[winIndex]));
				}
			}
			
			for(var i:int = 0; i < tiledWindows.length; i++)
			{
				var currentWindow:MDIWindow = tiledWindows.getItemAt(i) as MDIWindow;
				var xPos:Number = getLeftOffsetPosition(i, maxTiles, this.tileMinimizeWidth, this.minTilePadding);
				var yPos:Number = this.container.height - getBottomTilePosition(i, maxTiles, currentWindow.minimizeHeight, this.minTilePadding);
				var movePoint:Point = new Point(xPos, yPos);
				this.effects.reTileMinWindowsEffect(currentWindow, this, movePoint).play();
			}	
		}
		
	
		
		/**
		 * Maximizing of Window
		 * 
		 * @param window MDIWindowinstance to maximize
		 * 
		 **/
		private function maximizeWindow(window:MDIWindow):void
		{
			var maxTiles:int = this.container.width / this.tileMinimizeWidth;
			if(showMinimizedTiles)
			{
				this.effects.getMaximizeEffect(window, this, getBottomOffsetHeight(maxTiles, window.minimizeHeight, this.minTilePadding)).play();
			}
			else
			{
				this.effects.getMaximizeEffect(window, this).play();
			}
		}
		

		
		/**
		 * Removes the closed window from the ArrayCollection of tiled windows
		 * 
		 *  @param event MDIWindowEvent instance containing even type and window instance that is being handled
		 * 
		 * */
		private function removeTileInstance(window:MDIWindow):void
		{
			for(var i:int = 0; i < tiledWindows.length; i++)
			{
				if(tiledWindows.getItemAt(i) == window)
				{
					this.tiledWindows.removeItemAt(i);
					reTileWindows();
				}
			}
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
					PopUpManager.removePopUp(window as IFlexDisplayObject);
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
			window.addEventListener(MDIWindowEvent.MINIMIZE, windowEventProxy, false, -1);
			window.addEventListener(MDIWindowEvent.RESTORE, windowEventProxy, false, -1);
			window.addEventListener(MDIWindowEvent.MAXIMIZE, windowEventProxy, false, -1);
			window.addEventListener(MDIWindowEvent.CLOSE, windowEventProxy, false, -1);
			
			window.addEventListener(MDIWindowEvent.FOCUS_START, windowEventProxy, false, -1);
			window.addEventListener(MDIWindowEvent.FOCUS_END, windowEventProxy, false, -1);
			window.addEventListener(MDIWindowEvent.MOVE, windowEventProxy, false, -1);
			window.addEventListener(MDIWindowEvent.RESIZE_START, windowEventProxy, false, -1);
			window.addEventListener(MDIWindowEvent.RESIZE, windowEventProxy, false, -1);
			window.addEventListener(MDIWindowEvent.RESIZE_END, windowEventProxy, false, -1);
		}


		/**
		 *  @private
		 * 
		 *  Removes listeners 
		 *  @param window:MDIWindow 
		 */
		private function removeListeners(window:MDIWindow):void
		{
			window.removeEventListener(MDIWindowEvent.MINIMIZE, windowEventProxy);
			window.removeEventListener(MDIWindowEvent.RESTORE, windowEventProxy);
			window.removeEventListener(MDIWindowEvent.MAXIMIZE, windowEventProxy);
			window.removeEventListener(MDIWindowEvent.CLOSE, windowEventProxy);
			
			window.removeEventListener(MDIWindowEvent.FOCUS_START, windowEventProxy);
			window.removeEventListener(MDIWindowEvent.FOCUS_END, windowEventProxy);
			window.removeEventListener(MDIWindowEvent.MOVE, windowEventProxy);
			window.removeEventListener(MDIWindowEvent.RESIZE_START, windowEventProxy);
			window.removeEventListener(MDIWindowEvent.RESIZE, windowEventProxy);	
			window.removeEventListener(MDIWindowEvent.RESIZE_END, windowEventProxy);
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
			var array:Array = [];
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
			
			if(numWindows == 1)
			{
				MDIWindow(openWinList[0]).maximizeRestore();
			}
			else if(numWindows > 1)
			{
				var sqrt:int = Math.round(Math.sqrt(numWindows));
				var numCols:int = Math.ceil(numWindows / sqrt);
				var numRows:int = Math.ceil(numWindows / numCols);
				var col:int = 0;
				var row:int = 0;
				var availWidth:Number = this.container.width;
				var availHeight:Number = this.container.height
				
				if(showMinimizedTiles)
					availHeight = availHeight - getBottomOffsetHeight(this.tiledWindows.length, openWinList[0].minimizeHeight, this.minTilePadding);
					
				var targetWidth:Number = availWidth / numCols - ((gap * (numCols - 1)) / numCols);
				var targetHeight:Number = availHeight / numRows - ((gap * (numRows - 1)) / numRows);
				
				var effectItems:Array = [];
					
				for(var i:int = 0; i < openWinList.length; i++)
				{
					
					var win:MDIWindow = openWinList[i];
					
					bringToFront(win)
					
					var item:MDIGroupEffectItem = new MDIGroupEffectItem(win);
					
					item.widthTo = targetWidth;
					item.heightTo = targetHeight;

					if(i % numCols == 0 && i > 0)
					{
						row++;
						col = 0;
					}
					else if(i > 0)
					{
						col++;
					}
	
					item.moveTo = new Point((col * targetWidth), (row * targetHeight)); 
			
					//pushing out by gap
					if(col > 0) 
						item.moveTo.x += gap * col;
					
					if(row > 0) 
						item.moveTo.y += gap * row;
	
					effectItems.push(item);
	
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
						var orphan:MDIGroupEffectItem = effectItems[j];
						
						orphan.widthTo = orphanWidth;
						//orphan.window.width = orphanWidth;
						
						orphan.moveTo.x = (j - (numWindows - numOrphans)) * orphanWidth;
						if(orphanCount > 0) 
							orphan.moveTo.x += gap * orphanCount;
						orphanCount++;
					}
				} 
				
				this.effects.getTileEffect(effectItems,this).play();
			}
		}
		
		// set a min. width/height
		public function resize(window:MDIWindow):void
		{	
		
			var w:int = this.container.width * .6;
			var h:int = this.container.height * .6
			if(w > window.width)
				window.width = w;
			if(h > window.height)
				window.height=h;
		}
		
		
		
		/**
		 *  Cascades all managed windows from top left to bottom right 
		 * 
		 *  @param window:MDIWindow Window to maximize
		 */	
		public function cascade():void
		{

			var effectItems:Array = [];
			
			var windows:Array = getOpenWindowList();
			
			for(var i:int=0; i < windows.length; i++)
			{
				var window:MDIWindow = windows[i] as MDIWindow;
				
				bringToFront(window);
					
				var item:MDIGroupEffectItem = new MDIGroupEffectItem(window);
		
					item.moveTo =  new Point(i * 40,  i * 40);
					item.heightFrom = window.height;
					item.heightTo = window.height;
					item.widthFrom = window.width;
					item.widthTo = window.width;
					
				effectItems.push(item);
			}
			
			this.effects.getCascadeEffect(effectItems, this).play();
		}
		
		
		public function showAllWindows():void
		{
			for(var i:int = 0; i < tiledWindows.length; i++)
			{
				var currentWindow:MDIWindow = tiledWindows.getItemAt(i) as MDIWindow;
				currentWindow.unMinimize();
				tiledWindows.removeItemAt(i);
				i--;
			}
		}
		
			
	}
}