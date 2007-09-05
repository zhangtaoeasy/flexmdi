
package aworks.vo
{	
	import aworks.core.ValueObject;
	
	[Bindable]
	dynamic public class ProductDescription extends ValueObject
	{
		
		public function ProductDescription(args:*=null):void
		{
			super(args);
		}

		
		public var ProductDescriptionID : Number = 0;
		
		public var Description : String = "";
		
		public var rowguid : String = "";
		
		public var ModifiedDate : Date;
		
		
	}
}



