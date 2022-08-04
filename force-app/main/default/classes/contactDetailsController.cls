public class contactDetailsController {
@AuraEnabled(Cacheable=true)
public static Map<String, String> getContactDetailMap(String objectName, String fieldName, String recordId){
    Map<String, String> contactDetailsMap = new Map<String, String>();
    
    String mainObjectQuery = 'Select id, ' + fieldName + ' from ' + objectName + ' where id = \'' + recordId + '\' limit 1' ; 

	sObject s = Database.query(mainObjectQuery);
    System.debug('s.fieldName-------->'+ s.get(fieldName));
    String contactID = (String) s.get(fieldName);
    Contact con = [Select id , name , email , MailingCity, MailingState from contact where id =:contactID ];
    User u = [Select id, SmallPhotoUrl, FullPhotoUrl, BannerPhotoUrl From User where contactID =: contactID];
    
    contactDetailsMap.put('Name',con.name);
    contactDetailsMap.put('Email',con.email);
    contactDetailsMap.put('City',con.MailingCity);
    contactDetailsMap.put('State',con.MailingState);
    contactDetailsMap.put('ProfilePhoto',u.SmallPhotoUrl);
    contactDetailsMap.put('BannerPhoto',u.BannerPhotoUrl);
    
    
    return contactDetailsMap;
}
}