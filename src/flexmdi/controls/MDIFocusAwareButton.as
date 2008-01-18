/*
Copyright (c) 2007 FlexMDI Contributors.  See:
    http://code.google.com/p/flexmdi/wiki/ProjectContributors

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/

package flexmdi.controls
{
	import mx.controls.Button;
	
	/**
	 * Convenience class developers can inherit from in order to easily implement focus-aware buttons
	 * rather than having to define the get/set pairs required by IMDIFocusAwareStyleClient themselves.
	 */
	public class MDIFocusAwareButton extends Button implements IMDIFocusAwareStyleClient
	{
		private var _focusStyleName:String;
		private var _noFocusStyleName:String;
		
		public function MDIFocusAwareButton()
		{
			super();
			buttonMode = true;
		}
		
		public function get focusStyleName():String
		{
			return (_focusStyleName) ? _focusStyleName : String(styleName);
		}
		
		public function set focusStyleName(styleName:String):void
		{
			_focusStyleName = styleName;
		}
		
		public function get noFocusStyleName():String
		{
			return (_noFocusStyleName) ? _noFocusStyleName : focusStyleName;
		}
		
		public function set noFocusStyleName(styleName:String):void
		{
			_noFocusStyleName = styleName;
		}
	}
}