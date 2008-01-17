/*
Copyright (c) 2007 FlexMDI Contributors.  See:
    http://code.google.com/p/flexmdi/wiki/ProjectContributors

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/

package flexmdi.containers
{
	import flash.display.DisplayObject;
	
	import flexmdi.controls.MDIMaximizeRestoreButton;
	
	import mx.controls.Button;
	import mx.core.ContainerLayout;
	import mx.core.LayoutContainer;
	import mx.core.UITextField;

	public class MDIWindowControlsContainer extends LayoutContainer
	{
		public var window:MDIWindow;
		public var minimizeBtn:Button;
		public var maximizeRestoreBtn:MDIMaximizeRestoreButton;
		public var closeBtn:Button;
		
		/**
		 * Base class to hold window controls. Since it inherits from LayoutContainer, literally any layout
		 * can be accomplished by manipulating or subclassing this class.
		 */
		public function MDIWindowControlsContainer()
		{
			layout = ContainerLayout.HORIZONTAL;
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			if(!minimizeBtn)
			{
				minimizeBtn = new Button();
				minimizeBtn.width = 10;
				minimizeBtn.height = 10;
				minimizeBtn.styleName = "mdiWindowMinimizeBtn";
				minimizeBtn.buttonMode = true;
				addChild(minimizeBtn);
			}
			
			if(!maximizeRestoreBtn)
			{
				maximizeRestoreBtn = new MDIMaximizeRestoreButton(window);
				maximizeRestoreBtn.width = 10;
				maximizeRestoreBtn.height = 10;
				maximizeRestoreBtn.maximizeBtnStyleName = "mdiWindowMaximizeBtn";
				maximizeRestoreBtn.restoreBtnStyleName = "mdiWindowRestoreBtn";
				maximizeRestoreBtn.styleName = maximizeRestoreBtn.maximizeBtnStyleName;
				maximizeRestoreBtn.buttonMode = true;
				addChild(maximizeRestoreBtn);
			}
			
			if(!closeBtn)
			{
				closeBtn = new Button();
				closeBtn.width = 10;
				closeBtn.height = 10;
				closeBtn.styleName = "mdiWindowCloseBtn";
				closeBtn.buttonMode = true;
				addChild(closeBtn);
			}
		}
		
		override protected function updateDisplayList(w:Number, h:Number):void
		{
			super.updateDisplayList(w, h);
			
			// since we're in rawChildren we don't get measured and laid out by our parent
			// this routine finds the bounds of our children and sets our size accordingly
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
			
			// now that we're sized we set our position
			// right aligned, respecting border width
			this.x = window.width - this.width - Number(window.getStyle("borderThicknessRight"));
			// vertically centered
			this.y = (window.titleBarOverlay.height - this.height) / 2;
			
			// lay out the title field and icon (if present)
			var tf:UITextField = window.getTitleTextField();
			var icon:DisplayObject = window.getTitleIconObject();
			
			tf.x = Number(window.getStyle("borderThicknessLeft"));
			
			if(icon)
			{
				tf.x = icon.x + icon.width + 4;
			}
			
			// ghetto truncation
			if(!window.minimized)
			{
				tf.width = this.x - tf.x;
			}
			else
			{
				tf.width = window.width - tf.x - 4;
			}
		}
	}
}