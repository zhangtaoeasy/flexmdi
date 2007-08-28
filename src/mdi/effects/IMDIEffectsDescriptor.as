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

package mdi.effects
{
	import mdi.containers.MDIWindow;
	import mdi.managers.MDIManager;
	import flash.geom.Point;
	
	public interface IMDIEffectsDescriptor
	{	
		function playFocusInEffects(window:MDIWindow,manager:MDIManager):void
	
		function playFocusOutEffects(window:MDIWindow,manager:MDIManager):void
	
		function playShowEffects(window:MDIWindow,manager:MDIManager):void
	
		function playMoveEffects(window:MDIWindow,manager:MDIManager):void
	
		function playResizeEffects(window:MDIWindow,manager:MDIManager):void
	
		function playMinimizeEffects(window:MDIWindow,manager:MDIManager,moveTo:Point=null):void
	
		function playRestoreEffects(window:MDIWindow,manager:MDIManager,moveTo:Point=null):void
		
		function reTileMinWindowsEffects(window:MDIWindow,manager:MDIManager,moveTo:Point):void
	
		function playMaximizeEffects(window:MDIWindow,manager:MDIManager,bottomOffset:Number=0):void
	
		function playCloseEffects(window:MDIWindow,manager:MDIManager,callBack:Function):void
	
	
	
		//group window effects
		
		function playTileEffects(items:Array,manager:MDIManager):void
		
		function playCascadeEffects(items:Array,manager:MDIManager):void
		
	}
}