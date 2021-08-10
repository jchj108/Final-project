<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>WorkHome</title>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
  <!-- /.login-logo -->
  <div class="card card-outline card-primary">
    <div class="card-header text-center">
      <a href="../../index2.html" class="h1"><b>WorkHome</b></a>
    </div>
    <div class="card-body">
      <p class="login-box-msg"></p>
      <form action="login.emp" method="post" onsubmit="return login();">
        <div class="input-group mb-3">
          <input type="text" id="empNo" name="empNo" class="form-control" placeholder="사원번호">
          <div class="input-group-append">
            <div class="input-group-text">
              <span class="fas fa-address-card""></span>
            </div>
          </div>
        </div>
        <div class="input-group mb-3">
          <input type="password" id="password" name="password" class="form-control" placeholder="비밀번호">
          <div class="input-group-append">
            <div class="input-group-text">
              <span class="fas fa-lock"></span>
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-8">
            <div class="icheck-primary">
              <input type="checkbox" id="remember" name="remember">
              <label for="remember">
                 로그인 상태 유지
              </label>
            </div>
          </div>
          <!-- /.col -->
          <div class="col-4">
            <button type="submit" class="btn btn-primary btn-block">로그인</button>
          </div>
          <!-- /.col -->
        </div>
      </form>
   
      <p class="mb-1">
        <a href="findPwdForm.emp">비밀번호 찾기</a>
      </p>
      <p class="mb-0">
        <a href="signUpForm.emp" class="text-center">회원가입</a>
      </p>
    </div>
    <!-- /.card-body -->
  </div>
  <!-- /.card -->
</div>
<!-- /.login-box -->

<script>
	// 로그인 실패 시 나타나는 팝업창
	if('${ msg }' != ''){ 
		alert('${ msg }');
	}	
	
	// 로그인 시 미입력 항목 확인 메소드 
	function login(){
		if($('#empNo').val().trim() == ''){
			alert('사원번호를 입력해주세요.');
			$('#id').focus();
			return false;
		} else if($('#password').val().trim() == '') {
			alert('비밀번호를 입력해주세요.');
			$('#password').focus();
			return false;
		} else {
			return true;
		}
	}
</script>

<!-- jQuery -->
<script src="resources/plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap -->
<script src="resources/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- AdminLTE -->
<script src="resources/dist/js/adminlte.min.js"></script>	
</body>
</html>
