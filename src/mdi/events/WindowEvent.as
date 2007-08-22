package mdi.events
{
	import flash.events.Event;
	
	import mdi.containers.Window;

	public class WindowEvent extends Event
	{
		public static var MINIMIZE:String = "minimize";
		public static var RESTORE:String = "restore";
		public static var MAXIMIZE:String = "maximize";
		public static var CLOSE:String = "close";
		
		public var window:Window;
		
		public function WindowEvent(window:Window, type:String)
		{
			this.window = window;
			super(type, true, true);
		}
	}
}