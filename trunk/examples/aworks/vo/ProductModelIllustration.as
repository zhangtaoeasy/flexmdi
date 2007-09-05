
package aworks.vo
{	
	import aworks.core.ValueObject;
	
	[Bindable]
	dynamic public class ProductModelIllustration extends ValueObject
	{
		
		public function ProductModelIllustration(args:*=null):void
		{
			super(args);
		}

		
		public var ProductModelID : Number = 0;
		
		public var IllustrationID : Number = 0;
		
		public var ModifiedDate : Date;
		
		
	}
}



