package jun.boot.jpa.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import jun.boot.jpa.entity.Dept;

//Dept 엔티티에 대한 데이터 접근 계층을 정의하며 기본적인 CRUD 작업을 자동으로 제공한다.
public interface DeptRepository extends JpaRepository<Dept, Integer> {
}
