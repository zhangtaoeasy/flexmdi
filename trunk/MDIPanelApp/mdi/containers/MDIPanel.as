package mdi.containers
{
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import mx.containers.Panel;
	import mx.controls.Button;
	import mx.core.Application;
	import mx.core.EdgeMetrics;
	import mx.core.UIComponent;
	import mx.effects.Resize;
	import mx.events.DragEvent;
	import mx.events.EffectEvent;
	import mx.managers.CursorManager;
	
	import windows.managers.WindowManager;
	import mx.containers.ControlBar;
	
	
	[Event("startResize")]
	
	[Event("stopResize")]
	
	
	public class MDIPanel extends Panel
	{
		[Bindable] public var showControls:Boolean = true;
		[Bindable] public var enableResize:Boolean = true;
				
		//[Embed(source="/MDIPanelAssets.swf", symbol="resizeArrow")]
		[Embed(source="panelClasses/resizeCursor.png")]
		private static var resizeCursor:Class;
		
		private var	pTitleBar:UIComponent;
		private var oW:Number;
		private var oH:Number;
		private var oX:Number;
		private var oY:Number;
		private var maximizeButton:Button	= new Button();
					
		private var closeButton:Button		= new Button();
		//private var resizeButton:Button	= new Button();
		private var minimizeButton:Button = new Button();
		private var upMotion:Resize			= new Resize();
		private var downMotion:Resize		= new Resize();
		private var oPoint:Point 			= new Point();
		private var resizeCur:Number		= 0;
		
		private var rightEdgeButton:Button = new Button();
		
		public var OnClickMinimize : Function;
		
		
		
		
				
		public function MDIPanel()
		{
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			closeButton.x = this.width - 15;
			maximizeButton.x = this.width - 35;
			minimizeButton.x = this.width - 55;
		}

		override protected function createChildren():void 
		{
			super.createChildren();
			this.pTitleBar = super.titleBar;
			//this.setStyle("headerColors", [0xC3D1D9, 0xD2DCE2]);
			//this.setStyle("borderColor", 0xD2DCE2);
			this.doubleClickEnabled = true;
			
			if (enableResize) 
			{
				//this.resizeButton.width     = 12;
				//this.resizeButton.height    = 12;
				//this.resizeButton.styleName = "resizeHndlr";
				//this.rawChildren.addChild(resizeButton);
				this.initPos();
				
				
				//rawChildren.addChild(rightEdgeButton);
			}
			
			if (showControls) 
			{	
				this.minimizeButton.width     	= 10;
				this.minimizeButton.height    	= 10;
				this.minimizeButton.styleName 	= "minimizeBtn";
				this.minimizeButton.label = "-";
				
				this.maximizeButton.width     	= 10;
				this.maximizeButton.height    	= 10;
				this.maximizeButton.styleName 	= "increaseBtn";
				this.maximizeButton.label = "o";
				
				this.closeButton.width     		= 10;
				this.closeButton.height    		= 10;
				this.closeButton.styleName 		= "closeBtn";
				this.closeButton.label = "x";
				
				this.pTitleBar.addChild(this.minimizeButton);
				this.pTitleBar.addChild(this.maximizeButton);
				this.pTitleBar.addChild(this.closeButton);
			}
			
			this.positionChildren();	
			this.addListeners();
		}
		
		public function initPos():void 
		{
			this.oW = this.width;
			this.oH = this.height;
			this.oX = this.x;
			this.oY = this.y;
		}
	
		public function positionChildren():void 
		{
			if (showControls) 
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
			
			if (enableResize) 
			{
				//this.resizeButton.y = this.unscaledHeight - resizeButton.height - 1;
				//this.resizeButton.x = this.unscaledWidth - resizeButton.width - 1;
			}
		}
		
		private function MinimizeClickHandler(event:MouseEvent):void
		{
			if (OnClickMinimize != null)
			{
				OnClickMinimize(this);
			}
		}
		
		public function addListeners():void
		{
			this.addEventListener(MouseEvent.CLICK, panelClickHandler);
			this.pTitleBar.addEventListener(MouseEvent.MOUSE_DOWN, titleBarDownHandler);
			this.pTitleBar.addEventListener(MouseEvent.DOUBLE_CLICK, titleBarDoubleClickHandler);
			
			if (showControls) 
			{
				this.closeButton.addEventListener(MouseEvent.CLICK, closeClickHandler);
				this.maximizeButton.addEventListener(MouseEvent.CLICK, normalMaxClickHandler);
				this.minimizeButton.addEventListener(MouseEvent.CLICK, MinimizeClickHandler);
			}
			
			if (enableResize) 
			{
				//this.resizeButton.addEventListener(MouseEvent.MOUSE_OVER, resizeOverHandler);
				//this.resizeButton.addEventListener(MouseEvent.MOUSE_OUT, resizeOutHandler);
				//this.resizeButton.addEventListener(MouseEvent.MOUSE_DOWN, resizeDownHandler);
				
				//this.rightEdgeButton.addEventListener(MouseEvent.MOUSE_OVER, resizeOverHandler);
				//this.rightEdgeButton.addEventListener(MouseEvent.MOUSE_OUT, resizeOutHandler);
				//this.rightEdgeButton.addEventListener(MouseEvent.MOUSE_DOWN, resizeDownHandler);
			}
		}
		
		public function panelClickHandler(event:MouseEvent):void 
		{
			this.pTitleBar.removeEventListener(MouseEvent.MOUSE_MOVE, titleBarMoveHandler);
			this.parent.setChildIndex(this, this.parent.numChildren - 1);
			this.panelFocusCheckHandler();
		}
		
		public function titleBarDownHandler(event:MouseEvent):void {
			this.pTitleBar.addEventListener(MouseEvent.MOUSE_MOVE, titleBarMoveHandler);
		}
			
		public function titleBarMoveHandler(event:MouseEvent):void 
		{
			if (this.width < screen.width) {
				Application.application.parent.addEventListener(MouseEvent.MOUSE_UP, titleBarDragDropHandler);
				this.alpha = 0.5;
				
				this.pTitleBar.addEventListener(DragEvent.DRAG_DROP,titleBarDragDropHandler);
				this.parent.setChildIndex(this, this.parent.numChildren - 1);
				//this.panelFocusCheckHandler();
				
				this.startDrag(false, new Rectangle(0, 0, screen.width - this.width, screen.height - this.height));
			}
		}
		
		public function titleBarDragDropHandler(event:MouseEvent):void 
		{
			this.pTitleBar.removeEventListener(MouseEvent.MOUSE_MOVE, titleBarMoveHandler);
			this.alpha = 1.0;
			this.stopDrag();
		}
		
		public function panelFocusCheckHandler():void
		{	
			//this.setStyle("backgroundAlpha",1);
			/* for (var i:int = 0; i < this.parent.numChildren; i++) {
				var child:UIComponent = UIComponent(this.parent.getChildAt(i));
				if (this.parent.getChildIndex(child) < this.parent.numChildren - 1) 
				{
					//child.setStyle("headerColors", [0xC3D1D9, 0xD2DCE2]);
					//child.setStyle("borderColor", 0xD2DCE2);
				} 
				else if (this.parent.getChildIndex(child) == this.parent.numChildren - 1) 
				{
					//child.setStyle("headerColors", [0xC3D1D9, 0x5A788A]);
					//child.setStyle("borderColor", 0x5A788A);
				}
			} */
		}
		
		public function titleBarDoubleClickHandler(event:MouseEvent):void 
		{
			this.pTitleBar.removeEventListener(MouseEvent.MOUSE_MOVE, titleBarMoveHandler);
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
			} 
			else 
			{
				this.x = this.oX;
				this.y = this.oY;
				this.width = this.oW;
				this.height = this.oH;
				this.maximizeButton.styleName = "increaseBtn";
				this.positionChildren();
			}
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
		
		
		public function resizeOverHandler(event:MouseEvent):void 
		{
			this.resizeCur = CursorManager.setCursor(resizeCursor);
		}
		
		public function resizeOutHandler(event:MouseEvent):void 
		{
			CursorManager.removeCursor(CursorManager.currentCursorID);
		}
		
		public function resizeDownHandler(event:MouseEvent):void 
		{
			Application.application.parent.addEventListener(MouseEvent.MOUSE_MOVE, resizeMoveHandler);
			Application.application.parent.addEventListener(MouseEvent.MOUSE_UP, resizeUpHandler);
			
			this.panelClickHandler(event);
			
			this.resizeCur = CursorManager.setCursor(resizeCursor);
			
			this.oPoint.x = mouseX;
			
			this.oPoint.y = mouseY;
			
			this.oPoint = this.localToGlobal(oPoint);		
		}
		
		public function resizeMoveHandler(event:MouseEvent):void 
		{
			this.width = this.mouseX;
			this.height = this.mouseY;
			this.positionChildren();
		}
		
		public function resizeUpHandler(event:MouseEvent):void 
		{
			Application.application.parent.removeEventListener(MouseEvent.MOUSE_MOVE, resizeMoveHandler);
			
			Application.application.parent.removeEventListener(MouseEvent.MOUSE_UP, resizeUpHandler);
			
			CursorManager.removeCursor(CursorManager.currentCursorID);
			
			this.initPos();
		}
	}
	
}