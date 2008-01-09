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
	import flexmdi.containers.MDIWindow;
	
	import mx.controls.Button;
	
	/**
	 * Base class for maximize/restore button functionality. Implements IMDIFocusAwareStyleClient but does
	 * not force support of it, meaning that if noFocus styles are not defined it will transparently provide
	 * the regular styles. MDIWindow takes care of requesting focus/noFocus styles depending on window state
	 * and this class checks the window's maximized status to determine whether button should show 
	 * maximize or restore style. Should not need to be subclassed, custom controls containers can simply
	 * use this class and assign desired style names.
	 */
	public class MDIMaximizeRestoreButton extends Button implements IMDIFocusAwareStyleClient
	{
		/**
		 * @private Reference to (grand)parent MDIWindow
	     */
		private var window:MDIWindow;
		
		/**
		 * Style name to be used when window is floating and in focus.
	     */
		public var maximizeBtnStyleName:String;
		
		/**
		 * Style name to be used when window is maximized and in focus.
	     */
		public var restoreBtnStyleName:String;
		
		/**
		 * @private Internal storage of style name to be used when window is floating and out of focus.
	     */
		private var _maximizeBtnNoFocusStyleName:String;
		
		/**
		 * @private Internal storage of style name to be used when window is maximized and out of focus.
	     */
		private var _restoreBtnNoFocusStyleName:String;
		
		/**
		 * Constructor that requires reference to associated MDIWindow.
		 */
		public function MDIMaximizeRestoreButton(window:MDIWindow)
		{
			super();
			
			this.window = window;
			styleName = maximizeBtnStyleName;
		}
		
		/**
		 * Style name to be used when window is in focus. Defined by IMDIFocusAwareStyleClient.
		 * Contains logic to choose between maximize and restore styles.
		 */
		public function get focusStyleName():String
		{
			return (window.maximized) ? restoreBtnStyleName : maximizeBtnStyleName;
		}
		
		/**
		 * Only present to satisfy IMDIFocusAwareStyleClient, focusStyleName is read-only in this class.
		 */
		public function set focusStyleName(styleName:String):void
		{
			return;
		}
		
		/**
		 * Style name to be used when window is out of focus. Defined by IMDIFocusAwareStyleClient.
		 * Contains logic to choose between maximize and restore styles.
		 */
		public function get noFocusStyleName():String
		{
			return (window.maximized) ? restoreBtnNoFocusStyleName : maximizeBtnNoFocusStyleName;
		}
		
		/**
		 * Only present to satisfy IMDIFocusAwareStyleClient, focusStyleName is read-only in this class.
		 */
		public function set noFocusStyleName(styleName:String):void
		{
			return;
		}
		
		/**
		 * Style name to be used when window is floating and out of focus.
		 * If noFocus style has not been set the regular style will be returned.
		 */
		public function get maximizeBtnNoFocusStyleName():String
		{
			return (_maximizeBtnNoFocusStyleName == null) ? maximizeBtnStyleName : _maximizeBtnNoFocusStyleName;
		}
		
		public function set maximizeBtnNoFocusStyleName(styleName:String):void
		{
			_maximizeBtnNoFocusStyleName = styleName;
		}
		
		/**
		 * Style name to be used when window is maximized and out of focus.
		 * If noFocus style has not been set the regular style will be returned.
		 */
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