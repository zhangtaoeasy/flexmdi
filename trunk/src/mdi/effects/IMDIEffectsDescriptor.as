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
		function playMaximizeEffects(window:MDIWindow,manager:MDIManager):void
		function playCloseEffects(window:MDIWindow,manager:MDIManager,callBack:Function):void
		
		
		//group events
		function playTileEffects(windows:Array,manager:MDIManager):void
		function playCascadeEffects(window:MDIWindow,manager:MDIManager,moveTo:Point):void
		
	
		
	}
}