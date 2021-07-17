public with sharing class CoronaApex {
    public CoronaApex() {

    }

    @AuraEnabled
    public static List<CountryWrapper> getCountryDetails(String country){
        System.debug('Inside getCountryDetails::::'+country);
        List<CountryWrapper> countryWrapperList= new List<CountryWrapper>();
        String endPoint= 'https://corona.lmao.ninja/countries/'+country;
        try{
            Http http= new Http();
            HttpRequest httpRequest= new HttpRequest();
            httpRequest.setHeader('Content-Type', 'application/json');
            httpRequest.setMethod('GET');
            httpRequest.setEndPoint(endPoint);
            httpRequest.setTimeout(1300);
            HttpResponse httpResponse= http.send(httpRequest);
            System.debug('HttpResponse::::'+httpResponse);
            System.debug('HttpResponse Body::::'+httpResponse.getBody());
            if(httpResponse.getStatusCode() == 200){
                CountryWrapper cw= new CountryWrapper();
                Map<String,object> ObjMap= (Map<String,Object>) Json.deserializeUntyped(httpResponse.getBody());
                System.debug('ObjMap:::'+ObjMap);
                System.debug('Size :::'+ObjMap.size());
                cw.country=(String)ObjMap.get('country');
                cw.active=(Integer)ObjMap.get('active');
                cw.cases=(Integer)ObjMap.get('cases');
                cw.deaths=(Integer)ObjMap.get('deaths');
                cw.critical=(Integer)ObjMap.get('critical');
                cw.recovered=(Integer)ObjMap.get('recovered');
                cw.todayCases=(Integer)ObjMap.get('totalCases');
                cw.todayDeaths=(Integer)ObjMap.get('totalDeaths');
                countryWrapperList.add(cw);
              }
        } catch(Exception e){
            System.debug('Error in getCountryDetails::::'+e.getLineNumber()+'~~~'+e.getMessage());
        }
        System.debug('CountryWrapper List:::'+countryWrapperList);
        System.debug('Size::::'+countryWrapperList.size());
        return countryWrapperList;
    }

    @AuraEnabled
    public static List<CountryWrapper> getAllCountryDetails(){
        System.debug('Inside getAllCountryDetails::::');
        List<CountryWrapper> countryWrapperList= new List<CountryWrapper>();
        List<JSON2Apex> respJson;
        String endPoint= 'https://corona.lmao.ninja/countries?sort=country';
        try{
            Http http= new Http();
            HttpRequest httpRequest= new HttpRequest();
            httpRequest.setHeader('Content-Type', 'application/json');
            httpRequest.setMethod('GET');
            httpRequest.setEndPoint(endPoint);
            httpRequest.setTimeout(13000);
            HttpResponse httpResponse= http.send(httpRequest);
            System.debug('HttpResponse::::'+httpResponse);
            System.debug('HttpResponse.getBody::::'+httpResponse.getBody());
            if(httpResponse.getStatusCode() == 200){
               respJson= JSON2Apex.parse(httpResponse.getBody());
                //System.debug('respJson::::::'+respJson);
                for(JSON2Apex jsonSeg: respJson){
                    CountryWrapper conWrap= new CountryWrapper();
                    conWrap.active=jsonSeg.active;
                    conWrap.cases=jsonSeg.cases;
                    conWrap.country=jsonSeg.country;
                    conWrap.critical=jsonSeg.critical;
                    conWrap.deaths=jsonSeg.deaths;
                    conWrap.recovered=jsonSeg.recovered;
                    conWrap.todayCases=jsonSeg.todayCases;
                    conWrap.todayDeaths=jsonSeg.todayDeaths;
                    countryWrapperList.add(conWrap);
                }
              }
        } catch(Exception e){
            System.debug('Error in getCountryDetails::::'+e.getLineNumber()+'~~~'+e.getMessage());
        }
        System.debug('countryWrapper:::::'+countryWrapperList);
        System.debug('CountryWrapper Size:::'+countryWrapperList.size());
        return countryWrapperList;
    }



    public class CountryWrapper{

        @AuraEnabled
        public String country {get;set;}
        @AuraEnabled
        public Integer cases {get;set;}
        @AuraEnabled
        public Integer todayCases {get;set;}
        @AuraEnabled
        public Integer deaths {get;set;}
        @AuraEnabled
        public Integer todayDeaths {get;set;}
        @AuraEnabled
        public Integer recovered {get;set;}
        @AuraEnabled
        public Integer active {get;set;}
        @AuraEnabled
        public Integer critical {get;set;}
        }

}