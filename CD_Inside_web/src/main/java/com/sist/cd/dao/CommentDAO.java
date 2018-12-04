package com.sist.cd.dao;

import com.sist.cd.common.DuplicateUserIdException;
import com.sist.cd.domain.CommentVO;

public interface CommentDAO {

	int add(CommentVO inVO1) throws DuplicateUserIdException;

}
