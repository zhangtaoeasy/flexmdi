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
	import flash.geom.Point;
	
	import mdi.containers.MDIWindow;
	import mdi.effects.effectClasses.MDIGroupEffectItem;
	import mdi.managers.MDIManager;
	
	import mx.containers.Panel;
	import mx.effects.Effect;
	import mx.effects.Move;
	

	
	public class MDIEffectsDescriptorBase implements IMDIEffectsDescriptor
	{
		public function getFocusInEffect(window:MDIWindow,manager:MDIManager):Effect
		{
			return new Effect();
		}
		
		public function getFocusOutEffect(window:MDIWindow,manager:MDIManager):Effect
		{
			return new Effect();
		}
		
		public function getShowEffect(window:MDIWindow,manager:MDIManager):Effect
		{
			return new Effect();
		}
		
		public function getMoveEffect(window:MDIWindow,manager:MDIManager):Effect
		{
			return new Effect();
		}
		
		public function getResizeEffect(window:MDIWindow,manager:MDIManager):Effect
		{
			return new Effect();
		}
		
		public function getMinimizeEffect(window:MDIWindow, manager:MDIManager, moveTo:Point = null):Effect
		{
			window.height = window.minimizeHeight;
			window.width = window.minWidth;
			if(moveTo != null)
			{
				window.x = moveTo.x;
				window.y = moveTo.y;
			}
			return new Effect();
		}
		
		public function getRestoreEffect(window:MDIWindow, manager:MDIManager, moveTo:Point = null):Effect
		{
			window.height = window.dragStartPanelHeight;
			window.width = window.dragStartPanelWidth;
			if(moveTo != null)
			{
				window.x = moveTo.x;
				window.y = moveTo.y;
			}
			return new Effect();
		}
		
		public function reTileMinWindowsEffect(window:MDIWindow, manager:MDIManager, moveTo:Point):Effect
		{
			window.x = moveTo.x;
			window.y = moveTo.y;
			return new Effect();
		}
		
		
		public function getMaximizeEffect(window:MDIWindow,manager:MDIManager,bottomOffset:Number = 0):Effect
		{
			window.height = manager.container.height - bottomOffset;
			window.width = manager.container.width;
			window.x = 0;
			window.y = 0;
			return new Effect();
		}
		
		public function getCloseEffect(window:MDIWindow, manager:MDIManager):Effect
		{
			return new Effect();
		}
		
		public function getTileEffect(items:Array,manager:MDIManager):Effect
		{
			for each(var item : MDIGroupEffectItem  in items)
			{	
				manager.bringToFront(item.window);
				var move : Move = new Move(item.window);
					move.xTo = item.moveTo.x;
					move.yTo = item.moveTo.y;
					move.play();
			}
			return new Effect();
		}
		
		public function getCascadeEffect(items:Array,manager:MDIManager):Effect
		{
			for each(var item : MDIGroupEffectItem  in items)
			{	

				var move : Move = new Move(item.window);
					move.xTo = item.moveTo.x;
					move.yTo = item.moveTo.y;
					move.play();
			}
			return new Effect();
		}		
	}
}