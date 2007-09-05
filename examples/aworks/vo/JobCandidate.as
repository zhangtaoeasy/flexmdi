
package aworks.vo
{	
	import aworks.core.ValueObject;
	
	[Bindable]
	dynamic public class JobCandidate extends ValueObject
	{
		
		public function JobCandidate(args:*=null):void
		{
			super(args);
		}

		
		public var JobCandidateID : Number = 0;
		
		public var EmployeeID : Number = 0;
		
		public var Resume : String = "";
		
		public var ModifiedDate : Date;
		
		
	}
}



