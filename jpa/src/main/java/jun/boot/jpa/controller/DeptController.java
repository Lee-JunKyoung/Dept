package jun.boot.jpa.controller;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.inject.Inject;
import jun.boot.jpa.dto.DeptDTO;
import jun.boot.jpa.entity.Dept;
import jun.boot.jpa.service.DeptService;
import lombok.RequiredArgsConstructor;

//빈으로 컨트롤러 스캔을 구성하고 컨트롤러를 구현한다.
@Controller
//final 필드의 파라미터 생성자를 자동으로 생성한다.
@RequiredArgsConstructor
public class DeptController {
	private static final Logger logger = LogManager.getLogger(DeptController.class);
//의존관계를 자동으로 설정한다.
	@Inject
	private final DeptService deptService;

//부서 목록을 조회한다.
	@GetMapping("/DeptSelect")
	public String list(Model model) {
//모든 부서 목록을 모델에 추가한다.
		model.addAttribute("list", deptService.findAllDepts());
		logger.info("list", model);
		return "./dept/dept_select_all_view";
	}

//특정 부서의 상세 정보를 조회한다.
	@GetMapping("/DeptSelectDetail")
	public String detail(Model model, @RequestParam("deptno") Integer deptno) {
//특정 부서의 상세 정보를 모델에 추가한다.
		model.addAttribute("deptDTO", deptService.findDeptById(deptno));
		return "./dept/dept_select_view";
	}

//부서를 추가하는 페이지를 표시한다
	@GetMapping("/DeptInsert")
	public String insert() {
		return "./dept/dept_insert";
	}

//부서를 추가한다
	@PostMapping("/DeptInsert")
	public String insert(Model model, DeptDTO deptDTO) {
//DeptDTO를 Dept 엔티티로 변환한다.
		Dept dept = new Dept();
		dept.setDeptno(deptDTO.getDeptno());
		dept.setDname(deptDTO.getDname());
		dept.setLoc(deptDTO.getLoc());
//모든 부서 목록을 모델에 추가한다.
		model.addAttribute("list", deptService.findAllDepts());
//부서 정보를 저장한다.
		deptService.saveDept(dept);
		return "./dept/dept_insert_view";
	}

//부서 정보를 수정하는 페이지를 표시한다.
	@GetMapping("/DeptUpdate")
	public String update(Model model, @RequestParam("deptno") Integer deptno) {
//부서 정보를 조회한다.
		Dept dept = deptService.findDeptById(deptno);
		if (dept != null) {
//Dept 엔티티를 DeptDTO로 변환하여 모델에 추가한다.
			DeptDTO deptDTO = new DeptDTO();
			deptDTO.setDeptno(dept.getDeptno());
			deptDTO.setDname(dept.getDname());
			deptDTO.setLoc(dept.getLoc());
			model.addAttribute("deptDTO", deptDTO);
		}
		return "./dept/dept_update";
	}

//부서 정보를 수정한다.
	@PostMapping("/DeptUpdate")
	public String update(DeptDTO deptDTO) {
		Dept dept = new Dept();
		dept.setDeptno(deptDTO.getDeptno());
		dept.setDname(deptDTO.getDname());
		dept.setLoc(deptDTO.getLoc());
//부서 정보를 저장한다.
		deptService.saveDept(dept);
		return "./dept/dept_update_view";
	}

//부서 삭제 페이지를 표시한다.
	@GetMapping("/DeptDelete")
	public String delete() {
		return "./dept/dept_delete";
	}

//부서 정보를 삭제한다.
	@PostMapping("/DeptDelete")
	public String delete(@RequestParam("deptno") Integer deptno) {
//특정 부서를 삭제한다.
		deptService.deleteDeptById(deptno);
		return "./dept/dept_delete_view";
	}

	@GetMapping("/DeptSelectView")
	public String selectAllView() {
		return "./dept/dept_ajax";
	}
}