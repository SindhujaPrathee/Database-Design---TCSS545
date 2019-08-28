/**
 * 
 */
function required()  
{  
var s=document.getElementById("available_seats").value;
var n=document.getElementById("no_of_passengers").value;
var mobile_no = document.forms["booking"]["mobile_no"].value.length;
var f_name = document.forms["booking"]["f_name"].value;
var l_name = document.forms["booking"]["l_name"].value;

if (f_name == null || f_name == 0 || f_name == "")  
{  
alert("Please Enter first name");  
return false;
} 
else if (l_name == null || l_name ==0 || l_name =="")  
{  
alert("Please Enter last name");  
return false;
} 
else if (n == 0)  
{  
alert("Please Enter number of passengers");  
return false;
} 

if(mobile_no != 10)
	{
	alert("Invalid Mobile number.");
	return false;
	}
return true;
}  

