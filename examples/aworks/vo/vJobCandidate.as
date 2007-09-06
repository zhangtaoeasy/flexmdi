
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
		
		public var NamePrefix : String = "";
		
		public var NameFirst : String = "";
		
		public var NameMiddle : String = "";
		
		public var NameLast : String = "";
		
		public var NameSuffix : String = "";
		
		public var Skills : String = "";
		
		public var AddrType : String = "";
		
		public var AddrLocCountryRegion : String = "";
		
		public var AddrLocState : String = "";
		
		public var AddrLocCity : String = "";
		
		public var AddrPostalCode : String = "";
		
		public var EMail : String = "";
		
		public var WebSite : String = "";
		
		public var ModifiedDate : Date;
		
		
	}
}



