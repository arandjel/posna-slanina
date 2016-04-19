<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="ISO-8859-1"%>

<!-- JSP Tags -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<!-- Posna Slanina Custom Tags -->
<%@ taglib prefix="sl" tagdir="/WEB-INF/tags" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>Posna slanina</title>

<!-- jQuery -->
<script src="<c:url value="/resources/jquery/jquery-1.12.3.min.js" />"></script>
<script src="<c:url value="/resources/jquery/jquery.autocomplete.js" />"></script>

<!-- CSS -->
<link href="<c:url value="/resources/css/bootstrap/css/bootstrap.min.css" />" rel="stylesheet">
<link href="<c:url value="/resources/css/main.css" />" rel="stylesheet">

<!-- Fonts -->
<link href='https://fonts.googleapis.com/css?family=Roboto:400,300' rel='stylesheet' type='text/css'>

</head>
<body>

	<div class="container-fluid">
		<h1>Slanina Spring Example</h1><br>
	
		<div class="row">
		
		<div class="col-lg-6">
			<div class="panel panel-default">
			  	<div class="panel-heading">All Slaninas</div>
			  	<div class="panel-body">
					<c:forEach var="s" items="${slanine}">
						<sl:slanina slanina="${s}"/>
					</c:forEach>
			  	</div>
			</div>
		</div>
		<div class="col-lg-6">
			<div class="panel panel-default">
			  	<div class="panel-heading">Add New</div>
			  	<div class="panel-body">
					<form method="post" action="addSlanina">
						Name: <input type="text" name="name" />
						Skill: <input type="text" name="skill" />
						<button>Add</button>
					</form>
				</div>
			</div>
		</div>
		
		<div class="col-lg-6">
			<div class="panel panel-default">
			  	<div class="panel-heading">Search</div>
			  	<div class="panel-body">
					<input type="text"  id="w-input-search" value="">
				</div>
			</div>
		</div>
		
		<div class="col-lg-6">
			<div class="panel panel-default">
			  	<div class="panel-heading">AJAX create</div>
			  	<div class="panel-body">
					<div id="container">
						<div id="slaninaFormResponse"></div>
						
						<form:form id="newSlaninaForm" 
							action="${pageContext.request.contextPath}/create.json" 
							modelAttribute="slaninaModel">
						<table>
							<tbody>
								<tr>
									<td>Slanina:</td>
									<td>
										<form:select path="name">
											<form:option value="Slana">Slana</form:option>
											<form:option selected="selected" value="Posna">Posna</form:option>
											<form:option value="Masna">Masna</form:option>
											<form:option value="Dobra">Dobra</form:option>
										</form:select>
									</td>
								</tr>
								<tr>
									<td>Skill:</td>
									<td>
										<form:input path="skill"></form:input>
									</td>
								</tr>
								<tr>
									<td>
										<input value="Create" type="submit">
									</td>
								<td></td>
								</tr>
							</tbody>
						</table>
						</form:form>
					</div>
				</div>
			</div>
		</div>
		
		</div>
	</div>
	
	
	<!-- SCRIPTS -->
  	<script>
 	$(document).ready(function() {
	 
		$('#w-input-search').autocomplete({
			serviceUrl: '${pageContext.request.contextPath}/searchSlanina',
			paramName: "search_string",
			delimiter: ",",
		   	transformResult: function(response) {
			    
				return {      	
				  //must convert json to javascript object before process
				  suggestions: $.map($.parseJSON(response), function(item) {
				      return { value: item.name, data: item.id };
				   })    
				};      
	        }   
		});	
		
		 $('#newSlaninaForm').submit(function(event) {

			  var name = $('#name').val();
			  var skill = $('#skill').val();
			  var json = { "name" : name, "skill" : skill};

		    $.ajax({
		    	url: $("#newSlaninaForm").attr( "action"),
		    	data: JSON.stringify(json),
		    	type: "POST",

		    	beforeSend: function(xhr) {
		    		xhr.setRequestHeader("Accept", "application/json");
		    		xhr.setRequestHeader("Content-Type", "application/json");
		    	},
		    	success: function(smartphone) {
		    		var respContent = "";

					respContent += "<span class='success'>Slanina was created: [";
					respContent += smartphone.name + " : ";
					respContent += smartphone.skill + "]</span><br><br>";

		    		$("#slaninaFormResponse").html(respContent);   		
		    	}
		    });

		    event.preventDefault();
		  });
  	});
  	</script>
  	
</body>
</html>