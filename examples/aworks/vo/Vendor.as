
package aworks.vo
{	
	import aworks.core.ValueObject;
	
	[Bindable]
	dynamic public class Vendor extends ValueObject
	{
		
		public function Vendor(args:*=null):void
		{
			super(args);
		}

		
		public var VendorID : Number = 0;
		
		public var AccountNumber : String = "";
		
		public var Name : String = "";
		
		public var CreditRating : String = "";
		
		public var PreferredVendorStatus : String = "";
		
		public var ActiveFlag : String = "";
		
		public var PurchasingWebServiceURL : String = "";
		
		public var ModifiedDate : Date;
		
		
	}
}



