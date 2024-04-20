/**
 * Created by islam on 4/3/2024.
 */

public without sharing class takeHomePayHelper {

    @AuraEnabled(Cacheable=true)
    public static Map<String, Decimal> calculateTax(Decimal salary, String taxFillingStatus) {
        Map<String, Decimal> result = new Map<String, Decimal>();

        Tax__c taxCustomSetting     = getTaxCustomSetting();
        Decimal socialSecurity      = (salary * (taxCustomSetting.Social_Security_Rate__c/100)).setScale(2);
        Decimal medicareWithholding = (salary * (taxCustomSetting.Medicare_Withholding_Rate__c/100)).setScale(2);

        result.put('socialSecurity'     , socialSecurity);
        result.put('medicareWithholding', medicareWithholding);

        Decimal standardDeductionAmount = getStandardDeductionAmount(taxFillingStatus);
        result.put('standardDeductionAmount', standardDeductionAmount);

        Decimal taxableAmount       = salary - standardDeductionAmount;
        Decimal taxRate             = getTaxRate(taxFillingStatus, taxableAmount);
        Decimal federalIncomeTax    = (taxableAmount * (taxRate/100)).setScale(2);
        result.put('federalIncomeTax', federalIncomeTax);

        Decimal takeHomePay = (salary - federalIncomeTax - socialSecurity - medicareWithholding).setScale(2);
        result.put('takeHomePay', takeHomePay);

        return result;
    }

    @AuraEnabled(Cacheable=true)
    public static Job__c getCurrentJob(Id jobId) {
        Job__c job = [SELECT Id, Salary__c FROM Job__c WHERE Id = :jobId];
        return job;
    }

    @AuraEnabled(Cacheable=true)
    public static List<String> getTaxFillingStatusOptions() {

        List<String> picklistOptions = new List<String>();

        Schema.DescribeFieldResult picklistDescribeFieldResult = Standard_Deduction__mdt.Tax_Filling_Status__c.getDescribe();

        for (Schema.PicklistEntry currentPicklistEntry: picklistDescribeFieldResult.getPicklistValues()) {
            picklistOptions.add(currentPicklistEntry.getValue());
        }
        return picklistOptions;
    }


    @AuraEnabled(Cacheable=true)
    public static Decimal getStandardDeductionAmount(String taxFillingStatus) {
        return [SELECT  Id, Amount__c, Tax_Filling_Status__c
                FROM    Standard_Deduction__mdt
                WHERE   Tax_Filling_Status__c = :taxFillingStatus].Amount__c;
    }

    @AuraEnabled(Cacheable=true)
    public static Tax__c getTaxCustomSetting() {
        return [SELECT Id, Social_Security_Rate__c, Medicare_Withholding_Rate__c
                FROM Tax__c
                LIMIT 1];
    }

    @AuraEnabled(Cacheable=true)
    public static Decimal getTaxRate(String taxFillingStatus, Decimal amount) {
        return [SELECT  Id,
                        Tax_Filling_Status__c,
                        Minimum_Value__c,
                        Maximum_Value__c,
                        Tax_rate__c
                FROM Tax_Bracket__mdt
                WHERE Tax_Filling_Status__c = :taxFillingStatus
                AND Minimum_Value__c < :amount
                AND Maximum_Value__c > :amount].Tax_rate__c;
    }
}