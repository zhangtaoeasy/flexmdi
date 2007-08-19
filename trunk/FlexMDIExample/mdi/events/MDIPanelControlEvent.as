package mdi.events
{
	import flash.events.Event;
	
	import mx.containers.Panel;

	public class MDIPanelControlEvent extends Event
	{
		public static var MINIMIZE:String = "minimize";
		public static var RESTORE:String = "restore";
		public static var MAXIMIZE:String = "maximize";
		public static var CLOSE:String = "close";
		
		public var panel:Panel;
		
		public function MDIPanelControlEvent(panel:Panel, type:String)
		{
			this.panel = panel;
			super(type, true, true);
		}
	}
}