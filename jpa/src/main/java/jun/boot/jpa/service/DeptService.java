package jun.boot.jpa.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jakarta.inject.Inject;
import jun.boot.jpa.entity.Dept;
import jun.boot.jpa.repository.DeptRepository;

@Service
public class DeptService {
	@Inject
	private DeptRepository deptRepository;

//메서드 실행 시 트랜잭션이 시작되고 정상적으로 종료되면 트랜잭션이 커밋된다.
	@Transactional
	public Dept saveDept(Dept dept) {
//Dept 엔티티를 저장하고 저장된 엔티티를 반환한다.
		return deptRepository.save(dept);
	}

//읽기 전용 트랜잭션으로 데이터 변경 작업을 허용하지 않으며 성능 최적화에 도움이 된다.
	@Transactional(readOnly = true)
	public List<Dept> findAllDepts() {
//모든 Dept 엔티티를 조회하고 리스트로 반환한다.
		return deptRepository.findAll();
	}

	@Transactional(readOnly = true)
	public Dept findDeptById(Integer deptno) {
//ID로 Dept 엔티티를 조회하고 존재하지 않으면 null을 반환한다.
		return deptRepository.findById(deptno).orElse(null);
	}

	@Transactional
	public void deleteDeptById(Integer deptno) {
//ID로 Dept 엔티티를 삭제한다.
		deptRepository.deleteById(deptno);
	}

	public boolean existsByDeptno(Integer deptno) {
//ID로 Dept 엔티티의 존재 여부를 확인하고, 결과를 반환한다.
		return deptRepository.existsById(deptno);
	}
}