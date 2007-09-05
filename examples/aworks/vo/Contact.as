
package aworks.vo
{	
	import aworks.core.ValueObject;
	
	[Bindable]
	dynamic public class Contact extends ValueObject
	{
		
		public function Contact(args:*=null):void
		{
			super(args);
		}

		
		public var ContactID : Number = 0;
		
		public var NameStyle : String = "";
		
		public var Title : String = "";
		
		public var FirstName : String = "";
		
		public var MiddleName : String = "";
		
		public var LastName : String = "";
		
		public var Suffix : String = "";
		
		public var EmailAddress : String = "";
		
		public var EmailPromotion : Number = 0;
		
		public var Phone : String = "";
		
		public var PasswordHash : String = "";
		
		public var PasswordSalt : String = "";
		
		public var AdditionalContactInfo : String = "";
		
		public var rowguid : String = "";
		
		public var ModifiedDate : Date;
		
		
	}
}



