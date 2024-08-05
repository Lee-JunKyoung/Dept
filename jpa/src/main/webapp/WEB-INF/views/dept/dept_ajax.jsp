<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>부서 관리</title>
<link rel="stylesheet" type="text/css"
	href="./css/bootstrap.min_4.5.0.css">
<script src="./js/jquery-3.5.1.min.js" type="text/javascript"></script>
<script src="./js/bootstrap.min_4.5.0.js" type="text/javascript"></script>
<style type="text/css">
.btn-group-custom {
	display: flex;
	justify-content: center;
	margin-bottom: 20px;
	flex-wrap: wrap;
}

.btn-group-custom .btn {
	margin: 5px;
	min-width: 120px;
}

.custom-table-wrapper {
	overflow-x: auto;
	width: 100%;
}

table.custom-table {
	width: 100%;
	border-collapse: collapse;
	margin-bottom: 20px;
}

table.custom-table th, table.custom-table td {
	border: 1px solid #ddd;
	padding: 8px;
	text-align: center;
	vertical-align: middle;
}

table.custom-table th {
	background-color: #f2f2f2;
	font-weight: bold;
}

.modal-header {
	background-color: #f8f9fa;
}

.modal-body {
	padding: 20px;
}

.form-group label {
	font-weight: bold;
}
</style>
</head>
<body>
	<div class="container p-3 my-3 border">
		<div class="btn-group-custom">
			<button id="selectAllBtn" class="btn btn-outline-secondary">부서
				목록</button>
			<button id="selectBtn" class="btn btn-outline-secondary">부서
				상세 보기</button>
			<button id="insertBtn" class="btn btn-outline-secondary">부서
				입력</button>
			<button id="updateBtn" class="btn btn-outline-secondary">부서
				수정</button>
			<button id="deleteBtn" class="btn btn-outline-secondary">부서
				삭제</button>
		</div>
		<div id="result" class="custom-table-wrapper">
			<table id="resultTable" class="custom-table">
				<thead>
					<tr>
						<th>부서 번호</th>
						<th>부서 이름</th>
						<th>부서 지역</th>
					</tr>
				</thead>
				<tbody></tbody>
			</table>
		</div>
	</div>
	<!--부서 상세 모달을 설정한다.-->
	<div class="modal fade" id="selectModal" tabindex="-1" role="dialog"
		aria-labelledby="selectModalLabel" aria hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="selectModalLabel">부서 상세 보기</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form id="selectForm">
						<div class="form-group">
							<label for="selectDeptNo">부서 번호</label> <input type="text"
								class="form-control" id="selectDeptNo" name="deptno">
						</div>
						<button type="button" class="btn btn-outline-info"
							id="submitSelectForm">입력</button>
					</form>
				</div>
			</div>
		</div>
	</div>
	<!--부서 입력 모달을 설정한다.-->
	<div class="modal fade" id="insertModal" tabindex="-1" role="dialog"
		aria-labelledby="insertModalLabel" aria hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="insertModalLabel">부서 입력</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form id="insertForm">
						<div class="form-group">
							<label for="insertDeptNo">부서 번호</label> <input type="text"
								class="form-control" id="insertDeptNo" name="deptno">
						</div>
						<div class="form-group">
							<label for="insertDname">부서 이름</label> <input type="text"
								class="form-control" id="insertDname" name="dname">
						</div>
						<div class="form-group">
							<label for="insertLoc">부서 지역</label> <input type="text"
								class="form-control" id="insertLoc" name="loc">
						</div>
						<button type="button" class="btn btn-outline-info"
							id="submitInsertForm">등록</button>
					</form>
				</div>
			</div>
		</div>
	</div>
	<!--부서 수정 모달을 설정한다.-->
	<div class="modal fade" id="updateModal" tabindex="-1" role="dialog"
		aria-labelledby="updateModalLabel" aria hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="updateModalLabel">부서 수정</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form id="updateForm">
						<div class="form-group">
							<label for="updateDeptNo">부서 번호</label> <input type="text"
								class="form-control" id="updateDeptNo" name="deptno">
						</div>
						<div class="form-group">
							<label for="updateDname">부서 이름</label> <input type="text"
								class="form-control" id="updateDname" name="dname">
						</div>
						<div class="form-group">
							<label for="updateLoc">부서 지역</label> <input type="text"
								class="form-control" id="updateLoc" name="loc">
						</div>
						<button type="button" class="btn btn-outline-info"
							id="submitUpdateForm">수정</button>
					</form>
				</div>
			</div>
		</div>
	</div>
	<!--부서 삭제 모달을 설정한다.-->
	<div class="modal fade" id="deleteModal" tabindex="-1" role="dialog"
		aria-labelledby="deleteModalLabel" aria hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="deleteModalLabel">부서 삭제</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form id="deleteForm">
						<div class="form-group">
							<label for="deleteDeptNo">부서 번호</label> <input type="text"
								class="form-control" id="deleteDeptNo" name="deptno">
						</div>
						<button type="button" class="btn btn-outline-info"
							id="submitDeleteForm">삭제</button>
					</form>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
 //콜백 함수로 문서가 완전히 로드되고 DOM이 준비된 후에 실행된다.
 $(function( ) {
 //전체 부서 목록을 로드한다.
 function loadData( ) {
 $.ajax({
 //모든 부서 정보를 가져오는 API 엔드포인트다.
 url: './selectAll',
 method: 'GET',
 success: function(data) {
 console.log("json 데이터 확인 : ", data);
 //데이터를 테이블에 표시한다.
 displayTable(data); 
},
 error: function(error) {
 alert('부서 목록에 데이터가 없습니다.');
 }
 });
 }
 //부서 목록 버튼 클릭 시 부서 목록을 로드한다.
 $('#selectAllBtn').click(function( ) {
 loadData( );
 });
 //부서 상세 보기 버튼 클릭 시 모달 창에 표시한다.
 $('#selectBtn').click(function( ) {
 $('#selectModal').modal('show');
 });
 //부서 입력 버튼 클릭 시 모달 창에 표시한다.
 $('#insertBtn').click(function( ) {
 $('#insertModal').modal('show');
 });
 //부서 수정 버튼 클릭 시 모달 창에 표시한다.
 $('#updateBtn').click(function( ) {
 $('#updateModal').modal('show');
 });
 //부서 삭제 버튼 클릭 시 모달 창에 표시한다.
 $('#deleteBtn').click(function( ) {
 $('#deleteModal').modal('show');
 });
  //부서 번호를 입력받아 해당 부서의 정보를 조회한다.
 $('#submitSelectForm').click(function( ) {
 var deptno = $('#selectDeptNo').val( );
 //유효성을 검사한다.
 if(!deptno || isNaN(deptno) || deptno.length > 2) {
 alert("부서 번호를 올바르게 입력하세요.");
 return;
 }
 $.ajax({
 //특정 부서 정보를 가져오는 API 엔드포인트다.
 url: './select/' + deptno,
 method: 'GET',
 success: function(data) {
 //조회된 부서 정보를 테이블에 표시한다.
 displayTable([data]);
 $('#selectModal').modal('hide');
 },
 error: function(error) {
 alert('부서 번호가 존재하지 않습니다.' );
 }
 });
 });
 //새로운 부서 정보를 등록한다.
 $('#submitInsertForm').click(function( ) {
 var deptno = $('#insertDeptNo').val( );
 var dname = $('#insertDname').val( );
 var loc = $('#insertLoc').val( );
 //유효성을 검사한다.
 if(!deptno || isNaN(deptno) || deptno.length > 2) {
 alert("부서 번호를 올바르게 입력하세요.");
 return;
 }
 if(!dname || dname.length < 2 || dname.length > 14) {
 alert("부서 이름을 올바르게 입력하세요.");
 return;
 }
 if(!loc || loc.length < 2 || loc.length > 14) {
 alert("부서 지역을 올바르게 입력하세요.");
 return;
 }
 $.ajax({
 //부서 정보를 등록하는 API 엔드포인트다.
 url: './insert',
 method: 'POST',
 contentType: 'application/json',
 //객체를 JSON 문자열로 변환한다.
 data: JSON.stringify({
 deptno: deptno,
 dname: dname,
 loc: loc
 }),
 success: function(data) {
 alert("부서를 등록하였습니다.");
 //모달 창을 닫는다.
 $('#insertModal').modal('hide');
 //업데이트된 부서 목록을 로드한다.
 loadData( );
 },
 error: function(error) {
 alert('입력할 부서 번호가 존재합니다.');
 }
 });
 });
 //기존 부서 정보를 수정한다.
 $('#submitUpdateForm').click(function( ) {
 var deptno = $('#updateDeptNo').val( );
 var dname = $('#updateDname').val( );
 var loc = $('#updateLoc').val( );
 //유효성을 검사한다.
 if(!deptno || isNaN(deptno) || deptno.length > 2) {
 alert("부서 번호를 올바르게 입력하세요.");
 return;
 }
 if(!dname || dname.length < 2 || dname.length > 14) {
 alert("부서 이름을 올바르게 입력하세요.");
 return;
 }
 if(!loc || loc.length < 2 || loc.length > 14) {
 alert("부서 지역을 올바르게 입력하세요.");
 return;
 }
  $.ajax({
 //부서 정보를 수정하는 API 엔드포인트다.
 url: './update',
 method: 'PUT',
 contentType: 'application/json',
 //객체를 JSON 문자열로 변환한다.
 data: JSON.stringify({
 deptno: deptno,
 dname: dname,
 loc: loc
 }),
 success: function(data) {
 alert("부서를 수정하였습니다.");
 //모달 창을 닫는다.
 $('#updateModal').modal('hide');
 //업데이트된 부서 목록을 로드한다.
 loadData( );
 },
 error: function(error) {
 alert('수정할 부서 번호가 존재하지 않습니다.');
 }
 });
 });
 //특정 부서 번호의 부서 정보를 삭제한다.
 $('#submitDeleteForm').click(function( ) {
 var deptno = $('#deleteDeptNo').val( );
 //유효성을 검사한다.
 if(!deptno || isNaN(deptno) || deptno.length > 2) {
 alert("부서 번호를 올바르게 입력하세요.");
 return;
 }
 $.ajax({
 //부서 정보를 삭제하는 API 엔드포인트다.
 url: './delete/' + deptno,
 method: 'DELETE',
 success: function(data) {
 alert("부서를 삭제하였습니다.");
 $('#deleteModal').modal('hide');
 loadData( );
 },
 error: function(error) {
 alert('삭제할 부서 번호가 존재하지 않습니다.');
 }
 });
 });
  //테이블에 데이터를 표시한다.
 function displayTable(data) {
 var tableBody = $('#resultTable tbody');
 tableBody.empty( );
 data.forEach(function(row) {
 var rowHtml = '<tr>' +
 '<td>' + row.deptno + '</td>' +
 '<td>' + row.dname + '</td>' +
 '<td>' + row.loc + '</td>' +
 '</tr>';
 //새로운 데이터를 추가한다.
 tableBody.append(rowHtml);
 });
 }
 //페이지 로드 시 초기 데이터로 로드한다.
 loadData( );
 });
 </script>
</body>
</html>