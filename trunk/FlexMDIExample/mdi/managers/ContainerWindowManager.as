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

	public class ContainerWindowManager
	{
		public var windowList:Array = new Array();
		public var windowParent:UIComponent;
		
		
		public function add(window:*):void
		{	
			// track windows
			this.windowList.push(window);
			
			var win : IFlexDisplayObject = window as IFlexDisplayObject;
			
			// open window
			windowParent.addChild(window);
			/*
			if(parent == null)
			{
				parent.addChild(window);
				//PopUpManager.addPopUp(win, Application.application as DisplayObject);
			}
			else
			{
				PopUpManager.addPopUp(win, parent);
			}
			*/
		
			
			// center popup if modal
			this.position(window);
		}
		
		public function addCenter(window:*, parent:UIComponent):void
		{
			
			var newWindow:* = parent.addChild(window);
			center(newWindow);
		
		}
		
		public function center(window:*):void
		{
			window.x = windowParent.width / 2 - window.width;
			window.y = windowParent.height / 2 - window.height;
		}
		
		public function removeAll():void
		{
			for each(var win:IFlexDisplayObject in windowList)
			{
				remove(win);
			}
		}
		
		public function remove(win:IFlexDisplayObject):void
		{
			var index:int = ArrayUtil.getItemIndex(win, windowList);
			this.windowList.splice(index, 1);
			windowParent.removeChild(DisplayObject(win));
		}
		
		public function absPos(window:*,x:int,y:int):void
		{
			var win : IFlexDisplayObject = window as IFlexDisplayObject;
			win.x = x;
			win.y = y;
			
		}
		
		public function absRightPos(window:*,x:int,y:int):void
		{
			var win : IFlexDisplayObject = window as IFlexDisplayObject;
			win.x = x - win.width;
			win.y = y;
			
		}
		
		public function tile(fillSpace:Boolean = false, gap:int = 0):void
		{
			var numWindows:int = windowList.length;
			var sqrt:int = Math.floor(Math.sqrt(numWindows));
			var numCols:int = Math.ceil(numWindows / sqrt);
			var numRows:int = Math.ceil(numWindows / numCols);
			var col:int = 0;
			var row:int = 0;
			var availWidth:Number = windowParent.width;
			var availHeight:Number = windowParent.height - 5;
			var targetWidth:Number = availWidth / numCols - ((gap * (numCols - 1)) / numCols);
			var targetHeight:Number = availHeight / numRows - ((gap * (numRows - 1)) / numRows);
			
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
				if(col > 0) 
					win.x += gap * col;
				if(row > 0) 
					win.y += gap * row;
			}
			
			if(col < numCols && fillSpace)
			{
				var numOrphans:int = numWindows % numCols;
				var orphanWidth:Number = availWidth / numOrphans - ((gap * (numOrphans - 1)) / numOrphans);
				var orphanCount:int = 0
				for(var j:int = numWindows - numOrphans; j < numWindows; j++)
				{
					var orphan:Panel = windowList[j];
					orphan.width = orphanWidth;
					orphan.x = (j - (numWindows - numOrphans)) * orphanWidth;
					if(orphanCount > 0) 
						orphan.x += gap * orphanCount;
					orphanCount++;
				}
			}
		}
		
		public function position(window:IFlexDisplayObject):void
		{	
			var win : IFlexDisplayObject = window as IFlexDisplayObject;
			var x:int =  this.windowList.length * 40;
			var y:int =  this.windowList.length * 40;
			
			if(this.windowList.length > 1)
			{
				var c:IFlexDisplayObject = IFlexDisplayObject(this.windowList[this.windowList.length -1]); 
				//x = c.x;
				//y = c.y;
			}

			win.x = x;
			win.y = y;

			// cycle back around
			if( (win.x + win.width) > windowParent.width ) win.x = 40;
			if( (win.y + win.height) > windowParent.height ) win.y = 40;
		}
		
		// set a min. width/height
		public function resize(window:*):void
		{	
			var win : IFlexDisplayObject = window as IFlexDisplayObject;
			var w:int = windowParent.width * .6;
			var h:int = windowParent.height * .6
			if( w > win.width )
				win.width = w;
			if( h > win.height )
				win.height=h;
		}
		
		public function maximize(window:IFlexDisplayObject):void
		{	
			var win : IFlexDisplayObject = window as IFlexDisplayObject;
			win.x=10;
			win.y=40;
			win.width = windowParent.width - 20;
			win.height = windowParent.height - 60;	
		}
		
		
		public function cascade():void
		{
			for(var i:int=0; i < this.windowList.length; i++)
			{
				var win : DisplayObject = this.windowList[i] as DisplayObject;
				windowParent.setChildIndex(win, windowParent.numChildren - 1);
				win.x = i * 40;
				win.y = i * 40;
			}
		}
		
		
	}
}