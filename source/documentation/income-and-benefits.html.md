---
title: Income and benefits | Tax Logic service guide
weight: 2
description: Details of the calculations used for income and benefits.
---

# Income and benefits

Income tax calculations cover a range of income sources, including employment earnings, benefits in kind, self-employment profits, property income, savings, dividends, capital gains and pension income. These combined sources form the basis of taxable income.

## Self-employment

All parameters used as inputs for self-employment calculations are in the [Self Employment Business API](https://developer.service.hmrc.gov.uk/api-documentation/docs/api/service/self-employment-business-api/). However, some parameter names in the pseudocode differ slightly from those in the API and are noted in pseudocode comments.

> **Note:** For calculation purposes, self-employment data is processed for each income source. Customers with multiple self-employments will have source-level calculations, with totals across all sources calculated in the [Income summary totals](#income-summary-totals) section.

### Self-employment income

Self-employment income refers to sole trader self-employment income and not income earned through partnerships or limited companies. For more information about identifying self-employment income, refer to [Working for yourself (GOV.UK)](https://www.gov.uk/working-for-yourself).

Below is the calculation pseudocode for each self-employment income source.

<pre>
    <code>
    <font color="#85994b">// Input parameters (parameter names are same as API parameter names)</font>
turnover <font color="#85994b">// The takings, fees, sales or money earned by the business.</font>
other <font color="#85994b">// Any other business income not included in turnover.</font>

<font color="#85994b">// Other parameter used for calculations  </font>
totalSelfEmploymentIncome

<font color="#85994b">// Calculate totalSelfEmploymentIncome</font>
totalSelfEmploymentIncome = roundDown(turnover + other, 2) <font color="#85994b">// Round down to 2 decimal places</font>
   </code>
</pre>

### Self-employment expenses

For information about self-employment expenses, refer to [Expenses if you're self-employed (GOV.UK)](https://www.gov.uk/expenses-if-youre-self-employed).

Below is the calculation pseudocode for self-employment expenses.

<pre>
    <code>
<font color="#85994b">// Input parameters</font>  
consolidatedExpenses <font color="#85994b">// Parameter name is same as API parameter name</font>
costOfGoodsAllowable <font color="#85994b">// API parameter name: costofGoods</font>
paymentsToSubcontractorsAllowable <font color="#85994b">// API parameter name: paymentsToSubcontractors</font>
wagesAndStaffCostsAllowable <font color="#85994b">// API parameter name: wagesAndStaffCosts</font>
carVanTravelExpensesAllowable <font color="#85994b">// API parameter name: carVanTravelExpenses</font>
premisesRunningCostsAllowable <font color="#85994b">// API parameter name: premisesRunningCosts</font>
maintenanceCostsAllowable <font color="#85994b">// API parameter name: maintenanceCosts</font>
adminCostsAllowable <font color="#85994b">// API parameter name: adminCosts</font>
interestOnBankOtherLoansAllowable <font color="#85994b">// API parameter name: interestOnBankOtherLoans</font>
financeChargesAllowable <font color="#85994b">// API parameter name: financeCharges</font>
irrecoverableDebtsAllowable <font color="#85994b">// API parameter name: irrecoverableDebts</font>
professionalFeesAllowable <font color="#85994b">// API parameter name: professionalFees</font>
depreciationAllowable <font color="#85994b">// API parameter name: depcreciation</font>
otherExpensesAllowable <font color="#85994b">// API parameter name: otherExpenses</font>
advertisingCostsAllowable <font color="#85994b">// API parameter name: advertisingCosts</font>
businessEntertainmentCostsAllowable <font color="#85994b">// API parameter name: businessEntertainmentCosts</font>

<font color="#85994b">// NOTE: Self Employment Business API returns either consolidatedExpenses or the other expenses listed</font>

<font color="#85994b">// Other parameter used for calculations</font>
totalSelfEmploymentExpenses <font color="#85994b">// Total value can be negative</font>  

<font color="#85994b">// Calculate totalSelfEmploymentExpenses</font>
totalSelfEmploymentExpenses = roundUp(consolidatedExpenses + costOfGoodsAllowable + paymentsToSubcontractorsAllowable + wagesAndStaffCostsAllowable + carVanTravelExpensesAllowable + premisesRunningCostsAllowable + maintenanceCostsAllowable + adminCostsAllowable + interestOnBankOtherLoansAllowable + financeChargesAllowable + irrecoverableDebtsAllowable + professionalFeesAllowable + depreciationAllowable + otherExpensesAllowable + advertisingCostsAllowable + businessEntertainmentCostsAllowable, 2) <font color="#85994b">// Round up to 2 decimal places</font>
   </code>
</pre>

### Self-employment additions

For calculation purposes, ‘additions’ refer to disallowable expenses and certain adjustments.

For information about self-employment disallowable expenses, refer to [HS222 How to calculate your taxable profits (2024) (GOV.UK)](https://www.gov.uk/government/publications/how-to-calculate-your-taxable-profits-hs222-self-assessment-helpsheet/hs222-how-to-calculate-your-taxable-profits-2024).

Below is the calculation pseudocode for self-employment additions.

<pre>
    <code>
<font color="#85994b">// Input parameters</font>
<font color="#85994b">// Disallowable expenses</font>
<font color="#85994b">// Parameter names are same as API parameter names</font>
costOfGoodsDisallowable
paymentsToSubcontractorsDisallowable
wagesAndStaffCostsDisallowable
carVanTravelExpensesDisallowable
premisesRunningCostsDisallowable
maintenanceCostsDisallowable
adminCostsDisallowable
interestOnBankOtherLoansDisallowable
financeChargesDisallowable
irrecoverableDebtsDisallowable
professionalFeesDisallowable
depreciationDisallowable
otherExpensesDisallowable
advertisingCostsDisallowable
BusinessEntertainmentCostsDisallowable

<font color="#85994b">// Adjustments treated as additions</font>
<font color="#85994b">// Parameter names are same as API parameter names</font>
outstandingBusinessIncome
balancingChargeOther
balancingChargeBpra
goodAndServicesOwnUse

<font color="#85994b">// Other parameter used for calculations</font>
totalSelfEmploymentAdditions

<font color="#85994b">// Calculate totalSelfEmploymentAdditions</font>
totalSelfEmploymentAdditions = roundDown(costOfGoodsDisallowable + paymentsToSubcontractorsDisallowable + wagesAndStaffCostsDisallowable + carVanTravelExpensesDisallowable + premisesRunningCostsDisallowable + maintenanceCostsDisallowable + adminCostsDisallowable + interestOnBankOtherLoansDisallowable + financeChargesDisallowable + irrecoverableDebtsDisallowable + professionalFeesDisallowable + depreciationDisallowable + otherExpensesDisallowable + advertisingCostsDisallowable + businessEntertainmentCostsDisallowable + outstandingBusinessIncome + balancingChargeOther + balancingChargeBpra + goodAndServicesOwnUse, 2) <font color="#85994b">// Round down to 2 decimal places</font>
   </code>
</pre>

### Self-employment deductions

For information about self-employment deductions, refer to [Tax-free allowances on property and trading income](https://www.gov.uk/guidance/tax-free-allowances-on-property-and-trading-income).

Below is the calculation pseudocode for self-employment deductions.

<pre>
    <code>
<font color="#85994b">// Input parameters</font>
<font color="#85994b">// Deduction allowances</font>
tradingAllowance <font color="#85994b">// API parameter name: tradingIncomeAllowance  </font>
annualInvestmentAllowance <font color="#85994b">// Parameter name is same as API parameter name</font>
capitalAllowanceMainPool <font color="#85994b">// Parameter name is same as API parameter name</font>
capitalAllowanceSpecialRatePool <font color="#85994b">// Parameter name is same as API parameter name</font>
zeroEmmissionGoods <font color="#85994b">// API parameter name: zeroEmissionsGoodsVehicleAllowance</font>
businessPremisesRennovationAllowance <font color="#85994b">// Parameter name is same as API parameter name</font>
enhancedCapitalAllowance <font color="#85994b">// Parameter name is same as API parameter name</font>
allowanceOnSales <font color="#85994b">// Parameter name is same as API parameter name</font>
capitalAllowanceSingleAssetPool <font color="#85994b">// Parameter name is same as API parameter name</font>
electricChargePointAllowance <font color="#85994b">// Parameter name is same as API parameter name</font>
zeroEmissionsCarAllowance <font color="#85994b">// Parameter name is same as API parameter name</font>
structuredBuildingAllowance <font color="#85994b">// Parameter name is same as API parameter name</font>
enhancedStructuredBuildingAllowance <font color="#85994b">// Parameter name is same as API parameter name</font>

<font color="#85994b">// Adjustments parameter treated as a deduction</font>
includedNonTaxableProfits <font color="#85994b">// Parameter name is same as API parameter name</font>

<font color="#85994b">// Other parameter used for calculations  </font>
totalSelfEmploymentDeductions

<font color="#85994b">// Calculate totalSelfEmploymentDeductions</font>
totalSelfEmploymentDeductions = roundUp(tradingAllowance + annualInvestmentAllowance + capitalAllowanceMainPool + capitalAllowanceSpecialRatePool + zeroEmmissionGoods + businessPremisesRennovationAllowance + enhancedCapitalAllowance + allowanceOnSales + capitalAllowanceSingleAssetPool + includedNonTaxableProfits + electricChargePointAllowance + zeroEmissionsCarAllowance + structuredBuildingAllowance + enhancedStructuredBuildingAllowance, 2) <font color="#85994b">// Round up to 2 decimal places</font>
   </code>
</pre>

### Self-employment accounting adjustments

For information about self-employment accounting adjustments, refer to [Adjust your business income (GOV.UK)](https://www.gov.uk/guidance/use-making-tax-digital-for-income-tax/adjust-your-business-income).

Below is the calculation pseudocode for self-employment adjustments.

<pre>
    <code>
<font color="#85994b">// Input parameters</font> 
<font color="#85994b">//Parameter names are same as API parameter names)</font>
basisAdjustment
accountingAdjustment
averagingAdjustment

<font color="#85994b">// Other parameter used for calculations</font>
totalSelfEmploymentAccountingAdjustments

<font color="#85994b">// Calculate totalSelfEmploymentAccountingAdjustments</font>
totalSelfEmploymentAccountingAdjustments = roundDown(basisAdjustment + accountingAdjustment + averagingAdjustment, 2) <font color="#85994b">// Round down to 2 decimal places</font>
   </code>
</pre>

### Calculate total taxable self-employment profit

Below is the calculation pseudocode for total taxable self-employment profit or loss.

<pre>
    <code>
<font color="#85994b">// Input Parameters</font>
totalSelfEmploymentIncome
totalSelfEmploymentExpenses
totalSelfEmploymentAdditions
totalSelfEmploymentDeductions
totalSelfEmploymentAccountingAdjustments


<font color="#85994b">// Other parameters used for calculations</font>
netProfitFromSelfEmployment = 0 <font color="#85994b">// Net profit before additions, deductions and adjustments</font>
netLossFromSelfEmployment = 0 <font color="#85994b">// Net loss before additions, deductions and adjustments</font>
adjustedProfitOrLossFromSelfEmployment <font color="#85994b">// Taxable profit or loss after additions, deductions and adjustments</font>
taxableProfitFromSelfEmployment <font color="#85994b">// Final taxable profit after additions, deductions and adjustments</font>
taxableLossFromSelfEmployment <font color="#85994b">// Final taxable loss after additions, deductions and adjustments</font>


<font color="#85994b">// Calculate net profit or loss</font>
<font color="#1d70b8">if</font> totalSelfEmploymentIncome >= totalSelfEmploymentExpenses <font color="#1d70b8">then</font>
     netProfitFromSelfEmployment = totalSelfEmploymentIncome - totalSelfEmploymentExpenses
<font color="#1d70b8">else</font>
     netLossFromSelfEmployment = totalSelfEmploymentIncome - totalSelfEmploymentExpenses
<font color="#1d70b8">end if</font>


<font color="#85994b">// Calculate adjusted profit or loss by applying additions, deductions, and adjustments</font>
adjustedProfitOrLossFromSelfEmployment = netProfitFromSelfEmployment + netLossFromSelfEmployment + totalSelfEmploymentAdditions - totalSelfEmploymentDeductions + totalSelfEmploymentAccountingAdjustments <font color="#85994b">// Either netProfitFromSe or netLossFromSe would be present</font>


<font color="#85994b">// Determine if the adjusted amount is a taxable profit or loss</font>
<font color="#1d70b8">if</font> adjustedProfitOrLossFromSelfEmployment >= 0 <font color="#1d70b8">then</font>
    taxableProfitFromSelfEmployment = adjustedProfitOrLossFromSelfEmployment
<font color="#1d70b8">else</font>
    taxableLossFromSelfEmployment = adjustedProfitOrLossFromSelfEmployment
<font color="#1d70b8">end if</font>
</pre>
</code>

## Property

All parameters used as inputs for property calculations are in the [Property Business API](https://developer.service.hmrc.gov.uk/api-documentation/docs/api/service/property-business-api/). However, some parameter names in the pseudocode differ slightly from those in the API and are noted in pseudocode comments.

> **Note:** For calculation purposes, all foreign property data is handled at country level, with totals across all countries calculated in the [Income summary totals](#income-summary-totals) section.

### Property income

A customer’s property income includes rental income and other receipts from foreign and UK land or property, income from letting furnished rooms in the customer’s own home and from holiday lettings in the UK. For more information, refer to [Work out your rental income when you let property (GOV.UK)](https://www.gov.uk/guidance/income-tax-when-you-rent-out-a-property-working-out-your-rental-income).

#### UK non-FHL income

Below is the calculation pseudocode for UK non-FHL property income calculations.

<pre>
    <code>
<font color="#85994b">// Input parameters</font>
totalRentsReceived <font color="#85994b">// Total rents from property, but not ground rents, rent charges and rent-a-room rental income (API parameter name: periodAmount)</font>
premiumsOfLeaseGrant <font color="#85994b">// Premiums received for the grant of a lease and other lump sums to possess a property (parameter name is same as API parameter name)</font>
reversePremiums <font color="#85994b">// Amount paid by a landlord or outgoing tenant to induce a new tenant to enter into a leasehold agreement (parameter name is same as API parameter name)</font>
otherPropertyIncome <font color="#85994b">// Total amount of rent and any income for services provided to tenants (API parameter name: otherIncome)</font>
rarRentReceived <font color="#85994b">// Total rents received from properties (rent-a-room only) (API parameter name: rentARoom.rentsReceived)</font>

<font color="#85994b">// Other parameter used for calculations</font>
totalIncomeFromUkPropertyOther

<font color="#85994b">// Calculate totalIncomeFromUkPropertyOther</font>
totalIncomeFromUkPropertyOther = roundDown(totalRentsReceived + premiumsOfLeaseGrant + reversePremiums + otherPropertyIncome + rarRentReceived, 2) <font color="#85994b">// Round down to 2 decimal places</font>
   </code>
</pre>

### Property expenses

For information about property expenses, refer to [Work out your rental income when you let property (GOV.UK)](https://www.gov.uk/guidance/income-tax-when-you-rent-out-a-property-working-out-your-rental-income).

#### UK non-FHL expenses

Below is the calculation pseudocode for UK non-FHL property expenses.

<pre>
    <code>
<font color="#85994b">// Input parameters </font> 
<font color="#85994b">// Parameter names are same as API parameter names</font>
consolidatedExpenses
premisesRunningCosts
repairsAndMaintenance  
financialCosts  
professionalFees
costOfServices  
other  
travelCosts  

<font color="#85994b">// NOTE: Property Business API returns either consolidatedExpenses or the other expenses listed</font>

<font color="#85994b">// Other parameter used for calculations</font>  
totalExpensesFromUkPropertyOther <font color="#85994b">// Total value can be negative</font>

<font color="#85994b">// Calculate totalExpensesFromUkPropertyOther </font> 
totalExpensesFromUkPropertyOther = roundUp(consolidatedExpenses + premisesRunningCosts + repairsAndMaintenance + financialCosts + professionalFees + costOfServices + other + travelCosts, 2) <font color="#85994b">// Round up to 2 decimal places</font>
   </code>
</pre>

### Property additions

For calculation purposes, ‘additions’ refer to certain adjustments. There are no accounting adjustments for property income.

#### UK non-FHL additions

Below is the calculation pseudocode for UK non-FHL property additions.

<pre>
    <code>
<font color="#85994b">// Input parameters </font>
privateUseAdjustment <font color="#85994b">// Parameter name is same as API parameter name</font>
balancingCharge <font color="#85994b">// Parameter name is same as API parameter name</font>
bpraBalancingCharge <font color="#85994b">// API parameter name: businessPremisesRenovationAllowanceBalancingCharges</font>

<font color="#85994b">// Other parameter used for calculations</font>  
totalAdditionsFromUkPropertyOther

<font color="#85994b">// Calculate totalAdditionsFromUkPropertyOther</font>
totalAdditionsFromUkPropertyOther = roundDown(privateUseAdjustment + balancingCharge + bpraBalancingCharge, 2) <font color="#85994b">// Round down to 2 decimal places</font>
   </code>
</pre>

### Property deductions

For information about property deductions, refer to [Tax-free allowances on property and trading income](https://www.gov.uk/guidance/tax-free-allowances-on-property-and-trading-income).

#### UK non-FHL deductions

Below is the calculation pseudocode for UK non-FHL property deductions.

<pre>
    <code>
<font color="#85994b">// Input parameters  </font>
zeroEmissionsGoodsVehicleAllowance <font color="#85994b">// Parameter name is same as API parameter name</font>
annualInvestmentAllowance <font color="#85994b">// Parameter name is same as API parameter name  </font>
costOfReplacingDomesticItems <font color="#85994b">// Parameter name is same as API parameter name</font>
businessPremisesRenovationAllowance <font color="#85994b">// Parameter name is same as API parameter name</font>
propertyAllowance <font color="#85994b">// API parameter name: propertyIncomeAllowance  </font>
otherCapitalAllowance <font color="#85994b">// Parameter name is same as API parameter name </font> 
electricChargePointAllowance <font color="#85994b">// Parameter name is same as API parameter name</font>
zeroEmissionsCarAllowance <font color="#85994b">// Parameter name is same as API parameter name</font>
structuredBuildingAllowance <font color="#85994b">// Parameter name is same as API parameter name</font>
enhancedStructuredBuildingAllowance <font color="#85994b">// Parameter name is same as API parameter name</font>
rarReliefClaimed <font color="#85994b">// Amount of UK non-FHLrent claimed  </font>

<font color="#85994b">// NOTE: The Property Income Allowance is a £1,000 tax-free allowance available to customers who receive income from property rentals. If claimed, the customer cannot also deduct property expenses for that income.</font>  

<font color="#85994b">// Other parameter used for calculations</font>
totalDeductionsFromUkPropertyOther

<font color="#85994b">// Calculate totalDeductionsFromUkPropertyOther</font>
<font color="#1d70b8">if</font> propertyAllowance > 0 <font color="#1d70b8">then</font>  
    totalDeductions = propertyAllowance  
<font color="#1d70b8">else</font>  
    totalDeductions = zeroEmissionsGoodsVehicleAllowance + annualInvestmentAllowance + costOfReplacingDomesticItems + businessPremisesRenovationAllowance + otherCapitalAllowance + electricChargePointAllowance + zeroEmissionsCarAllowance + structuredBuildingAllowance + enhancedStructuredBuildingAllowance + rarReliefClaimed
<font color="#1d70b8">end if</font>  

<font color="#85994b">// Apply rounding</font>
totalDeductionsFromUkPropertyOther = roundUp(totalDeductionsFromUkPropertyOther, 2) <font color="#85994b">// Round up to 2 decimal places</font>
   </code>
</pre>

### Calculate total taxable property profit

Below is the calculation pseudocode for total taxable profit for a property income source.

<pre>
    <code>
<font color="#85994b">// Input Parameters</font>
totalIncomeFromUkPropertyOther
totalExpensesFromUkPropertyOther
totalAdditionsFromUkPropertyOther
totalDeductionsFromUkPropertyOther


<font color="#85994b">// Other parameters used for calculations</font>
netProfitFromUkPropertyOther = 0
netLossFromUkPropertyOther = 0
adjustedProfitOrLossFromUkPropertyOther = 0
taxableProfitFromUkPropertyOther = 0
taxableLossFromUkPropertyOther = 0


<font color="#85994b">// Calculate net profit or loss for UK Property Other</font>
<font color="#1d70b8">if</font> totalIncomeFromUkPropertyOther >= totalExpensesFromUkPropertyOther <font color="#1d70b8">then</font>
    netProfitFromUkPropertyOther = totalIncomeFromUkPropertyOther – totalExpensesFromUkPropertyOther
<font color="#1d70b8">else</font>
    netLossFromUkPropertyOther = totalIncomeFromUkPropertyOther –  totalExpensesFromUkPropertyOther
<font color="#1d70b8">end if</font>


<font color="#85994b">// Calculate taxable profit or loss for UK Property Other</font> 
adjustedProfitOrLossFromUkPropertyOther = netProfitFromUkPropertyOther + netLossFromUkPropertyOther + totalAdditionsFromUkPropertyOther – totalDeductionsFromUkPropertyOther <font color="#85994b">// Either netProfitFromUkPropertyOther or netLossFromUkPropertyOther would be present</font>
<font color="#1d70b8">if</font> adjustedProfitOrLossFromUkPropertyOther >= 0 <font color="#1d70b8">then</font>
    taxableProfitFromUkPropertyOther = adjustedProfitOrLossFromUkPropertyOther
<font color="#1d70b8">else</font>
    taxableLossFromUkPropertyOther = adjustedProfitOrLossFromUkPropertyOther
<font color="#1d70b8">end if</font>
</code>
</pre>

## State benefits

For information about state benefits, refer to [Tax-free and taxable state benefits (GOV.UK)](https://www.gov.uk/income-tax/taxfree-and-taxable-state-benefits).

All parameters used as inputs for state benefits calculations are in the [Individuals State Benefits API](https://developer.service.hmrc.gov.uk/api-documentation/docs/api/service/individuals-state-benefits-api/).

Below is the calculation pseudocode for state benefits.

<pre>
    <code>
<font color="#85994b">// Input parameters</font>
<font color="#85994b">// Parameter names are same as in the API and are represented as enum values under the benefitsType parameter in the API</font>
bereavementAllowance
employmentSupportAllowance
incapacityBenefit
jobSeekersAllowance
otherStateBenefits
statePension
statePensionLumpSum

<font color="#85994b">// Each input parameter can have up to 2 decimal places</font>
<font color="#85994b">// Other parameter used for calculations</font>
totalStateBenefitsIncomeExcludingStatePensionLumpSumBenefit

<font color="#85994b">// Calculate totalStateBenefitsIncomeExcludingStatePensionLumpSumBenefit</font>
totalStateBenefitsIncomeExcludingStatePensionLumpSumBenefit = bereavementAllowance + employmentSupportAllowance + incapacityBenefit + jobSeekersAllowance + otherStateBenefits + statePension <font color="#85994b">// No rounding</font>
   </code>
</pre>

## Income summary totals

Customers with income from multiple sources will have source level calculations handled in the individual sections, while the aggregation happens in this section.  
<br/>The scenario only covers self-employment, property and state benefits.

<pre>
    <code>
<font color="#85994b">// Input parameters</font> 
totalUntaxedInterest
totalGrossUkInterest
foreignSavingsInterest
totalGrossSecurities
untaxedUKGainsIncome
untaxedForeignGainsIncome
taxableProfitFromSelfEmployment <font color="#85994b">// Refer to <a href="#calculate-total-taxable-self-employment-profit">Calculate total taxable self-employment profit</a></font>
taxableProfitFromUkPropertyOther <font color="#85994b">// Refer to <a href="#calculate-total-taxable-property-profit">Calculate total taxable property profit</a></font>
taxableProfitFromUkPropertyFhl 
taxableProfitFromForeignPropertyOther 
taxableProfitFromEeaPropertyFhl
totalOccupationalPensionIncome
totalEmploymentIncomePlusBenefitsInKindMinusExpenses taxableProfitFromShareSchemes 
totalStateBenefitsIncomeExcludingStatePensionLumpSumBenefit <font color="#85994b">// Refer to <a href="#state-benefits">State Benefits</a></font> 
totalOverseasIncomeAndGains 
otherIncomesWhileAbroad 
foreignPensionIncome 
chargeableForeignBenefitsAndGifts 
postCessationTradeReceipts
totalDividendIncomeForUkOtherAndForeign
totalProfitFromTaxedUkGains 
totalProfitFromTaxedForeignGains 
totalEmploymentLumpSumsNotLiableForPPP 
 
<font color="#85994b">// Other parameters used for calculations</font>
totalProfitFromSelfEmployment
totalSavingsIncome
totalProfitFromProperty 
totalEmploymentIncome
totalProfitFromPayPensionsProfit 
totalIncomeFromAllSources 
 
<font color="#85994b">// Calculate totalProfitFromSelfEmployment</font>
totalProfitFromSelfEmployment = sum [taxableProfitFromSelfEmployment] <font color="#85994b">// Aggregate of all self-employment income</font>

<font color="#85994b">// Calculate totalSavingsIncome</font> 
totalSavingsIncome = totalUntaxedInterest + totalGrossUkInterest + foreignSavingsInterest + totalGrossSecurities + untaxedUKGainsIncome + untaxedForeignGainsIncome

<font color="#85994b">// Calculate totalProfitFromProperty</font>
totalProfitFromProperty = taxableProfitFromUkPropertyOther + taxableProfitFromUkPropertyFhl + taxableProfitFromForeignPropertyOther + taxableProfitFromEeaPropertyFhl

<font color="#85994b">// Calculate totalEmploymentIncome</font>
totalEmploymentIncome = totalOccupationalPensionIncome + totalEmploymentIncomePlusBenefitsInKindMinusExpenses

<font color="#85994b">// Calculate totalProfitFromPayPensionsProfit</font>
totalProfitFromPayPensionsProfit = totalProfitFromProperty + totalProfitFromSelfEmployment + taxableProfitFromShareSchemes + totalStateBenefits + totalEmploymentIncome + totalOverseasIncomeAndGains + otherIncomesWhileAbroad + foreignPensionIncome + chargeableForeignBenefitsAndGifts + postCessationTradeReceipts

<font color="#85994b">// Calculate totalIncomeFromAllSources</font>
totalIncomeFromAllSources = totalDividendIncomeForUkOtherAndForeign + totalSavingsIncome + totalProfitFromPayPensionsProfit + totalProfitFromTaxedUkGains + totalProfitFromTaxedForeignGains + totalEmploymentLumpSumsNotLiableForPPP
   </code>
</pre>