<%@page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib uri="WEB-INF/activityBodytag.tld" prefix="a" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
String name = (String)session.getAttribute("name"); 
String letterGrade = (String)session.getAttribute("letterGrade");
%>

<a:activityBodytag name="<%=name %>" letterGrade="<%=letterGrade %>"></a:activityBodytag>
</body>
</html>