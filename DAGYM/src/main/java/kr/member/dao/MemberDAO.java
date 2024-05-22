package kr.member.dao;

public class MemberDAO {
	//싱글톤 패턴
	private static MemberDAO instance = new MemberDAO();
	
	public static MemberDAO getInstance() {
		return instance;
	}
	
	private MemberDAO() {}
}
