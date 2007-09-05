
package aworks.vo
{	
	import aworks.core.ValueObject;
	
	[Bindable]
	dynamic public class ProductInventory extends ValueObject
	{
		
		public function ProductInventory(args:*=null):void
		{
			super(args);
		}

		
		public var ProductID : Number = 0;
		
		public var LocationID : String = "";
		
		public var Shelf : String = "";
		
		public var Bin : String = "";
		
		public var Quantity : String = "";
		
		public var rowguid : String = "";
		
		public var ModifiedDate : Date;
		
		
	}
}



