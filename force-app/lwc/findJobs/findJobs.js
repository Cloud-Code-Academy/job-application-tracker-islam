/**
 * Created by islam on 4/8/2024.
 */
import { LightningElement, track } from "lwc";
import { ShowToastEvent} from "lightning/platformShowToastEvent";

// Import APEX
import getJobs                from "@salesforce/apex/fetchJobsFromJooble.getJobs";
import insertJobs             from "@salesforce/apex/findJobsHelper.insertJobs";
import insertJobApplications  from "@salesforce/apex/findJobsHelper.insertJobApplications";


const columns = [
  { label: 'Title'              , fieldName: 'Position_Title__c'     , type: 'text'    } ,
  { label: 'Company'            , fieldName: 'Company_Name__c'       , type: 'text'    } ,
  { label: 'Location'           , fieldName: 'Location__c'           , type: 'text'    } ,
  { label: 'Salary Range'       , fieldName: 'Salary_Range__c'       , type: 'Decimal' } ,
  { label: 'Annual Lower Bound' , fieldName: 'Salary_Lower_Bound__c' , type: 'Decimal' } ,
  { label: 'Annual Upper Bound' , fieldName: 'Salary_Upper_Bound__c' , type: 'Decimal' } ,
  { label: 'Annual Average'     , fieldName: 'Salary__c'             , type: 'Decimal' } ,
  { label: 'URL'                , fieldName: 'URL__c'                , type: 'url'     }
];


export default class FindJobs extends LightningElement {
  selectedJobs;
  numberOfSelectedRows = 0;
  isButtonDisabled = true;
  jobRecords = [];
  columns = columns;

  connectedCallback() {
    this.fetchJobs();
  }

  handleSelection(event) {
    this.selectedJobs = event.detail.selectedRows;
    this.numberOfSelectedRows = this.selectedJobs.length;
    if ( this.numberOfSelectedRows > 0 ) {
      this.isButtonDisabled = false;
    } else {
      this.isButtonDisabled = true;
    }

    console.log( 'number of selected rows is ::: ' + this.numberOfSelectedRows );
    console.log('updated selected rows are ::: ')
    console.log( event.detail.selectedRows );

  }


  handleSaveJobs(event) {
    console.log( this.selectedJobs );
    console.log('selected jobs are ::: ')
    console.log( JSON.stringify( this.selectedJobs ) );
    insertJobs( { jobs: this.selectedJobs } )
      .then( result => {
        console.log( "jobs inserted successfully" );
        let msg;
        if ( this.numberOfSelectedRows == 1 ) {
          msg = this.numberOfSelectedRows + " Job saved successfully";
        } else {
          msg = this.numberOfSelectedRows + " Jobs saved successfully";
        }

        this.showToast( "Success", msg, "Success" );
      } )
      .catch( error => {
        console.error('insertJobs failed')
        console.error( error );
      } );
  }

  handleCreateApplications(event) {
    insertJobApplications( { jobs: this.selectedJobs } )
      .then( result => {
        console.log( "applications inserted successfully" );
        let msg;
        if ( this.numberOfSelectedRows == 1 ) {
          msg = this.numberOfSelectedRows + " Job saved successfully and an application created";
        } else {
          msg = this.numberOfSelectedRows + " Jobs saved successfully and applications created";
        }
        this.showToast( "Success", msg, "Success" );
      } ).catch( error => {
        console.error(error)
    } );
  }

  showToast( title, message, variant ) {
    const event = new ShowToastEvent( {
      title,
      message,
      variant
    } );
    this.dispatchEvent( event );
  }

  fetchJobs() {
    getJobs()
      .then( result => {
        this.jobRecords = result;
      } )
      .catch( error => {
        console.error( error );
      } );
  }

}