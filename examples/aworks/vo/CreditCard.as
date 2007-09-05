
package aworks.vo
{	
	import aworks.core.ValueObject;
	
	[Bindable]
	dynamic public class CreditCard extends ValueObject
	{
		
		public function CreditCard(args:*=null):void
		{
			super(args);
		}

		
		public var CreditCardID : Number = 0;
		
		public var CardType : String = "";
		
		public var CardNumber : String = "";
		
		public var ExpMonth : String = "";
		
		public var ExpYear : String = "";
		
		public var ModifiedDate : Date;
		
		
	}
}



