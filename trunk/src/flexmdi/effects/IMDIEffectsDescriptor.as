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

package flexmdi.effects
{
	import flash.geom.Point;
	
	import flexmdi.containers.MDIWindow;
	import flexmdi.managers.MDIManager;
	
	import mx.effects.Effect;
	
	public interface IMDIEffectsDescriptor
	{
		function getMinimizeEffect(window:MDIWindow, manager:MDIManager, moveTo:Point = null):Effect
	
		function getRestoreEffect(window:MDIWindow, manager:MDIManager, moveTo:Point = null):Effect
		
		function getMaximizeEffect(window:MDIWindow, manager:MDIManager, bottomOffset:Number = 0):Effect
	
		function getCloseEffect(window:MDIWindow, manager:MDIManager):Effect
		
		function getFocusInEffect(window:MDIWindow, manager:MDIManager):Effect
	
		function getFocusOutEffect(window:MDIWindow, manager:MDIManager):Effect
	
		function getShowEffect(window:MDIWindow, manager:MDIManager):Effect
	
		function getMoveEffect(window:MDIWindow, manager:MDIManager):Effect
	
		function getResizeEffect(window:MDIWindow, manager:MDIManager):Effect
	
		function reTileMinWindowsEffect(window:MDIWindow, manager:MDIManager, moveTo:Point):Effect	
	
		//group window effects
		
		function getTileEffect(items:Array, manager:MDIManager):Effect
		
		function getCascadeEffect(items:Array, manager:MDIManager):Effect		
	}
}