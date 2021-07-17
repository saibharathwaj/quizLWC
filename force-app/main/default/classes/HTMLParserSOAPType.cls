public class HTMLParserSOAPType {

   // public String value1='<s:Envelope xmlns:s="Schema URL"><s:Body><GetActivationInformationResponse xmlns="Schema URL"><GetActivationInformationResult xmlns:a="Schema URL" xmlns:i="Schema URL"><a:ATMFee>*****</a:ATMFee><a:ActivationData>******</a:ActivationData><a:ActivationType>PIN</a:ActivationType><a:LastVerificationResponse><a:ActivitiesPerformed i:nil="true"/><a:CardLimitAccountList i:nil="true"/><a:OOWQuiz i:nil="true"/><a:Reprompt i:nil="true"/><a:ResponseCode>verified</a:ResponseCode><a:ResponseText>RegistrationService Response Code: Passed</a:ResponseText></a:LastVerificationResponse><a:MonthlyFee>*****</a:MonthlyFee><a:PinInformation><a:AssociationName>MasterCard</a:AssociationName><a:BankName>*</a:Bank<a:BankShortName>ICBI</a:BankShortName><a:BankToken>3</a:BankToken><a:PINNumber>********</a:PINNumber><a:PinValue>******</a:PinValue><a:PortfolioToken>1</a:PortfolioToken><a:ProductLifeCycle>PERMA</a:ProductLifeCycle><a:ProductName>******</a:ProductName><a:ProductToken>7</a:ProductToken><a:ProductTypeNamePay>';
	
	//public String value2='</a:ProductTypeName><a:RetailerPartnerKey>8</a:RetailerPartnerKey><a:RetailerPartnerName>FirstAid</a:RetailerPartnerName></a:PinInformation><a:PrimaryCardHolder><a:Guarantor i:nil="true"/><a:PrimaryPerson><a:DOB>******</a:DOB><a:Email/><a:FirstName>******</a:FirstName><a:LastName>*******</a:LastName><a:MiddleName/><a:SSN>&&&&&&&&&</a:SSN><a:isEditable>true</a:isEditable><a:isMinor>false</a:isMinor></a:PrimaryPerson><a:ProductToken>15</a:ProductToken></a:PrimaryCardHolder><a:RegistrationToken>&&&&&&&</a:RegistrationToken><a:ResponseCode>Success</a:ResponseCode><a:ResponseText i:nil="true"/></GetActivationInformationResult></GetActivationInformationResponse></s:Body></s:Envelope>';
    
    public void parseHtml(){
        String s1='<s:Envelope xmlns:s="Schema URL"><s:Body><GetActivationInformationResponse xmlns="Schema URL"><GetActivationInformationResult xmlns:a="Schema URL" xmlns:i="Schema URL"><a:ATMFee>123</a:ATMFee><a:ActivationData>123</a:ActivationData><a:ActivationType>PIN</a:ActivationType><a:LastVerificationResponse><a:ActivitiesPerformed i:nil="true"/><a:CardLimitAccountList i:nil="true"/><a:OOWQuiz i:nil="true"/><a:Reprompt i:nil="true"/><a:ResponseCode>verified</a:ResponseCode><a:ResponseText>RegistrationService Response Code: Passed</a:ResponseText></a:LastVerificationResponse><a:MonthlyFee>123</a:MonthlyFee><a:PinInformation><a:AssociationName>MasterCard</a:AssociationName><a:BankName>12311</a:BankName><a:BankShortName>ICBI</a:BankShortName><a:BankToken>3</a:BankToken><a:PINNumber>123111</a:PINNumber><a:PinValue>1231</a:PinValue><a:PortfolioToken>1</a:PortfolioToken><a:ProductLifeCycle>PERMA</a:ProductLifeCycle><a:ProductName>1231</a:ProductName><a:ProductToken>7</a:ProductToken><a:ProductTypeName>PayCard';
        String s2='</a:ProductTypeName><a:RetailerPartnerKey>8</a:RetailerPartnerKey><a:RetailerPartnerName>FirstAid</a:RetailerPartnerName></a:PinInformation><a:PrimaryCardHolder><a:Guarantor i:nil="true"/><a:PrimaryPerson><a:DOB>1231</a:DOB><a:Email/><a:FirstName>1231</a:FirstName><a:LastName>12311</a:LastName><a:MiddleName/><a:SSN>999999999</a:SSN><a:isEditable>true</a:isEditable><a:isMinor>false</a:isMinor></a:PrimaryPerson><a:ProductToken>15</a:ProductToken></a:PrimaryCardHolder><a:RegistrationToken>12345</a:RegistrationToken><a:ResponseCode>Success</a:ResponseCode><a:ResponseText i:nil="true"/></GetActivationInformationResult></GetActivationInformationResponse></s:Body></s:Envelope>';
        String s=s1+s2;
        Dom.Document doc= new Dom.Document();
        doc.load(s);
        Dom.XmlNode env= doc.getRootElement();
        system.debug('env::::'+env);
       
        Dom.XmlNode body=env.getChildElement('Body','Schema URL');
        System.debug('Body:::'+body);
        Dom.XmlNode getActivationInformationResponse=Body.getChildElement('GetActivationInformationResponse','Schema URL');
        System.debug('getActivationInformationResponse::'+getActivationInformationResponse);
         Dom.XMLNode getActivationInformationResult=GetActivationInformationResponse.getChildElement('GetActivationInformationResult','Schema URL');
        System.debug('get Result:::'+getActivationInformationResult);
		String name= getActivationInformationResult.getChildElement('ATMFee', 'Schema URL').getText();   
        System.debug('name::'+name);
        
    }
    
    public void parseQueryResponse(){
        String s='<queryResponse><name>Sai</name><age>27</age><AdminSection><payroll>IC</payroll><subscriber>Airtel</subscriber></AdminSection><subscriberInfo><effectiveDate>19/06/2020</effectiveDate></subscriberInfo></queryResponse>';
        Dom.Document doc= new Dom.Document();
        doc.load(s);
        Dom.XmlNode env= doc.getRootElement();
        system.debug('env::::'+env);
        System.debug(env.getName());
        
         for(Dom.XmlNode child: env.getChildElements()){
               System.debug('Par::'+child.getName());
               System.debug('Child Elements:::'+child.getChildElements());
                for(Dom.XmlNode detailElement: child.getChildElements()){
                    System.debug('Name:::'+detailElement.getName()+'~'+'Text::::'+detailElement.getText());
                }
            }
       
       }
        
}