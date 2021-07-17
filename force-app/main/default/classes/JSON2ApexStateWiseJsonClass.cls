public with sharing class JSON2ApexStateWiseJsonClass {

	public class Delta {
		public Integer confirmed;
	}

	public class DistrictData {
		public String district;
		public Integer confirmed;
		public String lastupdatedtime;
		public Delta delta;
	}

	public String state;
	public List<DistrictData> districtData;

	
	public static List<JSON2ApexStateWiseJsonClass> parse(String json) {
		return (List<JSON2ApexStateWiseJsonClass>) System.JSON.deserialize(json, List<JSON2ApexStateWiseJsonClass>.class);
	}
}