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
	import mdi.effects.IMDIEffectsDescriptor;
	import mdi.managers.MDIManager;

	import flash.geom.Point;

	import flash.geom.Point;
	import mx.containers.Panel;
	import mx.effects.Move;
	

	
	public class MDIBaseEffects implements IMDIEffectsDescriptor
	{
		

		public function playFocusInEffects(window:MDIWindow,manager:MDIManager):void
		{
			
		}
		
		public function playFocusOutEffects(window:MDIWindow,manager:MDIManager):void
		{
			
		}
		
		public function playShowEffects(window:MDIWindow,manager:MDIManager):void
		{
			
		}
		
		public function playMoveEffects(window:MDIWindow,manager:MDIManager):void
		{
			
		}
		public function playResizeEffects(window:MDIWindow,manager:MDIManager):void
		{
			
		}
		public function playMinimizeEffects(window:MDIWindow, manager:MDIManager, moveTo:Point = null):void
		{
			window.height = window.minimizeHeight;
			window.width = window.minWidth;
			if(moveTo != null)
			{
				window.x = moveTo.x;
				window.y = moveTo.y;
			}
		}
		
		public function playRestoreEffects(window:MDIWindow, manager:MDIManager, moveTo:Point = null):void
		{
			window.height = window.dragStartPanelHeight;
			window.width = window.dragStartPanelWidth;
			if(moveTo != null)
			{
				window.x = moveTo.x;
				window.y = moveTo.y;
			}
		}
		
		public function reTileMinWindowsEffects(window:MDIWindow, manager:MDIManager, moveTo:Point):void
		{
			window.x = moveTo.x;
			window.y = moveTo.y;
		}
		
		
		public function playMaximizeEffects(window:MDIWindow,manager:MDIManager):void
		{
			window.height = manager.container.height;
			window.width = manager.container.width;
			window.x = 0;
			window.y = 0;
		}
		public function playCloseEffects(window:MDIWindow,manager:MDIManager,callback:Function):void
		{

			callback.call(window,window);	

		}
		
		public function playTileEffects(window:MDIWindow,manager:MDIManager,moveTo:Point):void
		{
			var move : Move = new Move(window);
				move.xTo = moveTo.x;
				move.yTo = moveTo.y;
				move.play();
		}
		public function playCascadeEffects(window:MDIWindow,manager:MDIManager,moveTo:Point):void
		{
			var move : Move = new Move(window);
				move.xTo = moveTo.x;
				move.yTo = moveTo.y;
				move.play();
		}
		
		
	}
}