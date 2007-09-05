
package aworks.vo
{	
	import aworks.core.ValueObject;
	
	[Bindable]
	dynamic public class CurrencyRate extends ValueObject
	{
		
		public function CurrencyRate(args:*=null):void
		{
			super(args);
		}

		
		public var CurrencyRateID : Number = 0;
		
		public var CurrencyRateDate : Date;
		
		public var FromCurrencyCode : String = "";
		
		public var ToCurrencyCode : String = "";
		
		public var AverageRate : String = "";
		
		public var EndOfDayRate : String = "";
		
		public var ModifiedDate : Date;
		
		
	}
}



