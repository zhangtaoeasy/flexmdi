package mdi.effects
{
	import mdi.containers.MDIWindow;
	import mdi.effects.IMDIEffectsDescriptor;
	import mdi.managers.MDIManager;
	
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
		public function playMinimizeEffects(window:MDIWindow,manager:MDIManager):void
		{
			
		}
		public function playMaximizeEffects(window:MDIWindow,manager:MDIManager):void
		{
			
		}
		public function playCloseEffects(window:MDIWindow,manager:MDIManager,callBack:Function):void
		{
			callback(window);	
		}
		
		public function playTileEffects(windows:Array,manager:MDIManager):void
		{
			
		}
		public function playCascadeEffects(windows:Array,manager:MDIManager):void
		{
			
		}
		
		
	}
}