<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>

<%@page import="edu.nbcc.activity.Activity"%>
<%@taglib uri="/WEB-INF/activityDropdown.tld" prefix="a"%>

<%!//declare variables and methods
	List<String> errors = new ArrayList();
	List<Activity> activityList = new ArrayList<Activity>();

	//store input
	String user = "";
	String quiz1 = "";
	String quiz2 = "";
	String asn1 = "";
	String asn2 = "";
	String asn3 = "";
	
	//store output
	double numericGrade = 0.0;
	String letterGrade = "";

	//method to check required fields
	private String checkRequiredField(String value, String fieldName) {
		if (value == "") {
			errors.add(fieldName + " is required.");
		}
		return value;
	}

	//method to validate score, else add to error list
	private boolean validateScores(String value, String fieldName) {
		try {
			if (!isNumeric(value) && value != "") {
				errors.add(fieldName + " must be numeric");
			}
			
			double x = Double.parseDouble(value);
			
			if ((fieldName == "Quiz 1" || fieldName == "Quiz 2" || fieldName == "Assignment 3") && (x < 0 ||  x > 100)){
				errors.add(fieldName + " must be between 0 and 100");
			}
			
			if (fieldName == "Assignment 2" && (x < 0 ||  x > 200)){
				errors.add(fieldName + " must be between 0 and 200");
			}
			
			if (fieldName == "Assignment 3" && (x < 0 ||  x > 50)){
				errors.add(fieldName + " must be between 0 and 50");
			}
			
			return true;
		} catch (Exception e) {
			return false;
		}
	}

	//method to check if valid numeric
	private boolean isNumeric(String value) {
		try {
			double x = Double.parseDouble(value);
			return true;
		} catch (Exception e) {
			return false;
		}
	}

	//Error Check. Run a check on the errors string array.
	private void errorCheck() throws Exception {
		if (errors.size() > 0) {
			throw new Exception("Errors present");
		}
	}%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Grade Provider</title>
<%@include file="/WEB-INF/jspf/header.jspf"%>
<style>
.container {
	padding: 20px;
}

.student-select {
	width: 275px;
}

.blue {
	color: blue;
}
</style>
</head>
<body>
	<%@include file="/WEB-INF/jspf/navigation.jspf"%>
	<h1>Grade Provider</h1>
	<div class="container">

	<%
		Activity act1 = null;
		Activity act2 = null;
		Activity act3 = null;
		Activity act4 = null;
		Activity act5 = null;
		
		if (request.getParameter("btnSubmit") != null) {
					
			errors = new ArrayList<String>();
			activityList = new ArrayList<Activity>();
			
			request.getParameter("dd2");
			
			act1 = Activity.getActivity("quiz1");
			act2 = Activity.getActivity("quiz2");
			act3 = Activity.getActivity("asn1");
			act4 = Activity.getActivity("asn2");
			act5 = Activity.getActivity("asn3");
			
			//check if no duplicate
			
       		if (Activity.isActivityOnList(activityList, act1)) {
   				errors.add("Activity " + act1.getName() + " is already added");
   			} else{
   				activityList.add(act1);
   			}

       		if (Activity.isActivityOnList(activityList, act2)) {
   				errors.add("Activity " + act2.getName() + " is already added");
   			} else{
   				activityList.add(act2);
   			}
       		
       		if (Activity.isActivityOnList(activityList, act3)) {
   				errors.add("Activity " + act3.getName() + " is already added");
   			} else{
   				activityList.add(act3);
   			}
       		
       		if (Activity.isActivityOnList(activityList, act4)) {
   				errors.add("Activity " + act4.getName() + " is already added");
   			} else{
   				activityList.add(act4);
   			}
       		
       		if (Activity.isActivityOnList(activityList, act5)) {
   				errors.add("Activity " + act5.getName() + " is already added");
   			} else{
   				activityList.add(act5);
   			}
       		
				       		
			//check if all required fields are entered
			user = checkRequiredField(request.getParameter("user"), "User Name");
			quiz1 = checkRequiredField(request.getParameter("quiz1"), "Quiz 1");
			quiz2 = checkRequiredField(request.getParameter("quiz2"), "Quiz 2");
			asn1 = checkRequiredField(request.getParameter("asn1"), "Assignment 1");
			asn2 = checkRequiredField(request.getParameter("asn2"), "Assignment 2");
			asn3 = checkRequiredField(request.getParameter("asn3"), "Assignment 3");

			//Validate the scores
			validateScores(quiz1, "Quiz 1");
			validateScores(quiz2, "Quiz 2");
			validateScores(asn1, "Assignment 1");
			validateScores(asn2, "Assignment 2");
			validateScores(asn3, "Assignment 3");
			
			if (errors.isEmpty()){
				numericGrade = (Double.parseDouble(quiz1)/100 + Double.parseDouble(quiz2)/100) * 30 + 
						(Double.parseDouble(asn1)/200 + Double.parseDouble(asn2)/100) * 50 +
						Double.parseDouble(asn3)/50 * 20 ;
					
				if (numericGrade >= 93){
					letterGrade = "A";
				}else if (numericGrade >= 85){
					letterGrade = "B";
				}else if (numericGrade >= 75){
					letterGrade = "C";
				}else if (numericGrade >= 65){
					letterGrade = "D";
				}else if (numericGrade >= 60){
					letterGrade = "E";
				}else {
					letterGrade = "F";
				}
				
				session.setAttribute("name", request.getParameter("user"));
				session.setAttribute("letterGrade", letterGrade);
				response.sendRedirect("/JavaEEEx4/index.jsp");
			}
		}
		%>

		<form method="post">
			<table>
				<tr>
					<td>Name of User:</td>
					<td><input type="text" name="user"></td>
				</tr>

				<tr>
					<td><a:activityDropdown name="dd1" className="act1"
							selectedIndex="0" /></td>
					<td><input type="text" name="<%=request.getParameter("dd1")%>"/></td>
				</tr>

				<tr>
					<td><a:activityDropdown name="dd2" className="act2"
							selectedIndex="1" /></td>
					<td><input type="text" name="<%=request.getParameter("dd2")%>"></td>
				</tr>

				<tr>
					<td><a:activityDropdown name="dd3" className="act3"
							selectedIndex="2" /></td>
					<td><input type="text" name="<%=request.getParameter("dd3")%>"></td>
				</tr>

				<tr>
					<td><a:activityDropdown name="dd4" className="act4"
							selectedIndex="3" /></td>
					<td><input type="text" name="<%=request.getParameter("dd4")%>"></td>
				</tr>

				<tr>
					<td><a:activityDropdown name="dd5" className="act5"
							selectedIndex="4" /></td>
					<td><input type="text" name="<%=request.getParameter("dd5")%>"></td>
				</tr>

			</table>

			<button class="btn btn-primary" name="btnSubmit">Calculate Score</button>
		</form>
		<%
		if (!errors.isEmpty()) {
		%>

		<!-- if there are errors, display the errors -->
		<ul>
			<%
			for (String err : errors) {
			%>
			<li><%=err%></li>
			<%
			}
		}
		%>
		</ul>
		
<%-- 		<ul>
			<%
			for (Activity a : team) {
			%>
			<li><%=a%></li>
			<%
			}

		%>
		</ul> --%>
	</div>
	<%@include file="/WEB-INF/jspf/footer.jspf"%>
</body>
</html>