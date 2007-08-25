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
		
		public var externallyHandledEvents:Array;
		
		public var showEffect : Effect;
		
		public var minimizeEffect:Effect;
		
		/**
     	*   Contstructor()
     	*/
		
		public function MDIManager(parent:UIComponent,showEffect:Effect=null):void
		{
			this.parent = parent;
			externallyHandledEvents = new Array();
		}
		
		
		
		private var _parent : UIComponent;
		public function get parent():UIComponent
		{
			return _parent;
		}
		public function set parent(value:UIComponent):void
		{
			this._parent = value;
		}
		
		
		
		
		
		/**
     	*  @private
     	*  the managed window stack
     	*/
		private var windowList:Array = new Array();

		public function add(window:MDIWindow):void
		{
			window.windowManager = this;
			
			this.addListeners(window);
			
			this.windowList.push(window);
			
			this.addContextMenu(window);

			 if(this.isGlobal)
			{
				PopUpManager.addPopUp( window,Application.application);
			}
			else
			{
				this.parent.addChild(window);
			} 
			
			this.bringToFront(window);
			
			this.position(window); 
			
			if(window.showEffect != null)
			{	
				window.showEffect.target = window;
				window.showEffect.play();
			}

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

			if( (window.x + window.width) > parent.width ) window.x = 40;
			if( (window.y + window.height) > parent.height ) window.y = 40; 	
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
			//implement move
		}
		private function windowResizeEventHandler(event:MDIWindowEvent):void
		{
			//implement resize
		}
		private function windowFocusEventHandler(event:MDIWindowEvent):void
		{
			// implement focus functionality
		}
		private function windowResizeStartEventHandler(event:MDIWindowEvent):void
		{
			// implement minimize functionality
		}
		private function windowResizeEndEventHandler(event:MDIWindowEvent):void
		{
			// implement minimize functionality
		}
		private function windowMinimizeHandler(event:MDIWindowEvent):void
		{
			if(externallyHandledEvents.indexOf(event.type) == -1)
			{
				var arr:Array = new Array(event.window, this, MDIManager.global);
				
				for(var i:int = 0; i < arr.length; i++)
				{
					if(arr[i].minimizeEffect != null)
					{
						arr[i].minimizeEffect.play([event.window]);
						return;
					}
				}	
				event.window.defaultMinimizeEffect.play();
			}
			else
			{
				dispatchEvent(event);
			}
		}
		
		
		private function windowRestoreEventHandler(event:MDIWindowEvent):void
		{
			// implement minimize functionality
		}
		private function windowMaximizeEventHandler(event:MDIWindowEvent):void
		{
			// implement minimize functionality
		}
		
		
		
		private function windowCloseEventHandler(event:MDIWindowEvent):void
		{
			/* if(this.windowList.indexOf( event.window) > -1)
			{
				this.remove(event.window);
			} */s
			
			if(externallyHandledEvents.indexOf(event.type) == -1 && !event.window.preventedDefaultActions.contains(event.type))
			{
				var arr:Array = new Array(event.window, this, MDIManager.global);
				
				for(var i:int = 0; i < arr.length; i++)
				{
					if(arr[i].defaultCloseEffect != null)
					{
						arr[i].defaultCloseEffect.play([event.window]);
						return;
					}
				}
				
				event.window.defaultCloseEffect.play();
			}
			else
			{
				dispatchEvent(event);
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
				this.parent.setChildIndex(window, this.parent.numChildren - 1);
			}
			
		}
		
		
		/**
		 * Positions a window in the center of the available screen. 
		 * 
		 *  @param window:MDIWindow to center
		 * */
		public function center(window:MDIWindow):void
		{
			window.x = this.parent.width / 2 - window.width;
			window.y = this.parent.height / 2 - window.height;
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
					parent.removeChild(window);
				}
				
				this.removeListeners(window);
			}
			
			this.windowList = new Array();
		}
		
		/**
		 *  Adds listeners 
		 *  @param window:MDIWindow  
		 */
		
		public function addListeners(window:MDIWindow):void
		{
						
			window.addEventListener(MDIWindowEvent.MOVE, this.windowMoveEventHandler );
			window.addEventListener(MDIWindowEvent.RESIZE, this.windowResizeEventHandler);
			window.addEventListener(MDIWindowEvent.FOCUS_IN, this.windowFocusEventHandler);
			window.addEventListener(MDIWindowEvent.MINIMIZE,this.windowMinimizeHandler);
			window.addEventListener(MDIWindowEvent.RESTORE,this.windowRestoreEventHandler);
			window.addEventListener(MDIWindowEvent.MAXIMIZE,this.windowMaximizeEventHandler);
			window.addEventListener(MDIWindowEvent.CLOSE,this.windowCloseEventHandler);
			window.addEventListener(MDIWindowEvent.RESIZE_END,this.windowResizeEndEventHandler);
			window.addEventListener(MDIWindowEvent.RESIZE_START,this.windowResizeStartEventHandler); 
		}
		/**
		 *  Removes listeners 
		 *  @param window:MDIWindow 
		 */
		
		public function removeListeners(window:MDIWindow):void
		{
			window.removeEventListener(MDIWindowEvent.MOVE, this.windowMoveEventHandler );
			window.removeEventListener(MDIWindowEvent.RESIZE, this.windowResizeEventHandler);
			window.removeEventListener(MDIWindowEvent.FOCUS_IN, this.windowFocusEventHandler);
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
				parent.removeChild(window);
			}
			
			this.removeListeners(window);
		}
		
		
				
		
		/**
		 * Pushes a window onto the managed window stack 
		 * 
		 *  @param win Window to push onto managed windows stack 
		 * */
		public function manage(window:MDIWindow):void
		{	
			if(win != null)
				windowList.push(window);
		}
		
		/**
		 *  Positions a window in an absolute position 
		 * 
		 *  @param win:IFlexDisplayObject Window to position
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
		public function tile(fillAvailableSpace:Boolean = false):void
		{
			
			
			var numWindows:int = this.windowList.length;
			var sqrt:int = Math.round(Math.sqrt(numWindows));
			var numCols:int = Math.ceil(numWindows / sqrt);
			var numRows:int = Math.ceil(numWindows / numCols);
			var col:int = 0;
			var row:int = 0;
			var availWidth:Number = this.parent.width;
			var availHeight:Number = this.parent.height;
			var targetWidth:Number = availWidth / numCols;
			var targetHeight:Number = availHeight / numRows;
			
						
			for(var i:int = 0; i < this.windowList.length; i++)
			{
				var win:MDIWindow = this.windowList[i];
				win.width = targetWidth;
				win.height = targetHeight;
				
				if(i > 0)
				{
					var prevWin:MDIWindow = this.windowList[i - 1];
				}				
				
				if(i % numCols == 0 && i > 0)
				{
					row++;
					col = 0;
				}
				else if(i > 0)
				{
					col++;
				}
				//positin window within parent
				win.x = this.parent.x + (col * targetWidth);
				win.y = this.parent.y + (row * targetHeight);
			}
			
			if(col < numCols && fillAvailableSpace)
			{
				var numOrphans:int = numWindows % numCols;
				var orphanWidth:Number = availWidth / numOrphans;
				for(var j:int = numWindows - numOrphans; j < numWindows; j++)
				{
					var orphan:MDIWindow = this.windowList[j];
					orphan.width = orphanWidth;
					orphan.x = this.parent.x + (j - (numWindows - numOrphans)) * orphanWidth;
				}
			}
		}
		
		
		
		
		
		
		
		
		// set a min. width/height
		public function resize(window:MDIWindow):void
		{	
		
			var w:int = this.parent.width * .6;
			var h:int = this.parent.height * .6
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
			window.width = this.parent.width - 20;
			window.height = this.parent.height - 60;
	
			this.bringToFront(window);
		}
		
		
		
		
		
		
		/**
		 *  Cascades all managed windows from top left to bottom right 
		 * 
		 *  @param window:MDIWindow Window to maximize
		 */	
		public function cascade():void
		{
			for(var i:int=0; i < this.windowList.length; i++)
			{
				var window : MDIWindow = this.windowList[i] as MDIWindow;
				
				this.bringToFront(window);
		
				window.x = this.parent.x + i * 40;
				window.y = this.parent.y + i * 40;
			}
		}
		
			
	}
}