
package aworks.vo
{	
	import aworks.core.ValueObject;
	
	[Bindable]
	dynamic public class sysdiagrams extends ValueObject
	{
		
		public function sysdiagrams(args:*=null):void
		{
			super(args);
		}

		
		public var name : String = "";
		
		public var principal_id : Number = 0;
		
		public var diagram_id : Number = 0;
		
		public var version : Number = 0;
		
		public var definition : String = "";
		
		
	}
}



