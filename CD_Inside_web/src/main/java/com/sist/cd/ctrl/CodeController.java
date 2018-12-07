package com.sist.cd.ctrl;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.sist.cd.domain.CodeVO;
import com.sist.cd.service.CodeSvc;


@RestController
public class CodeController {
	
	private final Logger log = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private CodeSvc codeSvc;
	
	@RequestMapping(value="code/select_one/{cd_id}")
	public List<CodeVO> do_retrieve(@PathVariable String cd_id,Model model) {
		log.info("=============================");
		log.info("=cd_id="+cd_id);
		log.info("=============================");
		CodeVO invo=new CodeVO();
		invo.setCd_id(cd_id);
		return (List<CodeVO>) codeSvc.do_retrieve(invo);
	}
}
