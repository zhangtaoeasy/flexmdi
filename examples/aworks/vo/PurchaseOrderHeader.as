
package aworks.vo
{	
	import aworks.core.ValueObject;
	
	[Bindable]
	dynamic public class PurchaseOrderHeader extends ValueObject
	{
		
		public function PurchaseOrderHeader(args:*=null):void
		{
			super(args);
		}

		
		public var PurchaseOrderID : Number = 0;
		
		public var RevisionNumber : String = "";
		
		public var Status : String = "";
		
		public var EmployeeID : Number = 0;
		
		public var VendorID : Number = 0;
		
		public var ShipMethodID : Number = 0;
		
		public var OrderDate : Date;
		
		public var ShipDate : Date;
		
		public var SubTotal : String = "";
		
		public var TaxAmt : String = "";
		
		public var Freight : String = "";
		
		public var TotalDue : String = "";
		
		public var ModifiedDate : Date;
		
		
	}
}



