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
				<h1>${error}</h1>
				<form:form method="POST"
					action="${pageContext.servletContext.contextPath}/login"
					modelAttribute="register">
					<div class="mb-3 mt-3">
							<form:label path="licenseNo"  class="form-label">License Number</form:label>
							<form:input type="text" path="licenseNo"  class="form-control" placeholder="Enter License No"/>
						</div>
						
						<div class="mb-3">
							<form:label path="passportNo"  class="form-label">Passport</form:label>
							<form:input type="text" path="passportNo"  class="form-control" placeholder="Enter Passport No"/>
						</div>
						<button type="button" id="verifyVoter" class="btn btn-primary" >Verify Voter Exist</button>
						
						<div class="mb-3 mt-3">
							<form:label path="emailId"  class="form-label">emailId</form:label>
							<form:input type="email" path="emailId"  class="form-control" placeholder="Enter email"/>
						</div>
						<div class="mb-3">
							<form:label path="pass"  class="form-label">password</form:label>
							<form:input type="password" path="pass"  class="form-control" placeholder="Enter password"/>
						 </div>
						 <div class="mb-3">
							<form:label path="confPass"  class="form-label">password</form:label>
							<form:input type="password" path="confPass"  class="form-control" placeholder="Confirm password"/>
						 </div>
						 
						 <button type="submit" class="btn btn-primary">Submit</button>
						
				</form:form>
			</div>
		</div>
	</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script>
	$("#verifyVoter").click(function() {
			
			var licenseNo= $('#licenseNo').val();;
			var passportNo= $('#passportNo').val();;
			
			 $.ajax({
				 	url:"http://localhost:8081/vs_front_end/verify-identity",
					type:'GET',
					dataType: 'json',
					data:{
						licenseNo: licenseNo,
						passportNo: passportNo
					 },
					 success:function(data){
					 	alert("Data: " + data);
					 }
			});
					  
		});
	</script>
</body>

	
</html>