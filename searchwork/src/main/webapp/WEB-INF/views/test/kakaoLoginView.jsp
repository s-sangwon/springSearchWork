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
pre { font-size: 12pt; }
</style>
<script type="text/javascript" src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.1.min.js"></script>
<%-- <script type="text/javascript" src="${ pageContext.servletContext.contextPath }/resources/js/kakao.min.js"></script> --%>
<script src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
<script type="text/javascript">
//애플리케이션 등록하고 발급받은 javascript 앱키를 사용해야 함
Kakao.init('b7b4462620f1ccc2046ae205abc86529');
//sdk 초기화여부 판단
console.log(Kakao.isInitialized());

//카카오 로그인
function kakaoLogin(){	
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
<h2>[1단계] 카카오 로그인 api 애플리케이션 설정 : </h2>
<pre>
1. 회원가입 : https://developers.kakao.com/
2. 또는 카카오계정으로 로그인
3. '내 애플리케이션' 선택
 - 애플리케이션 추가하기 (임의대로 작성)
 - 저장
4. 저장된 앱 클릭
 - 플랫폼 클릭
 - web : 사이트 도메인에 url 등록 (http://localhost:8080)
5. url 등록 후 Redirect URI 등록 : 등록하러 가기(필수 : 등록해야 사용할 수 있음)
 - 활성화 설정 ON으로 바꿈
 - redirect uri : http://localhost:포트번호/context-root명/로그인url-mapping
 - 로그아웃 uri 도 같이 추가 등록함
6. (선택사항)제품설정의 카카오로그인
 - 동의항목 선택
 - 필요한 동의항목 지정함 (컨트롤러로 전달되는 값이 됨)
7. 앱키에서 javascript 키를 복사함<br>
</pre>

<h2>[2단계] 뷰 페이지 작성</h2>
<pre>
1. 카카오 로그인 버튼 만들기 (이미지 다운받아 사용해도 됨)
2. 자바스크립트용으로 사용할 카카오 로그인용 자바스크립트 소스 추가함
cdn 방식(제공된 url로 연결) : 
	https://developers.kakao.com/sdk/js/kakao.js
sdk 다운받기 (자바스크립트 소스 js 파일 다운받기) : 
	https://developers.kakao.com/docs/latest/ko/sdk-download/js
 - webapp/resources/js 폴더 아래에 복사해 넣기함
 - script 태그 src="경로/resources/js/kakao.min.js" 추가함	
</pre>
<br>
<hr>
<a href="https://developers.kakao.com/docs/latest/ko/getting-started/sdk-js" target="_blank">
카카오 로그인 코드 설명 페이지로 이동</a>
<br>

<hr>
<h2>실행 흐름 : </h2>
<pre>
1. 카카오 로그인 버튼 클릭
2. 브라우저에 카카오 로그인 창이 나타남
3. 클라이언트가 로그인 정보 입력
4. 로그인 요청됨
5. 동의항목 나타남 - 체크함
6. 카카오 API 서버로 넘겨짐
7. 카카오 서버는 전달받은 데이터를 식별하고 클라이언트에게 토큰 발급함
8. 발급된 토큰을 사용해서 로그인 코드를 작성함
</pre>
<br>
<hr>
<h2>서버측 컨트롤러로 연결 요청시 : </h2>
<pre>
버튼 또는 이미지 클릭시 설정 url 은 아래와 같이 작성함 
https://kauth.kakao.com/oauth/authorize?client_id=자바스크립트앱키&
redirect_uri=등록된 로그인용 redirect uri 입력&response_type=code
로그아웃 컨트롤러 연결시 : 
https://kauth.kakao.com/oauth/authorize?client_id=자바스크립트앱키&
redirect_uri=등록된 로그아웃용 redirect uri 입력&response_type=code
</pre>

<hr>
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
	<h3>1. 카카오 로그인 버튼 이미지 클릭시에 전송온 토큰과 정보 확인</h3>
	<img src="${ pageContext.servletContext.contextPath }/resources/images/kakao_login.png" 
	onclick="kakaoLogin();"> <br>
	<button onclick="kakaoLogout();">카카오 로그아웃</button>
</center>
<center>	
	<H3>2. 등록된 카카오계정으로 로그인 컨트롤러로 연결 처리</H3>
	<h6>카카오 개발자 사이트 계정관리에서 로그아웃하면, 카카오 로그인 폼이 나타남</h6>
	<a href="https://kauth.kakao.com/oauth/authorize?response_type=code&client_id=b7b4462620f1ccc2046ae205abc86529&redirect_uri=http://localhost:8080/first/kakaologin.do&code=UC4n83dVZSGYODmqUKIPUCj2ZwsCBe1eTFnu_xvXoY1sCg28D0p2AFUfyE7ilgiExGntgAorDKcAAAGD9JtG4w">	
		<img src="${ pageContext.servletContext.contextPath }/resources/images/kakao_login.png">
	</a> 
	</center>
	<center>	
	<H3>3. 다른 계정으로 로그인 컨트롤러로 연결 처리</H3>
	<h6>카카오 로그인 폼이 나타남</h6>
	<!-- 포트번호, context-root명, 서블릿 url-mapping, 자바스크립트 앱 키 변경 필요함 -->
	<a href="https://accounts.kakao.com/login?continue=https://kauth.kakao.com/oauth/authorize?response_type=code&redirect_uri=http://localhost:8080/first/kakaologin.do/client_id=b7b4462620f1ccc2046ae205abc86529">	
		<img src="${ pageContext.servletContext.contextPath }/resources/images/kakao_login.png">
	</a> 
	</center>
	<center>
	<a href="#" onclick="test();">테스트</a>
	</center>

<script type="text/javascript">
function test(){
	Kakao.Auth.login({
        success: function(authObj) {
          //alert(JSON.stringify(authObj))
          Kakao.API.request({
              url: '/v2/user/me',
              success: function(response) {
                  let id = "kakao_" + response.id;
                  let email = (response.kakao_account.email != undefined ? response.kakao_account.email : '');
                  
                  let properties = response.properties;
                  let name = properties.nickname;
                  let profile_image = properties.profile_image;
                  
                  let member = {
                      id : id,
                      password : id,
                      email : email,
                      name : name,
                      profile : profile_image,
                      snsyn : 'Y'
                  }
                  kakaoLogin(member).then(res => {
                      if(res.status == 200){
                          getLoginInfo().then(result => {
                              if(result.status == 200){
                                  setLoginInfo(result.data);
                                  closeLoginPop();
                              }
                          })
                      }
                  })

              },
              fail: function(error) {
                  console.log(error);
              }
          });
        },
        fail: function(err) {
          alert(JSON.stringify(err))
        },
      })
}

</script>

<br><br><br><br><br><br><br><br><br><br><br><br>
</body>
</html>




