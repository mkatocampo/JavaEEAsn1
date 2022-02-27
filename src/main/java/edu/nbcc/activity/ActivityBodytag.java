package edu.nbcc.activity;

import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.BodyTagSupport;

public class ActivityBodytag extends BodyTagSupport {
	private String name;
	private String letterGrade;

	/**
	 * @return the name
	 */
	public String getName() {
		return name;
	}
	
	/**
	 * @param name the name to set
	 */
	public void setName(String name) {
		this.name = name;
	}
	
	/**
	 * @return the letterGrade
	 */
	public String getLetterGrade() {
		return letterGrade;
	}

	/**
	 * @param name the name to set
	 */
	public void setLetterGrade(String letterGrade) {
		this.letterGrade = letterGrade;
	}
	
	@Override
	public int doStartTag() {
		try {
		JspWriter out = pageContext.getOut();
		out.println("<h1>Hello " + getName() + ", Your grade is " + getLetterGrade() + "</h1>" );
		}
		catch(Exception ex) {
			System.out.println("ex.getMessage()");
		}
		return EVAL_BODY_INCLUDE;
	}
}
