
package aworks.vo
{	
	import aworks.core.ValueObject;
	
	[Bindable]
	dynamic public class ContactCreditCard extends ValueObject
	{
		
		public function ContactCreditCard(args:*=null):void
		{
			super(args);
		}

		
		public var ContactID : Number = 0;
		
		public var CreditCardID : Number = 0;
		
		public var ModifiedDate : Date;
		
		
	}
}



