
package aworks.vo
{	
	import aworks.core.ValueObject;
	
	[Bindable]
	dynamic public class SalesOrderHeaderSalesReason extends ValueObject
	{
		
		public function SalesOrderHeaderSalesReason(args:*=null):void
		{
			super(args);
		}

		
		public var SalesOrderID : Number = 0;
		
		public var SalesReasonID : Number = 0;
		
		public var ModifiedDate : Date;
		
		
	}
}



