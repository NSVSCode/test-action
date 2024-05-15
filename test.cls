*/
    @AuraEnabled
    public static UserWrapper getUserInfo () {
       List<User> lstUser = new List<User>();
       if(Schema.sObjectType.User.isAccessible() && Schema.sObjectType.User.fields.CompanyName.isAccessible() && 
        Schema.sObjectType.User.fields.Street.isAccessible() && Schema.sObjectType.User.fields.City.isAccessible() &&
        Schema.sObjectType.User.fields.State.isAccessible() && Schema.sObjectType.User.fields.PostalCode.isAccessible() &&
        Schema.sObjectType.User.fields.Country.isAccessible() && Schema.sObjectType.User.fields.Email.isAccessible() &&
        Schema.sObjectType.User.fields.Phone.isAccessible())  {
            lstUser = [SELECT CompanyName,  Street, City, State, PostalCode, Country, Phone  FROM User WHERE Id = :UserInfo.getUserId()];
       }
       UserWrapper userInfo = new UserWrapper();
       
       if(!lstUser.isEmpty()) {
        userInfo.companyName = lstUser[0].CompanyName;
        userInfo.phone = lstUser[0].Phone;       
        userInfo.url = '';
        userInfo.street = lstUser[0].Street;
        userInfo.city = lstUser[0].City;
        userInfo.country = lstUser[0].Country;
        userInfo.province = lstUser[0].State;
        userInfo.postalCode = lstUser[0].PostalCode;
       }
       return userInfo;
    }
    /**
    * @description Create QC customer
    */
    @AuraEnabled
    public static Map<String,Object> createCustomer (CustomerWrap customer) {
        Map<String,Object> result = new Map<String,Object>();
        Map<String, Object> attributes = new Map<String, Object>();
        attributes.put('name', customer.name);
        attributes.put('comments', customer.comments);            
        attributes.put('max-users', '1');
        attributes.put('phone', customer.phone);
        attributes.put('address',customer.address);
        attributes.put('language', 'en');
        attributes.put('company-url', customer.url);
        attributes.put('admin-account', true);
        attributes.put('partner', false);
        attributes.put('has-sso', false);
        attributes.put('include-managed-packages', true);
        attributes.put('has-self-service', false);
        Map<String, Object> data = new Map<String, Object>();
        data.put('type', 'customer');
        data.put('attributes', attributes);
        Map<String, Object> jsonObj = new Map<String, Object>();
        jsonObj.put('data', data);
        String jsonStr = JSON.serialize(jsonObj); 
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:QCLiveChecks__QualityClouds' + '/customer');
        req.setMethod('POST');
        req.setBody(jsonStr);
        req.setHeader('Authorization', '{!$Credential.QualityCloudsExternalCredential.ApiKey }');
        req.setHeader('client-name', 'GenericHttpClient');
        req.setHeader('Accept', 'application/vnd.api+json');
        req.setHeader('Content-Type','application/vnd.api+json');
        Http http = new Http();
        HTTPResponse res = http.send(req);
        
        if(res.getStatusCode() == 201) {
            Map<String, Object> response = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
            QcUser__c user = new QcUser__c(CustomerId__c = String.ValueOf(response.get('id')), User__c = UserInfo.getUserId());
            if(Schema.sObjectType.QcUser__c.isCreateable()) {
                insert user;
            } 
            result.put('isSuccess', 'OK');
        } else {
            result.put('isSuccess', 'KO');
            result.put('errorMessage', res.getBody() + ' - ' + res.getStatusCode());
            result.put('errorCode', res.getStatusCode());
            return result;
        }
        return result;
    }
    /**
    * @description Wrapper used for response to the LWC with data of the User and company
    */
    public class UserWrapper {
        /**
        * @description company Name
        */
        @AuraEnabled public String companyName {get;set;}
        /**
        * @description phone
        */
        @AuraEnabled public String phone {get;set;}
        /**
        * @description language
        */
        @AuraEnabled public String language {get;set;}
        /**
        * @description url
        */
        @AuraEnabled public String url {get;set;}
        /**
        * @description street
        */
        @AuraEnabled public String street {get;set;}
        /**
        * @description city
        */
        @AuraEnabled public String city {get;set;}
        /**
        * @description country
        */
        @AuraEnabled public String country {get;set;}
        /**
        * @description province
        */
        @AuraEnabled public String province {get;set;}
        /**
        * @description postalCode
        */
        @AuraEnabled public String postalCode {get;set;}
    }
}*/
    @AuraEnabled
    public static UserWrapper getUserInfo () {
       List<User> lstUser = new List<User>();
       if(Schema.sObjectType.User.isAccessible() && Schema.sObjectType.User.fields.CompanyName.isAccessible() && 
        Schema.sObjectType.User.fields.Street.isAccessible() && Schema.sObjectType.User.fields.City.isAccessible() &&
        Schema.sObjectType.User.fields.State.isAccessible() && Schema.sObjectType.User.fields.PostalCode.isAccessible() &&
        Schema.sObjectType.User.fields.Country.isAccessible() && Schema.sObjectType.User.fields.Email.isAccessible() &&
        Schema.sObjectType.User.fields.Phone.isAccessible())  {
            lstUser = [SELECT CompanyName,  Street, City, State, PostalCode, Country, Phone  FROM User WHERE Id = :UserInfo.getUserId()];
       }
       UserWrapper userInfo = new UserWrapper();
       
       if(!lstUser.isEmpty()) {
        userInfo.companyName = lstUser[0].CompanyName;
        userInfo.phone = lstUser[0].Phone;       
        userInfo.url = '';
        userInfo.street = lstUser[0].Street;
        userInfo.city = lstUser[0].City;
        userInfo.country = lstUser[0].Country;
        userInfo.province = lstUser[0].State;
        userInfo.postalCode = lstUser[0].PostalCode;
       }
       return userInfo;
    }
    /**
    * @description Create QC customer
    */
    @AuraEnabled
    public static Map<String,Object> createCustomer (CustomerWrap customer) {
        Map<String,Object> result = new Map<String,Object>();
        Map<String, Object> attributes = new Map<String, Object>();
        attributes.put('name', customer.name);
        attributes.put('comments', customer.comments);            
        attributes.put('max-users', '1');
        attributes.put('phone', customer.phone);
        attributes.put('address',customer.address);
        attributes.put('language', 'en');
        attributes.put('company-url', customer.url);
        attributes.put('admin-account', true);
        attributes.put('partner', false);
        attributes.put('has-sso', false);
        attributes.put('include-managed-packages', true);
        attributes.put('has-self-service', false);
        Map<String, Object> data = new Map<String, Object>();
        data.put('type', 'customer');
        data.put('attributes', attributes);
        Map<String, Object> jsonObj = new Map<String, Object>();
        jsonObj.put('data', data);
        String jsonStr = JSON.serialize(jsonObj); 
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:QCLiveChecks__QualityClouds' + '/customer');
        req.setMethod('POST');
        req.setBody(jsonStr);
        req.setHeader('Authorization', '{!$Credential.QualityCloudsExternalCredential.ApiKey }');
        req.setHeader('client-name', 'GenericHttpClient');
        req.setHeader('Accept', 'application/vnd.api+json');
        req.setHeader('Content-Type','application/vnd.api+json');
        Http http = new Http();
        HTTPResponse res = http.send(req);
        
        if(res.getStatusCode() == 201) {
            Map<String, Object> response = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
            QcUser__c user = new QcUser__c(CustomerId__c = String.ValueOf(response.get('id')), User__c = UserInfo.getUserId());
            if(Schema.sObjectType.QcUser__c.isCreateable()) {
                insert user;
            } 
            result.put('isSuccess', 'OK');
        } else {
            result.put('isSuccess', 'KO');
            result.put('errorMessage', res.getBody() + ' - ' + res.getStatusCode());
            result.put('errorCode', res.getStatusCode());
            return result;
        }
        return result;
    }
    /**
    * @description Wrapper used for response to the LWC with data of the User and company
    */
    public class UserWrapper {
        /**
        * @description company Name
        */
        @AuraEnabled public String companyName {get;set;}
        /**
        * @description phone
        */
        @AuraEnabled public String phone {get;set;}
        /**
        * @description language
        */
        @AuraEnabled public String language {get;set;}
        /**
        * @description url
        */
        @AuraEnabled public String url {get;set;}
        /**
        * @description street
        */
        @AuraEnabled public String street {get;set;}
        /**
        * @description city
        */
        @AuraEnabled public String city {get;set;}
        /**
        * @description country
        */
        @AuraEnabled public String country {get;set;}
        /**
        * @description province
        */
        @AuraEnabled public String province {get;set;}
        /**
        * @description postalCode
        */
        @AuraEnabled public String postalCode {get;set;}
    }
}