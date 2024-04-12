/**
 * Created by islam on 4/11/2024.
 */

import { api, LightningElement } from "lwc";

export default class PaycheckBreakdown extends LightningElement {
  weekly;
  biWeekly;
  monthly;
  sixMonths;
  yearly;
  takeHomePay;

  @api

  get takeHomePayFromParent() {
    return this.takeHomePay;
  }
  set takeHomePayFromParent(takeHomePayFromParent) {
    this.takeHomePay = takeHomePayFromParent;
    this.calculate();
  }

  calculate() {
    this.sixMonths = (this.takeHomePay  /  2).toFixed(2);
    this.monthly   = (this.takeHomePay  / 12).toFixed(2);
    this.biWeekly  = (this.monthly      /  2).toFixed(2);
    this.weekly    = (this.biWeekly     /  2).toFixed(2);
    this.yearly    = this.takeHomePay;

  }




}