import { LightningElement, wire } from 'lwc';
import getLevel1 from '@salesforce/apex/TableService.getLevel1';
import getLevel2 from '@salesforce/apex/TableService.getLevel2';
import getLevel3 from '@salesforce/apex/TableService.getLevel3';
import updateAccounts from '@salesforce/apex/TableService.updateAccounts';
import {refreshApex} from '@salesforce/apex';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';

const COLS = [  
    { label: 'Account Name', fieldName: 'Name', type: 'text', cellAttributes: { iconName: 'standard:account_info' }},
    { label: 'Phone', fieldName: 'Phone', type: 'phone'},
    { label: 'Last Modified By Name', fieldName: 'TestLast__c', type: 'text'},
];

export default class Table1 extends LightningElement {
    columns = COLS; 

    @wire(getLevel1) acclevel1;
    @wire(getLevel2) acclevel2;
    @wire(getLevel3) acclevel3;

    handleClick(){

        let level1Rows = this.template.querySelector('[data-id="Level1"]').getSelectedRows();
        let level2Rows = this.template.querySelector('[data-id="Level2"]').getSelectedRows();
        let level3Rows = this.template.querySelector('[data-id="Level3"]').getSelectedRows();

        let accountsToSend = level1Rows.concat(level2Rows);   
        accountsToSend = accountsToSend.concat(level3Rows); 

        if(accountsToSend.length == 0){
            const event = new ShowToastEvent({
                title: 'Warning',
                message:
                    'Select at least 1 (one) row 🎯',
                variant:
                    'error'
                });
                this.dispatchEvent(event);
        }
       
        if(accountsToSend.length > 0){
            updateAccounts({inputAccounts : accountsToSend})
            .then(() => {
                refreshApex(this.acclevel1);
                refreshApex(this.acclevel2);
                refreshApex(this.acclevel3);
                this.template.querySelector('[data-id="Level1"]')
                this.template.querySelector('[data-id="Level2"]')
                this.template.querySelector('[data-id="Level3"]')
                
                const event = new ShowToastEvent({
                    title: 'Success',
                    message:
                        '\u2022 Records successfully updated 👍',
                    variant:
                        'success'
                });
                this.dispatchEvent(event);
            })
            .catch((error) => {
                const event = new ShowToastEvent({
                title: 'Warning',
                message:
                `Error: ${error}`,
                variant:
                    'error'
                });
                this.dispatchEvent(event);
            })
        }
    }
    
}
