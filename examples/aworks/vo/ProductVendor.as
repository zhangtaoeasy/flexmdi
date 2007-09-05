
package aworks.vo
{	
	import aworks.core.ValueObject;
	
	[Bindable]
	dynamic public class ProductVendor extends ValueObject
	{
		
		public function ProductVendor(args:*=null):void
		{
			super(args);
		}

		
		public var ProductID : Number = 0;
		
		public var VendorID : Number = 0;
		
		public var AverageLeadTime : Number = 0;
		
		public var StandardPrice : String = "";
		
		public var LastReceiptCost : String = "";
		
		public var LastReceiptDate : Date;
		
		public var MinOrderQty : Number = 0;
		
		public var MaxOrderQty : Number = 0;
		
		public var OnOrderQty : Number = 0;
		
		public var UnitMeasureCode : String = "";
		
		public var ModifiedDate : Date;
		
		
	}
}



