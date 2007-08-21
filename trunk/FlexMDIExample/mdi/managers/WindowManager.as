package mdi.managers
{	

	import flash.display.DisplayObject;
	
	import mdi.containers.MDIPanel;
	import mx.containers.Panel;
	
	import mx.controls.Alert;
	import mx.core.Application;
	import mx.core.IFlexDisplayObject;
	import mx.core.UIComponent;
	import mx.effects.WipeDown;
	import mx.managers.PopUpManager;
	import mx.utils.ArrayUtil;

	public class WindowManager
	{
		public static var windowList:Array = new Array();
		
		
		
		public static function add(window:*, parent:*=null, modal:Boolean = false, childList:String = null):void
		{	
			// track windows
			WindowManager.windowList.push(window);
			
			var win : IFlexDisplayObject = window as IFlexDisplayObject;
			
			// open window
			if(parent == null)
			{
				PopUpManager.addPopUp(win, Application.application as DisplayObject, modal, childList);
			}
			else
			{
				PopUpManager.addPopUp(win, parent, modal, childList);
			}
			
		
			
			// center popup if modal
			if (modal) { PopUpManager.centerPopUp(window); }
			else { WindowManager.position(window); }
		}
		public static function addCenter(window:*, parent:*=null, modal:Boolean = false, childList:String = null):void
		{
			
			add(window,parent,modal,childList);
			center(window);
		
		}
		public static function center(window:*):void
		{
			PopUpManager.centerPopUp(window);
		}
		
		public static function removeAll():void
		{
			for each(var win:IFlexDisplayObject in windowList)
			{
				remove(win);
			}
		}
		
		
		/**
		 * Pushes a window onto the managed window stack 
		 * 
		 *  @param win Window to push onto managed windows stack 
		 * */
		public static function pushWindowOnStack(win:*):void
		{	
			if(win != null)
				WindowManager.windowList.push(win);
		}
		
		/**
		 *  Removes a window instance from the managed window stack 
		 *  @param win:IFlexDisplayObject Window to remove 
		 */
		public static function remove(win:IFlexDisplayObject):void
		{
			var index:int = ArrayUtil.getItemIndex(win, windowList);
			WindowManager.windowList.splice(index, 1);
			PopUpManager.removePopUp(win);
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
		public static function absPos(window:IFlexDisplayObject,x:int,y:int):void
		{
			window.x = x;
			window.y = y;		
		}
		
		
		/**
		 *  Tiles the window across the screen
		 *  
		 *  <p>By default, windows will be tiled to all the same size and use only the space they can accomodate.
		 *  If you set fillSpace = true, tile will use all the space available to tile the windows with
		 *  the windows being arranged by varying heights and widths. 
     	 *  </p>
		 * 
		 *  @param fillSpace:Boolean Variable to determine whether to use the entire screen
		 *  to tile or  
		 */
		public static function tile(fillSpace:Boolean = false):void
		{
			var numWindows:int = windowList.length;
			var sqrt:int = Math.round(Math.sqrt(numWindows));
			var numCols:int = Math.ceil(numWindows / sqrt);
			var numRows:int = Math.ceil(numWindows / numCols);
			var col:int = 0;
			var row:int = 0;
			var availWidth:Number = Application.application.width;
			var availHeight:Number = Application.application.height;
			var targetWidth:Number = availWidth / numCols;
			var targetHeight:Number = availHeight / numRows;
			
			for(var i:int = 0; i < windowList.length; i++)
			{
				var win:Panel = windowList[i];
				win.width = targetWidth;
				win.height = targetHeight;
				
				if(i > 0)
				{
					var prevWin:Panel = windowList[i - 1];
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
				
				win.x = col * targetWidth;
				win.y = row * targetHeight;
			}
			
			if(col < numCols && fillSpace)
			{
				var numOrphans:int = numWindows % numCols;
				var orphanWidth:Number = availWidth / numOrphans;
				for(var j:int = numWindows - numOrphans; j < numWindows; j++)
				{
					var orphan:Panel = windowList[j];
					orphan.width = orphanWidth;
					orphan.x = (j - (numWindows - numOrphans)) * orphanWidth;
				}
			}
		}
		
		
		
		
		
		
		/**
		 *  Positions a window on the screen 
		 *  
		 * 	<p>This is primarly used as the default space on the screen to position the window.</p>
		 * 
		 *  @param window:IFlexDisplayObject Window to position
		 */
		public static function position(window:IFlexDisplayObject):void
		{	
			var win : IFlexDisplayObject = window as IFlexDisplayObject;
			var x:int =  WindowManager.windowList.length * 40;
			var y:int =  WindowManager.windowList.length * 40;
			
			if(WindowManager.windowList.length > 1)
			{
				var c:IFlexDisplayObject = IFlexDisplayObject(WindowManager.windowList[WindowManager.windowList.length -1]); 
				//x = c.x;
				//y = c.y;
			}

			win.x = x;
			win.y = y;

			// cycle back around
			if( (win.x + win.width) > Application.application.width ) win.x = 40;
			if( (win.y + win.height) > Application.application.height ) win.y = 40;
		}
		
		// set a min. width/height
		public static function resize(window:*):void
		{	
			var win : IFlexDisplayObject = window as IFlexDisplayObject;
			var w:int = Application.application.width * .6;
			var h:int = Application.application.height * .6
			if( w > win.width )
				win.width = w;
			if( h > win.height )
				win.height=h;
		}
		
		
		
		
		
		
		
		/**
		 *  Maximizes a window to use all available space
		 * 
		 *  @param window:IFlexDisplayObject Window to maximize
		 */
		public static function maximize(window:IFlexDisplayObject):void
		{					
			var win : IFlexDisplayObject = window as IFlexDisplayObject;
			win.x=10;
			win.y=40;
			win.width = Application.application.width - 20;
			win.height = Application.application.height - 60;
			
			//make sure window is on top.
			PopUpManager.bringToFront(win);	
		}
		
		
		
		
		
		
		/**
		 *  Cascades all managed windows from top left to bottom right 
		 * 
		 *  @param window:IFlexDisplayObject Window to maximize
		 */	
		public static function cascade():void
		{
			for(var i:int=0; i < WindowManager.windowList.length; i++)
			{
				var win : IFlexDisplayObject = WindowManager.windowList[i] as IFlexDisplayObject;
				PopUpManager.bringToFront(win);
				win.x = i * 40;
				win.y = i * 40;
			}
		}
		
		
	}
}