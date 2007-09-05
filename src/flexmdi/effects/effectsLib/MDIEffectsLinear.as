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

package flexmdi.effects.effectsLib
{
	import flash.geom.Point;
	
	import flexmdi.containers.MDIWindow;
	import flexmdi.effects.IMDIEffectsDescriptor;
	import flexmdi.effects.MDIEffectsDescriptorBase;
	import flexmdi.effects.effectClasses.MDIGroupEffectItem;
	import flexmdi.managers.MDIManager;
	
	import mx.effects.Blur;
	import mx.effects.Effect;
	import mx.effects.Move;
	import mx.effects.Parallel;
	import mx.effects.Resize;
	import mx.effects.Rotate;
	import mx.effects.Sequence;
	import mx.effects.WipeDown;
	import mx.events.EffectEvent;
	import mx.effects.AnimateProperty;
	import mx.effects.Dissolve;

	public class MDIEffectsLinear extends MDIEffectsDescriptorBase implements IMDIEffectsDescriptor
	{		
		override public function getShowEffect(window:MDIWindow, manager:MDIManager):Effect
		{
			var p:Parallel = new Parallel(window);
			
			var resize:Resize = new Resize(window);
			resize.widthTo = window.width;
			resize.heightTo = window.height;
			resize.widthFrom = resize.heightFrom = 1;
			resize.duration = 100;
			p.addChild(resize);
			
			var d:Dissolve = new Dissolve(window);
			d.alphaFrom = 0;
			d.alphaTo = 1;
			d.duration = 100;
			p.addChild(d);
			
			return p;
		}
		
		override public function getCloseEffect(window:MDIWindow, manager:MDIManager):Effect
		{
			window.minWidth = window.minHeight = 1;
			
			var resize:Resize = new Resize(window);
			resize.widthTo = resize.heightTo = 1;
			resize.duration = 100;
			return resize;
		}
		
		private function cascadeEasingFunction(t:Number, b:Number, c:Number, d:Number):Number 
		{
			var ts:Number=(t/=d)*t;
  			var tc:Number=ts*t;
  			return b+c*(33*tc*ts + -106*ts*ts + 126*tc + -67*ts + 15*t);
		}
		
		override public function getCascadeEffect(items:Array,manager:MDIManager):Effect
		{
			var parallel:Parallel = new Parallel();
			
			for each(var item:MDIGroupEffectItem  in items)
			{
				var move:Move = new Move(item.window);
					move.xTo = item.moveTo.x;
					move.yTo = item.moveTo.y;
					move.easingFunction = this.cascadeEasingFunction;
					move.duration = 200;
					parallel.addChild(move);
			}
			
			return parallel;
		}
		
		override public function getTileEffect(items:Array,manager:MDIManager):Effect
		{			
			var sequence:Sequence = new Sequence();
			
			for each(var item:MDIGroupEffectItem  in items)
			{	
				manager.bringToFront(item.window);
				var move:Move = new Move(item.window);
					move.xTo = item.moveTo.x;
					move.yTo = item.moveTo.y;

				sequence.addChild(move);
				item.setWindowSize();
			}
			
			sequence.duration = 100;
			return sequence;
		}		
	
		override public function getMinimizeEffect(window:MDIWindow, manager:MDIManager, moveTo:Point=null):Effect
		{
			var seq:Sequence = new Sequence();
			
			var resizeW:Resize = new Resize(window);
			resizeW.widthTo = window.minWidth;
			resizeW.duration = 100;
			seq.addChild(resizeW);
			
			var resizeH:Resize = new Resize(window);
			resizeH.heightTo = window.minimizeHeight;
			resizeH.duration = 100;
			seq.addChild(resizeH);
			
			var moveX:Move = new Move(window);
			moveX.xTo = moveTo.x;
			moveX.duration = 100;
			seq.addChild(moveX);
			
			var moveY:Move = new Move(window);
			moveY.yTo = moveTo.y;
			moveY.duration = 100;
			seq.addChild(moveY);
			
			seq.end();
			return seq;
		}
		
		override public function getRestoreEffect(window:MDIWindow, manager:MDIManager, moveTo:Point=null):Effect
		{
			var seq:Sequence = new Sequence();
			
			var moveY:Move = new Move(window);
			moveY.yTo = moveTo.y;
			moveY.duration = 100;
			seq.addChild(moveY);
			
			var moveX:Move = new Move(window);
			moveX.xTo = moveTo.x;
			moveX.duration = 100;
			seq.addChild(moveX);
			
			var resizeW:Resize = new Resize(window);
			resizeW.widthTo = window.dragStartPanelWidth;
			resizeW.duration = 100;
			seq.addChild(resizeW);
			
			var resizeH:Resize = new Resize(window);
			resizeH.heightTo = window.dragStartPanelHeight;
			resizeH.duration = 100;
			seq.addChild(resizeH);
			
			seq.end();
			return seq;
		}
		
		override public function getMaximizeEffect(window:MDIWindow, manager:MDIManager, bottomOffset:Number = 0):Effect
		{
			var seq:Sequence = new Sequence(window);
			
			var moveX:Move = new Move(window);
			moveX.xTo = 0;
			moveX.duration = 100;
			seq.addChild(moveX);
			
			var moveY:Move = new Move(window);
			moveY.yTo = 0;
			moveY.duration = 100;
			seq.addChild(moveY);
			
			var resizeW:Resize = new Resize(window);
			resizeW.widthTo = manager.container.width;
			resizeW.duration = 100;
			seq.addChild(resizeW);
			
			var resizeH:Resize = new Resize(window);
			resizeH.heightTo = manager.container.height - bottomOffset;
			resizeH.duration = 100;
			seq.addChild(resizeH);
			
			seq.end();
			return seq;
		}
		
		override public function reTileMinWindowsEffect(window:MDIWindow, manager:MDIManager, moveTo:Point):Effect
		{
			var move:Move = new Move(window);
			move.xTo = moveTo.x;
			move.yTo = moveTo.y;
			move.duration = 300;
			move.end();
			return move;
		}		
	}
}