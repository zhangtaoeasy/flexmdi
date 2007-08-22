package mdi.events
{
	import flash.events.Event;
	
	import mdi.containers.MDIWindow;

	public class MDIWindowEvent extends Event
	{
		public static const FOCUS_IN:String = "mdiFocusIn";
		public static const FOCUS_OUT:String = "mdiFocusOut";
		public static const MOVE:String = "mdiMove";
		public static const RESIZE_START:String = "mdiResizeStart";
		public static const RESIZE:String = "mdiResize";
		public static const RESIZE_END:String = "mdiResizeEnd";
		
		public static const MINIMIZE:String = "mdiMinimize";
		public static const RESTORE:String = "mdiRestore";
		public static const MAXIMIZE:String = "mdiMaximize";
		public static const CLOSE:String = "mdiClose";
		
		public var window:MDIWindow;
		
		public function MDIWindowEvent(type:String, window:MDIWindow, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
			this.window = window;
		}
		
		override public function clone():Event
		{
			return new MDIWindowEvent(type, window, bubbles, cancelable);
		}
	}
}