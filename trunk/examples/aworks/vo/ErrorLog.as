
package aworks.vo
{	
	import aworks.core.ValueObject;
	
	[Bindable]
	dynamic public class ErrorLog extends ValueObject
	{
		
		public function ErrorLog(args:*=null):void
		{
			super(args);
		}

		
		public var ErrorLogID : Number = 0;
		
		public var ErrorTime : Date;
		
		public var UserName : String = "";
		
		public var ErrorNumber : Number = 0;
		
		public var ErrorSeverity : Number = 0;
		
		public var ErrorState : Number = 0;
		
		public var ErrorProcedure : String = "";
		
		public var ErrorLine : Number = 0;
		
		public var ErrorMessage : String = "";
		
		
	}
}



