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
			window.height = window.minimizeSize;
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
		
		
		public function playMaximizeEffects(window:MDIWindow,manager:MDIManager):void
		{
			
		}
		public function playCloseEffects(window:MDIWindow,manager:MDIManager,callBack:Function):void
		{

			callback.call(window,window);	

		}
		
		public function playTileEffects(windows:Array,manager:MDIManager):void
		{
			
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