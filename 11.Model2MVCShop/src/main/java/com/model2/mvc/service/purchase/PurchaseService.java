package com.model2.mvc.service.purchase;

import java.util.Map;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Purchase;

public interface PurchaseService {
	
	// �����ϱ�
	public void addPurchase(Purchase purchase) throws Exception;

	// ���ų��� �󼼺���
	public Purchase getPurchase(int tranNo) throws Exception;

	// �����̷���ȸ
	public Map<String, Object> getPurchaseList(Search search, String buyerId) throws Exception;

	public Map<String, Object> getSaleList(Search search) throws Exception;

	// ���ų��� ����
	public void updatePurchase(Purchase purchase) throws Exception;

	// ����ó�� �ڵ� ����
	public void updateTranCode(Purchase purchase) throws Exception;
}
