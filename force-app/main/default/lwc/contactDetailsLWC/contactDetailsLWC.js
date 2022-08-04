import { LightningElement, track,wire, api } from 'lwc';
import getContactDetailMap from '@salesforce/apex/contactDetailsController.getContactDetailMap';
export default class ContactDetailsLWC extends LightningElement {

    @track contactdetailsMap;
    @api recordId;
    @api objectName = '';
    @api fieldName = '';
    @track backgroundStyle;
    @track areDetailsVisible = false;

    @wire(getContactDetailMap, {
        objectName : '$objectName',
        fieldName : '$fieldName',
        recordId : '$recordId'
    })
    wiredContacts({ data }) {
        if (data) {
            this.contactdetailsMap = data; 
            console.log(this.contactdetailsMap);
            this.backgroundStyle = 'background-origin: content-box;height:10rem;background-size: 100% 50%;background-repeat: no-repeat;background-image:url(' + data.BannerPhoto + ')';
            this.areDetailsVisible = true;
        }
    }

}