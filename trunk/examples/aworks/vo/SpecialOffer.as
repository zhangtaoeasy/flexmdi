
package aworks.vo
{	
	import aworks.core.ValueObject;
	
	[Bindable]
	dynamic public class SpecialOffer extends ValueObject
	{
		
		public function SpecialOffer(args:*=null):void
		{
			super(args);
		}

		
		public var SpecialOfferID : Number = 0;
		
		public var Description : String = "";
		
		public var DiscountPct : String = "";
		
		public var Type : String = "";
		
		public var Category : String = "";
		
		public var StartDate : Date;
		
		public var EndDate : Date;
		
		public var MinQty : Number = 0;
		
		public var MaxQty : Number = 0;
		
		public var rowguid : String = "";
		
		public var ModifiedDate : Date;
		
		
	}
}



