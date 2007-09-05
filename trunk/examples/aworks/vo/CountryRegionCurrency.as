
package aworks.vo
{	
	import aworks.core.ValueObject;
	
	[Bindable]
	dynamic public class CountryRegionCurrency extends ValueObject
	{
		
		public function CountryRegionCurrency(args:*=null):void
		{
			super(args);
		}

		
		public var CountryRegionCode : String = "";
		
		public var CurrencyCode : String = "";
		
		public var ModifiedDate : Date;
		
		
	}
}



