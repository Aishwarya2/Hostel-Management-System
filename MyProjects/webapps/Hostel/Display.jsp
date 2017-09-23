<!--Display.jsp-->
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
 
 <style>
 table,tr,td{
	 font-size:20px;
	 border:2px solid black;
 }
 
 td{
	 padding:10px;
 }
 
 table{
	 border-spacing:10px;
 }
 }
 </style>
</head> 
  <body>
 

   <c:set var="flag" scope="application" value="0"/>
    <c:set var="flagger" scope="application" value="0"/>
	<c:set var="sco" scope="application" value="0"/>
	 <c:set var="num" value="0"/>
    <sql:setDataSource
	 var="user"
	 url="jdbc:mysql://localhost:3306/hostel"
	 driver="com.mysql.jdbc.Driver"
	 user="myuser" password="xxxx"/>
<sql:query dataSource="${user}" var="result2">
	    select * from hosteler where hostel_name=?
        <sql:param value="${s}"/>		
</sql:query>
	 <h2><b><center>MY DETAILS</center></b></h2>
<c:forEach var="row" items="${result2.rows}">
<div class="table-responsive">
  <table width="5" align="center">	 
	 <tr>
	 <td>Name</td>
	 <td>Age</td>
	 <td>Address</td>
	 <td>Mobile Number</td>
	 <td>EmailID</td>
	 <td>Room Number</td>
	 <td>Electricity Bill</td>
	 <td>Monthly Room Rent</td>
	 <td>Mess Fees</td>
	 <td>Paid</td>
	 </tr>
	 <tr>
	 <td><c:out value="${row.hostel_name}"/></td>
	 <td><c:out value="${row.age}"/></td>
	 <td><c:out value="${row.address}"/></td>
	 <td><c:out value="${row.mobile}"/></td>
	 <td><c:out value="${row.email}"/></td>
	 <td><c:out value="${row.roon_number}"/></td>
	 <td><c:out value="${row.eb}"/></td>
     <td><c:out value="${row.room_rent}"/></td>
     <td><c:out value="${row.mess_fees}"/></td>
	 <td><c:out value="${row.paid}"/></td>
	 </tr> </table> </div>
	<c:set var="sum" scope="application" value="${row.eb+row.mess_fees+row.room_rent}"/>
</c:forEach>
	 


<sql:query dataSource="${user}" var="result4">
 select paid from hosteler where paid=? and hostel_name=?
 <sql:param value="paid"/>
 <sql:param value="${s}"/>
</sql:query> 
<c:forEach var="row" items="${result4.rows}">
 <c:set var="flagger" scope="application" value="1"/>
 </c:forEach>

 
<div align="center" style="font-size:25px;position:relative;bottom:-30px">
<c:choose>
<c:when test="${flagger eq 1}">
<p>Fees already paid</p>
 <c:set var="flagger" scope="application" value="0"/>
</c:when>
<c:otherwise>
  <p><b>The total fees to be paid is:</b></p>
<c:out value="${sum}"/>
  <a href="pay.html"><b>To pay the fees,click here</b></a>
</c:otherwise>
</c:choose>

<sql:query dataSource="${user}" var="res1">
 select number from outpass where name=? and number>0 
 <sql:param value="${s}"/>
</sql:query> 
<c:forEach var="row" items="${res1.rows}">
 <c:set var="sco" scope="application" value="1"/>
 <c:set var="num" value="${row.number}"/>
 </c:forEach>
<br>

<c:choose>
<c:when test="${sco eq 1}">
<br>
<p>Outpass available.The number of outpasses left is:</p><br>
<c:out value="${num}"/>
<br>

<a href="fromtend.html">To get the outpass,click here</a>
 <c:set var="sco" scope="application" value="0"/>
 <c:set var="num" value="0"/>
</c:when>
<c:otherwise>
  <p><b>No more outpass available</b></p>
  <c:set var="sco" scope="application" value="0"/>
   <c:set var="num" value="0"/>
</c:otherwise>
</c:choose>

<form method=POST action="fromtend.html">
 <p>If you want to logout and come back later,click the button below</p>
 <br>
 <button class="btn btn-primary" style="font-size:25px;"type="submit">Logout</button>
 </form>
</div>

 <br>
<br> 
  </body>
</html>
