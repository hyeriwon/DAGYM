package kr.payment.dao;

import kr.payment.dao.PaymentDAO;

public class PaymentDAO {
	//싱글턴 패턴
	private static PaymentDAO instance = new PaymentDAO();

	public static PaymentDAO getInstance() {
		return instance;
	}
	private PaymentDAO () {}
}
