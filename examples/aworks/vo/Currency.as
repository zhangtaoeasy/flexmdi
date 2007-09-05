
package aworks.vo
{	
	import aworks.core.ValueObject;
	
	[Bindable]
	dynamic public class Currency extends ValueObject
	{
		
		public function Currency(args:*=null):void
		{
			super(args);
		}

		
		public var CurrencyCode : String = "";
		
		public var Name : String = "";
		
		public var ModifiedDate : Date;
		
		
	}
}



