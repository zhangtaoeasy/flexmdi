
package aworks.vo
{	
	import aworks.core.ValueObject;
	
	[Bindable]
	dynamic public class Department extends ValueObject
	{
		
		public function Department(args:*=null):void
		{
			super(args);
		}

		
		public var DepartmentID : String = "";
		
		public var Name : String = "";
		
		public var GroupName : String = "";
		
		public var ModifiedDate : Date;
		
		
	}
}



