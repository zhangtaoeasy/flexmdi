package mdi.events
{
	import flash.events.Event;
	
	import mdi.containers.MDIWindow;

	public class MDIWindowEvent extends Event
	{
		public static const MOVE:String = "move";
		public static const RESIZE_START:String = "resizeStart";
		public static const RESIZE:String = "resize";
		public static const RESIZE_END:String = "resizeEnd";
		public static const FOCUS:String = "focus";
		
		public static const MINIMIZE:String = "minimize";
		public static const RESTORE:String = "restore";
		public static const MAXIMIZE:String = "maximize";
		public static const CLOSE:String = "close";
		
		public var window:MDIWindow;
		
		public function MDIWindowEvent(type:String, window:MDIWindow, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super( type, bubbles, cancelable );
			this.window = window;
		}
		
		override public function clone():Event
		{
			return new MDIWindowEvent(type, window, bubbles, cancelable);
		}
	}
}