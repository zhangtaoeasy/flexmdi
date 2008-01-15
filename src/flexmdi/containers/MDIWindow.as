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

package flexmdi.containers
{
	import flash.display.DisplayObject;
	import flash.events.ContextMenuEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	
	import flexmdi.controls.IMDIFocusAwareStyleClient;
	import flexmdi.controls.MDIMaximizeRestoreButton;
	import flexmdi.events.MDIWindowEvent;
	import flexmdi.managers.MDIManager;
	
	import mx.containers.Canvas;
	import mx.containers.Panel;
	import mx.controls.Button;
	import mx.core.Container;
	import mx.core.UIComponent;
	import mx.core.UITextField;
	import mx.core.mx_internal;
	import mx.managers.CursorManager;
	import mx.styles.CSSStyleDeclaration;
	import mx.styles.StyleManager;
	
	
	//--------------------------------------
	//  Events
	//--------------------------------------
	
	/**
	 *  Dispatched when the minimize button is clicked.
	 *
	 *  @eventType flexmdi.events.MDIWindowEvent.MINIMIZE
	 */
	[Event(name="minimize", type="flexmdi.events.MDIWindowEvent")]
	
	/**
	 *  If the window is minimized, this event is dispatched when the titleBar is clicked. 
	 * 	If the window is maxmimized, this event is dispatched upon clicking the restore button
	 *  or double clicking the titleBar.
	 *
	 *  @eventType flexmdi.events.MDIWindowEvent.RESTORE
	 */
	[Event(name="restore", type="flexmdi.events.MDIWindowEvent")]
	
	/**
	 *  Dispatched when the maximize button is clicked or when the window is in a
	 *  normal state (not minimized or maximized) and the titleBar is double clicked.
	 *
	 *  @eventType flexmdi.events.MDIWindowEvent.MAXIMIZE
	 */
	[Event(name="maximize", type="flexmdi.events.MDIWindowEvent")]
	
	/**
	 *  Dispatched when the close button is clicked.
	 *
	 *  @eventType flexmdi.events.MDIWindowEvent.CLOSE
	 */
	[Event(name="close", type="flexmdi.events.MDIWindowEvent")]
	
	/**
	 *  Dispatched when the window gains focus and is given topmost z-index of MDIManager's children.
	 *
	 *  @eventType flexmdi.events.MDIWindowEvent.FOCUS_START
	 */
	[Event(name="focusStart", type="flexmdi.events.MDIWindowEvent")]
	
	/**
	 *  Dispatched when the window loses focus and no longer has topmost z-index of MDIManager's children.
	 *
	 *  @eventType flexmdi.events.MDIWindowEvent.FOCUS_END
	 */
	[Event(name="focusEnd", type="flexmdi.events.MDIWindowEvent")]
	
	/**
	 *  Dispatched when the window starts being dragged.
	 *
	 *  @eventType flexmdi.events.MDIWindowEvent.DRAG_START
	 */
	[Event(name="dragStart", type="flexmdi.events.MDIWindowEvent")]
	
	/**
	 *  Dispatched while the window is being dragged.
	 *
	 *  @eventType flexmdi.events.MDIWindowEvent.DRAG
	 */
	[Event(name="drag", type="flexmdi.events.MDIWindowEvent")]
	
	/**
	 *  Dispatched when the window stops being dragged.
	 *
	 *  @eventType flexmdi.events.MDIWindowEvent.DRAG_END
	 */
	[Event(name="dragEnd", type="flexmdi.events.MDIWindowEvent")]
	
	/**
	 *  Dispatched when a resize handle is pressed.
	 *
	 *  @eventType flexmdi.events.MDIWindowEvent.RESIZE_START
	 */
	[Event(name="resizeStart", type="flexmdi.events.MDIWindowEvent")]
	
	/**
	 *  Dispatched while the mouse is down on a resize handle.
	 *
	 *  @eventType flexmdi.events.MDIWindowEvent.RESIZE
	 */
	[Event(name="resize", type="flexmdi.events.MDIWindowEvent")]
	
	/**
	 *  Dispatched when the mouse is released from a resize handle.
	 *
	 *  @eventType flexmdi.events.MDIWindowEvent.RESIZE_END
	 */
	[Event(name="resizeEnd", type="flexmdi.events.MDIWindowEvent")]
	
	
	//--------------------------------------
	//  Skins
	//--------------------------------------
	
	/**
	 *  Name of the class used as cursor when resizing the window horizontally.
	 */
	[Style(name="resizeCursorHorizontalSkin", type="Class", inherit="no")]
	
	/**
	 *  Distance to horizontally offset resizeCursorHorizontalSkin.
	 */
	[Style(name="resizeCursorHorizontalSkinXOffset", type="Number", inherit="no")]
	
	/**
	 *  Distance to vertically offset resizeCursorHorizontalSkin.
	 */
	[Style(name="resizeCursorHorizontalSkinYOffset", type="Number", inherit="no")]
	
	
	/**
	 *  Name of the class used as cursor when resizing the window vertically.
	 */
	[Style(name="resizeCursorVerticalSkin", type="Class", inherit="no")]
	
	/**
	 *  Distance to horizontally offset resizeCursorVerticalSkin.
	 */
	[Style(name="resizeCursorVerticalSkinXOffset", type="Number", inherit="no")]
	
	/**
	 *  Distance to vertically offset resizeCursorVerticalSkin.
	 */
	[Style(name="resizeCursorVerticalSkinYOffset", type="Number", inherit="no")]
	
	
	/**
	 *  Name of the class used as cursor when resizing from top left or bottom right corner.
	 */
	[Style(name="resizeCursorTopLeftBottomRightSkin", type="Class", inherit="no")]
	
	/**
	 *  Distance to horizontally offset resizeCursorTopLeftBottomRightSkin.
	 */
	[Style(name="resizeCursorTopLeftBottomRightSkinXOffset", type="Number", inherit="no")]
	
	/**
	 *  Distance to vertically offset resizeCursorTopLeftBottomRightSkin.
	 */
	[Style(name="resizeCursorTopLeftBottomRightSkinYOffset", type="Number", inherit="no")]
	
	
	/**
	 *  Name of the class used as cursor when resizing from top right or bottom left corner.
	 */
	[Style(name="resizeCursorTopRightBottomLeftSkin", type="Class", inherit="no")]
	
	/**
	 *  Distance to horizontally offset resizeCursorTopRightBottomLeftSkin.
	 */
	[Style(name="resizeCursorTopRightBottomLeftSkinXOffset", type="Number", inherit="no")]
	
	/**
	 *  Distance to vertically offset resizeCursorTopRightBottomLeftSkin.
	 */
	[Style(name="resizeCursorTopRightBottomLeftSkinYOffset", type="Number", inherit="no")]
	
	
	/**
	 * Central window class used in flexmdi. Includes min/max/close buttons by default.
	 */
	public class MDIWindow extends Panel implements IMDIFocusAwareStyleClient
	{		
		/**
	     * Size of edge handles. Can be adjusted to affect "sensitivity" of resize area.
	     */
	    public var edgeHandleSize:Number = 4;
	    
	    /**
	     * Size of corner handles. Can be adjusted to affect "sensitivity" of resize area.
	     */
		public var cornerHandleSize:Number = 10;
	    
	    /**
	     * @private
	     * Internal storage for windowState property.
	     */
		private var _windowState:int;
		
		/**
	     * @private
	     * Internal storage of previous state, used in min/max/restore logic.
	     */
		private var _prevWindowState:int;
		
		/**
		 * @private
		 * Internal storage of style name to be applied when window is in focus.
		 */
		private var _focusStyleName:String;
		
		/**
		 * @private
		 * Internal storage of style name to be applied when window is out of focus.
		 */
		private var _noFocusStyleName:String;
		
		/**
	     * Parent of window controls (min, restore/max and close buttons).
	     */
		private var _windowControls:MDIWindowControlsContainer;
		
		/**
		 * @private
		 * Flag to determine whether or not close button is visible.
		 */
		private var _showCloseButton:Boolean = true;
		
		/**
		 * Height of window when minimized.
		 */
		private var _minimizeHeight:Number;
		
		/**
		 * Flag determining whether or not this window is resizable.
		 */
		public var resizable:Boolean;
		
		/**
		 * Flag determining whether or not this window is draggable.
		 */
		public var draggable:Boolean;
		
		/**
	     * @private
	     * Resize handle for top edge of window.
	     */
		private var resizeHandleTop:Button;
		
		/**
	     * @private
	     * Resize handle for right edge of window.
	     */
		private var resizeHandleRight:Button;
		
		/**
	     * @private
	     * Resize handle for bottom edge of window.
	     */
		private var resizeHandleBottom:Button;
		
		/**
	     * @private
	     * Resize handle for left edge of window.
	     */
		private var resizeHandleLeft:Button;
		
		/**
	     * @private
	     * Resize handle for top left corner of window.
	     */
		private var resizeHandleTL:Button;
		
		/**
	     * @private
	     * Resize handle for top right corner of window.
	     */
		private var resizeHandleTR:Button;
		
		/**
	     * @private
	     * Resize handle for bottom right corner of window.
	     */
		private var resizeHandleBR:Button;
		
		/**
	     * @private
	     * Resize handle for bottom left corner of window.
	     */
		private var resizeHandleBL:Button;		
		
		/**
		 * Resize handle currently in use.
		 */
		private var currentResizeHandle:Button;
		
		/**
		 * Style name to apply to cursors.
		 */
		public var cursorStyleName:String;
		
		/**
	     * Rectangle to represent window's size and position when resize begins
	     * or window's size/position is saved.
	     */
		public var savedWindowRect:Rectangle;
		
		/**
		 * @private
		 * Flag used to intelligently dispatch resize related events
		 */
		private var _resizing:Boolean;
		
		/**
		 * Invisible shape laid over titlebar to prevent funkiness from clicking in title textfield.
		 * Making it public gives child components like controls container access to size of titleBar.
		 */
		public var titleBarOverlay:Canvas;
		
		/**
		 * @private
		 * Flag used to intelligently dispatch drag related events
		 */
		private var _dragging:Boolean;
		
		/**
		 * @private
	     * Mouse's x position when resize begins.
	     */
		private var dragStartMouseX:Number;
		
		/**
		 * @private
	     * Mouse's y position when resize begins.
	     */
		private var dragStartMouseY:Number;
		
		/**
		 * @private
	     * Maximum allowable x value for resize. Used to enforce minWidth.
	     */
		private var dragMaxX:Number;
		
		/**
		 * @private
	     * Maximum allowable x value for resize. Used to enforce minHeight.
	     */
		private var dragMaxY:Number;
		
		/**
		 * @private
	     * Amount the mouse's x position has changed during current resizing.
	     */
		private var dragAmountX:Number;
		
		/**
		 * @private
	     * Amount the mouse's y position has changed during current resizing.
	     */
		private var dragAmountY:Number;
		
		/**
	     * Window's context menu.
	     */
		public var winContextMenu:ContextMenu = null;
		
		/**
		 * Reference to MDIManager instance this window is managed by, if any.
	     */
		public var windowManager:MDIManager;
		
		/**
		 * Is this window in focus?
		 */
		public var hasFocus:Boolean;		
		
		/**
		 * @private store the backgroundAlpha when minimized.
	     */
		private var backgroundAlphaRestore:Number = 1;
		
		
		/**
		 * Constructor
	     */
		public function MDIWindow()
		{
			super();
			minWidth = minHeight = width = height = 200;
			windowState = MDIWindowState.NORMAL;
			doubleClickEnabled = resizable = draggable = true;
			
			focusStyleName = "mdiWindow";
			noFocusStyleName = "mdiWindowNoFocus";
			styleName = focusStyleName;
			cursorStyleName = "mdiWindowCursorStyle";	
			
			windowControls = new MDIWindowControlsContainer();		
		}
		
		/**
		 * Create resize handles and window controls.
		 */
		override protected function createChildren():void
		{
			super.createChildren();
			
			if(!titleBarOverlay)
			{
				titleBarOverlay = new Canvas();
				titleBarOverlay.width = this.width;
				titleBarOverlay.height = this.titleBar.height;
				titleBarOverlay.alpha = 0;
				titleBarOverlay.setStyle("backgroundColor", 0x000000);
				rawChildren.addChild(titleBarOverlay);
			}
			
			// edges
			if(!resizeHandleTop)
			{
				resizeHandleTop = new Button();
				resizeHandleTop.x = cornerHandleSize * .5;
				resizeHandleTop.y = -(edgeHandleSize * .5);
				resizeHandleTop.height = edgeHandleSize;
				resizeHandleTop.alpha = 0;
				resizeHandleTop.focusEnabled = false;
				rawChildren.addChild(resizeHandleTop);
			}
			
			if(!resizeHandleRight)
			{
				resizeHandleRight = new Button();
				resizeHandleRight.y = cornerHandleSize * .5;
				resizeHandleRight.width = edgeHandleSize;
				resizeHandleRight.alpha = 0;
				resizeHandleRight.focusEnabled = false;
				rawChildren.addChild(resizeHandleRight);
			}
			
			if(!resizeHandleBottom)
			{
				resizeHandleBottom = new Button();
				resizeHandleBottom.x = cornerHandleSize * .5;
				resizeHandleBottom.height = edgeHandleSize;
				resizeHandleBottom.alpha = 0;
				resizeHandleBottom.focusEnabled = false;
				rawChildren.addChild(resizeHandleBottom);
			}
			
			if(!resizeHandleLeft)
			{
				resizeHandleLeft = new Button();
				resizeHandleLeft.x = -(edgeHandleSize * .5);
				resizeHandleLeft.y = cornerHandleSize * .5;
				resizeHandleLeft.width = edgeHandleSize;
				resizeHandleLeft.alpha = 0;
				resizeHandleLeft.focusEnabled = false;
				rawChildren.addChild(resizeHandleLeft);
			}
			
			// corners
			if(!resizeHandleTL)
			{
				resizeHandleTL = new Button();
				resizeHandleTL.x = resizeHandleTL.y = -(cornerHandleSize * .3);
				resizeHandleTL.width = resizeHandleTL.height = cornerHandleSize;
				resizeHandleTL.alpha = 0;
				resizeHandleTL.focusEnabled = false;
				rawChildren.addChild(resizeHandleTL);
			}
			
			if(!resizeHandleTR)
			{
				resizeHandleTR = new Button();
				resizeHandleTR.width = resizeHandleTR.height = cornerHandleSize;
				resizeHandleTR.alpha = 0;
				resizeHandleTR.focusEnabled = false;
				rawChildren.addChild(resizeHandleTR);
			}
			
			if(!resizeHandleBR)
			{
				resizeHandleBR = new Button();
				resizeHandleBR.width = resizeHandleBR.height = cornerHandleSize;
				resizeHandleBR.alpha = 0;
				resizeHandleBR.focusEnabled = false;
				rawChildren.addChild(resizeHandleBR);
			}
			
			if(!resizeHandleBL)
			{
				resizeHandleBL = new Button();
				resizeHandleBL.width = resizeHandleBL.height = cornerHandleSize;
				resizeHandleBL.alpha = 0;
				resizeHandleBL.focusEnabled = false;
				rawChildren.addChild(resizeHandleBL);
			}
			
			// bring windowControls to top as they are created in constructor
			rawChildren.setChildIndex(DisplayObject(windowControls), rawChildren.numChildren - 1);
			
			addListeners();
		}
		
		/**
		 * Position and size resize handles and window controls.
		 */
		override protected function updateDisplayList(w:Number, h:Number):void
		{
			super.updateDisplayList(w, h);
			
			titleBarOverlay.width = this.width;
			titleBarOverlay.height = this.titleBar.height;
			
			// edges
			resizeHandleTop.x = cornerHandleSize * .5;
			resizeHandleTop.y = -(edgeHandleSize * .5);
			resizeHandleTop.width = this.width - cornerHandleSize;
			resizeHandleTop.height = edgeHandleSize;
			
			resizeHandleRight.x = this.width - edgeHandleSize * .5;
			resizeHandleRight.y = cornerHandleSize * .5;
			resizeHandleRight.width = edgeHandleSize;
			resizeHandleRight.height = this.height - cornerHandleSize;
			
			resizeHandleBottom.x = cornerHandleSize * .5;
			resizeHandleBottom.y = this.height - edgeHandleSize * .5;
			resizeHandleBottom.width = this.width - cornerHandleSize;
			resizeHandleBottom.height = edgeHandleSize;
			
			resizeHandleLeft.x = -(edgeHandleSize * .5);
			resizeHandleLeft.y = cornerHandleSize * .5;
			resizeHandleLeft.width = edgeHandleSize;
			resizeHandleLeft.height = this.height - cornerHandleSize;
			
			// corners
			resizeHandleTL.x = resizeHandleTL.y = -(cornerHandleSize * .5);
			resizeHandleTL.width = resizeHandleTL.height = cornerHandleSize;
			
			resizeHandleTR.x = this.width - cornerHandleSize * .5;
			resizeHandleTR.y = -(cornerHandleSize * .5);
			resizeHandleTR.width = resizeHandleTR.height = cornerHandleSize;
			
			resizeHandleBR.x = this.width - cornerHandleSize * .5;
			resizeHandleBR.y = this.height - cornerHandleSize * .5;
			resizeHandleBR.width = resizeHandleBR.height = cornerHandleSize;
			
			resizeHandleBL.x = -(cornerHandleSize * .5);
			resizeHandleBL.y = this.height - cornerHandleSize * .5;
			resizeHandleBL.width = resizeHandleBL.height = cornerHandleSize;
			
			// cause windowControls container to update
			UIComponent(windowControls).invalidateDisplayList();
		}
		
		/**
		 * Detects change to styleName that is executed by MDIManager indicating a change in focus.
		 * Iterates over window controls and adjusts their styles if they're focus-aware.
		 */
		override public function styleChanged(styleProp:String):void
		{
			super.styleChanged(styleProp);
			
			if(windowControls && styleProp == "styleName")
			{
				var cntnr:Container = Container(windowControls);
				for each(var control:UIComponent in cntnr.getChildren())
				{
					if(control is IMDIFocusAwareStyleClient)
					{
						if(this.hasFocus)
						{
							control.styleName = IMDIFocusAwareStyleClient(control).focusStyleName;
						}
						else
						{
							control.styleName = IMDIFocusAwareStyleClient(control).noFocusStyleName;
						}
					}
				}
			}
		}
		
		/**
		 * Reference to class used to create windowControls property.
		 */
		public function get windowControls():MDIWindowControlsContainer
		{
			return _windowControls;
		}
		
		/**
		 * When reference is set windowControls will be reinstantiated, meaning runtime switching is supported.
		 */
		public function set windowControls(controlsContainer:MDIWindowControlsContainer):void
		{
			if(_windowControls)
			{
				var cntnr:Container = Container(windowControls);
				cntnr.removeAllChildren();
				rawChildren.removeChild(cntnr);
				_windowControls = null;
			}
			
			_windowControls = controlsContainer;
			_windowControls.window = this;
			rawChildren.addChild(UIComponent(_windowControls));
			if(windowState == MDIWindowState.MINIMIZED)
			{
				showControls = false;
			}
		}
		
		/**
		 * Minimize window button.
		 */
		public function get minimizeBtn():Button
		{
			return windowControls.minimizeBtn;
		}
		
		/**
		 * Maximize/restore window button.
		 */
		public function get maximizeRestoreBtn():MDIMaximizeRestoreButton
		{
			return windowControls.maximizeRestoreBtn;
		}
		
		/**
		 * Close window button.
		 */
		public function get closeBtn():Button
		{
			return windowControls.closeBtn;
		}
		
		public function get showCloseButton():Boolean
		{
			return _showCloseButton;
		}
		
		public function set showCloseButton(value:Boolean):void
		{
			_showCloseButton = value;
			if(closeBtn && closeBtn.visible != value)
			{
				closeBtn.visible = value;
				invalidateDisplayList();
			}
		}
		
		/**
		 * Returns reference to titleTextField which is protected by default.
		 * Provided to allow MDIWindowControlsContainer subclasses as much freedom as possible.
		 */
		public function getTitleTextField():UITextField
		{
			return titleTextField as UITextField;
		}
		
		/**
		 * Returns reference to titleIconObject which is mx_internal by default.
		 * Provided to allow MDIWindowControlsContainer subclasses as much freedom as possible.
		 */
		public function getTitleIconObject():DisplayObject
		{
			use namespace mx_internal;
			return titleIconObject as DisplayObject;
		}
		
		/**
		 * Save style settings for minimizing.
	     */
		public function saveStyle():void
		{
			//this.backgroundAlphaRestore = this.getStyle("backgroundAlpha");
		}
		
		/**
		 * Restores style settings for restore and maximize
	     */
		public function restoreStyle():void
		{
			//this.setStyle("backgroundAlpha", this.backgroundAlphaRestore);
		}
		
		/**
		 * Add listeners for resize handles and window controls.
		 */
		private function addListeners():void
		{
			// edges
			resizeHandleTop.addEventListener(MouseEvent.ROLL_OVER, onResizeButtonRollOver, false, 0, true);
			resizeHandleTop.addEventListener(MouseEvent.ROLL_OUT, onResizeButtonRollOut, false, 0, true);
			resizeHandleTop.addEventListener(MouseEvent.MOUSE_DOWN, onResizeButtonPress, false, 0, true);
			
			resizeHandleRight.addEventListener(MouseEvent.ROLL_OVER, onResizeButtonRollOver, false, 0, true);
			resizeHandleRight.addEventListener(MouseEvent.ROLL_OUT, onResizeButtonRollOut, false, 0, true);
			resizeHandleRight.addEventListener(MouseEvent.MOUSE_DOWN, onResizeButtonPress, false, 0, true);
			
			resizeHandleBottom.addEventListener(MouseEvent.ROLL_OVER, onResizeButtonRollOver, false, 0, true);
			resizeHandleBottom.addEventListener(MouseEvent.ROLL_OUT, onResizeButtonRollOut, false, 0, true);
			resizeHandleBottom.addEventListener(MouseEvent.MOUSE_DOWN, onResizeButtonPress, false, 0, true);
			
			resizeHandleLeft.addEventListener(MouseEvent.ROLL_OVER, onResizeButtonRollOver, false, 0, true);
			resizeHandleLeft.addEventListener(MouseEvent.ROLL_OUT, onResizeButtonRollOut, false, 0, true);
			resizeHandleLeft.addEventListener(MouseEvent.MOUSE_DOWN, onResizeButtonPress, false, 0, true);
			
			// corners
			resizeHandleTL.addEventListener(MouseEvent.ROLL_OVER, onResizeButtonRollOver, false, 0, true);
			resizeHandleTL.addEventListener(MouseEvent.ROLL_OUT, onResizeButtonRollOut, false, 0, true);
			resizeHandleTL.addEventListener(MouseEvent.MOUSE_DOWN, onResizeButtonPress, false, 0, true);
			
			resizeHandleTR.addEventListener(MouseEvent.ROLL_OVER, onResizeButtonRollOver, false, 0, true);
			resizeHandleTR.addEventListener(MouseEvent.ROLL_OUT, onResizeButtonRollOut, false, 0, true);
			resizeHandleTR.addEventListener(MouseEvent.MOUSE_DOWN, onResizeButtonPress, false, 0, true);
			
			resizeHandleBR.addEventListener(MouseEvent.ROLL_OVER, onResizeButtonRollOver, false, 0, true);
			resizeHandleBR.addEventListener(MouseEvent.ROLL_OUT, onResizeButtonRollOut, false, 0, true);
			resizeHandleBR.addEventListener(MouseEvent.MOUSE_DOWN, onResizeButtonPress, false, 0, true);
			
			resizeHandleBL.addEventListener(MouseEvent.ROLL_OVER, onResizeButtonRollOver, false, 0, true);
			resizeHandleBL.addEventListener(MouseEvent.ROLL_OUT, onResizeButtonRollOut, false, 0, true);
			resizeHandleBL.addEventListener(MouseEvent.MOUSE_DOWN, onResizeButtonPress, false, 0, true);
			
			// titleBar overlay
			titleBarOverlay.addEventListener(MouseEvent.MOUSE_DOWN, onTitleBarPress, false, 0, true);
			titleBarOverlay.addEventListener(MouseEvent.MOUSE_UP, onTitleBarRelease, false, 0, true);
			titleBarOverlay.addEventListener(MouseEvent.DOUBLE_CLICK, maximizeRestore, false, 0, true);
			titleBarOverlay.addEventListener(MouseEvent.CLICK, unMinimize, false, 0, true);
			
			// window controls
			addEventListener(MouseEvent.CLICK, windowControlClickHandler, false, 0, true);
			
			// clicking anywhere brings window to front
			addEventListener(MouseEvent.MOUSE_DOWN, bringToFrontProxy);
			contextMenu.addEventListener(ContextMenuEvent.MENU_SELECT, bringToFrontProxy);
		}
		
		/**
		 * Click handler for default window controls (minimize, maximize/restore and close).
		 */
		private function windowControlClickHandler(event:MouseEvent):void
		{
			if(windowControls)
			{
				if(windowControls.minimizeBtn && event.target == windowControls.minimizeBtn)
				{
					minimize();
				}
				else if(windowControls.maximizeRestoreBtn && event.target == windowControls.maximizeRestoreBtn)
				{
					maximizeRestore();
				}
				else if(windowControls.closeBtn && event.target == windowControls.closeBtn)
				{
					close();
				}
			}
		}
		
		/**
		 * Called automatically by clicking on window this now delegates execution to the manager.
		 */
		private function bringToFrontProxy(event:Event):void
		{
			windowManager.bringToFront(this);
		}
		
		/**
		 *  Minimize the window.
		 */
		public function minimize(event:MouseEvent = null):void
		{
			// if the panel is floating, save its state
			if(windowState == MDIWindowState.NORMAL)
			{
				savePanel();
			}
			dispatchEvent(new MDIWindowEvent(MDIWindowEvent.MINIMIZE, this));
			windowState = MDIWindowState.MINIMIZED;
			showControls = false;
		}
		
		
		/**
		 *  Called from maximize/restore button 
		 * 
		 *  @event MouseEvent (optional)
		 */
		public function maximizeRestore(event:MouseEvent = null):void
		{
			if(windowState == MDIWindowState.NORMAL)
			{
				savePanel();
				maximize();
			}
			else
			{
				restore();
			}
		}
		
		/**
		 * Restores the window to its last floating position.
		 */
		public function restore():void
		{
			windowState = MDIWindowState.NORMAL;
			if(maximizeRestoreBtn)
			{
				maximizeRestoreBtn.styleName = (this.hasFocus) 
													? maximizeRestoreBtn.focusStyleName 
													: maximizeRestoreBtn.noFocusStyleName;
			}
			dispatchEvent(new MDIWindowEvent(MDIWindowEvent.RESTORE, this));
		}
		
		/**
		 * Maximize the window.
		 */
		public function maximize():void
		{
			if(windowState == MDIWindowState.NORMAL)
			{
				savePanel();
			}
			showControls = true;
			windowState = MDIWindowState.MAXIMIZED;
			if(maximizeRestoreBtn)
			{
				maximizeRestoreBtn.styleName = (this.hasFocus) 
													? maximizeRestoreBtn.focusStyleName 
													: maximizeRestoreBtn.noFocusStyleName;
			}
			dispatchEvent(new MDIWindowEvent(MDIWindowEvent.MAXIMIZE, this));
		}
		
		/**
		 * Close the window.
		 */
		public function close(event:MouseEvent = null):void
		{
			dispatchEvent(new MDIWindowEvent(MDIWindowEvent.CLOSE, this));
		}
		
		/**
		 * Save the panel's floating coordinates.
		 * 
		 * @private
		 */
		private function savePanel():void
		{
			savedWindowRect = new Rectangle(this.x, this.y, this.width, this.height);
		}
		
		/**
		 * Title bar dragging.
		 * 
		 * @private
		 */
		private function onTitleBarPress(event:MouseEvent):void
		{
			// only floating windows can be dragged
			if(this.windowState == MDIWindowState.NORMAL && draggable)
			{
				if(windowManager.enforceBoundaries)
				{
					this.startDrag(false, new Rectangle(0, 0, parent.width - this.width, parent.height - this.height));
				}
				else
				{
					this.startDrag();
				}				
				
				systemManager.addEventListener(MouseEvent.MOUSE_MOVE, onWindowMove);
				systemManager.addEventListener(MouseEvent.MOUSE_UP, onTitleBarRelease);
				systemManager.stage.addEventListener(Event.MOUSE_LEAVE, onTitleBarRelease);
			}
		}
		
		private function onWindowMove(event:MouseEvent):void
		{
			if(!_dragging)
			{
				_dragging = true;
				// clear styles (future versions may allow enforcing constraints on drag)
				this.clearStyle("top");
				this.clearStyle("right");
				this.clearStyle("bottom");
				this.clearStyle("left");
				dispatchEvent(new MDIWindowEvent(MDIWindowEvent.DRAG_START, this));
			}
			dispatchEvent(new MDIWindowEvent(MDIWindowEvent.DRAG, this));
		}
		
		private function onTitleBarRelease(event:Event):void
		{
			this.stopDrag();
			if(_dragging)
			{
				_dragging = false;
				dispatchEvent(new MDIWindowEvent(MDIWindowEvent.DRAG_END, this));
			}
			systemManager.removeEventListener(MouseEvent.MOUSE_MOVE, onWindowMove);
			systemManager.removeEventListener(MouseEvent.MOUSE_UP, onTitleBarRelease);
			systemManager.stage.removeEventListener(Event.MOUSE_LEAVE, onTitleBarRelease);
		}
		
		/**
		 * Mouse down on any resize handle.
		 */
		private function onResizeButtonPress(event:MouseEvent):void
		{
			if(windowState == MDIWindowState.NORMAL && resizable)
			{
				currentResizeHandle = event.target as Button;
				setCursor(currentResizeHandle);
				dragStartMouseX = parent.mouseX;
				dragStartMouseY = parent.mouseY;
				savePanel();
				
				dragMaxX = savedWindowRect.x + (savedWindowRect.width - minWidth);
				dragMaxY = savedWindowRect.y + (savedWindowRect.height - minHeight);
				
				systemManager.addEventListener(Event.ENTER_FRAME, updateWindowSize, false, 0, true);
				systemManager.addEventListener(MouseEvent.MOUSE_MOVE, onResizeButtonDrag, false, 0, true);
				systemManager.addEventListener(MouseEvent.MOUSE_UP, onResizeButtonRelease, false, 0, true);
				systemManager.stage.addEventListener(Event.MOUSE_LEAVE, onMouseLeaveStage, false, 0, true);
			}
		}
		
		private function onResizeButtonDrag(event:MouseEvent):void
		{
			if(!_resizing)
			{
				_resizing = true;
				dispatchEvent(new MDIWindowEvent(MDIWindowEvent.RESIZE_START, this));
			}			
			dispatchEvent(new MDIWindowEvent(MDIWindowEvent.RESIZE, this));
		}
		
		/**
		 * Mouse move while mouse is down on a resize handle
		 */
		private function updateWindowSize(event:Event):void
		{
			if(windowState == MDIWindowState.NORMAL && resizable)
			{
				dragAmountX = parent.mouseX - dragStartMouseX;
				dragAmountY = parent.mouseY - dragStartMouseY;
				
				if(currentResizeHandle == resizeHandleTop && parent.mouseY > 0)
				{
					this.y = Math.min(savedWindowRect.y + dragAmountY, dragMaxY);
					this.height = Math.max(savedWindowRect.height - dragAmountY, minHeight);
				}
				else if(currentResizeHandle == resizeHandleRight && parent.mouseX < parent.width)
				{
					this.width = Math.max(savedWindowRect.width + dragAmountX, minWidth);
				}
				else if(currentResizeHandle == resizeHandleBottom && parent.mouseY < parent.height)
				{
					this.height = Math.max(savedWindowRect.height + dragAmountY, minHeight);
				}
				else if(currentResizeHandle == resizeHandleLeft && parent.mouseX > 0)
				{
					this.x = Math.min(savedWindowRect.x + dragAmountX, dragMaxX);
					this.width = Math.max(savedWindowRect.width - dragAmountX, minWidth);
				}
				else if(currentResizeHandle == resizeHandleTL && parent.mouseX > 0 && parent.mouseY > 0)
				{
					this.x = Math.min(savedWindowRect.x + dragAmountX, dragMaxX);
					this.y = Math.min(savedWindowRect.y + dragAmountY, dragMaxY);
					this.width = Math.max(savedWindowRect.width - dragAmountX, minWidth);
					this.height = Math.max(savedWindowRect.height - dragAmountY, minHeight);				
				}
				else if(currentResizeHandle == resizeHandleTR && parent.mouseX < parent.width && parent.mouseY > 0)
				{
					this.y = Math.min(savedWindowRect.y + dragAmountY, dragMaxY);
					this.width = Math.max(savedWindowRect.width + dragAmountX, minWidth);
					this.height = Math.max(savedWindowRect.height - dragAmountY, minHeight);
				}
				else if(currentResizeHandle == resizeHandleBR && parent.mouseX < parent.width && parent.mouseY < parent.height)
				{
					this.width = Math.max(savedWindowRect.width + dragAmountX, minWidth);
					this.height = Math.max(savedWindowRect.height + dragAmountY, minHeight);
				}
				else if(currentResizeHandle == resizeHandleBL && parent.mouseX > 0 && parent.mouseY < parent.height)
				{
					this.x = Math.min(savedWindowRect.x + dragAmountX, dragMaxX);
					this.width = Math.max(savedWindowRect.width - dragAmountX, minWidth);
					this.height = Math.max(savedWindowRect.height + dragAmountY, minHeight);
				}
			}
		}
		
		private function onResizeButtonRelease(event:MouseEvent = null):void
		{
			if(windowState == MDIWindowState.NORMAL && resizable)
			{
				if(_resizing)
				{
					_resizing = false;
					dispatchEvent(new MDIWindowEvent(MDIWindowEvent.RESIZE_END, this));
				}
				currentResizeHandle = null;
				systemManager.removeEventListener(Event.ENTER_FRAME, updateWindowSize);
				systemManager.removeEventListener(MouseEvent.MOUSE_MOVE, onResizeButtonDrag);
				systemManager.removeEventListener(MouseEvent.MOUSE_UP, onResizeButtonRelease);
				systemManager.stage.removeEventListener(Event.MOUSE_LEAVE, onMouseLeaveStage);
				CursorManager.removeCursor(CursorManager.currentCursorID);
			}
		}
		
		private function onMouseLeaveStage(event:Event):void
		{
			onResizeButtonRelease();
			systemManager.stage.removeEventListener(Event.MOUSE_LEAVE, onMouseLeaveStage);
		}
		
		/**
		 * Restore window to state it was in prior to being minimized.
		 */
		public function unMinimize(event:MouseEvent = null):void
		{
			if(minimized)
			{
				showControls = true;
				
				if(_prevWindowState == MDIWindowState.NORMAL)
				{
					restore();
				}
				else
				{
					maximize();
				}
			}
		}
		
		[Embed(source="/flexmdi/assets/img/resizeCursorH.gif")]
		private static var resizeCursorHorizontalSkin:Class;
		private static var resizeCursorHorizontalSkinXOffset:Number = -10;
		private static var resizeCursorHorizontalSkinYOffset:Number = -10;
		
		[Embed(source="/flexmdi/assets/img/resizeCursorV.gif")]
		private static var resizeCursorVerticalSkin:Class;
		private static var resizeCursorVerticalSkinXOffset:Number = -10;
		private static var resizeCursorVerticalSkinYOffset:Number = -10;
		
		[Embed(source="/flexmdi/assets/img/resizeCursorTLBR.gif")]
		private static var resizeCursorTopLeftBottomRightSkin:Class;
		private static var resizeCursorTopLeftBottomRightSkinXOffset:Number = -10;
		private static var resizeCursorTopLeftBottomRightSkinYOffset:Number = -10;
		
		[Embed(source="/flexmdi/assets/img/resizeCursorTRBL.gif")]
		private static var resizeCursorTopRightBottomLeftSkin:Class;
		private static var resizeCursorTopRightBottomLeftSkinXOffset:Number = -10;
		private static var resizeCursorTopRightBottomLeftSkinYOffset:Number = -10;
		
		private static var classConstructed:Boolean = classConstruct();
		
		private static function classConstruct():Boolean
		{
			if(!StyleManager.getStyleDeclaration(".mdiWindowCursorStyle"))
			{
				var cursorStyle:CSSStyleDeclaration = new CSSStyleDeclaration();
				cursorStyle.defaultFactory = function():void
				{
					this.resizeCursorVerticalSkin = resizeCursorVerticalSkin;
					this.resizeCursorVerticalSkinXOffset = resizeCursorVerticalSkinXOffset;
					this.resizeCursorVerticalSkinYOffset = resizeCursorVerticalSkinYOffset;
					
					this.resizeCursorHorizontalSkin = resizeCursorHorizontalSkin;
					this.resizeCursorHorizontalSkinXOffset = resizeCursorHorizontalSkinXOffset;
					this.resizeCursorHorizontalSkinYOffset = resizeCursorHorizontalSkinYOffset;
					
					this.resizeCursorTopLeftBottomRightSkin = resizeCursorTopLeftBottomRightSkin;
					this.resizeCursorTopLeftBottomRightSkinXOffset = resizeCursorTopLeftBottomRightSkinXOffset;
					this.resizeCursorTopLeftBottomRightSkinYOffset = resizeCursorTopLeftBottomRightSkinYOffset;
					
					this.resizeCursorTopRightBottomLeftSkin = resizeCursorTopRightBottomLeftSkin;
					this.resizeCursorTopRightBottomLeftSkinXOffset = resizeCursorTopRightBottomLeftSkinXOffset;
					this.resizeCursorTopRightBottomLeftSkinYOffset = resizeCursorTopRightBottomLeftSkinYOffset;
				}
				StyleManager.setStyleDeclaration(".mdiWindowCursorStyle", cursorStyle, true);
			}
			
			return true;
		}
		
		private function getHighestPriorityStyle(styleName:String):Object
		{
			var hierarchy:Array = new Array(this, StyleManager.getStyleDeclaration("." + cursorStyleName), StyleManager.getStyleDeclaration(".mdiWindowCursorStyle"));
			
			for(var i:int = 0, n:int = hierarchy.length; i < n; i++)
			{
				if(hierarchy[i].getStyle(styleName))
				{
					return hierarchy[i].getStyle(styleName);
				}
			}
			return MDIWindow[styleName];
		}
		
		private function setCursor(target:Button):void
		{
			var styleName:String;
			
			switch(target)
			{
				case resizeHandleRight:
				case resizeHandleLeft:
					styleName = "resizeCursorHorizontalSkin";
				break;
				
				case resizeHandleTop:
				case resizeHandleBottom:
					styleName = "resizeCursorVerticalSkin";
				break;
				
				case resizeHandleTL:
				case resizeHandleBR:
					styleName = "resizeCursorTopLeftBottomRightSkin";
				break;
				
				case resizeHandleTR:
				case resizeHandleBL:
					styleName = "resizeCursorTopRightBottomLeftSkin";
				break;
			}
			
			CursorManager.removeCursor(CursorManager.currentCursorID);
			CursorManager.setCursor(Class(getHighestPriorityStyle(styleName)), 2, Number(getHighestPriorityStyle(styleName + "XOffset")), Number(getHighestPriorityStyle(styleName + "YOffset")));
		}
		
		private function onResizeButtonRollOver(event:MouseEvent):void
		{
			// only floating windows can be resized
			// event.buttonDown is to detect being dragged over
			if(windowState == MDIWindowState.NORMAL && resizable && !event.buttonDown)
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
		
		public function set showControls(value:Boolean):void
		{
			Container(windowControls).visible = value;
		}
		
		private function get windowState():int
		{
			return _windowState;
		}
		
		private function set windowState(newState:int):void
		{
			_prevWindowState = _windowState;
			_windowState = newState;
			
			updateContextMenu(_windowState);
		}
		
		public function get minimized():Boolean
		{
			return _windowState == MDIWindowState.MINIMIZED;
		}
		
		public function get maximized():Boolean
		{
			return _windowState == MDIWindowState.MAXIMIZED;
		}
		
		public function get minimizeHeight():Number
		{
			return titleBar.height;
		}
		
		public function get focusStyleName():String
		{
			return _focusStyleName;
		}
		
		public function set focusStyleName(styleName:String):void
		{
			_focusStyleName = styleName;
		}
		
		public function get noFocusStyleName():String
		{
			return _noFocusStyleName;
		}
		
		public function set noFocusStyleName(styleName:String):void
		{
			_noFocusStyleName = styleName;
		}
		
		public function updateContextMenu(currentState:int):void
		{
			var defaultContextMenu:ContextMenu = new ContextMenu();
				defaultContextMenu.hideBuiltInItems();
			
			var minimizeItem:ContextMenuItem = new ContextMenuItem("Minimize");
		  		minimizeItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, menuItemSelectHandler);
		  		minimizeItem.enabled = currentState != MDIWindowState.MINIMIZED;
		  		defaultContextMenu.customItems.push(minimizeItem);	
			
			var maximizeItem:ContextMenuItem = new ContextMenuItem("Maximize");
		  		maximizeItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, menuItemSelectHandler);
		  		maximizeItem.enabled = currentState != MDIWindowState.MAXIMIZED;
		  		defaultContextMenu.customItems.push(maximizeItem);	
			
			var restoreItem:ContextMenuItem = new ContextMenuItem("Restore");
		  		restoreItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, menuItemSelectHandler);
		  		restoreItem.enabled = currentState != MDIWindowState.NORMAL;
		  		defaultContextMenu.customItems.push(restoreItem);	
			
			var closeItem:ContextMenuItem = new ContextMenuItem("Close");
		  		closeItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, menuItemSelectHandler);
		  		defaultContextMenu.customItems.push(closeItem);  
	

			var arrangeItem:ContextMenuItem = new ContextMenuItem("Auto Arrange");
				arrangeItem.separatorBefore = true;
		  		arrangeItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, menuItemSelectHandler);	
		  		defaultContextMenu.customItems.push(arrangeItem);

       	 	var arrangeFillItem:ContextMenuItem = new ContextMenuItem("Auto Arrange Fill");
		  		arrangeFillItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, menuItemSelectHandler);  	
		  		defaultContextMenu.customItems.push(arrangeFillItem);   
               	
            var cascadeItem:ContextMenuItem = new ContextMenuItem("Cascade");
		  		cascadeItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, menuItemSelectHandler);
		  		defaultContextMenu.customItems.push(cascadeItem);                     	
			
			var showAllItem:ContextMenuItem = new ContextMenuItem("Show All Windows");
		  		showAllItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, menuItemSelectHandler);
		  		defaultContextMenu.customItems.push(showAllItem);  
			
        	this.contextMenu = defaultContextMenu;
		}
		
		private function menuItemSelectHandler(event:ContextMenuEvent):void
		{
			switch(event.target.caption)
			{
				case("Minimize"):
					minimize();
				break;
				
				case("Maximize"):
					maximize();
				break;
				
				case("Restore"):
					if(this.windowState == MDIWindowState.MINIMIZED)
					{
						unMinimize();
					}
					else if(this.windowState == MDIWindowState.MAXIMIZED)
					{
						maximizeRestore();
					}	
				break;
				
				case("Close"):
					close();
				break;
				
				case("Auto Arrange"):
					this.windowManager.tile(false, this.windowManager.tilePadding);
				break;
				
				case("Auto Arrange Fill"):
					this.windowManager.tile(true, this.windowManager.tilePadding);
				break;
				
				case("Cascade"):
					this.windowManager.cascade();
				break;
				
				case("Show All Windows"):
					this.windowManager.showAllWindows();
				break;

			}
		}
	}
}