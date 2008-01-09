package flexmdi.controls
{
	import mx.controls.Button;

	public class MDIFocusAwareWindowControlButton extends Button implements IMDIFocusAwareStyleClient
	{
		private var _focusStyleName:String;
		private var _noFocusStyleName:String;
		
		public function MDIFocusAwareWindowControlButton()
		{
			super();
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
	}
}