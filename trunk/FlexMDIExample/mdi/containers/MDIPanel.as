package mdi.containers
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import mx.containers.Panel;
	import mx.controls.Button;
	import mx.core.UIComponent;
	import mx.effects.Resize;
	import mx.events.EffectEvent;
	import mx.events.FlexEvent;
	import mx.managers.CursorManager;

	public class MDIPanel extends Panel
	{
		public var collapsed:Boolean = false;
		public var collapseDuration:Number;
		public var controls:Array;
		public var controlsHolder:UIComponent;
		
		private static var DEFAULT_EDGE_HANDLE_SIZE:Number = 4;
		private static var DEFAULT_CORNER_HANDLE_SIZE:Number = 10;
		private static var DEFAULT_COLLAPSE_DURATION:Number = 300;
		
		private var resizeHandleTop:Button;
		private var resizeHandleRight:Button;
		private var resizeHandleBottom:Button;
		private var resizeHandleLeft:Button;
		
		private var resizeHandleTL:Button;
		private var resizeHandleTR:Button;
		private var resizeHandleBR:Button;
		private var resizeHandleBL:Button;
		
		private var uncollapsedHeight:Number;
		private var collapseEffect:Resize;
		
		private var currentDragHandle:Button;
		private var dragStartMouseX:Number;
		private var dragStartMouseY:Number;
		private var dragStartPanelX:Number;
		private var dragStartPanelY:Number;
		private var dragStartPanelWidth:Number;
		private var dragStartPanelHeight:Number;
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
		
		public function MDIPanel()
		{
			super();
			controls = new Array();
			doubleClickEnabled = true;
			minWidth = 140;
			minHeight = 70;
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			// edges
			if(!resizeHandleTop)
			{
				resizeHandleTop = new Button();
				resizeHandleTop.x = MDIPanel.DEFAULT_CORNER_HANDLE_SIZE * .5;
				resizeHandleTop.y = -(MDIPanel.DEFAULT_EDGE_HANDLE_SIZE * .5);
				resizeHandleTop.height = MDIPanel.DEFAULT_EDGE_HANDLE_SIZE;
				resizeHandleTop.alpha = 0;
				rawChildren.addChild(resizeHandleTop);
			}
			
			if(!resizeHandleRight)
			{
				resizeHandleRight = new Button();
				resizeHandleRight.y = MDIPanel.DEFAULT_CORNER_HANDLE_SIZE * .5;
				resizeHandleRight.width = MDIPanel.DEFAULT_EDGE_HANDLE_SIZE;
				resizeHandleRight.alpha = 0;
				rawChildren.addChild(resizeHandleRight);
			}
			
			if(!resizeHandleBottom)
			{
				resizeHandleBottom = new Button();
				resizeHandleBottom.x = MDIPanel.DEFAULT_CORNER_HANDLE_SIZE * .5;
				resizeHandleBottom.height = MDIPanel.DEFAULT_EDGE_HANDLE_SIZE;
				resizeHandleBottom.alpha = 0;
				rawChildren.addChild(resizeHandleBottom);
			}
			
			if(!resizeHandleLeft)
			{
				resizeHandleLeft = new Button();
				resizeHandleLeft.x = -(MDIPanel.DEFAULT_EDGE_HANDLE_SIZE * .5);
				resizeHandleLeft.y = MDIPanel.DEFAULT_CORNER_HANDLE_SIZE * .5;
				resizeHandleLeft.width = MDIPanel.DEFAULT_EDGE_HANDLE_SIZE;
				resizeHandleLeft.alpha = 0;
				rawChildren.addChild(resizeHandleLeft);
			}
			
			// corners
			if(!resizeHandleTL)
			{
				resizeHandleTL = new Button();
				resizeHandleTL.x = resizeHandleTL.y = -(MDIPanel.DEFAULT_CORNER_HANDLE_SIZE * .3);
				resizeHandleTL.width = resizeHandleTL.height = MDIPanel.DEFAULT_CORNER_HANDLE_SIZE;
				resizeHandleTL.alpha = 0;
				rawChildren.addChild(resizeHandleTL);
			}
			
			if(!resizeHandleTR)
			{
				resizeHandleTR = new Button();
				resizeHandleTR.width = resizeHandleTR.height = MDIPanel.DEFAULT_CORNER_HANDLE_SIZE;
				resizeHandleTR.alpha = 0;
				rawChildren.addChild(resizeHandleTR);
			}
			
			if(!resizeHandleBR)
			{
				resizeHandleBR = new Button();
				resizeHandleBR.width = resizeHandleBR.height = MDIPanel.DEFAULT_CORNER_HANDLE_SIZE;
				resizeHandleBR.alpha = 0;
				rawChildren.addChild(resizeHandleBR);
			}
			
			if(!resizeHandleBL)
			{
				resizeHandleBL = new Button();
				resizeHandleBL.width = resizeHandleBL.height = MDIPanel.DEFAULT_CORNER_HANDLE_SIZE;
				resizeHandleBL.alpha = 0;
				rawChildren.addChild(resizeHandleBL);
			}
			
			// controls
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
			resizeHandleTop.width = this.width - MDIPanel.DEFAULT_CORNER_HANDLE_SIZE;
			
			resizeHandleRight.x = this.width - MDIPanel.DEFAULT_EDGE_HANDLE_SIZE * .5;
			resizeHandleRight.height = this.height - MDIPanel.DEFAULT_CORNER_HANDLE_SIZE;
			
			resizeHandleBottom.y = this.height - MDIPanel.DEFAULT_EDGE_HANDLE_SIZE * .5;
			resizeHandleBottom.width = this.width - MDIPanel.DEFAULT_CORNER_HANDLE_SIZE;
			
			resizeHandleLeft.height = this.height - MDIPanel.DEFAULT_CORNER_HANDLE_SIZE;
			
			// corners			
			resizeHandleTR.x = this.width - MDIPanel.DEFAULT_CORNER_HANDLE_SIZE * .7;
			resizeHandleTR.y = -(MDIPanel.DEFAULT_CORNER_HANDLE_SIZE * .3);
			
			resizeHandleBR.x = this.width - MDIPanel.DEFAULT_CORNER_HANDLE_SIZE * .7;
			resizeHandleBR.y = this.height - MDIPanel.DEFAULT_CORNER_HANDLE_SIZE * .7;
			
			resizeHandleBL.x = -(MDIPanel.DEFAULT_CORNER_HANDLE_SIZE * .3);
			resizeHandleBL.y = this.height - MDIPanel.DEFAULT_CORNER_HANDLE_SIZE * .7;
			
			for(var i:int = 0; i < controlsHolder.numChildren; i++)
			{
				var control:UIComponent = controlsHolder.getChildAt(i) as UIComponent;
				
				control.x = this.width - ((controlsHolder.numChildren - i) * 20);
				control.y = (titleBar.height - control.height) / 2;
			}
		}
		
		private function onCloseBtn(event:MouseEvent):void
		{
			parent.removeChild(this);
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
			titleBar.addEventListener(MouseEvent.DOUBLE_CLICK, onTitleBarDoubleClick, false, 0, true);
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
			this.startDrag(false, new Rectangle(parent.x, parent.y, parent.width, parent.height));
		}
		
		private function onTitleBarRelease(event:MouseEvent):void
		{
			this.stopDrag();
		}
		
		private function onTitleBarDoubleClick(event:MouseEvent):void
		{
			collapseEffect = new Resize(this);
			if(this.height > titleBar.height)
			{
				uncollapsedHeight = this.height;
				collapseEffect.heightTo = titleBar.height;
			}
			else
			{
				collapseEffect.heightTo = uncollapsedHeight;
			}
			collapseEffect.duration = (!isNaN(collapseDuration)) ? collapseDuration : DEFAULT_COLLAPSE_DURATION;
			collapseEffect.addEventListener(EffectEvent.EFFECT_END, onCollapseFinish);
			collapseEffect.play();
		}
		
		private function onCollapseFinish(e:EffectEvent):void
		{
			collapsed = this.height == titleBar.height;
			collapseEffect.removeEventListener(EffectEvent.EFFECT_END, onCollapseFinish);
		}
		
		/**
		 * Mouse down on any resize handle
		 */
		private function onResizeButtonPress(event:MouseEvent):void
		{
			if(!collapsed)
			{
				currentDragHandle = event.target as Button;
				setCursor(currentDragHandle);
				dragStartMouseX = stage.mouseX;
				dragStartMouseY = stage.mouseY;
				dragStartPanelX = this.x;
				dragStartPanelY = this.y;
				dragStartPanelWidth = this.width;
				dragStartPanelHeight = this.height;
				
				dragMaxX = dragStartPanelX + (dragStartPanelWidth - minWidth);
				dragMaxY = dragStartPanelY + (dragStartPanelHeight - minHeight);
				
				systemManager.addEventListener(Event.ENTER_FRAME, onResizeButtonDrag, false, 0, true);
				systemManager.addEventListener(MouseEvent.MOUSE_UP, onResizeButtonRelease, false, 0, true);
				systemManager.stage.addEventListener(Event.MOUSE_LEAVE, onMouseLeaveStage, false, 0, true);
			}
		}
		
		/**
		 * Mouse move while mouse is down on a resize handle
		 */
		private function onResizeButtonDrag(event:Event):void
		{
			if(!collapsed)
			{
				dragAmountX = stage.mouseX - dragStartMouseX;
				dragAmountY = stage.mouseY - dragStartMouseY;
				
				if(currentDragHandle == resizeHandleTop)
				{
					this.y = Math.min(this.parent.mouseY, dragMaxY);
					this.height = Math.max(dragStartPanelHeight - dragAmountY, minHeight);
				}
				else if(currentDragHandle == resizeHandleRight)
				{
					this.width = Math.max(this.mouseX, minWidth);
				}
				else if(currentDragHandle == resizeHandleBottom)
				{
					this.height = Math.max(this.mouseY, minHeight);
				}
				else if(currentDragHandle == resizeHandleLeft)
				{
					this.x = Math.min(this.parent.mouseX, dragMaxX);
					this.width = Math.max(dragStartPanelWidth - dragAmountX, minWidth);
				}
				else if(currentDragHandle == resizeHandleTL)
				{
					this.x = this.parent.mouseX;
					this.y = this.parent.mouseY;
					this.width = Math.max(dragStartPanelWidth - dragAmountX, minWidth);
					this.height = Math.max(dragStartPanelHeight - dragAmountY, minHeight);				
				}
				else if(currentDragHandle == resizeHandleTR)
				{
					this.y = this.parent.mouseY;
					this.width = Math.max(this.mouseX, minWidth);
					this.height = Math.max(dragStartPanelHeight - dragAmountY, minHeight);
				}
				else if(currentDragHandle == resizeHandleBR)
				{
					this.width = Math.max(this.mouseX, minWidth);
					this.height = Math.max(this.mouseY, minHeight);
				}
				else if(currentDragHandle == resizeHandleBL)
				{
					this.x = this.parent.mouseX;
					this.width = Math.max(dragStartPanelWidth - dragAmountX, minWidth);
					this.height = Math.max(this.mouseY, minHeight);
				}
			}
		}
		
		private function onResizeButtonRelease(event:MouseEvent = null):void
		{
			if(!collapsed)
			{
				currentDragHandle = null;
				systemManager.removeEventListener(Event.ENTER_FRAME, onResizeButtonDrag);
				systemManager.removeEventListener(MouseEvent.MOUSE_UP, onResizeButtonRelease);
				systemManager.stage.removeEventListener(Event.MOUSE_LEAVE, onMouseLeaveStage);
				CursorManager.removeCursor(CursorManager.currentCursorID);
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
			
			CursorManager.setCursor(cursorClass, 2, -10, -10);
		}
		
		private function onResizeButtonRollOver(event:MouseEvent):void
		{
			if(!collapsed)
			{
				setCursor(event.target as Button);
			}
		}
		
		private function onResizeButtonRollOut(event:MouseEvent):void
		{
			CursorManager.removeCursor(CursorManager.currentCursorID);
		}
		
		public function set collapsible(value:Boolean):void
		{
			doubleClickEnabled = value;
		}
	}
}