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

package mdi.effects.effectsLib
{
	import mdi.containers.MDIWindow;
	import mdi.effects.IMDIEffectsDescriptor;
	import mdi.managers.MDIManager;

	import mx.effects.Blur;
	import mx.effects.Sequence;
	import mx.effects.Parallel;
	import mx.effects.Resize;
	import mdi.effects.MDIBaseEffects;
	import mx.events.EffectEvent;
	import mx.effects.WipeDown;
	import flash.geom.Point;
	import mx.effects.Rotate;
	import mx.effects.Move;

	import mdi.effects.effectClasses.MDIGroupEffectItem;

	public class MDIVistaEffectsDescriptor extends MDIBaseEffects implements IMDIEffectsDescriptor
	{
	
		
		override public function playShowEffects(window:MDIWindow,manager:MDIManager):void
		{
			
			var parallel : Parallel = new Parallel(window);

			var blurSequence : Sequence = new Sequence();

			var blurOut : Blur = new Blur();
				blurOut.blurXFrom = 0;
				blurOut.blurYFrom = 0;
				blurOut.blurXTo= 10;
				blurOut.blurYTo = 10;
			
			
			blurSequence.addChild(blurOut);
			
			var blurIn : Blur = new Blur();
				blurIn.blurXFrom = 10;
				blurIn.blurYFrom = 10;
				blurIn.blurXTo= 0;
				blurIn.blurYTo = 0;
				
			
			blurSequence.addChild(blurIn);

			parallel.addChild(blurSequence);
	
			
			parallel.duration = 200;
			parallel.play();
			
		}
		
		override public function playCloseEffects(window:MDIWindow,manager:MDIManager,callBack:Function):void
		{
			var blur : Blur = new Blur(window);
				blur.blurXFrom = 0;
				blur.blurYFrom = 0;
				blur.blurXTo = 10;
				blur.blurYTo = 10;
				blur.duration = 200;
				blur.addEventListener(EffectEvent.EFFECT_END, function():void {callBack.call(window,window);});
				blur.play();

		}
		
		private function cascadeEasingFunction(t:Number, b:Number, c:Number, d:Number):Number 
		{
			var ts:Number=(t/=d)*t;
  			var tc:Number=ts*t;
  			return b+c*(33*tc*ts + -106*ts*ts + 126*tc + -67*ts + 15*t);
		}
		
		override public function playCascadeEffects(items:Array,manager:MDIManager):void
		{

			for each(var item : MDIGroupEffectItem  in items)
			{	

				var move : Move = new Move(item.window);
					move.xTo = item.moveTo.x;
					move.yTo = item.moveTo.y;
					move.easingFunction = this.cascadeEasingFunction;
					move.duration = 200;
					move.play();
			}


		}
		
		override public function playTileEffects(items:Array,manager:MDIManager):void
		{
			
			var sequence : Sequence = new Sequence();
			
			for each(var item : MDIGroupEffectItem  in items)
			{	
				manager.bringToFront(item.window);
				var move : Move = new Move(item.window);
					move.xTo = item.moveTo.x;
					move.yTo = item.moveTo.y;

				sequence.addChild( move );
				item.setWindowSize();
			}
			
			sequence.duration = 100;
			sequence.play();

		}
		
	
		override public function playMinimizeEffects(window:MDIWindow, manager:MDIManager, moveTo:Point=null):void
		{
			var parallel : Parallel = new Parallel(window);
			
			var move:Move = new Move(window);
			move.xTo = moveTo.x;
			move.yTo = moveTo.y;
			move.duration = 300;
			parallel.addChild(move);
			
			var resize:Resize = new Resize(window);
			resize.heightTo = window.minimizeHeight;
			resize.widthTo = window.minWidth;
			resize.duration = 300;
			parallel.addChild(resize);
			
			parallel.end();
			parallel.play();
		}
		
		override public function playRestoreEffects(window:MDIWindow, manager:MDIManager, moveTo:Point=null):void
		{
			var parallel : Parallel = new Parallel(window);
			
			var move:Move = new Move(window);
			move.xTo = moveTo.x;
			move.yTo = moveTo.y;
			move.duration = 300;
			parallel.addChild(move);
			
			var resize:Resize = new Resize(window);
			resize.heightTo = window.dragStartPanelHeight;
			resize.widthTo = window.dragStartPanelWidth;
			resize.duration = 300;
			parallel.addChild(resize);
			
			parallel.end();
			parallel.play();
		}
		
		override public function playMaximizeEffects(window:MDIWindow, manager:MDIManager, bottomOffset:Number = 0):void
		{
			var parallel : Parallel = new Parallel(window);
			
			var move:Move = new Move(window);
			move.xTo = 0;
			move.yTo = 0;
			move.duration = 300;
			parallel.addChild(move);
			
			var resize:Resize = new Resize(window);
			resize.heightTo = manager.container.height - bottomOffset;
			resize.widthTo = manager.container.width;
			resize.duration = 300;
			parallel.addChild(resize);
			
			parallel.end();
			parallel.play();
		}
		
		override public function reTileMinWindowsEffects(window:MDIWindow, manager:MDIManager, moveTo:Point):void
		{
			var move:Move = new Move(window);
			move.xTo = moveTo.x;
			move.yTo = moveTo.y;
			move.duration = 300;
			move.end();
			move.play();
		}
		
		
	
		
	}
}