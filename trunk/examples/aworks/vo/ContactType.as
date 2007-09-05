
package aworks.vo
{	
	import aworks.core.ValueObject;
	
	[Bindable]
	dynamic public class ContactType extends ValueObject
	{
		
		public function ContactType(args:*=null):void
		{
			super(args);
		}

		
		public var ContactTypeID : Number = 0;
		
		public var Name : String = "";
		
		public var ModifiedDate : Date;
		
		
	}
}



