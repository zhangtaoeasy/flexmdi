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
			
			var resizeSequence : Sequence = new Sequence();
			
		 	var expand : Resize = new Resize();
		 		expand.heightBy = 20;
		 		expand.widthBy = 20;
				
				
			resizeSequence.addChild(expand);
			
			var contract : Resize = new Resize();
				contract.heightBy = -10;
				contract.widthBy = -10;
				
				
			resizeSequence.addChild(contract);
			
			parallel.addChild(resizeSequence);
			
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
				blur.duration = 150;
				blur.addEventListener(EffectEvent.EFFECT_END, function():void {callBack.call(window,window);});
				blur.play();

		}
		
		private function cascadeEasingFunction(t:Number, b:Number, c:Number, d:Number):Number 
		{
  			var ts:Number=(t/=d)*t;
  			var tc:Number=ts*t;
  			return b+c*(33*tc*ts + -106*ts*ts + 126*tc + -67*ts + 15*t);
		}
		
		override public function playCascadeEffects(window:MDIWindow,manager:MDIManager,moveTo:Point):void
		{

			var move : Move = new Move(window);
				move.xTo = moveTo.x;
				move.yTo = moveTo.y;
				move.easingFunction = this.cascadeEasingFunction;
				move.duration = 500;
				move.play();
	
		}
	
		
	}
}