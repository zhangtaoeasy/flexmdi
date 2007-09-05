
package aworks.vo
{	
	import aworks.core.ValueObject;
	
	[Bindable]
	dynamic public class ProductCostHistory extends ValueObject
	{
		
		public function ProductCostHistory(args:*=null):void
		{
			super(args);
		}

		
		public var ProductID : Number = 0;
		
		public var StartDate : Date;
		
		public var EndDate : Date;
		
		public var StandardCost : String = "";
		
		public var ModifiedDate : Date;
		
		
	}
}



