
package aworks.vo
{	
	import aworks.core.ValueObject;
	
	[Bindable]
	dynamic public class DatabaseLog extends ValueObject
	{
		
		public function DatabaseLog(args:*=null):void
		{
			super(args);
		}

		
		public var DatabaseLogID : Number = 0;
		
		public var PostTime : Date;
		
		public var DatabaseUser : String = "";
		
		public var Event : String = "";
		
		public var Schema : String = "";
		
		public var Object : String = "";
		
		public var TSQL : String = "";
		
		public var XmlEvent : String = "";
		
		
	}
}



