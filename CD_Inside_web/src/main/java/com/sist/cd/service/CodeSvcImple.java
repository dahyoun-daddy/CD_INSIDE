/**
 * 
 */
package com.sist.cd.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.cd.common.DTO;
import com.sist.cd.dao.CodeDao;


/**
 * @author sist1
 *
 */
@Service
public class CodeSvcImple implements CodeSvc {

	@Autowired
	private CodeDao codeDao;
	/* (non-Javadoc)
	 * @see com.sist.hr.code.service.CodeSvc#do_selectOne(com.sist.hr.common.DTO)
	 */
	@Override
	public List<?> do_retrieve(DTO dto){
		
		return codeDao.do_retrieve(dto);
	}

}
