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
					action="${pageContext.servletContext.contextPath}/login"
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
</body>
</html>