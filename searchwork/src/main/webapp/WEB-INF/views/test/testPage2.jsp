<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<script type="text/javascript" 
src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.1.min.js"></script>
<!-- <link rel="stylesheet" href="https://pyscript.net/alpha/pyscript.css" /> --> 
<script defer src="https://pyscript.net/alpha/pyscript.js"></script> 

</head>
<body>
<!-- 절대경로로 대상 파일의 위치를 지정한 경우 -->
<c:import url="/WEB-INF/views/common/menubar.jsp" /> 
<hr>
<br><br><br><br><br>
<!-- 처음 실행시에는 cmd 에서 exe 파일을 직접 한번 실행하고 나서 작동시킴
    또는 배치 스크립트로 서버 구동시 자동 실행이 되도록 설정함 -->
<py-script> 
 import os 
 
 os.system('./resources/python/webBindCV.exe')
</py-script>
<h2>CAMERA</h2>
<img id="video" src="http://localhost:5000/stream?src=0" width="650" height="480">
<br>
<div>
	<button id="snap" type="button">스크린샷 찍기</button> &nbsp; &nbsp; 
	<button type="button" onclick="javascript:location.href='main.do';">시작페이지로 이동</button>
</div>
<br>
<h3>Screenshort Output</h3>
<canvas id="canvas" width="640" height="480"></canvas>
<br>

<script type="text/javascript">

	const video = document.getElementById('video');
	const canvas = document.getElementById('canvas');
	const snap = document.getElementById('snap');
	
	const errorMsgElement = document.getElementById('snapErrorMsg');
	
	const constraints = {
			/* audio: true, */
			/* video: 
				width: 640, height: 360; */
	}
	
	var context = canvas.getContext('2d');
	var imageData = canvas.toDataURL("image/jpeg", 1.0);
	
	snap.addEventListener("click", function(){		   
	   	context.drawImage(video, 0, 0, 640, 480);	   
	});	
</script>

<button id="saveBtn">사진 파일업로드</button> &nbsp; &nbsp;

<script type="text/javascript">

	$('#saveBtn').click(function(){
		var filename = prompt("저장할 파일명을 입력하시오.");
		
		const canvas = document.getElementById('canvas');
		var context = canvas.getContext('2d');
		
		// PNG data url
		//let image_data_url = document.querySelector("#canvas").toDataURL();

		// JPEG data url
		//let image_data_url = document.querySelector("#canvas").toDataURL('image/jpeg');
		
		// PNG base64
		//let image_base64 = document.querySelector("#canvas").toDataURL().replace(/^data:image\/png;base64,/, "");

		// JPEG base64
		//let image_base64 = document.querySelector("#canvas").toDataURL('image/jpeg').replace(/^data:image\/jpeg;base64,/, "");
		
		// PNG file
		let file = null;
		let blob = canvas.toBlob(function(blob) {
						file = new File([blob], filename, { type: 'image/png' });
					}, 'image/png');

		// JPEG file
		//let file = null;
		//let blob = document.querySelector("#canvas").toBlob(function(blob) {
		//				file = new File([blob], filename, { type: 'image/jpeg' });
		//			}, 'image/jpeg');
				
		let formData = new FormData();
		formData.append('file', blob);
	    
	    $.ajax({
	        type : 'post',
	        url : 'saveimg.do',
	        data : formData,
	        enctype: 'multipart/form-data',
	        cache: false,
	        processData : false,	// data 파라미터 강제 string 변환 방지!!
	        contentType : false,	// application/x-www-form-urlencoded; 방지!!
	        success : function (data) {
	        	if(data === "ok"){
	            	alert("이미지 저장 성공");
	        	}
	        },
	        error: function(jqXHR, textStatus, errorThrown){
				console.log("image save error : " + jqXHR 
						+ ", " + textStatus + ", " + errorThrown);
			}
	    }); //ajax
	}); //addEventListener : saveBtn click	
	

</script>
<br><br><br><br><br>
<hr>
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>