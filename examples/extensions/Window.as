package extensions
{
	import flexmdi.containers.MDIWindow;
	import mx.controls.Button;
	import mx.events.MenuEvent;
	import mx.controls.Menu;
	import flash.events.MouseEvent;
	

	
	
	public class Window extends MDIWindow
	{
		
		public var menuBtn:Button;
		
		public function Window():void
		{
			
		}
		
		override protected function createChildren():void
		{
			
			// make sure you call super.createChildren() 
			super.createChildren();
			
			// create your button
			menuBtn = new Button();
			menuBtn.width = 11;
			menuBtn.height = 10;
			menuBtn.styleName = "menuBtn";
			menuBtn.addEventListener(MouseEvent.CLICK,onClickMenuBtn);
			// the index will place the button where you want in relation to other windows
			// with 0 being on theh left;
			this.addControl(menuBtn,0);		
		}
		
		private function onClickMenuBtn(event:MouseEvent):void
		{
			var menu : Menu = Menu.createMenu(this,this.mdp,false);
				menu.labelField = "@label";
				menu.addEventListener(MenuEvent.ITEM_CLICK,onClickMenu);
			menu.show( event.stageX - 5, event.stageY + 5 );
		}
		
		private function onClickMenu(event:MenuEvent):void
		{
			// implement super cool button logic here
			
		}
		
		
		private var mdp : XML = <root>
            <menuitem label="Pin To Desktop" eventName="pin"/>
            <menuitem label="Edit Settings" eventName="settings"/>
            
        </root>;
		
	}
}