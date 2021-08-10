<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
      
      <!-- 사원번호  -->
        <div class="input-group mb-3">
          <input type="text" id="empNo" name="empNo" class="form-control" placeholder="사원번호">
          <div class="input-group-append">
            <div class="input-group-text">
              <span class="fas fa-address-card"></span>
            </div>
          </div>
        </div>
        
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
          <input type="hidden" name="emailDuplicateCheck" id="emailDuplicateCheck" value="0">
          <div class="input-group-append">
            <div class="input-group-text" id="sendEmail" style="cursor: pointer;">
              <span class="fas fa-envelope"></span>
            </div>
          </div>
        </div>
        
        <!-- 이메일 인증 코드  -->
        <div class="input-group mb-3">
          <input type="text" id="checkCode" name="checkCode" class="form-control" placeholder="인증코드" onkeyup="checkEmail();">
          <input type="hidden" name="emailCodeCheck" id="emailCodeCheck" value="0">
            <div class="input-group-text" id="sendEmail">
              <span class="fas fa-check"></span>
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
        
        <!-- 확인 문구 -->
		<span id="check" style="font-size: 15px; font-weight: normal;">&nbsp;</span><br><br>
		
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
	// 이메일 중복 확인 메소드
	$('#email').on('keyup', function(){
		var email = $(this).val().trim();
		
		$.ajax({
			url: 'dupEmail.emp',
			data: {email: email},
			success: function(data){
				if(data.trim() == 'true'){
					$('#check').text('사용 가능한 이메일입니다.').css('color', 'green');
					$('#emailDuplicateCheck').val(1);
				} else {
					$('#check').text('이미 사용 중인 이메일입니다.').css('color', 'red');
					$('#emailDuplicateCheck').val(0);
				}
			},
			error: function(data){
				console.log('fail');
			}
		});
	});	
	
	// 이메일 인증 코드 전송 메소드
	$('#sendEmail').on('click', function(){
		var email = $('#email').val().trim();
		
		$.ajax({
			url: 'authEmail.emp',
			data: {email: email},
			success: function(data){
				console.log('success');
			},
			error: function(data){
				console.log('fail');
				$('#check').text('인증번호를 발송했습니다.').css('color', 'green');
			}
		});
	});	

	// 인증 코드 확인 메소드
	$('#checkCode').on('keyup', function(){
		var checkCode = $(this).val().trim();
		
		$.ajax({
			url: 'checkCode.emp',
			data: {checkCode: checkCode},
			success: function(data){
				if(data.trim() == 'true'){
					console.log('최종!!');
					$('#check').text('이메일 인증이 완료되었습니다.').css('color', 'green');
					$('#emailCodeCheck').val(1);
				} else {
					$('#check').text('인증번호를 다시 확인해주세요.').css('color', 'red');
					$('#emailCodeCheck').val(0);
				}
			},
			error: function(data){
				console.log('인증 실패');
			}
		});
	});	

	// 비밀번호 일치/불일치 확인 메소드
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
	
	// 회원가입시 미입력 항목 확인 메소드
	function signUp() {
		var empNo = document.getElementById('empNo').value;
		var name = document.getElementById('name').value;
		var email = document.getElementById('email').value;
		var emailDuplicateCheck = document.getElementById('emailDuplicateCheck').value;
		var checkCode = document.getElementById('checkCode').value;
		var pwd1 = document.getElementById('pwd1').value;
		var pwd2 = document.getElementById('pwd2').value;
		var agreeTerms = document.getElementById('agreeTerms');
		
		var regExp = /^[A-Za-z0-9]{8,15}$/;
		if (empNo == '' || empNo.length == 0) {
			alert('사원번호를 입력해주세요.');
			document.getElementById('empNo').focus();
			return false;
		} else if (name == '' || name.length == 0) {
			alert('이름을 입력해주세요.');
			document.getElementById('name').focus();
			return false;
		} else if (email == '' || email.length == 0) {
			alert('이메일을 입력해주세요.');
			document.getElementById('email').focus();
			return false;
		} else if (emailDuplicateCheck == 0) {
			alert('이미 사용 중인 이메일 입니다.');
			document.getElementById('email').focus();
			return false;
		} else if (checkCode == 0) {
			alert('인증번호가 일치하지 않습니다.');
			document.getElementById('checkCode').focus();
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
<script src="resources/plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap 4 -->
<script src="resources/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- AdminLTE App -->
<script src="resources/dist/js/adminlte.min.js"></script>
</body>
</html>
