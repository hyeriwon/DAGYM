package kr.member.dao2;


public class MemberDAO2 {
private static MemberDAO2 instance = new MemberDAO2();
	
	public static MemberDAO2 getInstance() {
		return instance;
	}
	private MemberDAO2() {}
	//아이디로 회원번호 구하기

}
