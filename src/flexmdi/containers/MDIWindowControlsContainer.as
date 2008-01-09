package flexmdi.containers
{
	import flash.display.DisplayObject;
	
	import flexmdi.controls.MDIMaximizeRestoreButton;
	
	import mx.controls.Button;
	import mx.core.ContainerLayout;
	import mx.core.LayoutContainer;

	public class MDIWindowControlsContainer extends LayoutContainer
	{
		public var window:MDIWindow;
		public var minimizeBtn:Button;
		public var maximizeRestoreBtn:MDIMaximizeRestoreButton;
		public var closeBtn:Button;
		
		public function MDIWindowControlsContainer()
		{
			layout = ContainerLayout.HORIZONTAL;
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			minimizeBtn = new Button();
			minimizeBtn.width = 10;
			minimizeBtn.height = 10;
			minimizeBtn.styleName = "mdiWindowMinimizeBtn";
			minimizeBtn.buttonMode = true;
			addChild(minimizeBtn);
			
			maximizeRestoreBtn = new MDIMaximizeRestoreButton(window);
			maximizeRestoreBtn.width = 10;
			maximizeRestoreBtn.height = 10;
			maximizeRestoreBtn.maximizeBtnStyleName = "mdiWindowMaximizeBtn";
			maximizeRestoreBtn.restoreBtnStyleName = "mdiWindowRestoreBtn";
			maximizeRestoreBtn.styleName = maximizeRestoreBtn.maximizeBtnStyleName;
			maximizeRestoreBtn.buttonMode = true;
			addChild(maximizeRestoreBtn);
			
			closeBtn = new Button();
			closeBtn.width = 10;
			closeBtn.height = 10;
			closeBtn.styleName = "mdiWindowCloseBtn";
			closeBtn.buttonMode = true;
			addChild(closeBtn);
		}
		
		override protected function updateDisplayList(w:Number, h:Number):void
		{
			super.updateDisplayList(w, h);
			
			var minX:Number = 9999;
			var minY:Number = 9999;
			var maxX:Number = -9999;
			var maxY:Number = -9999;
			for each(var child:DisplayObject in this.getChildren())
			{
				minX = Math.min(minX, child.x);
				minY = Math.min(minY, child.y);
				maxX = Math.max(maxX, child.x + child.width);
				maxY = Math.max(maxY, child.y + child.height);
			}
			this.setActualSize(maxX - minX, maxY - minY);
			
			this.x = window.width - this.width - Number(window.getStyle("borderThicknessRight"));
			this.y = (window.titleBarOverlay.height - this.height) / 2;
		}
	}
}