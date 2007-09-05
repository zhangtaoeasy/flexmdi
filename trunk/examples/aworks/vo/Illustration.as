
package aworks.vo
{	
	import aworks.core.ValueObject;
	
	[Bindable]
	dynamic public class Illustration extends ValueObject
	{
		
		public function Illustration(args:*=null):void
		{
			super(args);
		}

		
		public var IllustrationID : Number = 0;
		
		public var Diagram : String = "";
		
		public var ModifiedDate : Date;
		
		
	}
}



