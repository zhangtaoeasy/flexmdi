
package aworks.vo
{	
	import aworks.core.ValueObject;
	
	[Bindable]
	dynamic public class AWBuildVersion extends ValueObject
	{
		
		public function AWBuildVersion(args:*=null):void
		{
			super(args);
		}

		
		public var SystemInformationID : String = "";
		
		public var DatabaseVersion : String = "";
		
		public var VersionDate : Date;
		
		public var ModifiedDate : Date;
		
		
	}
}



