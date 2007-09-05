
package aworks.vo
{	
	import aworks.core.ValueObject;
	
	[Bindable]
	dynamic public class SalesReason extends ValueObject
	{
		
		public function SalesReason(args:*=null):void
		{
			super(args);
		}

		
		public var SalesReasonID : Number = 0;
		
		public var Name : String = "";
		
		public var ReasonType : String = "";
		
		public var ModifiedDate : Date;
		
		
	}
}



