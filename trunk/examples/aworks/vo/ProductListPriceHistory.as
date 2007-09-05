
package aworks.vo
{	
	import aworks.core.ValueObject;
	
	[Bindable]
	dynamic public class ProductListPriceHistory extends ValueObject
	{
		
		public function ProductListPriceHistory(args:*=null):void
		{
			super(args);
		}

		
		public var ProductID : Number = 0;
		
		public var StartDate : Date;
		
		public var EndDate : Date;
		
		public var ListPrice : String = "";
		
		public var ModifiedDate : Date;
		
		
	}
}



