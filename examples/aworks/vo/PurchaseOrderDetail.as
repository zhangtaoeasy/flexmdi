
package aworks.vo
{	
	import aworks.core.ValueObject;
	
	[Bindable]
	dynamic public class PurchaseOrderDetail extends ValueObject
	{
		
		public function PurchaseOrderDetail(args:*=null):void
		{
			super(args);
		}

		
		public var PurchaseOrderID : Number = 0;
		
		public var PurchaseOrderDetailID : Number = 0;
		
		public var DueDate : Date;
		
		public var OrderQty : String = "";
		
		public var ProductID : Number = 0;
		
		public var UnitPrice : String = "";
		
		public var LineTotal : String = "";
		
		public var ReceivedQty : String = "";
		
		public var RejectedQty : String = "";
		
		public var StockedQty : String = "";
		
		public var ModifiedDate : Date;
		
		
	}
}



