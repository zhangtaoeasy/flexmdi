package taskbar
{
	import flexmdi.containers.MDIWindow;
	
	[Bindable]
	public class TaskBarItem
	{	
		public var window : MDIWindow;
		public var label : String;
		
		public function TaskBarItem(label:String, window:MDIWindow):void
		{
			this.label = label;
			this.window = window;	
		}
		
	}
}