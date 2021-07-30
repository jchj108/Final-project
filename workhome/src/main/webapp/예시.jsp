<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>AdminLTE 3 | Dashboard 3</title>
  <!-- Google Font: Source Sans Pro -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  <!-- Font Awesome Icons -->
  <link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
  <!-- IonIcons -->
  <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="dist/css/adminlte.min.css">
</head>
<!--
`body` tag options:

  Apply one or more of the following classes to to the body tag
  to get the desired effect

  * sidebar-collapse
  * sidebar-mini
-->
<body class="hold-transition sidebar-mini">
<div class="wrapper">
  <!-- header -->
  <jsp:include page="header.jsp"></jsp:include>
  <!-- /header -->
  
  <!-- sidebar -->
  <jsp:include page="sidebar.jsp"></jsp:include>
  <!-- /sidebar -->
  
  <!-- 메인 컨텐츠 -->
  <div class="content-wrapper" align="center">
	<section class="content">
		<div class="container-fluid">
			<div class="login-box">
		 	  <div class="card card-outline card-primary">
			    <div class="card-header text-center">
			      <a href="../../index2.html" class="h1"><b>WorkHome</b></a>
			    </div>
			    <div class="card-body">
			      <p class="login-box-msg">비밀번호를 찾고자 하는 이메일을 입력해 주세요.</p>
			      <form action="findPwd.me" method="post" onsubmit="return findPwd();">
			        <div class="input-group mb-3">
			          <input type="email"  id="email" name="email" class="form-control" placeholder="이메일">
			          <div class="input-group-append">
			            <div class="input-group-text">
			              <span class="fas fa-envelope"></span>
			            </div>
			          </div>
			        </div>
			        <div class="row">
			          <div class="col-12">
			            <button type="submit" class="btn btn-primary btn-block">임시 비밀번호 발급</button>
			          </div>
			          <!-- /.col -->
			        </div>
			      </form>
			      <p class="mt-3 mb-1">
			        <a href="login.html">Login</a>
			      </p>
			    </div>
			    <!-- /.login-card-body -->
			  </div>
			</div>
		</div>
	</section>	
</div>
  <!-- /메인 컨텐츠 -->
  
  <!-- footer -->
  <jsp:include page="footer.jsp"></jsp:include>
  <!-- /footer -->
  
</div>
<!-- ./wrapper -->

<!-- REQUIRED SCRIPTS -->

<!-- jQuery -->
<script src="plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap -->
<script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- AdminLTE -->
<script src="dist/js/adminlte.js"></script>

<!-- OPTIONAL SCRIPTS -->
<script src="plugins/chart.js/Chart.min.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="dist/js/demo.js"></script>
<!-- AdminLTE dashboard demo (This is only for demo purposes) -->
<script src="dist/js/pages/dashboard3.js"></script>
</body>
</html>
