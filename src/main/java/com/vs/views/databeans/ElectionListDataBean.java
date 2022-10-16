package com.vs.views.databeans;

import java.util.List;
import java.util.Map;

import com.google.gson.JsonArray;

public class ElectionListDataBean {

	private List<Map<String,Object>> electionList;
	
	private JsonArray electionJsonArray;

	public List<Map<String, Object>> getElectionList() {
		return electionList;
	}

	public void setElectionList(List<Map<String, Object>> electionList) {
		this.electionList = electionList;
	}

	public JsonArray getElectionJsonArray() {
		return electionJsonArray;
	}

	public void setElectionJsonArray(JsonArray electionJsonArray) {
		this.electionJsonArray = electionJsonArray;
	}
	
	
	
}
