package flexmdi.effects.effectsLib
{
	import flash.geom.Point;
	
	import flexmdi.containers.MDIWindow;
	import flexmdi.effects.MDIEffectsDescriptorBase;
	import flexmdi.managers.MDIManager;
	
	import mx.effects.Effect;
	import mx.effects.Parallel;
	import mx.effects.Resize;
	
	import mx.events.EffectEvent;
	import mx.effects.Move;
	
	public class MDIRelationalEffects extends MDIVistaEffectsDescriptor
	{
		
		
		override public function getMinimizeEffect(window:MDIWindow, manager:MDIManager, moveTo:Point=null):Effect
		{
			
			var parallel:Parallel = super.getMinimizeEffect(window,manager,moveTo) as Parallel;
			
			parallel.addEventListener(EffectEvent.EFFECT_END, function():void {manager.tile(true,10); } );
			
			
			return parallel;
		}
		
		override public function getRestoreEffect(window:MDIWindow, manager:MDIManager, moveTo:Point=null):Effect
		{
			var parallel:Parallel = super.getRestoreEffect(window,manager,moveTo) as Parallel;
			
			parallel.addEventListener(EffectEvent.EFFECT_START, function():void {manager.tile(true,10); } );
			
			return parallel;
		}
		
		override public function reTileMinWindowsEffect(window:MDIWindow, manager:MDIManager, moveTo:Point):Effect
		{
			var move:Move = super.reTileMinWindowsEffect(window,manager,moveTo) as Move;
			manager.bringToFront(window);
			return move;
		}
		
		
		
	}
}