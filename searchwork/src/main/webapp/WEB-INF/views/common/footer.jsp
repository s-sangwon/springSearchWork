<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title></title>
<style type="text/css">
footer {
	text-align: center;
	background-color: navy;
	color: white;
	
}

</style>


</head>
<body>
	<footer>
	copyright@first 스프링 레거시 MVC 템플릿 적용 프로젝트<Br>
	2022-09-14 개발, developer : 서상원<br>
	</footer>
	<!--  TWC chatbot Scripts -->
<script src="https://public-common-sdk.s3.ap-northeast-2.amazonaws.com/sdk/seller/Twc.plugin.js"></script>

<script>
(function() {
 Twc('init', {
   brandKey: "m0qEkQGszGQPOJycVHShoA",
   channelType: "scenario",
scenarioId: "Njk=",
   buttonOption: {
     showLauncher: true,
     zIndex: 10,
     bottom: 25,
     right: 25
    }
  })
})();
</script>
<!--— End TWC chatbot Scripts —--->
</body>
</html>