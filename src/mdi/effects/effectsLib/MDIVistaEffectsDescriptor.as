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
	
	public class MDIVistaEffectsDescriptor extends MDIBaseEffects implements IMDIEffectsDescriptor
	{
		
		override public function playShowEffects(window:MDIWindow,manager:MDIManager):void
		{

			var parallel : Parallel = new Parallel(window);

			var blurSequence : Sequence = new Sequence(window);

			var blurOut : Blur = new Blur();
				blurOut.blurXFrom = 0;
				blurOut.blurYFrom = 0;
				blurOut.blurXTo= 5;
				blurOut.blurYTo = 5;
				blurOut.duration = 100;
			
			blurSequence.addChild(blurOut);
			
			var blurIn : Blur = new Blur(window);
				blurIn.blurXFrom = 10;
				blurIn.blurYFrom = 5;
				blurIn.blurXTo= 0;
				blurIn.blurYTo = 0;
				
				blurIn.duration = 50;
			
			blurSequence.addChild(blurIn);
			
			
			parallel.addChild(blurSequence);
			
			var resizeSequence : Sequence = new Sequence(window);
			
		 	var expand : Resize = new Resize(window);
		 		expand.heightBy = 10;
		 		expand.widthBy = 10;
				expand.duration = 100;
				
			resizeSequence.addChild(expand);
			
			var contract : Resize = new Resize(window);
				contract.heightBy = -10;
				contract.widthBy = -10;
				contract.duration = 50;
				
			resizeSequence.addChild(contract);
			
			parallel.addChild(resizeSequence);
			
			parallel.play();
			
		}
		
		
	
		
	}
}