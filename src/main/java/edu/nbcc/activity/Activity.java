package edu.nbcc.activity;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class Activity {
	public Activity(String value, String name) {
		this.value = value;
		this.name = name;
	}

	private String value;
	private String name;

	/**
	 * @return the value
	 */
	public String getValue() {
		return value;
	}
	/**
	 * @param value the value to set
	 */
	public void setValue(String value) {
		this.value = value;
	}
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
	 * 
	 * @return
	 */
	public static List<Activity> getActivities() {
		List<Activity> activities = new ArrayList<Activity>();
		activities.add(new Activity("quiz1", "Quiz 1"));
		activities.add(new Activity("quiz2", "Quiz 2"));
		activities.add(new Activity("asn1", "Assignment 1"));
		activities.add(new Activity("asn2", "Assignment 2"));
		activities.add(new Activity("asn3", "Assignment 3"));
		return activities;
		
	}
	/**
	 * 
	 * @param id
	 * @return
	 */
	public static Activity getActivity(String value) {
		List<Activity> activity = getActivities().stream().filter(a -> a.getValue() == value).collect(Collectors.toList());
		if (activity.size() > 0) {
			return activity.get(0);
		}
		return null;
	}
	/**
	 * 
	 * @param list
	 * @param activity
	 * @return
	 */
	public static boolean isActivityOnList(List<Activity> list, Activity activity) {
		return list.stream().filter(a -> a.getValue() == activity.getValue()).collect(Collectors.toList()).size() > 0;
	}
}