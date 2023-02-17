<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>kakaoMapView</title>
</head>
<body>
<h1>카카오 지도 서비스 api 테스트</h1>
<p>
카카오 지도 api 도 사용하려면, 카카오 로그인 api 사용과 동일한 순서로 
카카오 개발자 사이트에 로그인하여, 등록된 앱에 대한 자바스크립트 키를 
복사해서 사용함.<br>
script 태그 src 에 src="//dapi.kakao.com/v2/maps/sdk.js?appkey=발급받은 APP KEY를 넣으시면 됩니다."<br>
<br>
Kakao 지도 Javascript API 는 지도와 함께 사용할 수 있는 라이브러리 를 지원하고 있음.<br>
라이브러리는 추가로 불러와서 사용할 수 있도록 되어있음.<br>
* clusterer: 마커를 클러스터링 할 수 있는 클러스터러 라이브러리임.<br>
* services: 장소 검색과 주소-좌표 변환을 할 수 있는 services 라이브러리임.<br>
* drawing: 지도 위에 마커와 그래픽스 객체를 쉽게 그릴 수 있게 그리기 모드를 지원하는 drawing 라이브러리임.<br>
<br>
script 태그에 src="//dapi.kakao.com/v2/maps/sdk.js?appkey=APIKEY&libraries=LIBRARY이름" <br>
로 작성하여 사용함 <br>
</p>
<a href="https://apis.map.kakao.com/web/guide/">카카오 지도 api 가이드</a>
<br>
<a href="https://apis.map.kakao.com/web/sample/">카카오 지도 샘플 페이지</a>
<br>
<hr>

<!-- 지도를 표시할 div 입니다 -->
<div id="map" style="width:500px;height:400px;"></div>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0874d4b0d4aba7c91a4fb77d9a303727"></script>
<script type="text/javascript">
	var container = document.getElementById('map'); // 지도를 표시할 div 
	var options = { //지도를 생성할 때 필요한 기본 옵션
		center : new kakao.maps.LatLng(37.335887, 126.584063), // 지도의 중심좌표 (서울시청)
		level : 15 //지도의 레벨(확대, 축소 정도)
	};

	// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
	var map = new kakao.maps.Map(container, options);
</script>

<hr>
<h1>내 위치 지도에 표시하기</h1>
	위도 : <span id="lat"></span>, 
	경도 : <span id="lng"></span>
	<br>
	
	<script type="text/javascript">
		var lat = 0;
		var lng = 0;
		
		//실행시 권한 요청을 수락하여야 함.
		navigator.geolocation.getCurrentPosition(
				function(position) {
			lat = position.coords.latitude;
			lng = position.coords.longitude;
			
			document.getElementById("lat").innerHTML = lat;
			document.getElementById("lng").innerHTML = lng;
		});
		
	</script>
	
	<!-- 지도를 표시할 div 입니다 -->
	<div id="map" style="width:600px;height:400px;"></div>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0874d4b0d4aba7c91a4fb77d9a303727"></script>
	<script>
		var container = document.getElementById('map'); // 지도를 표시할 div 
		var options = {
			center : new kakao.maps.LatLng(lat, lng), // 지도의 중심좌표
			level : 4 // 지도의 확대 레벨
		};

		// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
		var map = new kakao.maps.Map(container, options);
	</script>
	
<hr>
<h1>지도에 내 위치 마커 표시하기</h1>
	위도 :
	<span id="lat"></span>, 경도 :
	<span id="lng"></span>
	<script type="text/javascript">
		var lat = 0;
		var lng = 0;
		navigator.geolocation.getCurrentPosition(function(position) {
			lat = position.coords.latitude;
			lng = position.coords.longitude;
			console.log(lat + ", " + lng);
			
			document.getElementById("lat").innerHTML = lat;
			document.getElementById("lng").innerHTML = lng;
		});
		
	</script>
	<!-- 지도를 표시할 div 입니다 -->
	<div id="map" style="width: 600px; height: 400px;"></div>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0874d4b0d4aba7c91a4fb77d9a303727"></script>
	<script>
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
			center : new kakao.maps.LatLng(lat, lng), // 지도의 중심좌표
			level : 4
		// 지도의 확대 레벨
		};

		// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
		var map = new kakao.maps.Map(mapContainer, mapOption);

		//마커가 표시될 위치입니다 
		var markerPosition = new kakao.maps.LatLng(lat, lng);

		// 마커를 생성합니다
		var marker = new kakao.maps.Marker({
			position : markerPosition
		});

		// 마커가 지도 위에 표시되도록 설정합니다
		marker.setMap(map);
		
		// 마커가 드래그 가능하도록 설정합니다 
		marker.setDraggable(true); 
	</script>	
	
<hr>
<h1>지도 마커에 정보창 표시하기</h1>
	위도 :
	<span id="lat"></span>, 경도 :
	<span id="lng"></span>
	<script type="text/javascript">
		var lat = 0;
		var lng = 0;
		navigator.geolocation.getCurrentPosition(function(position) {
			lat = position.coords.latitude;
			lng = position.coords.longitude;
		});
		document.getElementById("lat").innerHTML = lat;
		document.getElementById("lng").innerHTML = lng;
	</script>
	<!-- 지도를 표시할 div 입니다 -->
	<div id="map" style="width: 600px; height: 400px;"></div>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0874d4b0d4aba7c91a4fb77d9a303727"></script>
	<script>
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
			center : new kakao.maps.LatLng(lat, lng), // 지도의 중심좌표
			level : 4
		// 지도의 확대 레벨
		};

		// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
		var map = new kakao.maps.Map(mapContainer, mapOption);

		//마커가 표시될 위치입니다 
		var markerPosition = new kakao.maps.LatLng(lat, lng);

		// 마커를 생성합니다
		var marker = new kakao.maps.Marker({
			position : markerPosition
		});

		// 마커가 지도 위에 표시되도록 설정합니다
		marker.setMap(map);
		
		// 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
		var iwContent = '<div style="padding:5px;">Hello World!</div>',
		
		//인포윈도우 표시 위치입니다
	    iwPosition = new kakao.maps.LatLng(lat, lng),
	  
	    // removeable 속성을 ture 로 설정하면 인포윈도우를 닫을 수 있는 x버튼이 표시됩니다
	    iwRemoveable = true; 

	
		// 인포윈도우를 생성하고 지도에 표시합니다
		 /*
		var infowindow = new kakao.maps.InfoWindow({
	   	 	map: map, // 인포윈도우가 표시될 지도
	    	position : iwPosition, 
	    	content : iwContent,
	    	removable : iwRemoveable
	    });
		*/
		var infowindow = new kakao.maps.InfoWindow({
	    	position : iwPosition, 
	    	content : iwContent,
	    	removable : iwRemoveable
	    });
		// infowindow.open(map);
		 infowindow.open(map,marker);		
		
	</script>	
	
<hr>
<h1>지도에 여러 개의 마커 표시하기</h1>
	위도 : <span id="lat"></span>, 
	경도 : <span id="lng"></span> <br>
	
	<script type="text/javascript">
		var lat = 0;
		var lng = 0;
		navigator.geolocation.getCurrentPosition(
				function(position) {
			lat = position.coords.latitude;
			lng = position.coords.longitude;
			
			document.getElementById("lat").innerHTML = lat;
			document.getElementById("lng").innerHTML = lng;
		});
		
	</script>
	<!-- 지도를 표시할 div 입니다 -->
	<div id="map" style="width:600px;height:400px;"></div>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0874d4b0d4aba7c91a4fb77d9a303727"></script>
	<script>
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
			center : new kakao.maps.LatLng(lat, lng), // 지도의 중심좌표
			level : 4
		// 지도의 확대 레벨
		};

		// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
		var map = new kakao.maps.Map(mapContainer, mapOption);

		//마커가 표시될 위치가 여러개인 경우
		var positions = [ 
		{
			title : '카카오',
			latlng : new kakao.maps.LatLng(lat, lng)
		}, {
			title : '생태연못',
			latlng : new kakao.maps.LatLng(lat+0.0001, lng+0.0003)
		}, {
			title : '텃밭',
			latlng : new kakao.maps.LatLng(lat+0.0003, lng+0.0003)
		}, {
			title : '근린공원',
			latlng : new kakao.maps.LatLng(lat+0.0009, lng+0.0003)
		} ];
		// 마커 이미지의 이미지 주소입니다 (예 : "/first/resources/images/marker.png")
		var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
		for (var i = 0; i < positions.length; i ++) {
		    // 마커 이미지의 이미지 크기 입니다
		    var imageSize = new kakao.maps.Size(24, 35); 
		    
		    // 마커 이미지를 생성합니다    
		    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
		    
		    // 마커를 생성합니다
		    var marker = new kakao.maps.Marker({
		        map: map, // 마커를 표시할 지도
		        position: positions[i].latlng, // 마커를 표시할 위치
		        title : positions[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
		        image : markerImage // 마커 이미지 
		    });
		}
	</script>	
</body>
</html>