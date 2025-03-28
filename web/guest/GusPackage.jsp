<%-- 
    Document   : SearchPackageForm
    Created on : Feb 9, 2025, 1:12:40 AM
    Author     : admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, model.Package" %>

<!DOCTYPE html>
<html>
<head>
    <title>Tìm kiếm gói khám</title>
    <style>
    body { 
        font-family: Arial, sans-serif; 
        background-color: #ffffff;
    }
    .container { 
        width: 80%; 
        margin: 0 auto; 
        padding: 20px;
    }
    table { 
        width: 100%; 
        border-collapse: collapse; 
        margin-top: 20px; 
    }
    th, td { 
        border: 1px solid #1a75ff;
        padding: 12px; 
        text-align: left; 
    }
    th { 
        background-color: #1a75ff;
        color: #ffffff;
    }
    td a {
        color: #1a75ff;
        text-decoration: none;
    }
    td a:hover {
        text-decoration: underline;
    }
    .error { 
        color: red; 
    }
    .search-container { 
        margin: 20px 0;
        display: flex;
        gap: 10px;
    }
    input[type="text"], select, button {
        padding: 8px 12px;
        border: 1px solid #1a75ff;
        border-radius: 4px;
    }
    select {
        min-width: 150px;
    }
    button {
        background-color: #1a75ff;
        color: #ffffff;
        cursor: pointer;
        border: none;
        padding: 8px 16px;
        border-radius: 4px;
    }
    button:hover {
        background-color: #004de6;
    }
    .package-card {
        border: 1px solid #e0e0e0;
        padding: 20px;
        margin-bottom: 20px;
        border-radius: 8px;
        box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    }
    .package-image {
        width: 64px;
        height: 64px;
        margin-bottom: 10px;
    }
    .price {
        color: #1a75ff;
        font-size: 1.2em;
        font-weight: bold;
    }
    .original-price {
        color: #999;
        text-decoration: line-through;
        margin-left: 8px;
    }
    .pagination {
        margin-top: 20px;
        display: flex;
        justify-content: center;
        gap: 8px;
    }
    .pagination a {
        color: #1a75ff;
        padding: 8px 12px;
        text-decoration: none;
        border: 1px solid #1a75ff;
        border-radius: 4px;
    }
    .pagination a.active {
        background-color: #1a75ff;
        color: white;
    }
    </style>
</head>
<body>
    <jsp:include page="../Header.jsp"></jsp:include>
     <div class="container">
        <h2>Tìm kiếm gói khám</h2>
        
        <form action="SearchPackage" method="get" class="search-container">
            <input type="text" name="keyword" placeholder="Nhập từ khóa..." value="${param.keyword}">
            
            <select name="category">
                
                <c:forEach var="cat" items="${categories}">
                    <option value="${cat}" ${param.category == cat ? 'selected' : ''}>${cat}</option>
                </c:forEach>
            </select>

            <button type="submit">Tìm kiếm</button>
        </form>

        <c:if test="${not empty error}">
            <p class="error">${error}</p>
        </c:if>

        <c:choose>
            <c:when test="${not empty packages}">
                <div class="packages-grid">
                    <c:forEach var="pkg" items="${packages}">
                        <div class="package-card">
<!--                            <img src="" alt="${pkg.name}" class="package-image">-->
                            <h3><a href="packageDetail?id=${pkg.id}">${pkg.name}</a></h3>
                            <p>${pkg.description}</p>
                            <div>
                                <span class="price">${pkg.price}đ</span>

                            </div>
                            <p>Thời gian: ${pkg.durationMinutes} phút</p>
                            <p>Danh mục: ${pkg.category}</p>
                            <button onclick="location.href='appointment?id=${pkg.id}'">Đặt khám ngay</button>
                        </div>
                    </c:forEach>
                </div>
                
                <c:if test="${totalPages > 1}">
                    <div class="pagination">
                        <c:if test="${currentPage > 1}">
                            <a href="?page=${currentPage - 1}&keyword=${param.keyword}&category=${param.category}">&laquo; Trước</a>
                        </c:if>
                        
                        <c:forEach begin="1" end="${totalPages}" var="i">
                            <a href="?page=${i}&keyword=${param.keyword}&category=${param.category}" 
                               class="${i == currentPage ? 'active' : ''}">${i}</a>
                        </c:forEach>
                        
                        <c:if test="${currentPage < totalPages}">
                            <a href="?page=${currentPage + 1}&keyword=${param.keyword}&category=${param.category}">Sau &raquo;</a>
                        </c:if>
                    </div>
                </c:if>
            </c:when>
            <c:otherwise>
                <p>Không tìm thấy gói khám nào.</p>
            </c:otherwise>
        </c:choose>
    </div>
    <jsp:include page="../Footer.jsp"></jsp:include>
    </body>
</html>
