
package aworks.vo
{	
	import aworks.core.ValueObject;
	
	[Bindable]
	dynamic public class SalesPersonQuotaHistory extends ValueObject
	{
		
		public function SalesPersonQuotaHistory(args:*=null):void
		{
			super(args);
		}

		
		public var SalesPersonID : Number = 0;
		
		public var QuotaDate : Date;
		
		public var SalesQuota : String = "";
		
		public var rowguid : String = "";
		
		public var ModifiedDate : Date;
		
		
	}
}



