
package aworks.vo
{	
	import aworks.core.ValueObject;
	
	[Bindable]
	dynamic public class Culture extends ValueObject
	{
		
		public function Culture(args:*=null):void
		{
			super(args);
		}

		
		public var CultureID : String = "";
		
		public var Name : String = "";
		
		public var ModifiedDate : Date;
		
		
	}
}



