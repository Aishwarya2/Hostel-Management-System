<!--Login.jsp-->
<%@page import="java.io.*,java.util.*,java.sql.*"%>
<%@page import="javax.servlet.*,javax.servlet.http.*"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<html>
<head>
 <link rel="stylesheet" href="Css/otherback.css">
  <link rel="stylesheet"  href="Css/bootstrap.css">
 <link rel="stylesheet"  href="bootstrap.js">
	<style>
	p{
		font-size:50px;
	}
	</style>
 </head>
 
 <body>

 
    <c:set var="USER_FLAG" scope="application" value="0"/>
	<c:set var="FLAG" scope="application" value="0"/>
	<sql:setDataSource
	    var="user"
		url="jdbc:mysql://localhost:3306/hostel"
        driver="com.mysql.jdbc.Driver"
        user="myuser"	password="xxxx"/>
		
		
	<sql:query dataSource="${user}" var="result">
	 select * from users where uname=?
	 <sql:param value="${param.uname}"/>
	 </sql:query>
	 
	 <c:forEach var="row" items="${result.rows}">
	  <c:set var="USER_FLAG" scope="application" value="1"/>
	  </c:forEach>
	  
    <sql:query dataSource="${user}" var="result1">
     select * from users where uname=? and pass=?
       <sql:param value="${param.uname}"/>
       <sql:param value="${param.pass}"/> 
    </sql:query>	
	
	<c:forEach var="row" items="${result1.rows}">
	 <c:set var="FLAG" scope="application" value="1"/>
	</c:forEach>

	
    <c:choose>
     <c:when test="${FLAG eq 1}">
        <p><b>valid username</b></p>
        <c:set var="USER_FLAG" scope="application" value="0"/>
        <c:set var="FLAG" scope="application" value="0"/>
		<c:set var="s" scope="session" value="${param.uname}"/>
		<jsp:forward page="display.jsp"/>
		<jsp:forward page="cash.jsp"/>
		<a href="display.jsp"><b>Click here to see your record</b></a>
     </c:when>
	  <c:when test="${USER_FLAG eq 0}">
        <p align="center"><b>invalid username</b></p>
        <c:set var="USER_FLAG" scope="application" value="0"/>
        <c:set var="FLAG" scope="application" value="0"/>
     </c:when>
	 <c:otherwise>
	      <p align="center">Invalid Password</p>
		<c:set var="USER_FLAG" scope="application" value="0"/>
        <c:set var="FLAG" scope="application" value="0"/>

	 </c:otherwise>
    </c:choose>

 </body>
</html>