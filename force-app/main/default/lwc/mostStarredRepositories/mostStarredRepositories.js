import { LightningElement, api, track, wire } from 'lwc';
import getRepositories from '@salesforce/apex/RepositoryController.getRepositories';

const columns = [
    { label: 'Repository Name', fieldName: 'Name', type: 'text' },
    { label: 'Number of Stars', fieldName: 'Number_of_Stars__c', type: 'number' },
    { label: 'Number of Forks', fieldName: 'Number_of_Forks__c', type: 'number' },
    { label: 'GitHub Repository ID', fieldName: 'Repository_ID__c', type: 'string' }
];

export default class MostStarredRepositories extends LightningElement {

    @api title;
    @track showSpinner = true;
    @track data = [];
    @track columns = columns;

    connectedCallback() {
        getRepositories()
            .then(result => {
                this.data = result;
                this.showSpinner = false;
            })
            .catch(error => {
                console.log('error is: ' + JSON.stringify(error));
                this.showSpinner = false;
            });
        
        
    }


}