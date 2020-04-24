<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="https://oauth2.googleapis.com/token" method="post" enctype="application/x-www-form-urlencoded">
		code : <input type="text" name="code" value="<%=request.getParameter("code")%>"><br>
		client_id : <input type="text" name="client_id" value="523392531637-h589a81n8ni7bgln4dc5ot68904e6p4g.apps.googleusercontent.com"><br>
		client_secret : <input type="text" name="client_secret" value="YrBLBIB2SPRqfy3Ui4f8qNdg"><br>
		redirect_uri : <input type="text" name="redirect_uri" value="http://localhost:8080/festa/member/googleCallback"><br>
		grant_type : <input type="text" name="grant_type" value="authorization_code"><br>
		<input type="submit" >	
	</form>
</body>
</html>