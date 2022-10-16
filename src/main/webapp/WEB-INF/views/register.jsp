<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
<style>
.fakeimg {
	height: 200px;
	background: #aaa;
}
form .error {
  color: #ff0000;
}
</style>
</head>
</head>
<body>
	<div class="p-5 bg-primary text-white text-center">
		<h1>Online Voting System</h1>
	</div>
	<div class="container mt-5">
		<div class="row">
			<div class="col-sm-4">


				<ul class="nav nav-pills flex-column">
					<li class="nav-item"><a class="nav-link"
						href="${pageContext.request.contextPath}/login">Login</a></li>
					<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/register">Register</a>
					</li>

				</ul>
				<hr class="d-sm-none">
			</div>
			<div class="col-sm-8">
			<div id="msg"></div>
			<c:if test="${error != null }">
			<div class="alert alert-success">
   				${error}
  			</div>
  			</c:if>
				<form:form method="POST"
					action="${pageContext.servletContext.contextPath}/register"
					modelAttribute="register" name="register">
					<div class="mb-3 mt-3" id="licenseNo">
							<form:label path="licenseNoInput"  class="form-label">License Number</form:label>
							<form:input type="text" path="licenseNoInput"  class="form-control" placeholder="Enter License No"/>
						</div>
						
						<div class="mb-3" id="passportNo">
							<form:label path="passportNoInput"  class="form-label">Passport</form:label>
							<form:input type="text" path="passportNoInput"  class="form-control" placeholder="Enter Passport No"/>
						</div>
						<button type="button" id="verifyVoter" class="btn btn-primary" >Verify Voter Exist</button>
						<input type="hidden" id="voterId" name="voterId" value=""/>
						<div class="mb-3 mt-3" style="display:none" id="emailId">
							<form:label path="emailId"  class="form-label">emailId</form:label>
							<form:input type="email" path="emailId"  class="form-control" placeholder="Enter email"/>
						</div>
						<div class="mb-3" id="pass" style="display:none">
							<form:label path="pass"  class="form-label">password</form:label>
							<form:input type="password"  path="pass"  class="form-control" placeholder="Enter password"/>
						 </div>
						 <div class="mb-3" id="confPass" style="display:none">
							<form:label path="confPass"  class="form-label">password</form:label>
							<form:input type="password" path="confPass"  class="form-control" placeholder="Confirm password"/>
						 </div>
						 
						 <button type="submit" id="submitBtn"  style="display:none" class="btn btn-primary">Submit</button>
						
				</form:form>
			</div>
		</div>
	</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.11.1/jquery.validate.min.js"></script>
	<script>
	jQuery.validator.addMethod("emailCustomFormat", function (value, element) {
        return this.optional(element) || /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/.test(value);
    }, "Please enter valid email address");
	
	jQuery.validator.addMethod("pwcheck", function(value) {
		   return /^[A-Za-z0-9\d=!\-@._*]*$/.test(value) // consists of only these
		       && /[a-z]/.test(value) // has a lowercase letter
		       && /\d/.test(value) // has a digit
		});
	$(function() {
		  // Initialize form validation on the registration form.
		  // It has the name attribute "registration"
		  $("form[name='register']").validate({
		    // Specify validation rules
		    rules: {
		      // The key name on the left side is the name attribute
		      // of an input field. Validation rules are defined
		      // on the right side
		      emailId:{
		    	  required : true,
		    	  emailCustomFormat : true
		      },
		 
		      pass: {
		        required: true,
		        minlength: 8,
		        maxlength:15,
		        pwcheck: true
		      },
		      confPass: {
			        required: true,
			        minlength: 8,
			        maxlength:15,
			        pwcheck: true
			   }
		    },
		    // Specify validation error messages
		    messages: {
		    	emailId:{
			    	  required : "Please provide a email",
			    	  emailCustomFormat : "Please enter valid email format"
			      },
			      pass: {
		        	required: "Please provide a password",
		        	minlength: "Your password must be at least 8 characters long",
		        	maxlength: "Your password maximum size 15 characters",
		        	pwcheck:  "Your password must contain numbers and characters"
		      	},
		      	confPass: {
		        	required: "Please provide a confirm password",
		        	minlength: "Your password must be at least 8 characters long",
		        	maxlength: "Your confirm password maximum size 15 characters",
		        	pwcheck:  "Your password must contain numbers and characters"
		      	}
		    },
		    // Make sure the form is submitted to the destination defined
		    // in the "action" attribute of the form when valid
		    submitHandler: function(form) {
		      form.submit();
		    }
		  });
		});
	$("#verifyVoter").click(function() {
			
			var licenseNo= document.getElementById('licenseNoInput').value;
			var passportNo=document.getElementById('passportNoInput').value;
			var ctx = "${pageContext.request.contextPath}";
			 $.ajax({
				 	url:ctx+"/verify-identity?licenseNo="+licenseNo+"&passportNo="+passportNo,
					type:'GET',
					dataType: 'json',
					
					 success:function(data){
						if(data.status=="201"){
							$('#msg').text("Voter is not exist");
							$('#msg').addClass('alert alert-danger');
							
						}else{
							$('#msg').text("Voter found! Please configure login details");
							$('#msg').addClass('alert alert-success');
							$("#confPass").show();
							$("#submitBtn").show();
							$("#pass").show();
							$("#emailId").show();
							$("#passportNo").hide();
							$("#licenseNo").hide();
							$("#verifyVoter").hide();
							document.getElementById("voterId").value = data.id;
							
						}
					 }
			});
					  
		});
	</script>
</body>

	
</html>