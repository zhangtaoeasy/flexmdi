
package aworks.vo
{	
	import aworks.core.ValueObject;
	
	[Bindable]
	dynamic public class SalesTaxRate extends ValueObject
	{
		
		public function SalesTaxRate(args:*=null):void
		{
			super(args);
		}

		
		public var SalesTaxRateID : Number = 0;
		
		public var StateProvinceID : Number = 0;
		
		public var TaxType : String = "";
		
		public var TaxRate : String = "";
		
		public var Name : String = "";
		
		public var rowguid : String = "";
		
		public var ModifiedDate : Date;
		
		
	}
}



