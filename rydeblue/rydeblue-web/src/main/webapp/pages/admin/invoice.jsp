 <head>
<style>
 #invoice li{
	background: #f7f8fa !important;
	color: #188ae2 !important;
	border-left:4px solid #188ae2 !important;
	outline: none;
	    text-decoration: none;
}
</style>
</head>
 <div class="body-content">
 <script>
$("#login-content").hide();
$("#login-trigger").click(function(){
 //alert();
 $("#login-content").toggle("slow");
});
</script>
 <div class="col-md-12">&nbsp;</div>
 <div class="col-md-12"> 
 <a type="submit"  ng-click="getDriversForInvoice()" ng-show="type=='DRIVER'" class="btn btn-primary button" >Generate Driver Invoice</a>
 <a class="btn btn-primary " ng-click="generateDriverInvoiceXL()" ng-show="type=='DRIVER'" class="btn btn-primary button">Download Excel</a>
 <a class="btn btn-primary " ng-click="generateConsumerInvoiceXL()" ng-show="type=='CONSUMER'" class="btn btn-primary button">Download Excel</a>
<div class="col-md-2 pull-right padding-0">
  <div class = "input-group searchz" ng-show="invoices.length!=0">
         <span class = "input-group-addon"><i class="fa fa-search" aria-hidden="true"></i></span>
         <input  ng-model="search" class="form-control" placeholder="Search">
      </div>
</div> 
</div>
<div class="col-md-12">&nbsp;</div>
<div class="col-md-12  padding-0 whitebg">
<div class="col-md-12 headingbg">
<div class="col-md-10">
<h4 class="fs-16px text-uppercase margin-btm-5">{{type}}S Invoice List</h4>
</div>
<div class="col-md-2 text-right">
 <select class="form-control selectstyle" id="type" ng-change=getOnSelectData(type) ng-model="type" >
 		 <option value="DRIVER">Drivers</option>
        <option value="CONSUMER">Consumers</option>     
      </select>
</div>  
</div>
 <table class="table searchz ">
    <thead>
      <tr>
        <th>#</th>
        <th>Invoice Number</th>
        <th>Name</th>
        <th>Email</th>
        <th>Mobile Number</th>
        <th>Amount</th>
        <th>Date  & Time </th>
        <th>Status</th>
        <th>Action</th>
      </tr>
    </thead>
    <tbody>
      <tr  ng-repeat="invoice in filtered =invoices | filter:search | startFrom:(currentPage-1)*entryLimit | limitTo:entryLimit">
        <td>{{ $index +1}}</td>
        <td>{{invoice.invoiceNumber}}</td>
        <td>{{invoice.userName}}</td>
        <td>{{invoice.emailId}}</td> 
        <td>{{invoice.mobileNumber}}</td>
        <td>{{invoice.amount}}</td>
        <td>{{invoice.generatedOn|date:'yyyy-MM-dd HH:mm a'}}</td>
        <td class=""  ng-class="{'green': invoice.status == 'Cleared' , 'newcolor': invoice.status == 'Pending' }">{{invoice.status}}</td>
        <td ng-show="type=='CONSUMER'"><a href="#/invoicedetails/{{invoice.invoiceId}}/invoice">View </a></td>
        <td ng-show="type=='DRIVER'"><a href="#/driverinvoicedetails/{{invoice.invoiceId}}/invoice">View</a>&nbsp;| &nbsp;
        <a href=""  data-toggle="modal" data-target="#myModal" ng-show="invoice.status!='Cleared'"  ng-click="setInvoiceId(invoice.invoiceId,invoice.userId,invoice.amount)">Update payment info  </a>
        <a href=""  ng-show="invoice.status=='Cleared'" disabled="disabled" style="color: #aab2b7 !important">Update payment info  </a></td>
      </tr>
      	<tr ng-show="filteredSize==0">
					<td colspan="10" align="center">No records found..</td>
				</tr>
     		 <tr ng-show="filteredSize!=0">
					<td colspan="10" align="center">
					<pagination page="currentPage"
							max-size="noOfPages" total-items="totalItems"
							items-per-page="entryLimit" class="pagination"
							boundary-links="true"></pagination></td>
				</tr>
    </tbody>
  </table>
</div>  
</div>
<div id="myModal" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close close1" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Invoice Payment</h4>
      </div>
      <div class="modal-body">
         <div class="row">
         <div class="col-md-12">
           <form name="paymentForm" ng-submit="paymentForm.$valid && saveInvoicePayment()" novalidate>
           <div class="form-group">
            <label>Reference Id</label>
         <input type="text" class="form-control" name="referenceId" id="referenceId" ng-model="payment.referenceId" required> 
         <span class="red" ng-show="paymentForm.referenceId.$error.required">
           Reference Id is required
         </span>
         </div>
         <div class="form-group">
          <label>Payment Type</label>
         <input type="text" class="form-control" name="type" id="type" ng-model="payment.type" required>
         <span class="red" ng-show="paymentForm.type.$error.required ">
           Payment Type is required
         </span> 
        </div>   
        <div class="form-group">
          <label>Date</label>
         <input type="date" class="form-control" name="tranctionDate" id="tranctionDate" ng-model="payment.tranctionDate" required > 
         <span class="red" ng-show="paymentForm.tranctionDate.$error.required">
           Date is required
         </span> 
        </div>   
       <div class="col-md-2 box margin-top-10">
        <div class="form-group commentbtn">
        <input type="submit" value="Save" ng-click="submitted==true" class="btn btn-primary button" >
        </div>
     </div>
            </form>
            </div>
            </div>
      </div>
    </div>
  </div>
</div>
     <div class="question-modal collapse" style="z-index:1">
 			<div class="col-md-12 text-right">
					<i class="fa fa-times-circle closeicon" ng-click="closeAccount()" id="close" aria-hidden="true"></i>
					</div>
				   <div class="col-md-12">
				   <div class="new-body">
				    <div class="col-md-12"> 
 <a type="submit"  ng-click="generasteInvoice()"  class="btn btn-primary button" >Generate Invoice</a>
</div>
				 <div class="col-md-12 headingbg newtop text-left">
<div class="col-md-12">
<div class="col-md-10">
<h4 class="fs-16px text-uppercase margin-btm-5">Drivers List{{drivers.driverIds}}</h4>
</div>
<div class="col-md-2 pull-right padding-0">
  <div class = "input-group searchz" ng-show="driversList.length!=0">
         <span class = "input-group-addon"><i class="fa fa-search" aria-hidden="true"></i></span>
         <input  ng-model="search1" class="form-control" placeholder="Search">
      </div>
</div> 
</div>
</div>
				   <table class="table ">
<tbody>
<thead>
      <tr>
         <th><input type="checkbox" ng-model="checked" ng-change="checkAll()" /></th>
      <th>Driver ID </th>
       <th>Driver Name  </th>
	     <th>Email ID</th>
		<th>Mobile Number</th>
		<th>Rydes</th>
		<th>Amount</th>
      </tr>
      </thead>
        <tr ng-repeat="driver in filtered =driversList| filter:search1 | startFrom:(currentPage1-1)*entryLimit1 | limitTo:entryLimit1 | orderBy:order">
        	<td> <input type="checkbox" checklist-model="drivers.driverIds" checklist-value="driver.driverId"></td>
         <td>DRIVID{{driver.driverId}}</td>
         <td>{{driver.name}}</td>
           <td>{{driver.email}}</td>
        <td>{{driver.mobile}}</td> 
        <td>{{driver.rydes}}</td>
            <td>{{driver.amount}}</td>
      </tr>
      <tr ng-show="filteredSize1!=0" >
					<td colspan="7" align="center" class="text-center"><pagination page="currentPage1"
							max-size="noOfPages1" total-items="totalItems1"
							items-per-page="entryLimit1" class="pagination-sm"
							boundary-links="true"></pagination></td>
				</tr>
        <tr ng-show="filteredSize1==0">
					<td colspan="6" align="center">No records found..</td>
				</tr>
    </tbody>
  </table>
  </div>
</div>
      </div>  