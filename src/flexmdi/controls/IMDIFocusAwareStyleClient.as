package flexmdi.controls
{	
	public interface IMDIFocusAwareStyleClient
	{
		function get focusStyleName():String;
		function set focusStyleName(styleName:String):void;
		
		function get noFocusStyleName():String;
		function set noFocusStyleName(styleName:String):void;
	}
}