public with sharing class JSON2Apex {
    public JSON2Apex() {

    }
    public class CountryInfo_Z {
		public Integer x_id {get;set;} // in json: _id
		public String iso2 {get;set;} 
		public String iso3 {get;set;} 
		public Double lat {get;set;} 
		public Double long_Z {get;set;} // in json: long
		public String flag {get;set;} 

		public CountryInfo_Z(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == '_id') {
							x_id = parser.getIntegerValue();
						} else if (text == 'iso2') {
							iso2 = parser.getText();
						} else if (text == 'iso3') {
							iso3 = parser.getText();
						} else if (text == 'lat') {
							lat = parser.getDoubleValue();
						} else if (text == 'long') {
							long_Z = parser.getDoubleValue();
						} else if (text == 'flag') {
							flag = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'CountryInfo_Z consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class CountryInfo_Y {
		public Integer x_id {get;set;} // in json: _id
		public String iso2 {get;set;} 
		public String iso3 {get;set;} 
		public Integer lat {get;set;} 
		public Double long_Z {get;set;} // in json: long
		public String flag {get;set;} 

		public CountryInfo_Y(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == '_id') {
							x_id = parser.getIntegerValue();
						} else if (text == 'iso2') {
							iso2 = parser.getText();
						} else if (text == 'iso3') {
							iso3 = parser.getText();
						} else if (text == 'lat') {
							lat = parser.getIntegerValue();
						} else if (text == 'long') {
							long_Z = parser.getDoubleValue();
						} else if (text == 'flag') {
							flag = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'CountryInfo_Y consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class CountryInfo_X {
		public Integer x_id {get;set;} // in json: _id
		public String iso2 {get;set;} 
		public String iso3 {get;set;} 
		public Double lat {get;set;} 
		public Integer long_Z {get;set;} // in json: long
		public String flag {get;set;} 

		public CountryInfo_X(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == '_id') {
							x_id = parser.getIntegerValue();
						} else if (text == 'iso2') {
							iso2 = parser.getText();
						} else if (text == 'iso3') {
							iso3 = parser.getText();
						} else if (text == 'lat') {
							lat = parser.getDoubleValue();
						} else if (text == 'long') {
							long_Z = parser.getIntegerValue();
						} else if (text == 'flag') {
							flag = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'CountryInfo_X consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public String country {get;set;} 
	public CountryInfo countryInfo {get;set;} 
	public Integer cases {get;set;} 
	public Integer todayCases {get;set;} 
	public Integer deaths {get;set;} 
	public Integer todayDeaths {get;set;} 
	public Integer recovered {get;set;} 
	public Integer active {get;set;} 
	public Integer critical {get;set;} 
	public Double casesPerOneMillion {get;set;} 
	public Double deathsPerOneMillion {get;set;} 
	public Long updated {get;set;} 

	public JSON2Apex(JSONParser parser) {
		while (parser.nextToken() != System.JSONToken.END_OBJECT) {
			if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
				String text = parser.getText();
				if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
					if (text == 'country') {
						country = parser.getText();
					} else if (text == 'countryInfo') {
						countryInfo = new CountryInfo(parser);
					} else if (text == 'cases') {
						cases = parser.getIntegerValue();
					} else if (text == 'todayCases') {
						todayCases = parser.getIntegerValue();
					} else if (text == 'deaths') {
						deaths = parser.getIntegerValue();
					} else if (text == 'todayDeaths') {
						todayDeaths = parser.getIntegerValue();
					} else if (text == 'recovered') {
						recovered = parser.getIntegerValue();
					} else if (text == 'active') {
						active = parser.getIntegerValue();
					} else if (text == 'critical') {
						critical = parser.getIntegerValue();
					} else if (text == 'casesPerOneMillion') {
						casesPerOneMillion = parser.getDoubleValue();
					} else if (text == 'deathsPerOneMillion') {
						deathsPerOneMillion = parser.getDoubleValue();
					} else if (text == 'updated') {
						updated = parser.getLongValue();
					} else {
						System.debug(LoggingLevel.WARN, 'JSON2Apex consuming unrecognized property: '+text);
						consumeObject(parser);
					}
				}
			}
		}
	}
	
	public class CountryInfo_W {
		public Object x_id {get;set;} // in json: _id
		public Object iso2 {get;set;} 
		public Object iso3 {get;set;} 
		public Integer lat {get;set;} 
		public Integer long_Z {get;set;} // in json: long
		public String flag {get;set;} 

		public CountryInfo_W(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == '_id') {
							x_id = parser.readValueAs(Object.class);
						} else if (text == 'iso2') {
							iso2 = parser.readValueAs(Object.class);
						} else if (text == 'iso3') {
							iso3 = parser.readValueAs(Object.class);
						} else if (text == 'lat') {
							lat = parser.getIntegerValue();
						} else if (text == 'long') {
							long_Z = parser.getIntegerValue();
						} else if (text == 'flag') {
							flag = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'CountryInfo_W consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class CountryInfo {
		public Integer x_id {get;set;} // in json: _id
		public String iso2 {get;set;} 
		public String iso3 {get;set;} 
		public Integer lat {get;set;} 
		public Integer long_Z {get;set;} // in json: long
		public String flag {get;set;} 

		public CountryInfo(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == '_id') {
							x_id = parser.getIntegerValue();
						} else if (text == 'iso2') {
							iso2 = parser.getText();
						} else if (text == 'iso3') {
							iso3 = parser.getText();
						} else if (text == 'lat') {
							lat = parser.getIntegerValue();
						} else if (text == 'long') {
							long_Z = parser.getIntegerValue();
						} else if (text == 'flag') {
							flag = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'CountryInfo consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	
	public static List<JSON2Apex> parse(String json) {
		System.JSONParser parser = System.JSON.createParser(json);
		return arrayOfJSON2Apex(parser);
	}
	
	public static void consumeObject(System.JSONParser parser) {
		Integer depth = 0;
		do {
			System.JSONToken curr = parser.getCurrentToken();
			if (curr == System.JSONToken.START_OBJECT || 
				curr == System.JSONToken.START_ARRAY) {
				depth++;
			} else if (curr == System.JSONToken.END_OBJECT ||
				curr == System.JSONToken.END_ARRAY) {
				depth--;
			}
		} while (depth > 0 && parser.nextToken() != null);
	}
	


    private static List<JSON2Apex> arrayOfJSON2Apex(System.JSONParser p) {
        List<JSON2Apex> res = new List<JSON2Apex>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new JSON2Apex(p));
        }
        return res;
    }

}