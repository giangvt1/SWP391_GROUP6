<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
  <head>
      <meta charset="UTF-8">
      <title>Update Profile</title>
      <link href="../css/admin/bootstrap.min.css" rel="stylesheet" type="text/css"/>
      <link href="../css/admin/styleAdmin.css" rel="stylesheet" type="text/css"/>
      <style>
          /* Nếu sidebar có chiều rộng khoảng 250px, thêm margin-left cho nội dung chính */
          .main-content {
              margin-top: 50px;
              margin-left: 260px; /* Điều chỉnh theo chiều rộng của sidebar */
              padding: 20px;
          }
          .alert {
              margin-top: 20px;
          }
          .profile-img {
              margin-bottom: 15px;
          }
      </style>
      <script>
          // Hàm chuẩn hóa chuỗi: thay thế nhiều khoảng trắng liên tiếp bằng 1 khoảng trắng và trim
          function normalizeString(str) {
              return str.replace(/\s+/g, " ").trim();
          }
          
          function validateProfile() {
              var fullnameField = document.getElementById("fullname");
              var addressField = document.getElementById("address");
              var dobField = document.getElementById("dob");
              
              var fullname = fullnameField.value.trim();
              var normalizedFullname = normalizeString(fullnameField.value);
              if (fullname === "") {
                  alert("Full Name is required.");
                  fullnameField.focus();
                  return false;
              }
              if (fullname !== normalizedFullname) {
                  alert("Full Name must not contain multiple consecutive spaces.");
                  fullnameField.focus();
                  return false;
              }
              
              var address = addressField.value.trim();
              if (address !== "") {
                  var normalizedAddress = normalizeString(addressField.value);
                  if (address !== normalizedAddress) {
                      alert("Address must not contain multiple consecutive spaces.");
                      addressField.focus();
                      return false;
                  }
                  if (address.length > 50) {
                      alert("Address must not exceed 50 characters.");
                      addressField.focus();
                      return false;
                  }
              }
              return true;
          }
      </script>
  </head>
  <body>
      <jsp:include page="../admin/AdminHeader.jsp" />
      <jsp:include page="../admin/AdminLeftSideBar.jsp" />
      
      <div class="container main-content">
          <h2>Update Profile</h2>
          
          <!-- Hiển thị thông báo thành công hoặc lỗi -->
          <c:if test="${not empty successMessage}">
              <div class="alert alert-success">${successMessage}</div>
          </c:if>
          <c:if test="${not empty errorMessage}">
              <div class="alert alert-danger">${errorMessage}</div>
          </c:if>
          
          <form action="${pageContext.request.contextPath}/system/profile" method="POST" enctype="multipart/form-data" onsubmit="return validateProfile();">
              <!-- Phần upload ảnh -->
              <div class="form-group">
                  <label for="img">Profile Image (JPG or PNG only)</label>
                  <c:if test="${not empty staff.img}">
                      <div class="profile-img">
                          <img src="${pageContext.request.contextPath}/${staff.img}" alt="Profile Image" class="img-thumbnail" width="150"/>
                      </div>
                  </c:if>
                  <input type="file" class="form-control-file" id="img" name="img" accept=".jpg,.png">
              </div>
              
              <div class="form-group">
                  <label for="fullname">Full Name</label>
                  <input type="text" class="form-control" id="fullname" name="fullname" value="${staff.fullname}" required>
              </div>
              <div class="form-group">
                  <label for="gender">Gender</label>
                  <select class="form-control" id="gender" name="gender">
                      <option value="true" <c:if test="${staff.gender}">selected</c:if>>Male</option>
                      <option value="false" <c:if test="${!staff.gender}">selected</c:if>>Female</option>
                  </select>
              </div>
              <div class="form-group">
                  <label for="address">Address</label>
                  <input type="text" class="form-control" id="address" name="address" value="${staff.address}">
              </div>
              <div class="form-group">
                  <label for="dob">Date of Birth</label>
                  <input type="date" class="form-control" id="dob" name="dob" value="${staff.dob}">
              </div>
              <br>
              <button type="submit" class="btn btn-primary">Save Profile</button>
          </form>
      </div>
      
      <script src="../js/jquery.min.js"></script>
      <script src="../js/bootstrap.min.js"></script>
      <script src="../js/main.js"></script>
  </body>
</html>
