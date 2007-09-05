
package aworks.vo
{	
	import aworks.core.ValueObject;
	
	[Bindable]
	dynamic public class ProductCategory extends ValueObject
	{
		
		public function ProductCategory(args:*=null):void
		{
			super(args);
		}

		
		public var ProductCategoryID : Number = 0;
		
		public var Name : String = "";
		
		public var rowguid : String = "";
		
		public var ModifiedDate : Date;
		
		
	}
}



