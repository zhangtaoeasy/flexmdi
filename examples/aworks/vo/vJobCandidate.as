
package aworks.vo
{	
	import aworks.core.ValueObject;
	
	[Bindable]
	dynamic public class vJobCandidate extends ValueObject
	{
		
		public function vJobCandidate(args:*=null):void
		{
			super(args);
		}

		
		public var JobCandidateID : Number = 0;
		
		public var EmployeeID : Number = 0;
		
		public var Name.Prefix : String = "";
		
		public var Name.First : String = "";
		
		public var Name.Middle : String = "";
		
		public var Name.Last : String = "";
		
		public var Name.Suffix : String = "";
		
		public var Skills : String = "";
		
		public var Addr.Type : String = "";
		
		public var Addr.Loc.CountryRegion : String = "";
		
		public var Addr.Loc.State : String = "";
		
		public var Addr.Loc.City : String = "";
		
		public var Addr.PostalCode : String = "";
		
		public var EMail : String = "";
		
		public var WebSite : String = "";
		
		public var ModifiedDate : Date;
		
		
	}
}



