
package aworks.vo
{	
	import aworks.core.ValueObject;
	
	[Bindable]
	dynamic public class ProductDocument extends ValueObject
	{
		
		public function ProductDocument(args:*=null):void
		{
			super(args);
		}

		
		public var ProductID : Number = 0;
		
		public var DocumentID : Number = 0;
		
		public var ModifiedDate : Date;
		
		
	}
}



