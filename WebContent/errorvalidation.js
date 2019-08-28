
function required()  
{  
var empt = document.forms["booking_criteria"]["date"].value; 
var selectedDate = $('#datepicker').datepicker('getDate');
var from = document.forms["booking_criteria"]["From"].value; 
var to = document.forms["booking_criteria"]["To"].value; 

var now = new Date();
now.setHours(0,0,0,0);
if (from == "From")  
{  
alert("Please select From");
return false;
} 
else if (to == "To")  
{  
alert("Please select To");
return false;
} 
else if (empt == "")  
{  
alert("Please select date");  
return false;
}  
else if (selectedDate <= now)
	{
	alert("Please select future date");  
	return false;
	}
return true;
}  