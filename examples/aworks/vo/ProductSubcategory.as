
package aworks.vo
{	
	import aworks.core.ValueObject;
	
	[Bindable]
	dynamic public class ProductSubcategory extends ValueObject
	{
		
		public function ProductSubcategory(args:*=null):void
		{
			super(args);
		}

		
		public var ProductSubcategoryID : Number = 0;
		
		public var ProductCategoryID : Number = 0;
		
		public var Name : String = "";
		
		public var rowguid : String = "";
		
		public var ModifiedDate : Date;
		
		
	}
}



