<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자주 묻는 질문</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

</head>
<body>
<div class="container">
	<h3>자주 묻는 질문</h3>
	<div class="accordion" id="accordionExample">
		<div class="accordion-item">
			<h2 class="accordion-header" id="headingOne">
				<button class="accordion-button" type="button" data-bs-toggle="collapse"
					data-bs-target="#collapseOne">
					1. DAGYM 피트니스 위치는 어디인가요?
				</button>
			</h2>
			<div id="collapseOne" class="accordion-collapse collapse" data-bs-parent="#accordionExample">
			<div class="accordion-body">
				서울시 강남구
			</div>
			</div>
		</div><!-- end of item -->
		<div class="accordion-item">
			<h2 class="accordion-header" id="headingTwo">
				<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
					data-bs-target="#collapseTwo">
					2. DAGYM 피트니스 회원권 구매는?
				</button>
			</h2>
			<div id="collapseTwo" class="accordion-collapse collapse" 
			   data-bs-parent="#accordionExample">
				<div class="accordion-body">
					상담 후 구매가능
				</div>
			</div>
		</div><!-- end of item -->
		
	</div>
</div>
</body>
</html>