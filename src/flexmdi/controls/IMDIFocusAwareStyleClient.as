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
	/**
	 * Marker interface for components that switch styles based on whether they are in focus.
	 * Focus refers to topmost window, not focus as it relates to keyboard input and such.
	 * MDIWindow and MDIMaximizeRestoreButton are implementors, custom window controls can optionally implement as well.
	 */
	public interface IMDIFocusAwareStyleClient
	{
		function get focusStyleName():String;
		function set focusStyleName(styleName:String):void;
		
		function get noFocusStyleName():String;
		function set noFocusStyleName(styleName:String):void;
	}
}