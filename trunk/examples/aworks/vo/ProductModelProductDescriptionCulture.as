
package aworks.vo
{	
	import aworks.core.ValueObject;
	
	[Bindable]
	dynamic public class ProductModelProductDescriptionCulture extends ValueObject
	{
		
		public function ProductModelProductDescriptionCulture(args:*=null):void
		{
			super(args);
		}

		
		public var ProductModelID : Number = 0;
		
		public var ProductDescriptionID : Number = 0;
		
		public var CultureID : String = "";
		
		public var ModifiedDate : Date;
		
		
	}
}



