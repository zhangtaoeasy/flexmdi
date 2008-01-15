package
{
	import flexmdi.containers.MDIWindowControlsContainer;
	
	import mx.core.ContainerLayout;

	public class MacOS9WindowControls extends MDIWindowControlsContainer
	{
		public function MacOS9WindowControls()
		{
			layout = ContainerLayout.ABSOLUTE;
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			minimizeBtn.width = 13;
			minimizeBtn.height = 13;
			minimizeBtn.styleName = "minimizeBtnMac";
			
			maximizeRestoreBtn.width = 13;
			maximizeRestoreBtn.height = 13;
			maximizeRestoreBtn.maximizeBtnStyleName = "increaseBtnMac";
			maximizeRestoreBtn.restoreBtnStyleName = "decreaseBtnMac";
			maximizeRestoreBtn.styleName = maximizeRestoreBtn.maximizeBtnStyleName;
			
			closeBtn.width = 13;
			closeBtn.height = 13;
			closeBtn.styleName = "closeBtnMac";
		}
		
		override protected function updateDisplayList(w:Number, h:Number):void
		{
			super.updateDisplayList(w, h);
			
			this.setActualSize(window.width, window.titleBarOverlay.height);
			this.x = this.y = 0;
			
			closeBtn.x = Number(window.getStyle("borderThicknessLeft"));
			closeBtn.y = (window.titleBarOverlay.height - closeBtn.height) / 2;
			
			minimizeBtn.x = window.width - minimizeBtn.width - Number(window.getStyle("borderThicknessRight"));
			minimizeBtn.y = (window.titleBarOverlay.height - closeBtn.height) / 2;
			
			maximizeRestoreBtn.x = minimizeBtn.x - maximizeRestoreBtn.width - 5;
			maximizeRestoreBtn.y = (window.titleBarOverlay.height - closeBtn.height) / 2;
			
			window.getTitleTextField().x = (window.width - window.getTitleTextField().textWidth) / 2;
			if(window.getTitleIconObject())
			{
				window.getTitleIconObject().x = window.getTitleTextField().x - window.getTitleIconObject().width - 4;
			}
		}
	}
}