package mdi.containers
{
	import mx.containers.Panel;
	import mx.managers.CursorManager;
	import mx.managers.ISystemManager;
	import mx.controls.Alert;
	import mx.logging.Log;
	import mx.utils.ObjectUtil;
	import mx.controls.Button;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.system.System;
	import flash.geom.Rectangle;
	
	
	import mx.controls.Button;
	import mx.core.Application;
	import mx.core.EdgeMetrics;
	import mx.core.UIComponent;
	import mx.effects.Resize;
	import mx.events.DragEvent;
	import mx.events.EffectEvent;
	import mx.managers.CursorManager;
	import mdi.managers.WindowManager;
	
	
	/**
	 *  The close button disabled skin.
	 *
	 *  @default CloseButtonDisabled
	 */
	[Style(name="closeBtn", type="Class", inherit="no")]
	
	public class Window extends Panel
	{
		
		protected static const HEADER_PADDING:Number = 14;
			
		private const dragThreshold:int = 2;
			// sanity constraints.  
		private const minSizeWidth:int = 180;  
		private const minSizeHeight:int = 220;
			
		public const cursorSizeNone:int = -1;
		public const cursorSizeNE:int   = 0;
		public const cursorSizeN:int    = 1;
		public const cursorSizeNW:int   = 2;
		public const cursorSizeW:int    = 3;
		public const cursorSizeSW:int   = 4;
		public const cursorSizeS:int    = 5;
		public const cursorSizeSE:int   = 6;
		public const cursorSizeE:int    = 7;
		public const cursorSizeAll:int  = 8;
		
		
		[Embed(source="/mdi/assets/img/resizeCursorV.gif")]
		public static var sizeNSCursorSymbol:Class;

		[Embed(source="/mdi/assets/img/resizeCursorTRBL.gif")]
		public static var sizeNESWCursorSymbol:Class;
			
		[Embed(source="/mdi/assets/img/resizeCursorH.gif")]
		public static var sizeWECursorSymbol:Class;

		[Embed(source="/mdi/assets/img/resizeCursorTLBR.gif")]
		public static var sizeNWSECursorSymbol:Class;
									
		[Embed(source="/mdi/assets/img/resizeCursorVH.gif")]
		public static var sizeAllCursorSymbol:Class;
		
		
		[Embed(source="/mdi/assets/img/closeButton.png")]
		public static var closeBtn:Class;
		
		private var downX:int;
		private var downY:int;
		private var startLeft:int;
		private var startTop:int;
		private var startHeight:int;
		private var startWidth:int;
			
		private var resizeCursor:int;
		private var currentCursorID:int;
		private var prevCursor:int;
		private var isResizing:Boolean;
	
	
		private var upMotion:Resize	= new Resize();
		private var downMotion:Resize = new Resize();
		
		private var closeButton:Button = new Button();
		private var minimizeButton:Button = new Button();
		private var maximizeButton:Button = new Button();
		
		public var onClickMinimize : Function;
		
		
		private var oW:Number;
		private var oH:Number;
		private var oX:Number;
		private var oY:Number;
		
		public function Window():void
		{
			super();
			isResizing = false;
			currentCursorID = CursorManager.NO_CURSOR;
			prevCursor = cursorSizeNone;
			
			this.setStyle("closeBtn",closeBtn);	
		}
		
		override protected function createChildren():void
		{
			super.createChildren();

			// make the cursor change to the resize cursor
			this.titleBar.addEventListener(MouseEvent.MOUSE_MOVE, titleBar_resizeMoveListener);
			
			this.addEventListener(MouseEvent.MOUSE_MOVE, resizeMoveListener);
				
			this.addEventListener(MouseEvent.MOUSE_OUT, cursorMouseOutListener);
				
			// since the titlebar mousedown listener calls startDragging, but the listener is private
			// we will do our checking in the overridden startDragging event for the titlebar
			this.addEventListener(MouseEvent.MOUSE_DOWN, resizeDownListener);
			
			
			super.titleBar.addEventListener(MouseEvent.MOUSE_DOWN, titleBarDownHandler);
			super.titleBar.addEventListener(MouseEvent.DOUBLE_CLICK, titleBarDoubleClickHandler);

			this.doubleClickEnabled = true;
			
			this.minimizeButton.width     	= 10;
			this.minimizeButton.height    	= 10;
			this.minimizeButton.styleName 	= "minimizeBtn";
	
			this.maximizeButton.width     	= 10;
			this.maximizeButton.height    	= 10;
			this.maximizeButton.styleName 	= "increaseBtn";
			
			this.closeButton.width     		= 10;
			this.closeButton.height    		= 10;
			//this.closeButton.styleName 		= "closeBtn";
	
			super.titleBar.addChild(this.minimizeButton);
			super.titleBar.addChild(this.maximizeButton);
			super.titleBar.addChild(this.closeButton);
			
			
			this.closeButton.addEventListener(MouseEvent.CLICK, closeClickHandler);
			this.maximizeButton.addEventListener(MouseEvent.CLICK, normalMaxClickHandler);
			this.minimizeButton.addEventListener(MouseEvent.CLICK, minimizeClickHandler);
			
			this.positionChildren();
			
		}
		public function positionChildren():void 
		{
				
			this.minimizeButton.buttonMode = true;
			this.minimizeButton.useHandCursor = true;
			this.minimizeButton.x = this.unscaledWidth - this.minimizeButton.width - 42;
			this.minimizeButton.y = 8;
				
				
			this.maximizeButton.buttonMode    = true;
			this.maximizeButton.useHandCursor = true;
			this.maximizeButton.x = this.unscaledWidth - this.maximizeButton.width - 24;
			this.maximizeButton.y = 8;
				
			this.closeButton.buttonMode	   = true;
			this.closeButton.useHandCursor = true;
			this.closeButton.x = this.unscaledWidth - this.closeButton.width - 8;
			this.closeButton.y = 8;
			
		}
		
		public function initPos():void 
		{
			this.oW = this.width;
			this.oH = this.height;
			this.oX = this.x;
			this.oY = this.y;
		}
			
			
			
			
		public function normalMaxClickHandler(event:MouseEvent):void 
		{
			if (this.maximizeButton.styleName == "increaseBtn") 
			{
				if (this.height > 28) 
				{
					this.initPos();
					this.x = 0;
					this.y = 0;
					this.width = screen.width;
					this.height = screen.height;
					this.maximizeButton.styleName = "decreaseBtn";
					this.positionChildren();
				}
			} else 
			{
				this.x = this.oX;
				this.y = this.oY;
				this.width = this.oW;
				this.height = this.oH;
				this.maximizeButton.styleName = "increaseBtn";
				this.positionChildren();
			}
		}
		
		
		
		
		
		private function minimizeClickHandler(event:MouseEvent):void
		{
			if ( this.onClickMinimize != null)
			{
				this.onClickMinimize(this);
			}
		}
		
		
		
		
		
		public function titleBarDownHandler(event:MouseEvent):void 
		{
			super.titleBar.addEventListener(MouseEvent.MOUSE_MOVE, titleBarMoveHandler);
		}
			
			
			
			
			
		public function titleBarMoveHandler(event:MouseEvent):void 
		{
			if (this.width < screen.width) 
			{
				Application.application.parent.addEventListener(MouseEvent.MOUSE_UP, titleBarDragDropHandler);

				super.titleBar.addEventListener(DragEvent.DRAG_DROP,titleBarDragDropHandler);
				
				this.parent.setChildIndex(this, this.parent.numChildren - 1);
				
				this.startDrag(false, new Rectangle(0, 0, screen.width - this.width, screen.height - this.height));
			}
		}
		
		public function titleBarDragDropHandler(event:MouseEvent):void 
		{
			/*  remove mouse move event listener */
			super.titleBar.removeEventListener(MouseEvent.MOUSE_MOVE, titleBarMoveHandler);
			
			/* declare stop drag */
			this.stopDrag();
		}	
			
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			closeButton.x = this.width - 15;
			maximizeButton.x = this.width - 35;
			minimizeButton.x = this.width - 55;
		}
		
		public function closeClickHandler(event:MouseEvent):void 
		{
			this.close();
		}
		
		public function close():void
		{
			this.removeEventListener(MouseEvent.CLICK, panelClickHandler);
			WindowManager.remove(this);
			
		}
		
		public function panelClickHandler(event:MouseEvent):void 
		{
			super.titleBar.removeEventListener(MouseEvent.MOUSE_MOVE, titleBarMoveHandler);
			this.parent.setChildIndex(this, this.parent.numChildren - 1);
		}	
		
		
		
		
		public function resizeUpHandler(event:MouseEvent):void 
		{
			Application.application.parent.removeEventListener(MouseEvent.MOUSE_MOVE, resizeMoveHandler);
			Application.application.parent.removeEventListener(MouseEvent.MOUSE_UP, resizeUpHandler);
			CursorManager.removeCursor(CursorManager.currentCursorID);

			this.initPos();
		}
		
		public function resizeMoveHandler(event:MouseEvent):void 
		{
			this.width = this.mouseX;
			this.height = this.mouseY;
			this.positionChildren();
		}
		
		public function titleBarDoubleClickHandler(event:MouseEvent):void 
		{
			super.titleBar.removeEventListener(MouseEvent.MOUSE_MOVE, titleBarMoveHandler);
			Application.application.parent.removeEventListener(MouseEvent.MOUSE_UP, resizeUpHandler);
			
			this.upMotion.target = this;
			this.upMotion.duration = 300;
			this.upMotion.heightFrom = oH;
			this.upMotion.heightTo = 28;
			this.upMotion.end();
			
			this.downMotion.target = this;
			this.downMotion.duration = 300;
			this.downMotion.heightFrom = 28;
			this.downMotion.heightTo = oH;
			this.downMotion.end();
			
			if (this.width < screen.width) 
			{
				if (this.height == oH) {
					this.upMotion.play();
					//this.resizeButton.visible = false;
				}
				else 
				{
					this.downMotion.play();
					this.downMotion.addEventListener(EffectEvent.EFFECT_END, endEffectEventHandler);
				}
			}
		}
		
		protected function getCursorStyle(x:int, y:int, isTitleBar:Boolean):int
		{
				if (isResizing)
					return resizeCursor;
				
				// the NW corner has to be done in a seperate section because this 
				// corner is twitchy and we add a 1 pix buffer
				if (x >= 0 && x <= dragThreshold + 1 && y >= 0 && y <= dragThreshold + 1)
				{
					return cursorSizeNW;
				} else if (x >= 0 && x <= dragThreshold)
				{
					if (y >= this.height - dragThreshold)
					{
						return cursorSizeSW;
					} else {
						return cursorSizeW;
					}
				} else if (x >= this.width - dragThreshold)
				{
					if (y >= 0 && y <= dragThreshold)
					{
						return cursorSizeNE;
					} else if (y >= this.height - dragThreshold)
					{
						return cursorSizeSE;
					} else {
						return cursorSizeE;
					}					
				} 
				else if (y >= 0 && y <= dragThreshold)
				{
					return cursorSizeN;
				} 
				else if (y >= this.height - dragThreshold)
				{
					return cursorSizeS;			
				} 
				//else if (isTitleBar)
				//{
				//	return cursorSizeAll;
				//}
				return cursorSizeNone;
			}
			
			protected function clearCursor():void
			{
				if (currentCursorID != CursorManager.NO_CURSOR)
				{
					CursorManager.removeCursor(currentCursorID);
					currentCursorID = CursorManager.NO_CURSOR;
				}
				prevCursor = cursorSizeNone;				
			}
			
			/**
			 *  @protected
			 *  Returns the height of the header.
			 */
			override protected function getHeaderHeight():Number
			{
				var headerHeight:Number = getStyle("headerHeight");
				
				if (isNaN(headerHeight))
					headerHeight = measureHeaderText().height + Window.HEADER_PADDING;
				
				return headerHeight;
			}
			
			/**
			 *  @protected. Returns a Rectangle containing the largest piece of header
			 *  text (can be either the title or status, whichever is bigger).
			 */
			protected function measureHeaderText():Rectangle
			{
				var textWidth:Number = 20;
				var textHeight:Number = 14;
				
				if (titleTextField && titleTextField.text)
				{
					titleTextField.validateNow();
					textWidth = titleTextField.textWidth;
					textHeight = titleTextField.textHeight;
				}
				
				if (statusTextField)
				{
					statusTextField.validateNow();
					textWidth = Math.max(textWidth, statusTextField.textWidth);
					textHeight = Math.max(textHeight, statusTextField.textHeight);
				}
				
				return new Rectangle(0, 0, textWidth, textHeight);
			}
									
			protected function adjustCursor(event:MouseEvent, isTitleBar:Boolean):void
			{
				var c:int;
				
				// we only want the move event from the title bar itself, not from it's children
				// otherwise you get weird cursor behavior in the middle of the titlebar
				if (isTitleBar && event.target != titleBar)
				{
					c = cursorSizeAll;
				} else {
					c = getCursorStyle(event.localX, event.localY, isTitleBar);
				}
				
				// don't switch stuff around if we don't have to
				if (c == prevCursor)
				{
					return;
				}
				
				prevCursor = c;
								
				clearCursor();
				
				switch (c) 
				{			
					///case cursorSizeAll:
					//	currentCursorID = CursorManager.setCursor(sizeAllCursorSymbol, 2, -10, -10);	
					//	break;
					case cursorSizeE:
					case cursorSizeW:
						currentCursorID = CursorManager.setCursor(sizeWECursorSymbol, 2, -10, -11);     
						break;
					case cursorSizeNW:
					case cursorSizeSE:
						currentCursorID = CursorManager.setCursor(sizeNWSECursorSymbol, 2, -11, -11);
						break;
					case cursorSizeNE:
					case cursorSizeSW:
						currentCursorID = CursorManager.setCursor(sizeNESWCursorSymbol, 2, -11, -10);
						break;
					case cursorSizeN:
					case cursorSizeS:
						currentCursorID = CursorManager.setCursor(sizeNSCursorSymbol, 2, -10, -10);
						break;
				}
			}
						
			protected function titleBar_resizeMoveListener(event:MouseEvent):void
			{
				if (event.target is Button)
				{
					//the base class doesn't give me access to "closeButton", so this
					//is the only way to check if we are over the button
					clearCursor();
					return;
				}

				adjustCursor(event, true);
			}
			
			
			public function endEffectEventHandler(event:EffectEvent):void 
			{
				//this.resizeButton.visible = true;
			}
			
			protected function resizeMoveListener(event:MouseEvent):void
			{
				//don't do it twice, the title bar takes care of it, and don't do it if we aren't the the TitleWindow
				if (event.localY > getHeaderHeight() && event.target is Window)  
				{
					
					adjustCursor(event, false);
				}
			}
			
			override protected function startDragging(event:MouseEvent):void
			{
				// check for the threshholds first,  
				// if we are within the threshold do our stuff, else call super 
				var cursorStyle:int = getCursorStyle(event.localX, event.localY, true);
				if (cursorStyle != cursorSizeNone && cursorStyle != cursorSizeAll )
				{
					startSizing(cursorStyle, event.stageX, event.stageY);
				} else {
					super.startDragging(event);
				}
			}
			
			protected function resizeDownListener(event:MouseEvent):void
			{
				// check for the threshholds first, 
				// if we are within the threshold do our stuff, else call super 
				var cursorStyle:int = getCursorStyle(event.localX, event.localY, false);
				if (cursorStyle != cursorSizeNone && cursorStyle != cursorSizeAll)
				{
					startSizing(cursorStyle, event.stageX, event.stageY);
				} 				
			}
			
			protected function startSizing(cursor:int, x:int, y:int):void
			{
				downX = x;
				downY = y;
				startHeight = this.height;
				startWidth = this.width;
				startLeft = this.x;
				startTop = this.y;
				resizeCursor = cursor;
				isResizing = true;								
								
				systemManager.addEventListener(
					MouseEvent.MOUSE_MOVE, systemManager_resizeMouseMoveHandler, true);
		
				systemManager.addEventListener(
					MouseEvent.MOUSE_UP, systemManager_resizeMouseUpHandler, true);
		
				stage.addEventListener(
					Event.MOUSE_LEAVE, stage_resizeMouseLeaveHandler);
					
				this.dispatchEvent(new Event("startResize"));
			}			
	
			protected function stopSizing():void
			{
				isResizing = false;
				
				systemManager.removeEventListener(
					MouseEvent.MOUSE_MOVE, systemManager_resizeMouseMoveHandler, true);
		
				systemManager.removeEventListener(
					MouseEvent.MOUSE_UP, systemManager_resizeMouseUpHandler, true);
		
				stage.removeEventListener(
					Event.MOUSE_LEAVE, stage_resizeMouseLeaveHandler);

				clearCursor();
				
				this.dispatchEvent(new Event("stopResize"));
			}
			
			private function sizeWidth(event:MouseEvent):void
			{
				var tmp:int;
				tmp = startWidth + event.stageX - downX;
				if (tmp >= minSizeWidth)   
				{
					this.width = tmp;
				}				
			}

			private function sizeHeight(event:MouseEvent):void
			{
				var tmp:int;
				tmp = startHeight + event.stageY - downY;
				if (tmp >= minSizeHeight)   
				{
					this.height = tmp;
				}
			}
						
			private function sizeTop(event:MouseEvent):int
			{
				var tmp:int;
				var delta:int = downY - event.stageY; 
				tmp = startHeight + delta;
				if (tmp < minSizeHeight)   
				{					
					delta = minSizeHeight - startHeight;
					tmp = startHeight + delta;					
				}
				
				this.height = tmp;
				return delta;
//				return 0;
			}

			private function sizeLeft(event:MouseEvent):int
			{
				var tmp:int;
				var delta:int = downX - event.stageX;
				tmp = startWidth + delta;
				if (tmp < minSizeWidth)   
				{
					delta = minSizeWidth - startWidth;
					tmp = startWidth + delta;
				}
				
				this.width = tmp;
				return delta;
//				return 0;
			}

			/**
			 *  @private
			 */
			private function systemManager_resizeMouseMoveHandler(event:MouseEvent):void
			{
				var leftDelta:int=0;
				var topDelta:int=0;				
				switch (resizeCursor)
				{
					case cursorSizeE:
						sizeWidth(event);
						break;
					case cursorSizeSE:
						sizeWidth(event);
						sizeHeight(event);
						break;						
					case cursorSizeS:
						sizeHeight(event);
						break;
					case cursorSizeSW:
						leftDelta = sizeLeft(event);
						sizeHeight(event);
						break;
					case cursorSizeW:
						leftDelta = sizeLeft(event);
						break;
					case cursorSizeNW:
						topDelta = sizeTop(event);
						leftDelta = sizeLeft(event);
						break;
					case cursorSizeN:
						topDelta = sizeTop(event);
						break;
					case cursorSizeNE:
						topDelta = sizeTop(event);
						sizeWidth(event);
						break;
				}
				
				// when sizing, we only want to do the move once (multiple moves cause ugly refresh problems)
				// a move happens when dragging involves the left or top side				
				if (leftDelta != 0 || topDelta != 0)
				{
					move(startLeft - leftDelta, startTop - topDelta);
				}
			}
			     
			/**
			 *  @private
			 */
			private function systemManager_resizeMouseUpHandler(event:MouseEvent):void
			{
				stopSizing();
			}
		
			/**
			 *  @private
			 */
			private function stage_resizeMouseLeaveHandler(event:Event):void
			{
				stopSizing();
			}			
			
			private function cursorMouseOutListener(event:MouseEvent):void
			{
				if (!isResizing)
				{
					clearCursor();
				}
			}
		
	
		
	}
}