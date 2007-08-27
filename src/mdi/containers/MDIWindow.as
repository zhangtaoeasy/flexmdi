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


package mdi.containers
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import mdi.events.MDIWindowEvent;
	import mdi.managers.MDIManager;
	
	import mx.collections.ArrayCollection;
	import mx.containers.Panel;
	import mx.controls.Button;
	import mx.core.UIComponent;
	import mx.events.FlexEvent;
	import mx.managers.CursorManager;
	
	//--------------------------------------
	//  Events
	//--------------------------------------
	
	/**
	 *  Dispatched when the minimize button is clicked.
	 *
	 *  @eventType mdi.events.MDIWindowEvent.MINIMIZE
	 */
	[Event(name="mdiMinimize", type="mdi.events.MDIWindowEvent")]
	
	/**
	 *  If the window is minimized, this event is dispatched when the titleBar is clicked. 
	 * 	If the window is maxmimized, this event is dispatched upon clicking the restore button
	 *  or double clicking the titleBar.
	 *
	 *  @eventType mdi.events.MDIWindowEvent.RESTORE
	 */
	[Event(name="mdiRestore", type="mdi.events.MDIWindowEvent")]
	
	/**
	 *  Dispatched when the maximize button is clicked or when the window is in a
	 *  normal state (not minimized or maximized) and the titleBar is double clicked.
	 *
	 *  @eventType mdi.events.MDIWindowEvent.MAXIMIZE
	 */
	[Event(name="mdiMaximize", type="mdi.events.MDIWindowEvent")]
	
	/**
	 *  Dispatched when the minimize button is clicked.
	 *
	 *  @eventType mdi.events.MDIWindowEvent.CLOSE
	 */
	[Event(name="mdiClose", type="mdi.events.MDIWindowEvent")]
	
	public class MDIWindow extends Panel
	{
		private var _windowState:int;
		private var _prevWindowState:int;
		
		public var minimizeHeight:Number;
		public var collapseDuration:Number;
		public var controls:Array;
		private var controlsHolder:UIComponent;
		
		public var minimizeBtn:Button;
		public var maximizeRestoreBtn:Button;
		public var closeBtn:Button;
		
		public var preventedDefaultActions:ArrayCollection;
		
		// resize handles and default values
		private static var DEFAULT_EDGE_HANDLE_SIZE:Number = 4;
		private static var DEFAULT_CORNER_HANDLE_SIZE:Number = 10;
		private var currentResizeHandle:Button;
		
		private var resizeHandleTop:Button;
		private var resizeHandleRight:Button;
		private var resizeHandleBottom:Button;
		private var resizeHandleLeft:Button;
		
		private var resizeHandleTL:Button;
		private var resizeHandleTR:Button;
		private var resizeHandleBR:Button;
		private var resizeHandleBL:Button;
		
		
		public var dragStartPanelX:Number;
		public var dragStartPanelY:Number;
		public var dragStartPanelWidth:Number;
		public var dragStartPanelHeight:Number;
		
		private var dragStartMouseX:Number;
		private var dragStartMouseY:Number;
		private var dragAmountX:Number;
		private var dragAmountY:Number;
		private var dragMaxX:Number;
		private var dragMaxY:Number;
		
		[Embed(source="/mdi/assets/img/resizeCursorV.gif")]
		private var resizeCursorV:Class;
		[Embed(source="/mdi/assets/img/resizeCursorH.gif")]
		private var resizeCursorH:Class;
		[Embed(source="/mdi/assets/img/resizeCursorTLBR.gif")]
		private var resizeCursorTLBR:Class;
		[Embed(source="/mdi/assets/img/resizeCursorTRBL.gif")]
		private var resizeCursorTRBL:Class;
		
		public var windowManager:MDIManager;
		
		
		public function MDIWindow()
		{
			super();
			controls = new Array();
			preventedDefaultActions = new ArrayCollection();
			doubleClickEnabled = true;
			minWidth = 200;
			minHeight = 200;
			windowState = MDIWindowState.NORMAL;
			
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			// edges
			if(!resizeHandleTop)
			{
				resizeHandleTop = new Button();
				resizeHandleTop.x = MDIWindow.DEFAULT_CORNER_HANDLE_SIZE * .5;
				resizeHandleTop.y = -(MDIWindow.DEFAULT_EDGE_HANDLE_SIZE * .5);
				resizeHandleTop.height = MDIWindow.DEFAULT_EDGE_HANDLE_SIZE;
				resizeHandleTop.alpha = 0;
				resizeHandleTop.focusEnabled = false;
				rawChildren.addChild(resizeHandleTop);
			}
			
			if(!resizeHandleRight)
			{
				resizeHandleRight = new Button();
				resizeHandleRight.y = MDIWindow.DEFAULT_CORNER_HANDLE_SIZE * .5;
				resizeHandleRight.width = MDIWindow.DEFAULT_EDGE_HANDLE_SIZE;
				resizeHandleRight.alpha = 0;
				resizeHandleRight.focusEnabled = false;
				rawChildren.addChild(resizeHandleRight);
			}
			
			if(!resizeHandleBottom)
			{
				resizeHandleBottom = new Button();
				resizeHandleBottom.x = MDIWindow.DEFAULT_CORNER_HANDLE_SIZE * .5;
				resizeHandleBottom.height = MDIWindow.DEFAULT_EDGE_HANDLE_SIZE;
				resizeHandleBottom.alpha = 0;
				resizeHandleBottom.focusEnabled = false;
				rawChildren.addChild(resizeHandleBottom);
			}
			
			if(!resizeHandleLeft)
			{
				resizeHandleLeft = new Button();
				resizeHandleLeft.x = -(MDIWindow.DEFAULT_EDGE_HANDLE_SIZE * .5);
				resizeHandleLeft.y = MDIWindow.DEFAULT_CORNER_HANDLE_SIZE * .5;
				resizeHandleLeft.width = MDIWindow.DEFAULT_EDGE_HANDLE_SIZE;
				resizeHandleLeft.alpha = 0;
				resizeHandleLeft.focusEnabled = false;
				rawChildren.addChild(resizeHandleLeft);
			}
			
			// corners
			if(!resizeHandleTL)
			{
				resizeHandleTL = new Button();
				resizeHandleTL.x = resizeHandleTL.y = -(MDIWindow.DEFAULT_CORNER_HANDLE_SIZE * .3);
				resizeHandleTL.width = resizeHandleTL.height = MDIWindow.DEFAULT_CORNER_HANDLE_SIZE;
				resizeHandleTL.alpha = 0;
				resizeHandleTL.focusEnabled = false;
				rawChildren.addChild(resizeHandleTL);
			}
			
			if(!resizeHandleTR)
			{
				resizeHandleTR = new Button();
				resizeHandleTR.width = resizeHandleTR.height = MDIWindow.DEFAULT_CORNER_HANDLE_SIZE;
				resizeHandleTR.alpha = 0;
				resizeHandleTR.focusEnabled = false;
				rawChildren.addChild(resizeHandleTR);
			}
			
			if(!resizeHandleBR)
			{
				resizeHandleBR = new Button();
				resizeHandleBR.width = resizeHandleBR.height = MDIWindow.DEFAULT_CORNER_HANDLE_SIZE;
				resizeHandleBR.alpha = 0;
				resizeHandleBR.focusEnabled = false;
				rawChildren.addChild(resizeHandleBR);
			}
			
			if(!resizeHandleBL)
			{
				resizeHandleBL = new Button();
				resizeHandleBL.width = resizeHandleBL.height = MDIWindow.DEFAULT_CORNER_HANDLE_SIZE;
				resizeHandleBL.alpha = 0;
				resizeHandleBL.focusEnabled = false;
				rawChildren.addChild(resizeHandleBL);
			}
			
			// controls			
			if(controls.length == 0)
			{
				minimizeBtn = new Button();
				minimizeBtn.width = 10;
				minimizeBtn.height = 10;
				minimizeBtn.styleName ="minimizeBtn";
				controls.push(minimizeBtn);
				
				maximizeRestoreBtn = new Button();
				maximizeRestoreBtn.width = 10;
				maximizeRestoreBtn.height = 10;
				maximizeRestoreBtn.styleName ="increaseBtn";
				controls.push(maximizeRestoreBtn);
				
				closeBtn = new Button();
				closeBtn.width = 10;
				closeBtn.height = 10;
				closeBtn.styleName ="closeBtn";
				controls.push(closeBtn);				
			}
			
			controlsHolder = new UIComponent();
			rawChildren.addChild(controlsHolder);
			
			for(var i:int = 0; i < controls.length; i++)
			{
				var control:UIComponent = controls[i];
				
				control.x = this.width - ((controls.length - i) * 20);
				control.y = (titleBar.height - control.height) / 2;
				control.buttonMode = true;
				controlsHolder.addChild(control);
			}
			
			addListeners();
		}		
		
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			
			// edges
			resizeHandleTop.width = this.width - MDIWindow.DEFAULT_CORNER_HANDLE_SIZE;
			
			resizeHandleRight.x = this.width - MDIWindow.DEFAULT_EDGE_HANDLE_SIZE * .5;
			resizeHandleRight.height = this.height - MDIWindow.DEFAULT_CORNER_HANDLE_SIZE;
			
			resizeHandleBottom.y = this.height - MDIWindow.DEFAULT_EDGE_HANDLE_SIZE * .5;
			resizeHandleBottom.width = this.width - MDIWindow.DEFAULT_CORNER_HANDLE_SIZE;
			
			resizeHandleLeft.height = this.height - MDIWindow.DEFAULT_CORNER_HANDLE_SIZE;
			
			// corners			
			resizeHandleTR.x = this.width - MDIWindow.DEFAULT_CORNER_HANDLE_SIZE * .7;
			resizeHandleTR.y = -(MDIWindow.DEFAULT_CORNER_HANDLE_SIZE * .3);
			
			resizeHandleBR.x = this.width - MDIWindow.DEFAULT_CORNER_HANDLE_SIZE * .7;
			resizeHandleBR.y = this.height - MDIWindow.DEFAULT_CORNER_HANDLE_SIZE * .7;
			
			resizeHandleBL.x = -(MDIWindow.DEFAULT_CORNER_HANDLE_SIZE * .3);
			resizeHandleBL.y = this.height - MDIWindow.DEFAULT_CORNER_HANDLE_SIZE * .7;
			
			for(var i:int = 0; i < controlsHolder.numChildren; i++)
			{
				var control:UIComponent = controlsHolder.getChildAt(i) as UIComponent;
				
				control.x = this.width - ((controlsHolder.numChildren - i) * 20);
				control.y = (titleBar.height - control.height) / 2;
			}
		}
		
		
		private function addListeners():void
		{
			// rollover and rollout
			resizeHandleTop.addEventListener(MouseEvent.ROLL_OVER, onResizeButtonRollOver, false, 0, true);
			resizeHandleTop.addEventListener(MouseEvent.ROLL_OUT, onResizeButtonRollOut, false, 0, true);
			resizeHandleRight.addEventListener(MouseEvent.ROLL_OVER, onResizeButtonRollOver, false, 0, true);
			resizeHandleRight.addEventListener(MouseEvent.ROLL_OUT, onResizeButtonRollOut, false, 0, true);
			resizeHandleBottom.addEventListener(MouseEvent.ROLL_OVER, onResizeButtonRollOver, false, 0, true);
			resizeHandleBottom.addEventListener(MouseEvent.ROLL_OUT, onResizeButtonRollOut, false, 0, true);
			resizeHandleLeft.addEventListener(MouseEvent.ROLL_OVER, onResizeButtonRollOver, false, 0, true);
			resizeHandleLeft.addEventListener(MouseEvent.ROLL_OUT, onResizeButtonRollOut, false, 0, true);
			
			resizeHandleTL.addEventListener(MouseEvent.ROLL_OVER, onResizeButtonRollOver, false, 0, true);
			resizeHandleTL.addEventListener(MouseEvent.ROLL_OUT, onResizeButtonRollOut, false, 0, true);
			resizeHandleTR.addEventListener(MouseEvent.ROLL_OVER, onResizeButtonRollOver, false, 0, true);
			resizeHandleTR.addEventListener(MouseEvent.ROLL_OUT, onResizeButtonRollOut, false, 0, true);
			resizeHandleBR.addEventListener(MouseEvent.ROLL_OVER, onResizeButtonRollOver, false, 0, true);
			resizeHandleBR.addEventListener(MouseEvent.ROLL_OUT, onResizeButtonRollOut, false, 0, true);
			resizeHandleBL.addEventListener(MouseEvent.ROLL_OVER, onResizeButtonRollOver, false, 0, true);
			resizeHandleBL.addEventListener(MouseEvent.ROLL_OUT, onResizeButtonRollOut, false, 0, true);
			
			// dragging
			resizeHandleTop.addEventListener(MouseEvent.MOUSE_DOWN, onResizeButtonPress, false, 0, true);
			resizeHandleRight.addEventListener(MouseEvent.MOUSE_DOWN, onResizeButtonPress, false, 0, true);
			resizeHandleBottom.addEventListener(MouseEvent.MOUSE_DOWN, onResizeButtonPress, false, 0, true);
			resizeHandleLeft.addEventListener(MouseEvent.MOUSE_DOWN, onResizeButtonPress, false, 0, true);
			
			resizeHandleTL.addEventListener(MouseEvent.MOUSE_DOWN, onResizeButtonPress, false, 0, true);
			resizeHandleTR.addEventListener(MouseEvent.MOUSE_DOWN, onResizeButtonPress, false, 0, true);
			resizeHandleBR.addEventListener(MouseEvent.MOUSE_DOWN, onResizeButtonPress, false, 0, true);
			resizeHandleBL.addEventListener(MouseEvent.MOUSE_DOWN, onResizeButtonPress, false, 0, true);
			
			// clicking
			titleBar.addEventListener(MouseEvent.MOUSE_DOWN, onTitleBarPress, false, 0, true);
			titleBar.addEventListener(MouseEvent.MOUSE_UP, onTitleBarRelease, false, 0, true);
			titleBar.addEventListener(MouseEvent.DOUBLE_CLICK, onMaximizeRestoreBtnClick, false, 0, true);
			titleBar.addEventListener(MouseEvent.CLICK, onTitleBarClick, false, 0, true);
			
			
			if(minimizeBtn)
			{
				minimizeBtn.addEventListener(MouseEvent.CLICK, minimize, false, 0, true);
			}
			if(maximizeRestoreBtn)
			{
				maximizeRestoreBtn.addEventListener(MouseEvent.CLICK, onMaximizeRestoreBtnClick, false, 0, true);
			}
			if(closeBtn)
			{
				closeBtn.addEventListener(MouseEvent.CLICK, close, false, 0, true);
			}
			
			this.addEventListener(MouseEvent.MOUSE_DOWN, setMDIWindowFocus);
		}
		
		private function setMDIWindowFocus(event:Event):void
		{
			if(parent.getChildIndex(this) != parent.numChildren - 1)
			{
				dispatchEvent(new MDIWindowEvent(MDIWindowEvent.FOCUS_IN, this));
			}
			parent.setChildIndex(this, parent.numChildren - 1);
		}
		
		public function minimize(event:MouseEvent = null):void
		{
			if(windowState != MDIWindowState.MAXIMIZED)
				savePanel();
			_prevWindowState = windowState;
			//titleBar is protected property, so we have to keep setting minimizeHeight
			minimizeHeight = this.titleBar.height;
			dispatchEvent(new MDIWindowEvent(MDIWindowEvent.MINIMIZE, this));
			windowState = MDIWindowState.MINIMIZED;
			showControls = false;
		}
		
		private function onMaximizeRestoreBtnClick(event:MouseEvent):void
		{
			//titleBar is protected property, so we have to keep setting minimizeHeight
			minimizeHeight = this.titleBar.height;
			if(maximizeRestoreBtn.styleName == "increaseBtn")
			{
				savePanel();
				windowState = MDIWindowState.MAXIMIZED;
				maximizeRestoreBtn.styleName = "decreaseBtn";
				dispatchEvent(new MDIWindowEvent(MDIWindowEvent.MAXIMIZE, this));
			}
			else
			{
				maximizeRestoreBtn.styleName = "increaseBtn";
				windowState = MDIWindowState.NORMAL;
				dispatchEvent(new MDIWindowEvent(MDIWindowEvent.RESTORE, this));
			}
		}
		
		public function close(event:MouseEvent = null):void
		{
			dispatchEvent(new MDIWindowEvent(MDIWindowEvent.CLOSE, this));
		}
		
		private function savePanel():void
		{
			dragStartPanelX = this.x;
			dragStartPanelY = this.y;
			dragStartPanelWidth = this.width;
			dragStartPanelHeight = this.height;
		}
		
		public function addControl(uic:UIComponent, index:int = -1):void
		{
			uic.buttonMode = true;
			if(index > -1)
			{
				controlsHolder.addChildAt(uic, index);
			}
			else
			{
				controlsHolder.addChild(uic);
			}
			invalidateDisplayList();
		}
		
		/**
		 * Title bar dragging and collapsing
		 */
		private function onTitleBarPress(event:MouseEvent):void
		{
			this.startDrag(false, new Rectangle(0, 0, parent.width - this.width, parent.height - this.height - 5));
			systemManager.addEventListener(MouseEvent.MOUSE_UP, onTitleBarRelease);
		}
		
		private function onTitleBarRelease(event:Event):void
		{
			this.stopDrag();
			systemManager.removeEventListener(MouseEvent.MOUSE_UP, onTitleBarRelease);
		}
		
		private function onTitleBarClick(event:MouseEvent):void
		{
			if(minimized)
			{
				showControls = true;
				
				windowState = _prevWindowState;
				if(windowState == MDIWindowState.NORMAL)
				{
					dispatchEvent(new MDIWindowEvent(MDIWindowEvent.RESTORE, this));
				}
				else
				{
					dispatchEvent(new MDIWindowEvent(MDIWindowEvent.MAXIMIZE, this));
				}
			}
		}
		
		/**
		 * Mouse down on any resize handle
		 */
		private function onResizeButtonPress(event:MouseEvent):void
		{
			if(!minimized)
			{
				currentResizeHandle = event.target as Button;
				setCursor(currentResizeHandle);
				dragStartMouseX = parent.mouseX;
				dragStartMouseY = parent.mouseY;
				dragStartPanelX = this.x;
				dragStartPanelY = this.y;
				dragStartPanelWidth = this.width;
				dragStartPanelHeight = this.height;
				
				dragMaxX = dragStartPanelX + (dragStartPanelWidth - minWidth);
				dragMaxY = dragStartPanelY + (dragStartPanelHeight - minHeight);
				
				systemManager.addEventListener(Event.ENTER_FRAME, onResizeButtonDrag, false, 0, true);
				systemManager.addEventListener(MouseEvent.MOUSE_UP, onResizeButtonRelease, false, 0, true);
				systemManager.stage.addEventListener(Event.MOUSE_LEAVE, onMouseLeaveStage, false, 0, true);
				dispatchEvent(new MDIWindowEvent(MDIWindowEvent.RESIZE_START, this));
			}
		}
		
		/**
		 * Mouse move while mouse is down on a resize handle
		 */
		private function onResizeButtonDrag(event:Event):void
		{
			if(!minimized)
			{
				dragAmountX = parent.mouseX - dragStartMouseX;
				dragAmountY = parent.mouseY - dragStartMouseY;
				
				if(currentResizeHandle == resizeHandleTop && parent.mouseY > 0)
				{
					this.y = Math.min(this.parent.mouseY, dragMaxY);
					this.height = Math.max(dragStartPanelHeight - dragAmountY, minHeight);
				}
				else if(currentResizeHandle == resizeHandleRight && parent.mouseX < parent.width)
				{
					this.width = Math.max(this.mouseX, minWidth);
				}
				else if(currentResizeHandle == resizeHandleBottom && parent.mouseY < parent.height)
				{
					this.height = Math.max(parent.mouseY - this.y, minHeight);
				}
				else if(currentResizeHandle == resizeHandleLeft && parent.mouseX > 0)
				{
					this.x = Math.min(this.parent.mouseX, dragMaxX);
					this.width = Math.max(dragStartPanelWidth - dragAmountX, minWidth);
				}
				else if(currentResizeHandle == resizeHandleTL && parent.mouseX > 0 && parent.mouseY > 0)
				{
					this.x = Math.min(this.parent.mouseX, dragMaxX);
					this.y = Math.min(this.parent.mouseY, dragMaxY);
					this.width = Math.max(dragStartPanelWidth - dragAmountX, minWidth);
					this.height = Math.max(dragStartPanelHeight - dragAmountY, minHeight);				
				}
				else if(currentResizeHandle == resizeHandleTR && parent.mouseX < parent.width && parent.mouseY > 0)
				{
					this.y = Math.min(this.parent.mouseY, dragMaxY);
					this.width = Math.max(this.mouseX, minWidth);
					this.height = Math.max(dragStartPanelHeight - dragAmountY, minHeight);
				}
				else if(currentResizeHandle == resizeHandleBR && parent.mouseX < parent.width && parent.mouseY < parent.height)
				{
					this.width = Math.max(this.mouseX, minWidth);
					this.height = Math.max(this.mouseY, minHeight);
				}
				else if(currentResizeHandle == resizeHandleBL && parent.mouseX > 0 && parent.mouseY < parent.height)
				{
					this.x = Math.min(this.parent.mouseX, dragMaxX);
					this.width = Math.max(dragStartPanelWidth - dragAmountX, minWidth);
					this.height = Math.max(this.mouseY, minHeight);
				}
				dispatchEvent(new MDIWindowEvent(MDIWindowEvent.RESIZE, this));
			}
		}
		
		private function onResizeButtonRelease(event:MouseEvent = null):void
		{
			if(!minimized)
			{
				currentResizeHandle = null;
				systemManager.removeEventListener(Event.ENTER_FRAME, onResizeButtonDrag);
				systemManager.removeEventListener(MouseEvent.MOUSE_UP, onResizeButtonRelease);
				systemManager.stage.removeEventListener(Event.MOUSE_LEAVE, onMouseLeaveStage);
				CursorManager.removeCursor(CursorManager.currentCursorID);
				dispatchEvent(new MDIWindowEvent(MDIWindowEvent.RESIZE_END, this));
			}
		}
		
		private function onMouseLeaveStage(event:Event):void
		{
			onResizeButtonRelease();
		}
		
		private function setCursor(target:Button):void
		{
			var cursorClass:Class;
			
			if(target == resizeHandleTop || target == resizeHandleBottom)
			{
				cursorClass = resizeCursorV;
			}
			else if(target == resizeHandleRight || target == resizeHandleLeft)
			{
				cursorClass = resizeCursorH;
			}
			else if(target == resizeHandleTL || target == resizeHandleBR)
			{
				cursorClass = resizeCursorTLBR;
			}
			else if(target == resizeHandleTR || target == resizeHandleBL)
			{
				cursorClass = resizeCursorTRBL;
			}
			
			CursorManager.removeCursor(CursorManager.currentCursorID);
			CursorManager.setCursor(cursorClass, 2, -10, -10);
		}
		
		private function onResizeButtonRollOver(event:MouseEvent):void
		{
			if(!minimized && !event.buttonDown)
			{
				setCursor(event.target as Button);
			}
		}
		
		private function onResizeButtonRollOut(event:MouseEvent):void
		{
			if(!event.buttonDown)
			{
				CursorManager.removeCursor(CursorManager.currentCursorID);
			}
		}
		
		public function set collapsible(value:Boolean):void
		{
			doubleClickEnabled = value;
		}
		
		public function set showControls(value:Boolean):void
		{
			controlsHolder.visible = value;
		}
		
		public function get windowState():int
		{
			return _windowState;
		}
		
		public function set windowState(newState:int):void
		{
			_prevWindowState = _windowState;
			_windowState = newState;
		}
		
		public function get minimized():Boolean
		{
			return _windowState == MDIWindowState.MINIMIZED;
		}
	}
}