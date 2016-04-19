<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ attribute name="slanina" required="true" type="slanina_posna.entities.Slanina" %>

<p>
	<b>${slanina.name}</b>
	
	<br/>
	<span style="font-size: 60%">(ID = ${slanina.id} | SKILL = ${slanina.skill})</span>
</p>