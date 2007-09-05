
package aworks.vo
{	
	import aworks.core.ValueObject;
	
	[Bindable]
	dynamic public class SalesOrderDetail extends ValueObject
	{
		
		public function SalesOrderDetail(args:*=null):void
		{
			super(args);
		}

		
		public var SalesOrderID : Number = 0;
		
		public var SalesOrderDetailID : Number = 0;
		
		public var CarrierTrackingNumber : String = "";
		
		public var OrderQty : String = "";
		
		public var ProductID : Number = 0;
		
		public var SpecialOfferID : Number = 0;
		
		public var UnitPrice : String = "";
		
		public var UnitPriceDiscount : String = "";
		
		public var LineTotal : String = "";
		
		public var rowguid : String = "";
		
		public var ModifiedDate : Date;
		
		
	}
}



