package jun.boot.jpa.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

//기본 생성자를 자동으로 생성한다.
@NoArgsConstructor
@Getter
@Setter
//클래스가 JPA 엔티티임을 나타낸다.
@Entity
//클래스명을 테이블명으로 선언한다.
public class Dept {
//필드가 엔티티의 기본키임을 나타낸다.
	@Id
	private Integer deptno;
	private String dname;
	private String loc;
}