package flexmdi.controls
{	
	import flexmdi.containers.MDIWindow;
	
	import mx.controls.Button;
	
	public class MDIMaximizeRestoreButton extends Button implements IMDIFocusAwareStyleClient
	{
		private var window:MDIWindow;
		
		public var maximizeBtnStyleName:String;
		public var restoreBtnStyleName:String;
		
		private var _maximizeBtnNoFocusStyleName:String;
		private var _restoreBtnNoFocusStyleName:String;
		
		public function MDIMaximizeRestoreButton(window:MDIWindow)
		{
			super();
			
			this.window = window;
			styleName = maximizeBtnStyleName;
		}
		
		public function get focusStyleName():String
		{
			return (window.maximized) ? restoreBtnStyleName : maximizeBtnStyleName;
		}		
		public function set focusStyleName(styleName:String):void
		{
			return;
		}
		
		public function get noFocusStyleName():String
		{
			return (window.maximized) ? restoreBtnNoFocusStyleName : maximizeBtnNoFocusStyleName;
		}		
		public function set noFocusStyleName(styleName:String):void
		{
			return;
		}
		
		// if noFocus style has not been set we return the regular style
		public function get maximizeBtnNoFocusStyleName():String
		{
			return (_maximizeBtnNoFocusStyleName == null) ? maximizeBtnStyleName : _maximizeBtnNoFocusStyleName;
		}
		public function set maximizeBtnNoFocusStyleName(styleName:String):void
		{
			_maximizeBtnNoFocusStyleName = styleName;
		}
		
		// if noFocus style has not been set we return the regular style
		public function get restoreBtnNoFocusStyleName():String
		{
			return (_restoreBtnNoFocusStyleName == null) ? restoreBtnStyleName : _restoreBtnNoFocusStyleName;
		}
		public function set restoreBtnNoFocusStyleName(styleName:String):void
		{
			_restoreBtnNoFocusStyleName = styleName;
		}
	}
}