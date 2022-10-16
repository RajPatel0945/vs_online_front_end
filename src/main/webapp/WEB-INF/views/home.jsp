<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
<title>Election View List</title>
</head>
<body>

<div class="p-2 bg-primary text-white ">
		<p class="text-left">Online Voting System                                                        <a href="${pageContext.request.contextPath}/login" class="text-right" style="color:black;">Logout</a></p>
</div>
	 <c:if test="${error != null }">
		<div class="alert alert-success">${error}</div>
	</c:if>


	<table id="example" class="display" style="width: 100%">
		<thead>
			<tr>
				<th>Election ID</th>
				<th>Election Name</th>
				<th>Election Description</th>
				<th>Election Start Date</th>
				<th>Election End Date</th>
				<th>Action</th>
			</tr>
		</thead>
	</table>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.11.1/jquery.validate.min.js"></script>
	<script src="https://cdn.datatables.net/v/dt/dt-1.10.18/datatables.min.js"></script>
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/dt/dt-1.10.18/datatables.min.css"/>
	<script>
	$(document).ready(function() {
		var grpAlphaInfoVOJSON =${home.electionJsonArray};
		 var jsonString = JSON.stringify(grpAlphaInfoVOJSON);
		 var ctx = "${pageContext.request.contextPath}";
		  $('#example').dataTable({
			"data" : grpAlphaInfoVOJSON,
		    "columns": [
		        { "data": "ElectionId" },
		        { "data": "ElectionName" },
		        { "data": "ElectionDescription" },
		        { "data": "ElectionStartDateTime" },
		        { "data": "ElectionEndDateTime" },
		        {
		        	render: function (data, type, row) {
                    	return '<div style="text-align:center;"><a href="'+ctx+'/open-election?voterId='+1004+ '" title="Action">Action</a></div>'
                      }
                }
		      ]
		  });
		});
	</script>
</body>
</html>