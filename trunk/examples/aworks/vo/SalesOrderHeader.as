
package aworks.vo
{	
	import aworks.core.ValueObject;
	
	[Bindable]
	dynamic public class SalesOrderHeader extends ValueObject
	{
		
		public function SalesOrderHeader(args:*=null):void
		{
			super(args);
		}

		
		public var SalesOrderID : Number = 0;
		
		public var RevisionNumber : String = "";
		
		public var OrderDate : Date;
		
		public var DueDate : Date;
		
		public var ShipDate : Date;
		
		public var Status : String = "";
		
		public var OnlineOrderFlag : String = "";
		
		public var SalesOrderNumber : String = "";
		
		public var PurchaseOrderNumber : String = "";
		
		public var AccountNumber : String = "";
		
		public var CustomerID : Number = 0;
		
		public var ContactID : Number = 0;
		
		public var SalesPersonID : Number = 0;
		
		public var TerritoryID : Number = 0;
		
		public var BillToAddressID : Number = 0;
		
		public var ShipToAddressID : Number = 0;
		
		public var ShipMethodID : Number = 0;
		
		public var CreditCardID : Number = 0;
		
		public var CreditCardApprovalCode : String = "";
		
		public var CurrencyRateID : Number = 0;
		
		public var SubTotal : String = "";
		
		public var TaxAmt : String = "";
		
		public var Freight : String = "";
		
		public var TotalDue : String = "";
		
		public var Comment : String = "";
		
		public var rowguid : String = "";
		
		public var ModifiedDate : Date;
		
		
	}
}



