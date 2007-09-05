
package aworks.vo
{	
	import aworks.core.ValueObject;
	
	[Bindable]
	dynamic public class Product extends ValueObject
	{
		
		public function Product(args:*=null):void
		{
			super(args);
		}

		
		public var ProductID : Number = 0;
		
		public var Name : String = "";
		
		public var ProductNumber : String = "";
		
		public var MakeFlag : String = "";
		
		public var FinishedGoodsFlag : String = "";
		
		public var Color : String = "";
		
		public var SafetyStockLevel : String = "";
		
		public var ReorderPoint : String = "";
		
		public var StandardCost : String = "";
		
		public var ListPrice : String = "";
		
		public var Size : String = "";
		
		public var SizeUnitMeasureCode : String = "";
		
		public var WeightUnitMeasureCode : String = "";
		
		public var Weight : String = "";
		
		public var DaysToManufacture : Number = 0;
		
		public var ProductLine : String = "";
		
		public var Class : String = "";
		
		public var Style : String = "";
		
		public var ProductSubcategoryID : Number = 0;
		
		public var ProductModelID : Number = 0;
		
		public var SellStartDate : Date;
		
		public var SellEndDate : Date;
		
		public var DiscontinuedDate : Date;
		
		public var rowguid : String = "";
		
		public var ModifiedDate : Date;
		
		
	}
}



