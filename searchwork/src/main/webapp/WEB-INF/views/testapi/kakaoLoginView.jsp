<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>kakaoLoginView</title>
<style type="text/css">
h1 {
	font-size: 48pt;
	color: navy;
}

div {
	width: 500px;
	height: 200px;
	border: 2px solid navy;
	position: relative;
	left: 200px;
}

div form {
	font-size: 16pt;
	color: navy;
	font-weight: bold;
	margin: 10px;
	padding: 10px;
}

div#loginForm form input.pos {
	position: absolute;
	left: 120px;
	width: 300px;
	height: 25px;
}

div#loginForm form input[type=submit] {
	margin: 10px;
	width: 250px;
	height: 40px;
	position: absolute;
	left: 120px;
	background: navy;
	color: white;
	font-size: 16pt;
	font-weight: bold;
}
</style>
<script type="text/javascript" src="${pageContext.servletContext.contextPath}/resources/js/jquery-3.6.1.min.js"></script>
<script src="${pageContext.servletContext.contextPath}/resources/js/kakao.min.js"></script>
<script>
	//발급받은 키 중 javascript키를 사용해준다.
	Kakao.init('0874d4b0d4aba7c91a4fb77d9a303727');
	console.log(Kakao.isInitialized()); // sdk초기화여부판단
	//카카오로그인
	function kakaoLogin() {
		Kakao.Auth.login({
			success : function(response) {				
				Kakao.API.request({
					url : '/v2/user/me',
					success : function(response) {
						console.log(response)
					},
					fail : function(error) {
						console.log(error)
					},
				})
			},
			fail : function(error) {
				console.log(error);				
			},
		})
	}
	
	//카카오로그아웃  
	function kakaoLogout() {
	    if (Kakao.Auth.getAccessToken()) {
	      Kakao.API.request({
	        url: '/v1/user/unlink',
	        success: function (response) {
	        	console.log(response)
	        },
	        fail: function (error) {
	          console.log(error)
	        },
	      })
	      Kakao.Auth.setAccessToken(undefined)
	    }
	  }  
</script>
</head>
<body>
	<h1>first 로그인</h1>
	<div id="loginForm">		
		<form action="login.do" method="post">
			<label>아이디 : <input type="text" name="userid" id="uid"
				class="pos"></label> <br> <label>암 호 : <input
				type="password" name="userpwd" id="upwd" class="pos"></label> <br>
			<input type="submit" value="로그인">
		</form>
	</div>
	<hr>
	<center>	
		<H4>이미지 클릭시 전송온 토큰과 정보 확인</H4>	
		<img src="${pageContext.servletContext.contextPath}/resources/images/kakao_login.png" 
		onclick="kakaoLogin();"> <br>
		<button onclick="kakaoLogout();">카카오 로그아웃</button>
	</center>
	<center>	
	<H4>등록된 카카오계정으로 로그인 서블릿으로 연결 처리</H4>
	<h6>카카오 개발자 사이트 계정관리에서 로그아웃하면, 카카오 로그인 폼이 나타남</h6>
	<a href="https://kauth.kakao.com/oauth/authorize?client_id=0874d4b0d4aba7c91a4fb77d9a303727&redirect_uri=http://localhost:8080/first/kakaologin&response_type=code">	
		<img src="/first/resources/images/kakao_login.png">
	</a> 
	</center>
	<center>	
	<H4>다른 계정으로 로그인 서블릿으로 연결 처리</H4>
	<h6>카카오 로그인 폼이 나타남</h6>
	<!-- 포트번호, context-root명, 서블릿 url-mapping, 자바스크립트 앱 키 변경 필요함 -->
	<a href="https://accounts.kakao.com/login?continue=https%3A%2F%2Fkauth.kakao.com%2Foauth%2Fauthorize%3Fresponse_type%3Dcode%26redirect_uri%3Dhttp%253A%252F%252Flocalhost%253A8080%252Ffirst%252Fkakaologin%26client_id%3D0874d4b0d4aba7c91a4fb77d9a303727">	
		<img src="/first/resources/images/kakao_login.png">
	</a> 
	</center>
<hr>
<a href="https://developers.kakao.com/docs/latest/ko/kakaologin/common">
카카오 로그인 설명 페이지로 이동</a>
<br>
<p>
실행 흐름 : <br>
카카오 로그인 이미지 클릭 
&gt; 사이트에서 카카오 로그인 창 보여짐
&gt; 클라이언트가 로그인 정보 입력  
&gt; 로그인 요청  
&gt; 동의 항목 체크  
&gt; 카카오 API 서버로 넘겨짐  
&gt; 카카오 서버는 전달받은 데이터 식별하고 클라이언트에게 토큰 발급
&gt; 발급된 토큰을 활용하여 로그인 코드 작성함
</p>
<HR>
<P>
애플리케이션 설정 : <BR>
1. 회원가입 : https://developers.kakao.com/<br>
2. 내 애플리케이션 &gt; 애플리케이션 추가하기 (임의대로 작성) 
&gt; 저장 <br>
3. 작성된 앱 클릭 &gt; 플랫폼 클릭 &gt; url 등록 
(http://localhost:포트번호) <br>
4. url 등록 후 Redirect URI 등록 : 등록하러 가기 (필수: 등록해야 사용할 수 있음)
<br> 활성화 설정 ON 으로 바꿈<BR>
* redirect uri : http://localhost:포트번호/context-root명/로그인-url-mapping
<br>
로그아웃용 uri 도 등록함 : <br>
redirect uri : http://localhost:포트번호/context-root명/로그아웃-url-mapping
5. (선택사항)제품설정 &gt; 동의항목 
&gt; 필요한 동의항목 설정함 (컨트롤러로 전달되는 값이 됨.)<BR>
6. 앱키에서 JavaScript 키를 복사함 <br>
<br>
7. 뷰 페이지 작성 : 카카오 로그인 버튼 만들기<br>
8. 자바스크립트용 : 사용할 카카오 로그인용 자바스크립트 소스 추가함 <br>
cdn방식 : https://developers.kakao.com/sdk/js/kakao.js<br>
sdk 다운받기 : https://developers.kakao.com/docs/latest/ko/sdk-download/js <br>
src="/first/resources/js/kakao.min.js" 로 javascript 태그 작성함<br>
<br>
서버측 컨트롤러로 연결 요청시 : <br>
버튼 또는 이미지 클릭시 설정 url 은 아래와 같이 작성함 <br>
https://kauth.kakao.com/oauth/authorize?
client_id=자바스크립트앱키&
redirect_uri=등록된 로그인용 redirect uri 입력
&response_type=code <br>
9. 로그아웃 컨트롤러 연결시 : <br>
https://kauth.kakao.com/oauth/authorize?
client_id=자바스크립트앱키&
redirect_uri=등록된 로그아웃용 redirect uri 입력
&response_type=code
</P>	
</body>
</html>