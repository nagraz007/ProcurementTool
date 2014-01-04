	var date = function(a){
       $('#'+ a).datepicker({ dateFormat: 'dd-M-yy',changeMonth: true, changeYear: true } );
	} ; 
	
	var deletef = function (id , path) {
	  $.getJSON( pathToUtil + "util/util.cfc", {
        method: 'deleteFile',
        DocPath: path,
        returnformat: 'plain'
    }, function(success){
			if(success == true){
				document.getElementById(id).style.display = 'none';	
			}
			else{
				alert("Deleting the File Failed. Try Again ");
			}
		});
	};
	
	var calculateListPrice = function(quantity, b){
		var i = 1;
		var count = document.getElementById('totalItems').value;
		document.list['listP' + b].value = quantity * document.list['quantity' + b].value ;
		document.list['CostAfterDiscount' + b].value =parseFloat(document.list['listP' + b].value - ((document.list['discount' + b].value * document.list['listP' + b].value )/100) );
		//alert(document.list['CostAfterDiscount' + b].value);
		document.list['Total' + b].value =parseFloat(document.list['CostAfterDiscount' + b].value)  + parseFloat( document.list['shipC' + b].value) ;
		document.list['GTotal' + b].value =	parseFloat(document.list['Total' + b].value) + parseFloat((document.list['Total' + b].value * document.list['tax' + b].value)/100 );
		document.list['grandtotal'].value = 0;
		for(i=1;i<= count ;i=i+1)
		{
			document.list['grandtotal'].value = parseFloat(document.list['grandtotal'].value) + parseFloat(document.list['GTotal' + i].value );		
		}
		
		
		document.getElementById('listP' + b).innerHTML = document.list['listP' + b].value ;
		document.getElementById('Total' + b).innerHTML = document.list['Total' + b].value ;
		document.getElementById('CostAfterDiscount' + b).innerHTML = document.list['CostAfterDiscount' + b].value ;
		document.getElementById('GTotal' + b).innerHTML = document.list['GTotal' + b].value ;
		document.getElementById('grandtotal').innerHTML = document.list['grandtotal'].value ;
		
	};
	var calculateCostAfterDiscount = function(discount, b){
		var i = 1;
		var count = document.getElementById('totalItems').value;
		document.list['CostAfterDiscount' + b].value = parseFloat( document.list['listP' + b].value - ((discount * document.list['listP' + b].value )/100) );
		document.list['Total' + b].value = parseFloat(document.list['CostAfterDiscount' + b].value)  + parseFloat( document.list['shipC' + b].value) ;
		document.list['GTotal' + b].value =	parseFloat(document.list['Total' + b].value) + parseFloat((document.list['Total' + b].value * document.list['tax' + b].value)/100 );
		
		document.list['grandtotal'].value = 0;
		for(i=1;i<= count ;i=i+1)
		{
			document.list['grandtotal'].value = parseFloat(document.list['grandtotal'].value) + parseFloat(document.list['GTotal' + i].value );	
		}
		
		document.getElementById('Total' + b).innerHTML = document.list['Total' + b].value ;
		document.getElementById('CostAfterDiscount' + b).innerHTML = document.list['CostAfterDiscount' + b].value ;
		document.getElementById('GTotal' + b).innerHTML = document.list['GTotal' + b].value ;
		document.getElementById('grandtotal').innerHTML = document.list['grandtotal'].value ;
	};
	var calculateCostAfterShipping = function(shipping, b){
		var i = 1;
		var count = document.getElementById('totalItems').value;
		document.list['Total' + b].value =  parseFloat(shipping) + parseFloat(document.list['CostAfterDiscount' + b].value) ;
		//alert(document.list['Total' + b].value);
		document.list['GTotal' + b].value =	parseFloat(document.list['Total' + b].value) + parseFloat((document.list['Total' + b].value * document.list['tax' + b].value)/100 );
		document.getElementById('Total' + b).innerHTML = document.list['Total' + b].value ;
		document.getElementById('GTotal' + b).innerHTML = document.list['GTotal' + b].value ;
	
		document.list['grandtotal'].value = 0;
		for(i=1;i<= count ;i=i+1)
		{
			document.list['grandtotal'].value = parseFloat(document.list['grandtotal'].value) + parseFloat(document.list['GTotal' + i].value );	
		}
		document.getElementById('grandtotal').innerHTML = document.list['grandtotal'].value ;		
								};
	var calculateCostAfterTax = function(tax, b){
		var i = 1;
		var count = document.getElementById('totalItems').value;
		document.list['GTotal' + b].value =	parseFloat(document.list['Total' + b].value) + parseFloat((document.list['Total' + b].value * tax)/100 );
		//alert(document.list['GTotal' + b].value);
		//alert(count);
		document.list['grandtotal'].value = 0;
		for(i=1;i<= count;i=i+1)
		{
		document.list['grandtotal'].value = parseFloat(document.list['grandtotal'].value) + parseFloat(document.list['GTotal' + i].value );	
		}
		document.getElementById('GTotal' + b).innerHTML = document.list['GTotal' + b].value ;
		document.getElementById('grandtotal').innerHTML = document.list['grandtotal'].value ;
		};

	  function toggleseefiles(a) 
    {
		$('#' + a).toggle();
	} 
	  var PrintOrder = function(){
	   		document.ShowPO.po_id.value = document.list.purchaseid.value;
	   		ColdFusion.Window.show('PrintOrder'); 
	  };
	 var dovalidate = function(){
		  var ret = true;
		  var count = document.list.count.value;
		  var i = 0;
		  var flag = 0;
		  var temp = 0;
		  
		  for(i = 1;i<= count;i++){
		    if (i==1){
				temp = 	document.list['currency' + i].value;
		    }
		    else{
		       if (temp != document.list['currency' + i].value )
		        ret = false;
		       break;
		    }
		  }
		  if(ret == false)
		  {
		   $("#currencyAlert").html('<span class="alert">Currency Types Mismatch</span>');
		        alert("Currency Types Mismatch");
		  }
		 return ret; 
	 };  
	 
	 var deliverymade = function(a){
		 if(confirm('Will you Register it as Asset Now?')){
				document.ShowPO.po_item.value = document.list.purchaseid.value;
				document.ShowPO.po_id.value = document.list['item'+ a].value;
				ColdFusion.Window.show('RegDisplay');
		
			}
	 };
	 
	 var validatePO = function(){
		var choices = document.getElementsByName('choice');
		var i = 0;
		var checked = false;
		
		if(document.itemprint.campus.value == '-1') {
			alert('Please choose a campus');
			return false;
		}
		
		for(;i < choices.length;i++){
			if(choices[i].checked){
				checked = true;	
			}
		}
		
		if(!checked){
			alert('Please Choose a Item - Vendor');
			return false;
				
		}
		
		if (checked){
			ColdFusion.navigate('printorder.cfm','PrintOrder', mycallBack, myerrorHandler,'POST','itemprint');
		}
	};
	 var mycallBack = function(){};
	 var myerrorHandler = function(){};