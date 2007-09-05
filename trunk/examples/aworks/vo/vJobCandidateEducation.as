
package aworks.vo
{	
	import aworks.core.ValueObject;
	
	[Bindable]
	dynamic public class vJobCandidateEducation extends ValueObject
	{
		
		public function vJobCandidateEducation(args:*=null):void
		{
			super(args);
		}

		
		public var JobCandidateID : Number = 0;
		
		public var Edu.Level : String = "";
		
		public var Edu.StartDate : Date;
		
		public var Edu.EndDate : Date;
		
		public var Edu.Degree : String = "";
		
		public var Edu.Major : String = "";
		
		public var Edu.Minor : String = "";
		
		public var Edu.GPA : String = "";
		
		public var Edu.GPAScale : String = "";
		
		public var Edu.School : String = "";
		
		public var Edu.Loc.CountryRegion : String = "";
		
		public var Edu.Loc.State : String = "";
		
		public var Edu.Loc.City : String = "";
		
		
	}
}



