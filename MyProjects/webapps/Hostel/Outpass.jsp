<%@page import="java.io.*,java.util.*,java.sql.*"%>
<%@page import="javax.servlet.*,javax.servlet.http.*"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<html>
<head>
<link rel="stylesheet" href="Css/otherback.css">
  <link rel="stylesheet"  href="Css/bootstrap.css">
      <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">

 <link rel="stylesheet"  href="bootstrap.js">
 
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
	</head>
	<style>
	p{
		font-size:50px;
	}
	</style>
 <body>
 	 <c:set var="se" scope="application" value="0"/>
	 <c:set var="ve" scope="application" value="0"/>
 	<sql:setDataSource
	    var="user"
		url="jdbc:mysql://localhost:3306/hostel"
        driver="com.mysql.jdbc.Driver"
        user="myuser"	password="xxxx"/>
		
    <sql:query dataSource="${user}" var="res">
     select * from outpass where fingerprintID=? and name=? and number>0
    <sql:param value="${param.fp}"/>
    <sql:param value="${param.name1}"/>
    </sql:query>	
	
	<c:forEach var="row" items="${res.rows}">
	 <c:set var="se" scope="application" value="1"/>
	 <c:set var="ve" scope="application" value="${row.number}"/>
	 </c:forEach>
	 <div align="center" style="font-size:25px;position:relative;bottom:-30px">
	 <c:choose>
	  <c:when test="${se eq 1}">
	 
	 <sql:update dataSource="${user}">
	 update outpass set number=? where fingerprintID=?
	 <sql:param value="${ve-1}"/>
	 <sql:param value="${param.fp}"/>
	 </sql:update>
	 
	 <p>Outpass issued</p>
	 <br>
	 <p><b>The number of outpasses left for this month is:</b></p>
	 <c:out value="${ve-1}"/>
	 <br>
	 	 <c:set var="ve" scope="application" value="0"/>
		 	 <c:set var="se" scope="application" value="0"/>
	 <p><b>To check your details,logout and login again through user login</b></p>
	 
	 
	  </c:when>
	 <c:otherwise>
	 <p>Invalid Login</p>
	 	 	 <c:set var="ve" scope="application" value="0"/>
			 	 <c:set var="se" scope="application" value="0"/>
	 </c:otherwise>
	 </c:choose>
	 </div>
	 </body>
	 </html>
	 

