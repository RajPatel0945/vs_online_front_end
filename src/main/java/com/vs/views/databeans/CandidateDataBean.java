package com.vs.views.databeans;

import java.util.List;
import java.util.Map;

import com.google.gson.JsonArray;

public class CandidateDataBean {

	private List<Map<String,Object>> candidateList;

	private JsonArray candidateJsonArrayList;
	
	private int listSize;
	
	private int voterId;
	
	
	
	public int getVoterId() {
		return voterId;
	}

	public void setVoterId(int voterId) {
		this.voterId = voterId;
	}

	public int getListSize() {
		return listSize;
	}

	public void setListSize(int listSize) {
		this.listSize = listSize;
	}

	public List<Map<String, Object>> getCandidateList() {
		return candidateList;
	}

	public void setCandidateList(List<Map<String, Object>> candidateList) {
		this.candidateList = candidateList;
	}

	public JsonArray getCandidateJsonArrayList() {
		return candidateJsonArrayList;
	}

	public void setCandidateJsonArrayList(JsonArray candidateJsonArrayList) {
		this.candidateJsonArrayList = candidateJsonArrayList;
	}
	
	
	
}
