
package aworks.vo
{	
	import aworks.core.ValueObject;
	
	[Bindable]
	dynamic public class vJobCandidateEmployment extends ValueObject
	{
		
		public function vJobCandidateEmployment(args:*=null):void
		{
			super(args);
		}

		
		public var JobCandidateID : Number = 0;
		
		public var Emp.StartDate : Date;
		
		public var Emp.EndDate : Date;
		
		public var Emp.OrgName : String = "";
		
		public var Emp.JobTitle : String = "";
		
		public var Emp.Responsibility : String = "";
		
		public var Emp.FunctionCategory : String = "";
		
		public var Emp.IndustryCategory : String = "";
		
		public var Emp.Loc.CountryRegion : String = "";
		
		public var Emp.Loc.State : String = "";
		
		public var Emp.Loc.City : String = "";
		
		
	}
}



