package com.code.bean;

import com.code.constant.TypeConstant;
import com.code.util.StringUtils;

public class Cloumn {

	private String cloumnName;
	private String comment;
	private String cloumnType;

	public String getCloumnName() {
		return cloumnName;
	}

	public void setCloumnName(String cloumnName) {
		this.cloumnName = cloumnName;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public String getCloumnType() {
		return cloumnType;
	}

	public void setCloumnType(String cloumnType) {
		this.cloumnType = cloumnType;
	}

	public String getFieldName() {
		return StringUtils.putOffUnderline(this.cloumnName);
	}

	public String getJavaType() {
		return TypeConstant.getJavaType(this.cloumnType);
	}

	public String getUpperCasecloumnName() {
		return StringUtils.captureName(getFieldName());
	}
}
