/**
 * Created by Islam on 4/3/2024.
 */

// Importing necessary modules and functions
import { api, LightningElement, wire }  from "lwc";
import FIELD_SALARY                     from "@salesforce/schema/Job__c.Salary__c";
import { getFieldValue, getRecord }     from "lightning/uiRecordApi";

// Importing APEX methods
import getTaxFillingStatusOptions       from "@salesforce/apex/takeHomePayHelper.getTaxFillingStatusOptions";
import getStandardDeductionAmount       from "@salesforce/apex/takeHomePayHelper.getStandardDeductionAmount";
import getTaxRate                       from "@salesforce/apex/takeHomePayHelper.getTaxRate";
import getTaxCustomSetting              from "@salesforce/apex/takeHomePayHelper.getTaxCustomSetting";

// Defining the TakeHomePay class
export default class TakeHomePay extends LightningElement {

  // Declaring public properties
  @api recordId;

  salary;
  taxRate;
  takeHomePay;
  taxableIncome;
  taxRatesRecord;
  socialSecurity;
  federalIncomeTax;
  taxBracketRecords;
  medicareWithholding;
  standardDeductionAmount;
  standardDeductionRecords;
  taxFillingStatusOptions = [];
  selectedTaxFillingStatus = "Single";












  // Event handler for tax filling status change
  handleTaxFillingStatusChange(event) {
    this.selectedTaxFillingStatus = event.target.value;
    this.calculate();
  }

  // Method to calculate take-home pay
  calculate() {

    // Calculating federal income tax
    this.federalIncomeTax     = this.taxableIncome * ( this.taxRate / 100 );

    // Calculating social security and medicare withholding
    this.socialSecurity       = (this.taxRatesRecord.Social_Security_Rate__c/100)       * this.salary;
    this.medicareWithholding  = (this.taxRatesRecord.Medicare_Withholding_Rate__c/100)  * this.salary;

    // Calculating take-home pay
    this.takeHomePay =  this.salary           -
                        this.federalIncomeTax -
                        this.socialSecurity   -
                        this.medicareWithholding;
  }

  setStandardDeductionAmount() {

    // Determining standard deduction amount based on tax filling status
    this.standardDeductionAmount = this.standardDeductionRecords.find( item => {
      return item.Tax_Filling_Status__c === this.selectedTaxFillingStatus;
    } ).Amount__c;
  }

  setTaxRate() {

    // Calculating taxable income
    this.taxableIncome = this.salary - this.standardDeductionAmount;

    console.log('tax bracket records are ::: ')
    console.log( JSON.stringify( this.taxBracketRecords ) );
    // Determining tax rate based on taxable income

      this.taxRate        = this.taxBracketRecords.find( item => {
        return item.Minimum_Value__c < this.taxableIncome && item.Maximum_Value__c > this.taxableIncome;
      } ).Tax_rate__c;


  }

  // Wired function to fetch salary data
  @wire( getRecord, { recordId: "$recordId", fields: [FIELD_SALARY] } )
  salaryHandler( { data } ) {
    if ( data ) {
      this.salary = getFieldValue( data, FIELD_SALARY );
      this.calculate();
    }
  }
  @wire( getStandardDeductionAmount, {taxFillingStatus: '$selectedTaxFillingStatus'} )
  getStandardDeductionAmountHandler( { data, error } ) {
    if ( data ) {
      this.standardDeductionAmount = data;
      this.taxableIncome = this.salary - this.standardDeductionAmount;
    }
    if ( error ) {
      console.error( error );
    }
  }

  @wire( getTaxRate, { taxFillingStatus: "$selectedTaxFillingStatus", amount: "$taxableIncome" } )
  getTaxRateHandler( { data, error } ) {
    if ( data ) {
      this.taxRate = data;
    }
    if ( error ) {
      console.error( error );
    }
  }

  @wire( getTaxCustomSetting )
  getTaxCustomSettingHandler( { data, error } ) {
    if ( data ) {
      this.socialSecurity = data.Social_Security_Rate__c;
      this.medicareWithholding = data.Medicare_Withholding_Rate__c;
    }
    if ( error ) {
      console.error( error );
    }
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

}
