
package aworks.vo
{	
	import aworks.core.ValueObject;
	
	[Bindable]
	dynamic public class ScrapReason extends ValueObject
	{
		
		public function ScrapReason(args:*=null):void
		{
			super(args);
		}

		
		public var ScrapReasonID : String = "";
		
		public var Name : String = "";
		
		public var ModifiedDate : Date;
		
		
	}
}



