<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sl" tagdir="/WEB-INF/tags" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<title>Posna slanina</title>

<!-- jQuery -->
<script src="<c:url value="/resources/jquery/jquery-1.12.3.min.js" />"></script>
<script src="<c:url value="/resources/jquery/jquery.autocomplete.js" />"></script>

<!-- CSS -->
<link href="<c:url value="/resources/css/main.css" />" rel="stylesheet">

<!-- Fonts -->
<link href='https://fonts.googleapis.com/css?family=Roboto:400,300' rel='stylesheet' type='text/css'>

</head>
<body>

	<h1>All Slaninas</h1>
	<c:forEach var="s" items="${slanine}">
		<sl:slanina slanina="${s}"/>
	</c:forEach>

	<h1>Add New</h1>
	<form method="post" action="addSlanina">
		Name: <input type="text" name="name" />
		Skill: <input type="text" name="skill" />
		<button>Add</button>
	</form>
	
	<h1>Search</h1>
	<input type="text"  id="w-input-search" value="">
	
	
	
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
  	});
  	</script>
  	
</body>
</html>