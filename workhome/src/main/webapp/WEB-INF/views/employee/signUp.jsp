<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>WorkHome</title>

  <!-- Google Font: Source Sans Pro -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
  <!-- icheck bootstrap -->
  <link rel="stylesheet" href="plugins/icheck-bootstrap/icheck-bootstrap.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="dist/css/adminlte.min.css">
</head>
<body class="hold-transition register-page">
<div class="register-box">
  <div class="card card-outline card-primary">
    <div class="card-header text-center">
      <a href="../../index2.html" class="h1"><b>WorkHome</b></a>
    </div>
    <div class="card-body">
      <p class="login-box-msg"></p>

	<!-- 회원가입 폼 -->
      <form action="insert.emp" method="post" onsubmit="return signUp();">
      
      <!-- 이름  -->
        <div class="input-group mb-3">
          <input type="text" id="name" name="empName" class="form-control" placeholder="이름">
          <div class="input-group-append">
            <div class="input-group-text">
              <span class="fas fa-user"></span>
            </div>
          </div>
        </div>
        
        <!-- 이메일 -->
        <div class="input-group mb-3">
          <input type="email" id="email" name="email" class="form-control" placeholder="이메일">
          <div class="input-group-append">
            <div class="input-group-text">
              <span class="fas fa-envelope"></span>
            </div>
          </div>
        </div>
        
		<!-- 비밀번호 -->
        <div class="input-group mb-3">
          <input type="password" id="pwd1" name="password" class="form-control" placeholder="비밀번호(8~15자)" onkeyup="checkPwd();">
          <div class="input-group-append">
            <div class="input-group-text">
              <span class="fas fa-lock"></span>
            </div>
          </div>
        </div>
        
        <!-- 비밀번호 확인  -->
        <div class="input-group mb-3">
          <input type="password" id="pwd2" name="pwd2" class="form-control" placeholder="비밀번호확인" onkeyup="checkPwd();">
          <div class="input-group-append">
            <div class="input-group-text">
              <span class="fas fa-lock"></span>
            </div>
          </div>
        </div>
        
        <!-- 비밀번호 일치/불일치 확인 문구 -->
		<span id="check" style="font-size: 15px; font-weight: normal;">&nbsp;</span><br>
		
		<!-- 약관동의  -->
        <div class="row">
          <div class="col-8">
            <div class="icheck-primary">
              <input type="checkbox" id="agreeTerms" name="agreeTerms">
              <label for="agreeTerms">
               <a href="#">약관</a>에 동의합니다.
              </label>
            </div>
          </div>
          
          <!-- /.col -->
          <div class="col-4">
            <button type="submit" class="btn btn-primary btn-block">회원가입</button>
          </div>
          <!-- /.col -->
        </div>
      </form>
	<br>
      이미 아이디가 존재한다면? <a href="${ contextPath }" class="text-center">로그인</a>
    </div>
    <!-- /.form-box -->
  </div><!-- /.card -->
</div>
<!-- /.register-box -->

<script>

	/* 비밀번호 일치/불일치 확인 메소드 */
	function checkPwd() {
		var pwd1 = document.getElementById('pwd1').value;
		var pwd2 = document.getElementById('pwd2').value;
		var check = document.getElementById('check');
	
		if (pwd2 == '' || pwd2.length == 0) {
			check.innerHTML = '';
		} else if (pwd1 != pwd2) {
			check.style.color = 'red';
			check.innerHTML = '비밀번호가 일치하지 않습니다.';
		} else {
			check.style.color = 'green';
			check.innerHTML = '비밀번호가 일치합니다.';
		}
	}
	
	/* 약관동의 확인 메소드 */
	function agree() {
		var agree = document.getElementsByName("agree");

		for (var i = 1; i < (agree.length) - 1; i++) {
			if (agree[i].checked == false) {
				return 1;
			}
		}
		return 2;
	}
	
	/* 회원가입시 빠진 항목 확인 메소드 */
	function signUp() {
		var name = document.getElementById('name').value;
		var email = document.getElementById('email').value;
		var pwd1 = document.getElementById('pwd1').value;
		var pwd2 = document.getElementById('pwd2').value;
		var agreeTerms = document.getElementById('agreeTerms');
		
		var regExp = /^[A-Za-z0-9]{8,15}$/;
		
		if (name == '' || name.length == 0) {
			alert('이름을 입력해주세요.');
			document.getElementById('name').focus();
			return false;
		} else if (email == '' || email.length == 0) {
			alert('이메일을 입력해주세요.');
			document.getElementById('email').focus();
			return false;
		} else if (pwd1 == '' || pwd1.length == 0) {
			alert('비밀번호를 입력해주세요.');
			document.getElementById('pwd1').focus();
			return false;
		} else if (pwd2 == '' || pwd2.length == 0) {
			alert('비밀번호 확인을 입력해주세요.');
			document.getElementById('pwd2').focus();
			return false;
		} else if (document.getElementById('check').style.color == 'red' || pwd1 != pwd2) {
			alert('비밀번호가 일치하지 않습니다.');
			document.getElementById('pwd2').value = '';
			document.getElementById('pwd2').focus();
			return false;
		} else if (!regExp.test(pwd1)) {
			alert('비밀번호가 조건에 맞지 않습니다');
			document.getElementById('pwd1').value = '';
			document.getElementById('pwd2').value = '';
			document.getElementById('pwd1').focus();
			return false;
		} else if (agreeTerms.checked == false) {
			alert("이용약관에 동의해주세요.")
			return false;
		} else {
			alert(name + "님, 회원가입이 성공적으로 완료되었습니다.");
			return true;
		}
	}
</script>


<!-- jQuery -->
<script src="plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap 4 -->
<script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- AdminLTE App -->
<script src="dist/js/adminlte.min.js"></script>
</body>
</html>
