package mdi.managers
{	

	import flash.display.DisplayObject;
	
	import mdi.containers.MDIPanel;
	
	import mx.controls.Alert;
	import mx.core.Application;
	import mx.core.IFlexDisplayObject;
	import mx.core.UIComponent;
	import mx.effects.WipeDown;
	import mx.managers.PopUpManager;
	import mx.utils.ArrayUtil;

	public class WindowManager extends PopUpManager 
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
		
		public static function remove(win:IFlexDisplayObject):void
		{
			var index:int = ArrayUtil.getItemIndex(win, windowList);
			WindowManager.windowList.splice(index, 1);
			PopUpManager.removePopUp(win);
		}
		public static function absPos(window:*,x:int,y:int):void
		{
			var win : IFlexDisplayObject = window as IFlexDisplayObject;
			win.x = x;
			win.y = y;
			
		}
		public static function absRightPos(window:*,x:int,y:int):void
		{
			var win : IFlexDisplayObject = window as IFlexDisplayObject;
			win.x = x - win.width;
			win.y = y;
			
		}
		
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
				var win:MDIPanel = windowList[i];
				win.width = targetWidth;
				win.height = targetHeight;
				
				if(i > 0)
				{
					var prevWin:MDIPanel = windowList[i - 1];
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
					var orphan:MDIPanel = windowList[j];
					orphan.width = orphanWidth;
					orphan.x = (j - (numWindows - numOrphans)) * orphanWidth;
				}
			}
		}
		
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
		
		public static function maximize(window:IFlexDisplayObject):void
		{					
			var win : IFlexDisplayObject = window as IFlexDisplayObject;
			win.x=10;
			win.y=40;
			win.width = Application.application.width - 20;
			win.height = Application.application.height - 60;	
		}
		
		
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