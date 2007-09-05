package flexmdi.effects.effectClasses
{
	import flexmdi.containers.MDIWindow;
	import flash.geom.Point;
	
	public class MDIGroupEffectItem
	{
		
		public var window : MDIWindow;
		public var moveTo : Point;
		
		public var heightTo : int;
		public var heightFrom : int;
		public var widthTo : int;
		public var widthFrom : int;
	
		public function MDIGroupEffectItem(window:MDIWindow):void
		{
			this.window = window;
		}
		
		public function setWindowSize():void
		{
			this.window.width = this.widthTo;
			this.window.height = this.heightTo;
		}
		
	}
}