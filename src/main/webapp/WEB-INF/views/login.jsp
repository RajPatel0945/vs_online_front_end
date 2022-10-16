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
					<li class="nav-item"><a class="nav-link active"
						href="${pageContext.request.contextPath}/login">Login</a></li>
					<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/register">Register</a>
					</li>

				</ul>
				<hr class="d-sm-none">
			</div>
			<div class="col-sm-8">
			<c:if test="${error != null }">
			<div class="alert alert-danger">
  					${error}
  			</div>
				</c:if>
				
				<c:if test="${success != null }">
			<div class="alert alert-success">
  					${success}
  			</div>
				</c:if>
				<form:form method="POST"
					action="${pageContext.servletContext.contextPath}/login" name="login"
					modelAttribute="login">
					<div class="mb-3 mt-3">
					
							<form:label path="emailId"  class="form-label">emailId</form:label>
							<form:input type="email" path="emailId"  class="form-control" placeholder="Enter email"/>
						</div>
						<div class="mb-3">
							<form:label path="password"  class="form-label">password</form:label>
							<form:input type="password" path="password"  class="form-control" placeholder="Enter password"/>
						 </div>
							  <button type="submit" class="btn btn-primary">Submit</button>
						
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
		  $("form[name='login']").validate({
		    // Specify validation rules
		    rules: {
		      // The key name on the left side is the name attribute
		      // of an input field. Validation rules are defined
		      // on the right side
		      emailId:{
		    	  required : true,
		    	  emailCustomFormat : true
		      },
		 
		      password: {
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
			      password: {
		        	required: "Please provide a password",
		        	minlength: "Your password must be at least 8 characters long",
		        	maxlength: "Your password maximum size 15 characters",
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
	</script>
</body>
</html>