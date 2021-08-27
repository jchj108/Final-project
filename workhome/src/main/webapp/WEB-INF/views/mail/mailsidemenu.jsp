<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="col-md-3">
		<a href="send.mail" class="btn btn-primary btn-block mb-3">메일 쓰기</a>

		<div class="card">
			<div class="card-header">
				<h3 class="card-title">보관함</h3>

				<div class="card-tools">
					<button type="button" class="btn btn-tool" data-card-widget="collapse">
						<i class="fas fa-minus"></i>
					</button>
				</div>
			</div>
			<div class="card-body p-0">
				<ul class="nav nav-pills flex-column">
					<li class="nav-item"><a href="${contextPath }/alllist.mail" class="nav-link alllist"> <i class="fas fa-envelope mail-icon"></i> 전체메일
					</a></li>
					<li class="nav-item active"><a href="${contextPath }/receivelist.mail" class="nav-link receivelist"> <i
							class="far fa-envelope-open mail-icon"
						></i> 받은메일함 <c:if test="${count != 0 }">
								<span class="badge bg-primary float-right"> ${count } </span>
							</c:if>
					</a></li>
					<li class="nav-item"><a href="${contextPath }/sendlist.mail" class="nav-link sendlist"> <i class="far fa-paper-plane mail-icon"></i>
							보낸메일함
					</a></li>
					<li class="nav-item"><a href="${contextPath}/templist.mail" class="nav-link templist"><i class="far fa-file-alt mail-icon"></i> 임시보관함 </a></li>
					<li class="nav-item"><a href="${contextPath }/favoriteslist.mail" class="nav-link favoriteslist"> <i class="far fa-star favorites" id="favorites-icon"></i>즐겨찾기<span
							class="badge bg-warning float-right mail-icon"
						>65</span>
					</a></li>
					<li class="nav-item"><a href="${contextPath }/deletelist.mail" class="deletelist nav-link"> <i class="far fa-trash-alt mail-icon"></i> 휴지통
					</a></li>
				</ul>
			</div>
			<!-- /.card-body -->
		</div>
		<!-- /.card -->
		<div class="card">
			<!-- 			<div class="card-header"> -->
			<!-- 				<h3 class="card-title">휴지통</h3> -->

			<!-- 				<div class="card-tools"> -->
			<!-- 					<button type="button" class="btn btn-tool" data-card-widget="collapse"> -->
			<!-- 						<i class="fas fa-minus"></i> -->
			<!-- 					</button> -->
			<!-- 				</div> -->
			<!-- 			</div> -->
			<!-- 			<div class="card-body p-0"> -->
			<!-- 				<ul class="nav nav-pills flex-column"> -->
			<!-- 					<li class="nav-item"><a href="#" class="nav-link"> <i class="far fa-circle text-danger"></i> 긴급 -->
			<!-- 					</a></li> -->
			<!-- 					<li class="nav-item"><a href="#" class="nav-link"> <i class="far fa-circle text-warning"></i> 보통 -->
			<!-- 					</a></li> -->
			<!-- 					<li class="nav-item"><a href="#" class="nav-link"> <i class="far fa-circle text-primary"></i> 낮음 -->
			<!-- 					</a></li> -->
			<!-- 				</ul> -->
			<!-- 			</div> -->
			<!-- /.card-body -->
		</div>
		<!-- /.card -->
	</div>

	<script>
		// 페이지에 따라 메뉴 하이라이트
		var url = window.location.href;
		var lastIndex = url.lastIndexOf('/') + 1;
		var url = url.substr(lastIndex, url.length);

		if (url == 'alllist.mail') {
			$('.alllist').css({
				"color" : "#007BFF",
				"font-weight" : "bold"
			});
		} else if (url == 'receivelist.mail') {
			$('.receivelist').css({
				"color" : "#007BFF",
				"font-weight" : "bold"
			});
		} else if (url == 'sendlist.mail') {
			$('.sendlist').css({
				"color" : "#007BFF",
				"font-weight" : "bold"
			});
		} else if (url == 'templist.mail') {
			$('.templist').css({
				"color" : "#007BFF",
				"font-weight" : "bold"
			});
		} else if (url == 'deletelist.mail') {
			$('.deletelist').css({
				"color" : "#007BFF",
				"font-weight" : "bold"
			});
		} else if (url == 'favoriteslist.mail') {
			$('.favoriteslist').css({
				"color" : "#007BFF",
				"font-weight" : "bold"
		}
	</script>
</body>
</html>