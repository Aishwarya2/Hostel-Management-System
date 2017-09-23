<!--Card.jsp-->
<%@page import="java.io.*,java.util.*,java.sql.*"%>
<%@page import="javax.servlet.*,javax.servlet.http.*"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<html>
 <head>
   <title>Card Payment</title>
   <link rel="stylesheet" href="Css/otherback.css">
    <link rel="stylesheet"  href="Css/bootstrap.css">
 <link rel="stylesheet"  href="bootstrap.js">
<style>
*{
font-size:40px;
}
</style>
 </head>
 <body>
 <c:set var="v" scope="application" value="0"/>
 <c:set var="v1" scope="application" value="0"/>
 <sql:setDataSource
	 var="user"
	 url="jdbc:mysql://localhost:3306/hostel"
	 driver="com.mysql.jdbc.Driver"
	 user="myuser" password="xxxx"/> 

<sql:query dataSource="${user}" var="result5">
select balance from card where pin=? and name=?
<sql:param value="${param.pin}"/>
<sql:param value="${s}"/>

</sql:query>


 <c:forEach var="row" items="${result5.rows}">
 <c:set var="v" scope="application" value="1"/>
 </c:forEach>
 
 <c:choose>
 
<c:when test="${v eq 1}">
<c:set var="v" scope="application" value="0"/>
<center> <p style="color:blue">Payment successful</p> </center>
 
 
<c:forEach var="row" items="${result5.rows}">
<c:set var="v1" scope="application" value="${row.balance-sum}"/>
</c:forEach>
<center> <p>Your card balance is:<br> 
<c:out value="${v1}"/></p> </center>

 <sql:update dataSource="${user}" var="result6">
update card set balance=? where name=? 
<sql:param value="${v1}"/>
<sql:param value="${s}"/>
</sql:update>

<sql:update dataSource="${user}" var="result5">
update hosteler set paid=? where hostel_name=?
<sql:param value="paid"/>
<sql:param value="${s}"/>
</sql:update>

 <c:set var="v" scope="application" value="0"/>
 <c:set var="v1" scope="application" value="0"/>
 <form method=POST action="fromtend.html">
 <p>To view updated details,click the button below</p>
 <br>
 <button class="btn btn-primary" style="font-size:25px;"type="submit">Logout</button>
 </form>
</c:when>

<c:otherwise>
 <p align="center">Invalid PIN</p>
</c:otherwise>

</c:choose> 

</body>
</html>
