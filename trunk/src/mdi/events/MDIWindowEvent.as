package mdi.events
{
	import flash.events.Event;
	
	import mdi.containers.MDIWindow;

	public class MDIWindowEvent extends Event
	{
		public static var MINIMIZE:String = "minimize";
		public static var RESTORE:String = "restore";
		public static var MAXIMIZE:String = "maximize";
		public static var CLOSE:String = "close";
		
		public var window:MDIWindow;
		
		public function MDIWindowEvent(window:MDIWindow, type:String)
		{
			this.window = window;
			super(type, true, true);
		}
	}
}