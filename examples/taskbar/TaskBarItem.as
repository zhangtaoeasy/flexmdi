package taskbar
{
	import flexmdi.containers.MDIWindow;
	import mx.core.UIComponent;
	
	[Bindable]
	public class TaskBarItem extends UIComponent
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