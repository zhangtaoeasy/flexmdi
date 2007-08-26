package mdi.containers
{
	import mdi.managers.MDIManager;
	
	import mx.containers.Canvas;
	import mx.events.FlexEvent;
	import mx.core.UIComponent;

	public class MDICanvas extends Canvas
	{
		public var mdiManager:MDIManager;
		
		public function MDICanvas()
		{
			super();
			mdiManager = new MDIManager(this);
			addEventListener(FlexEvent.CREATION_COMPLETE, onCreationComplete);
		}
		
		private function onCreationComplete(event:FlexEvent):void
		{
			for each(var child:UIComponent in getChildren())
			{
				if(child is MDIWindow)
				{
					mdiManager.add(child as MDIWindow);
				}
			}
			removeEventListener(FlexEvent.CREATION_COMPLETE, onCreationComplete);
		}
	}
}