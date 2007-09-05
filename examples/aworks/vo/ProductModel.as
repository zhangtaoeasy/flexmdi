
package aworks.vo
{	
	import aworks.core.ValueObject;
	
	[Bindable]
	dynamic public class ProductModel extends ValueObject
	{
		
		public function ProductModel(args:*=null):void
		{
			super(args);
		}

		
		public var ProductModelID : Number = 0;
		
		public var Name : String = "";
		
		public var CatalogDescription : String = "";
		
		public var Instructions : String = "";
		
		public var rowguid : String = "";
		
		public var ModifiedDate : Date;
		
		
	}
}



