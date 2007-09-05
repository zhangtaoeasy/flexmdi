
package aworks.vo
{	
	import aworks.core.ValueObject;
	
	[Bindable]
	dynamic public class SpecialOfferProduct extends ValueObject
	{
		
		public function SpecialOfferProduct(args:*=null):void
		{
			super(args);
		}

		
		public var SpecialOfferID : Number = 0;
		
		public var ProductID : Number = 0;
		
		public var rowguid : String = "";
		
		public var ModifiedDate : Date;
		
		
	}
}



