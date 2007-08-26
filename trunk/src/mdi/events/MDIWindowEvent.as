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

package mdi.events
{
	import flash.events.Event;
	
	import mdi.containers.MDIWindow;

	public class MDIWindowEvent extends Event
	{	
		public static const SHOW:String = "mdiSHOW";
		public static const FOCUS_IN:String = "mdiFocusIn";
		public static const FOCUS_OUT:String = "mdiFocusOut";
		public static const MOVE:String = "mdiMove";
		public static const RESIZE_START:String = "mdiResizeStart";
		public static const RESIZE:String = "mdiResize";
		public static const RESIZE_END:String = "mdiResizeEnd";
		
		public static const MINIMIZE:String = "mdiMinimize";
		public static const RESTORE:String = "mdiRestore";
		public static const MAXIMIZE:String = "mdiMaximize";
		public static const CLOSE:String = "mdiClose";
		
		public var window:MDIWindow;
		
		public function MDIWindowEvent(type:String, window:MDIWindow, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
			this.window = window;
		}
		
		override public function clone():Event
		{
			return new MDIWindowEvent(type, window, bubbles, cancelable);
		}
	}
}