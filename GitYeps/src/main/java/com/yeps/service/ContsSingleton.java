package com.yeps.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.yeps.model.ContsDTO;

@Service
public class ContsSingleton {

	private List<ContsDTO> contsList = null;
	private List<ContsDTO> contsUploadList = new ArrayList<ContsDTO>();

	private ContsSingleton() {
	}

	private static class ContsSingletonHolder {
		public static final ContsSingleton INSTANCE = new ContsSingleton();
	}

	public static ContsSingleton getContsSingletonObject() {
		return ContsSingletonHolder.INSTANCE;
	}

	public List<ContsDTO> getContsList() {
		return this.contsList;
	}

	public void setContsList(List<ContsDTO> contsList) {
		this.contsList = contsList;
	}

	public List<ContsDTO> getContsUploadList() {
		return this.contsUploadList;
	}

	public void addContsUploadList(ContsDTO dto) {
		this.contsUploadList.add(dto);
	}

	public void clearContsUploadList() {
		this.contsUploadList.clear();
		;
	}
}
