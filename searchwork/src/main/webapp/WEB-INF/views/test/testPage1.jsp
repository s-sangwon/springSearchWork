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
<button id="saveBtn">사진 파일업로드</button> &nbsp; &nbsp;
<a href="#" id="downBtn" style="border:1px solid gray;">사진 다운로드</a> <br>
<script type="text/javascript">

	const video = document.getElementById('video');
	const canvas = document.getElementById('canvas');
	const snap = document.getElementById('snap');
	const saveBtn = document.getElementById('saveBtn');
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

	$(function(){
		saveBtn.addEventListener('click', function(){
			var filename = prompt("저장할 파일명을 입력하시오.");			
			
			const canvas = document.getElementById('canvas');

			var img = new Image();
			img.crossOrigin = 'Anonymous';
			
			//const imgBase64 = canvas.toDataURL('image/jpeg', 'image/octet-stream');
			const imgBase64 = imageData;
			const decodImg = atob(imgBase64.split(',')[1]);
			
			let array = [];
			for (let i = 0; i < decodImg.length; i++) {
			  array.push(decodImg.charCodeAt(i));
			}
			
			const file = new Blob([new Uint8Array(array)], {type: 'image/jpeg'});
			//const fileName = 'canvas_img_' + new Date().getMilliseconds() + '.jpg';
			let formData = new FormData();
			formData.append('file', file, filename);
		    
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
		
		//다운로드 클릭시
		const downBtn = document.getElementById("downBtn");
		function download() {
		  const fname = prompt("다운 저장할 파일명.png : ");
		  const image = imageData.replace("image/png", "image/octet-stream");
		  downBtn.setAttribute("href", image);
		  downBtn.setAttribute("download", fname);
		}
		downBtn.addEventListener("click",
		  (e) => (e.target.href = imageData)
		);
	});  //$
</script>
<br><br><br><br><br>
<hr>
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>