<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
.light-hr {
	margin-top: 1rem;
	margin-bottom: 1rem;
	border: none;
	height: 2px;
	color: #333;
	background-color: #333;
	color: #333;
}
</style>
<meta charset="ISO-8859-1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
<title>Election List page</title>
</head>
<body>
	<div class="p-2 bg-primary text-white ">
		<p class="text-left">Online Voting System  <a href="${pageContext.request.contextPath}/login" class="text-right" style="color:black;">Logout</a></p>
	</div>
	<br />
	<br />
	<br />
	<br />
	<div class="container">
		<c:if test="${error != null }">
			<div class="alert alert-success">${error}</div>
		</c:if>
	<div class="align-items-center p-3 my-3 rounded box-shadow table-borderless" style="background-color: #EEF6E8;">
		<div class="row">
			<div class="col-sm-2">
				<c:url var="imgUrl" value="/resources/crest-stylised.gif" />
				<img src="${imgUrl}" alt="Australia" style="width: 60px; height: 60px;">
			</div>
			<div class="col-sm-8 text-center">
				<h1>House of Representatives Ballot Paper</h1>
			</div>
			<div class="col-sm-2"></div>
		</div>
		<br />
		<div class="row">
			<div class="col-sm-12 ">
				<h5>South Australia</h5>
			</div>
		</div>
		<div class="row">
			<div class="col-sm-12 ">
				<h3>Electoral Division of Paralowie</h3>
			</div>
		</div>
		<div class="row">
			<div class="col-sm-12">
				<hr class="light-hr" />
			</div>
		</div>
		<div class="row">
			<div class="col-sm-12">
				<h3>Number the boxes from 1 to ${ballotPaper.listSize} in the order of your choice</h3>
			</div>
		</div>
		<div class="row">
			<div class="col-sm-12">
				<table id="example" class="table table-borderless" style="background-color: #EEF6E8; width: 100%">
					<tr>
						<th class="text-center col-sm-1">Logo</th>
						<th class="text-center col-sm-1">Select Preference</th>
						<th class="text-center col-sm-3">Candidate Name</th>
						<th class="text-center col-sm-3">Party Name</th>
					</tr>
					<c:forEach items="${ballotPaper.candidateList}" var="candidateList" varStatus="cnt">
						<tr>
							<td></td>
							<td class="col-sm-1">
							<select class="form-select"
								id="candidate_selection_${cnt.index}">
									<option value=""></option>
									<c:forEach items="${ballotPaper.candidateList}" var="optionList" varStatus="optionCnt">
										<option value="${optionCnt.index+1}">${optionCnt.index+1}</option>
									</c:forEach>
							</select> 
							<input type="hidden" id="candidate_id_${cnt.index}" name="candidate_id_${cnt.index}" value="${candidateList.CandidateId}"/>
							<span style="color:red;" id="error_candidate_selection_${cnt.index}"></span>
							</td>
							<td class="text-center">${candidateList.FirstName}
								${candidateList.LastName}</td>
							<td class="text-center">${candidateList.PartyName}</td>
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>
		<div class="row">
			<div class="col-sm-12 font-weight-bold">
				<h3>Remember... number every box to make your vote count</h3>
			</div>
		</div>
		<div class="row">
			<div class="center-block text-center">
				<button type="button" id="submitBtn" class="btn btn-secondary">Submit</button>
				<button type="button" id="clearBtn" class="btn btn-light">Clear</button>
			</div>
		</div>
	</div>
</div>
</body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.11.1/jquery.validate.min.js"></script>
<script>
	var sizeOfcandidates=${ballotPaper.listSize};
	var voterId=${ballotPaper.voterId}
	$("select[id^='candidate_selection']").change(
			function() {
				for (i = 0; i < sizeOfcandidates; i++) {
					var conceptName = $('#candidate_selection_' + i).find(":selected").val();
					if (conceptName) {
						$('#candidate_selection_' + i).val(conceptName);
						$('#error_candidate_selection_'+i).text(""); 
						for (j = 0; j < sizeOfcandidates; j++) {
							if (i != j) {
								$("#candidate_selection_" + j+ " option[value='"+ conceptName + "']").remove();
							}
						}
					}
				}
			});
	
	$("#clearBtn").click(function() {
		for (i = 0; i < sizeOfcandidates; i++) {
			$('#candidate_selection_' + i).val("");
			
		}
	});
	
	$("#submitBtn").click(function() {
		var unselected=0;
		for (i = 0; i < sizeOfcandidates; i++) {
			var conceptName = $('#candidate_selection_' + i).find(":selected").val();
			if(conceptName){
				
			}else{
				unselected++;
				$("#error_candidate_selection_"+i).text("Please select preference before submit");
			}
		}
		
		var json_data = {'candidateId':[],'preference':[]};
		if(unselected==0){
			for(k=0;k<sizeOfcandidates;k++){
				json_data.preference.push($('#candidate_selection_' + k).find(":selected").val());
				json_data.candidateId.push($('#candidate_id_' + k).val());
			}
			var ctx = "${pageContext.request.contextPath}";
			var requestData=JSON.stringify(json_data);
			 $.ajax({
				 	url:ctx+"/submit-ballot?json_data="+requestData+"&voterId="+voterId,
					type:'GET',
					dataType: 'json',
					success:function(data){
						 window.location.href = ctx+"/success-vote";
					}
			 });
		}
	});
</script>
</html>



