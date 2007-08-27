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
	
	public class MDIVistaEffectsDescriptor extends MDIBaseEffects implements IMDIEffectsDescriptor
	{
	
		
		override public function playShowEffects(window:MDIWindow,manager:MDIManager,destination:Point):void
		{
			
			var parallel : Parallel = new Parallel(window);

			var blurSequence : Sequence = new Sequence(window);

			var blurOut : Blur = new Blur();
				blurOut.blurXFrom = 0;
				blurOut.blurYFrom = 0;
				blurOut.blurXTo= 10;
				blurOut.blurYTo = 10;
			
			
			blurSequence.addChild(blurOut);
			
			var blurIn : Blur = new Blur(window);
				blurIn.blurXFrom = 10;
				blurIn.blurYFrom = 10;
				blurIn.blurXTo= 0;
				blurIn.blurYTo = 0;
				
			
			blurSequence.addChild(blurIn);
			
			
			parallel.addChild(blurSequence);
			
			var resizeSequence : Sequence = new Sequence(window);
			
		 	var expand : Resize = new Resize(window);
		 		expand.heightBy = 20;
		 		expand.widthBy = 20;
				
				
			resizeSequence.addChild(expand);
			
			var contract : Resize = new Resize(window);
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
		
		override public function playCascadeEffects(windows:Array,manager:MDIManager,callBack:Function):void
		{
			trace("play cascade effects");
			
		}
	
		
	}
}