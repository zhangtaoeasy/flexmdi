
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
		
		public var EmpStartDate : Date;
		
		public var EmpEndDate : Date;
		
		public var EmpOrgName : String = "";
		
		public var EmpJobTitle : String = "";
		
		public var EmpResponsibility : String = "";
		
		public var EmpFunctionCategory : String = "";
		
		public var EmpIndustryCategory : String = "";
		
		public var EmpLocCountryRegion : String = "";
		
		public var EmpLocState : String = "";
		
		public var EmpLocCity : String = "";
		
		
	}
}



