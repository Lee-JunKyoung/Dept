package jun.boot.jpa.controller;

import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import jakarta.inject.Inject;
import jun.boot.jpa.entity.Dept;
import jun.boot.jpa.service.DeptService;
import lombok.RequiredArgsConstructor;

//RESTful 웹 서비스를 정의하는 컨트롤러로 구성한다.
@RestController
//final 필드의 파라미터 생성자를 자동으로 생성한다.
@RequiredArgsConstructor
public class DeptRestController {
	private static final Logger logger = LogManager.getLogger(DeptRestController.class);
//의존관계를 자동으로 설정한다.
	@Inject
	private final DeptService deptService;

//모든 부서 목록을 조회한다.
	@GetMapping("/selectAll")
	public List<Dept> getAllDepts() {
//부서 목록을 조회하여 반환한다.
		return deptService.findAllDepts();
	}

//특정 부서의 상세 정보를 조회한다.
	@GetMapping("/select/{deptno}")
	public ResponseEntity<Dept> getDeptById(@PathVariable("deptno") Integer deptno) {
//특정 부서의 상세 정보를 조회한다.
		Dept dept = deptService.findDeptById(deptno);
		logger.info("dept", dept);
		if (dept != null) {
//부서 정보가 존재하면 200 상태 코드와 함께 부서 정보를 반환한다.
			return new ResponseEntity<>(dept, HttpStatus.OK);
		} else {
//부서 정보가 존재하지 않으면 404 상태 코드를 반환한다.
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
	}

//새로운 부서를 추가하는 POST 요청을 처리한다.
	@PostMapping("/insert")
	public ResponseEntity<String> createDept(@RequestBody Dept dept) {
//부서 번호가 이미 존재하는지 확인한다.
		if (deptService.existsByDeptno(dept.getDeptno())) {
//부서 번호가 이미 존재하면 400 상태 코드와 함께 오류 메시지를 반환한다.
			return new ResponseEntity<>("부서 번호가 이미 존재합니다.", HttpStatus.BAD_REQUEST);
		}
//부서 정보를 저장한다.
		Dept dept2 = deptService.saveDept(dept);
		logger.info("dept", dept2);
//부서가 성공적으로 저장되었음을 알리는 메시지와 함께 201 상태 코드를 반환한다.
		return new ResponseEntity<>("부서가 성공적으로 저장되었습니다.", HttpStatus.CREATED);
	}

//기존 부서 정보를 수정한다.
	@PutMapping("/update/{deptno}")
	public ResponseEntity<Dept> updateDept(@PathVariable("deptno") Integer deptno, @RequestBody Dept deptDetails) {
//특정 부서의 상세 정보를 조회한다.
		Dept dept = deptService.findDeptById(deptno);
		if (dept != null) {
//조회된 부서 정보를 업데이트한다.
			dept.setDname(deptDetails.getDname());
			dept.setLoc(deptDetails.getLoc());
//업데이트된 부서 정보를 저장한다.
			Dept dept2 = deptService.saveDept(dept);
//업데이트된 부서 정보와 함께 200 상태 코드를 반환한다.
			return new ResponseEntity<>(dept2, HttpStatus.OK);
		} else {
//부서 정보가 존재하지 않으면 404 상태 코드를 반환한다.
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
	}

//특정 부서 정보를 삭제한다.
	@DeleteMapping("/delete/{deptno}")
	public ResponseEntity<HttpStatus> deleteDept(@PathVariable("deptno") Integer deptno) {
//부서 정보를 삭제한다.
		deptService.deleteDeptById(deptno);
//204 상태 코드를 반환한다.
		return new ResponseEntity<>(HttpStatus.NO_CONTENT);
	}
}
