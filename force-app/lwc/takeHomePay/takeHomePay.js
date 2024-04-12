/**
 * Created by Islam on 4/3/2024.
 */

// Importing necessary modules and functions
import { api, LightningElement, wire }      from "lwc";
import FIELD_SALARY                         from "@salesforce/schema/Job__c.Salary__c";
import FIELD_SingleStandardDeductionAmount  from "@salesforce/schema/Standard_Deduction__c";
import { getFieldValue, getRecord }         from "lightning/uiRecordApi";

// Importing APEX methods
import getTaxFillingStatusOptions       from "@salesforce/apex/takeHomePayHelper.getTaxFillingStatusOptions";
import calculateTax                     from "@salesforce/apex/takeHomePayHelper.calculateTax";


// Defining the TakeHomePay class
export default class TakeHomePay extends LightningElement {

  // Declaring public properties
  @api recordId;

  salary;
  takeHomePay;
  socialSecurity;
  federalIncomeTax;
  medicareWithholding;
  standardDeductionAmount;
  taxFillingStatusOptions = [];
  selectedTaxFillingStatus = "Single";

  // Event handler for tax filling status change
  handleTaxFillingStatusChange(event) {
    this.selectedTaxFillingStatus = event.target.value;
    this.calculateTax();
  }

  // Wired function to fetch salary data
  @wire( getRecord, { recordId: "$recordId", fields: [FIELD_SALARY] } )
  salaryHandler( { data } ) {
    if ( data ) {
      this.salary = getFieldValue( data, FIELD_SALARY );
      this.calculateTax();
    }
  }

  @wire ( getRecord)

  calculateTax() {
    console.log('calculateTax is getting called')
      calculateTax( { salary: this.salary, taxFillingStatus: this.selectedTaxFillingStatus } ).then( result => {
        console.log('calculateTax apex is called')
        this.socialSecurity           = result.socialSecurity;
        this.medicareWithholding      = result.medicareWithholding;
        this.federalIncomeTax         = result.federalIncomeTax;
        this.takeHomePay              = result.takeHomePay;
        this.standardDeductionAmount  = result.standardDeductionAmount;

      } ).catch( error => {
        console.error( error );
      } );
  }


  // Wired function to fetch tax filling status options
  @wire( getTaxFillingStatusOptions )
  getTaxFillingStatusOptionsHandler( { data, error } ) {
    if ( data ) {
      // Formatting options for combobox
      data.forEach( currentItem => {
        this.taxFillingStatusOptions = [...this.taxFillingStatusOptions, {label: currentItem, value: currentItem}]
      } );
    }
    if ( error ) {
      console.error( error );
    }
  }

  salaryChangeHandler(event) {
    if ( event.target.value < this.standardDeductionAmount ) {
      event.target.setCustomValidity( "Must be greater than " + this.standardDeductionAmount );
      event.target.reportValidity();
    } else {
      this.resetValidity(event);
      this.salary = event.target.value;
      this.calculateTax();
    }
  }

  blurHandler(event) {
    if ( event.target.value < this.standardDeductionAmount ) {
      event.target.value = this.salary;
      this.resetValidity(event);
    }
  }

  resetValidity(event) {
    event.target.setCustomValidity( "" );
    event.target.reportValidity();
  }

}