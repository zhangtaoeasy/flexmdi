
package aworks.vo
{	
	import aworks.core.ValueObject;
	
	[Bindable]
	dynamic public class Individual extends ValueObject
	{
		
		public function Individual(args:*=null):void
		{
			super(args);
		}

		
		public var CustomerID : Number = 0;
		
		public var ContactID : Number = 0;
		
		public var Demographics : String = "";
		
		public var ModifiedDate : Date;
		
		
	}
}



