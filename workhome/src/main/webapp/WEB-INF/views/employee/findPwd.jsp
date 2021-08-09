<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>WorkHome</title>

  <!-- Google Font: Source Sans Pro -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="resources/plugins/fontawesome-free/css/all.min.css">
  <!-- icheck bootstrap -->
  <link rel="stylesheet" href="resources/plugins/icheck-bootstrap/icheck-bootstrap.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="resources/dist/css/adminlte.min.css">
</head>
<body class="hold-transition login-page">
<div class="login-box">
  <div class="card card-outline card-primary">
    <div class="card-header text-center">
      <a href="../../index2.html" class="h1"><b>WorkHome</b></a>
    </div>
    <div class="card-body">
      <p class="login-box-msg" style="font-size: 14px;">기존에 가입한 이메일 주소 입력 시 <br> 임시 비밀번호가 발급됩니다.</p>
      <form action="findPwd.emp" method="post" onsubmit="return findPwd();">
        <div class="input-group mb-3">
          <input type="email" id="email" name="email" class="form-control" placeholder="이메일">
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
        <a href="${ contextPath }">로그인</a>
      </p>
    </div>
    <!-- /.login-card-body -->
  </div>
</div>
<!-- /.login-box -->

<!-- 이메일 입력 확인 -->
<script>
	function findPwd(){
		if ($('#email').val().trim() == '') {
			alert("이메일을 입력해주세요.");
			$('#email').focus();
			return false;
		} else {
			return true;
		}
	}
	
	
	if('${ msg }' != ''){ 
		alert('${ msg }');
	}	
</script>

<!-- jQuery -->
<script src="resources/plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap 4 -->
<script src="resources/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- AdminLTE App -->
<script src="resources/dist/js/adminlte.min.js"></script>
</body>
</html>
