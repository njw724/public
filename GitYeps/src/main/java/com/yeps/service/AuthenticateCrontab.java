package com.yeps.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.yeps.model.ContsDTO;

@Service
@EnableScheduling
public class AuthenticateCrontab {

	@Autowired
	private ContsMapper contsMapper;

	@Scheduled(fixedDelay = 1000 * 10)
	public void fixedDelayTask() {
		ContsSingleton conts = ContsSingleton.getContsSingletonObject();

		List<ContsDTO> contsList = conts.getContsList();
		if (contsList == null) {
			contsList = contsMapper.getContsList();
			conts.setContsList(contsList);
		}

		List<ContsDTO> contsUpdateList = conts.getContsUploadList();
		if (contsUpdateList != null) {
			int res = contsMapper.updateContsList(contsUpdateList);
			if (res != -1) {
				conts.clearContsUploadList();
				contsUpdateList.clear();
			}

			contsList = contsMapper.getContsList();
			conts.setContsList(contsList);
		}
	}

}