---
title: Income and benefits | Tax Logic service guide
weight: 2
description: Details of the calculations used for income and benefits.
---

# Income and benefits

Income tax calculations cover a range of income sources, including employment earnings, benefits in kind, self-employment profits, property income, savings, dividends, capital gains and pension income. These combined sources form the basis of taxable income.

## Self-employment

All parameters used as inputs for self-employment calculations are in the [Self Employment Business API](https://developer.service.hmrc.gov.uk/api-documentation/docs/api/service/self-employment-business-api/). However, some parameter names in the pseudocode differ slightly from those in the API and are noted in pseudocode comments.

> **Note:** For calculation purposes, self-employment data is processed for each income source. Customers with multiple self-employments will have source-level calculations handled separately, with totals across all sources calculated elsewhere in this document, such as [Income summary totals](#_Income_summary_totals).

### Self-employment income

Self-employment income refers to sole trader self-employment income and not income earned through partnerships or limited companies. For more information about identifying self-employment income, refer to [Working for yourself (GOV.UK)](https://www.gov.uk/working-for-yourself).

Below is the calculation pseudocode for each self-employment income source.

````
// Input parameters (parameter names are same as API parameter names)

turnover // The takings, fees, sales or money earned by the business.

other // Any other business income not included in turnover.

&nbsp;

// Other parameter used for calculations  

totalIncome

&nbsp;

// Calculate totalIncome

totalIncome = roundDown(turnover + other, 2) // Round down to nearest penny
````

### Self-employment expenses

For information about self-employment expenses, refer to [Expenses if you're self-employed (GOV.UK)](https://www.gov.uk/expenses-if-youre-self-employed).

Below is the calculation pseudocode for self-employment expenses.

````
// Input parameters  

consolidatedExpenses // Parameter name is same as API parameter name

&nbsp;

costOfGoodsAllowable // API parameter name: costofGoods

paymentsToSubcontractorsAllowable // API parameter name: paymentsToSubcontractors

wagesAndStaffCostsAllowable // API parameter name: wagesAndStaffCosts

carVanTravelExpensesAllowable // API parameter name: carVanTravelExpenses

premisesRunningCostsAllowable // API parameter name: premisesRunningCosts

maintenanceCostsAllowable // API parameter name: maintenanceCosts

adminCostsAllowable // API parameter name: adminCosts

interestOnBankOtherLoansAllowable // API parameter name: interestOnBankOtherLoans

financeChargesAllowable // API parameter name: financeCharges

irrecoverableDebtsAllowable // API parameter name: irrecoverableDebts

professionalFeesAllowable // API parameter name: professionalFees

depreciationAllowable // API parameter name: depcreciation

otherExpensesAllowable // API parameter name: otherExpenses

advertisingCostsAllowable // API parameter name: advertisingCosts

businessEntertainmentCostsAllowable // API parameter name: businessEntertainmentCosts

&nbsp;

// NOTE: Self Employment Business API returns either consolidatedExpenses or the other expenses listed

&nbsp;

// Other parameter used for calculations  

totalExpenses // Total value can be negative  

&nbsp;

// Calculate totalExpenses  

totalExpenses = ceiling(consolidatedExpenses + costOfGoodsAllowable + paymentsToSubcontractorsAllowable + wagesAndStaffCostsAllowable + carVanTravelExpensesAllowable + premisesRunningCostsAllowable + maintenanceCostsAllowable + adminCostsAllowable + interestOnBankOtherLoansAllowable + financeChargesAllowable + irrecoverableDebtsAllowable + professionalFeesAllowable + depreciationAllowable + otherExpensesAllowable + advertisingCostsAllowable + businessEntertainmentCostsAllowable, 2) // Round up to 2 decimal places
````
### Self-employment additions

For calculation purposes, ‘additions’ refer to disallowable expenses and certain adjustments.

For information about self-employment disallowable expenses, refer to [HS222 How to calculate your taxable profits (2024) (GOV.UK)](https://www.gov.uk/government/publications/how-to-calculate-your-taxable-profits-hs222-self-assessment-helpsheet/hs222-how-to-calculate-your-taxable-profits-2024).

Below is the calculation pseudocode for self-employment additions.

````
// Input parameters

// Disalllowable expenses

// Parameter names are same as API parameter names

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

&nbsp;

// Adjustments treated as additions

// Parameter names are same as API parameter names

outstandingBusinessIncome

balancingChargeOther

balancingChargeBpra

goodAndServicesOwnUse

&nbsp;

// Other parameter used for calculations

totalAdditions

&nbsp;

// Calculate totalAdditions

totalAdditions = floor(costOfGoodsDisallowable + paymentsToSubcontractorsDisallowable + wagesAndStaffCostsDisallowable + interestOnBankOtherLoansDisallowable + financeChargesDisallowable + irrecoverableDebtsDisallowable + professionalFeesDisallowable + depreciationDisallowable + otherExpensesDisallowable + advertisingCostsDisallowable + businessEntertainmentCostsDisallowable + outstandingBusinessIncome + balancingChargeOther + balancingChargeBpra + goodAndServicesOwnUse, 2) // Round down to 2 decimal places
````
### Self-employment deductions

For information about self-employment deductions, refer to [Tax-free allowances on property and trading income](https://www.gov.uk/guidance/tax-free-allowances-on-property-and-trading-income).

Below is the calculation pseudocode for self-employment deductions.

````
// Input parameters

// Deduction allowances

tradingAllowance // API parameter name: tradingIncomeAllowance  

annualInvestmentAllowance // Parameter name is same as API parameter name

capitalAllowanceMainPool // Parameter name is same as API parameter name

capitalAllowanceSpecialRatePool // Parameter name is same as API parameter name

zeroEmmissionGoods // API parameter name: zeroEmissionsGoodsVehicleAllowance

businessPremisesRennovationAllowance // Parameter name is same as API parameter name

enhancedCapitalAllowance // Parameter name is same as API parameter name

allowanceOnSales // Parameter name is same as API parameter name

capitalAllowanceSingleAssetPool // Parameter name is same as API parameter name

electricChargePointAllowance // Parameter name is same as API parameter name

zeroEmissionsCarAllowance // Parameter name is same as API parameter name

structuredBuildingAllowance // Parameter name is same as API parameter name

enhancedStructuredBuildingAllowance // Parameter name is same as API parameter name

&nbsp;

// Adjustments parameter treated as a deduction

includedNonTaxableProfits // Parameter name is same as API parameter name

&nbsp;

// Other parameter used for calculations  

totalDeductions

&nbsp;  

// Calculate totalDeductions

totalDeductions = ceiling(tradingAllowance + annualInvestmentAllowance + capitalAllowanceMainPool + capitalAllowanceSpecialRatePool + zeroEmmissionGoods + businessPremisesRennovationAllowance + enhancedCapitalAllowance + allowanceOnSales + capitalAllowanceSingleAssetPool + includedNonTaxableProfits + electricChargePointAllowance + zeroEmissionsCarAllowance + structuredBuildingAllowance + enhancedStructuredBuildingAllowance, 2) // Round up to 2 decimal places
````
### Self-employment accounting adjustments

For information about self-employment accounting adjustments, refer to [Adjust your business income (GOV.UK)](https://www.gov.uk/guidance/use-making-tax-digital-for-income-tax/adjust-your-business-income).

Below is the calculation pseudocode for self-employment adjustments.

````
// Input parameters (parameter names are same as API parameter names)

basisAdjustment

accountingAdjustment

averagingAdjustment

&nbsp;

// Other parameter used for calculations

totalAccountingAdjustments

&nbsp;

// Calculate totalAccountingAdjustments

totalAccountingAdjustments = floor(basisAdjustment + accountingAdjustment + averagingAdjustment, 2) // Round down to 2 decimal places
````
### Calculate total taxable self-employment profit

The steps for calculating total taxable profit for a self-employment income source are as follows:

1. Net Profit (or Loss) = Total Income - Total Expenses
2. Taxable Profit/Loss amount = Net Profit/Loss + Total Additions - Total Deductions + Total Accounting Adjustments

## Property

All parameters used as inputs for property calculations are in the [Property Business API](https://developer.service.hmrc.gov.uk/api-documentation/docs/api/service/property-business-api/). However, some parameter names in the pseudocode differ slightly from those in the API and are noted in pseudocode comments.

> **Note:** For calculation purposes, all foreign property data is handled at country level, with totals across all countries calculated elsewhere in this document, such as [Income summary totals](#_Income_summary_totals).

### Property income

A customer’s property income includes rental income and other receipts from foreign and UK land or property, income from letting furnished rooms in the customer’s own home and from holiday lettings in the UK. For more information, refer to [Work out your rental income when you let property (GOV.UK)](https://www.gov.uk/guidance/income-tax-when-you-rent-out-a-property-working-out-your-rental-income).

#### UK non-FHL income

Below is the calculation pseudocode for UK non-FHL property income calculations.

````
// Input parameters

totalRentsReceived // Total rents from property, but not ground rents, rent charges and rent-a-room rental income (API parameter name: periodAmount)

premiumsOfLeaseGrant // Premiums received for the grant of a lease and other lump sums to possess a property (parameter name is same as API parameter name)

reversePremiums // Amount paid by a landlord or outgoing tenant to induce a new tenant to enter into a leasehold agreement (parameter name is same as API parameter name)

otherPropertyIncome // Total amount of rent and any income for services provided to tenants (API parameter name: otherIncome)

rarRentReceived // Total rents received from properties (rent-a-room only) (API parameter name: rentARoom.rentsReceived)

&nbsp;

// Other parameter used for calculations

totalIncome

&nbsp;

// Calculate totalIncome

totalIncome = roundDown(totalRentsReceived + premiumsOfLeaseGrant + reversePremiums + otherPropertyIncome + rarRentReceived, 2) // Round down to nearest penny
````
### Property expenses

For information about property expenses, refer to [Work out your rental income when you let property (GOV.UK)](https://www.gov.uk/guidance/income-tax-when-you-rent-out-a-property-working-out-your-rental-income).

#### UK non-FHL expenses

Below is the calculation pseudocode for UK non-FHL property expenses.

````
// Input parameters  

// Parameter names are same as API parameter names

consolidatedExpenses

&nbsp;

premisesRunningCosts

repairsAndMaintenance  

financialCosts  

professionalFees

costOfServices  

other  

travelCosts  

&nbsp;

// NOTE: Property Business API returns either consolidatedExpenses or the other expenses listed  

&nbsp;

// Other parameter used for calculations  

totalExpenses // Total value can be negative

&nbsp;  

// Calculate totalExpenses  

totalExpenses = ceiling(consolidatedExpenses + premisesRunningCosts + repairsAndMaintenance + financialCosts + professionalFees + costOfServices + other + travelCosts, 2) // Round up to 2 decimal places
````
### Property additions

For calculation purposes, ‘additions’ refer to certain adjustments. There are no accounting adjustments for property income.

#### UK non-FHL additions

Below is the calculation pseudocode for UK non-FHL property additions.

````
// Input parameters  

privateUseAdjustment // Parameter name is same as API parameter name

balancingCharge // Parameter name is same as API parameter name

bpraBalancingCharge // API parameter name: businessPremisesRenovationAllowanceBalancingCharges

&nbsp;

// Other parameter used for calculations  

totalAdditions

&nbsp;

// Calculate totalAdditions

totalAdditions = floor(privateUseAdjustment + balancingCharge + bpraBalancingCharge, 2) // Round down to 2 decimal places
````
### Property deductions

For information about property deductions, refer to [Tax-free allowances on property and trading income](https://www.gov.uk/guidance/tax-free-allowances-on-property-and-trading-income).

#### UK non-FHL deductions

Below is the calculation pseudocode for UK non-FHL property deductions.

````
// Input parameters  

zeroEmissionsGoodsVehicleAllowance // Parameter name is same as API parameter name

annualInvestmentAllowance // Parameter name is same as API parameter name  

costOfReplacingDomesticItems // Parameter name is same as API parameter name

businessPremisesRenovationAllowance // Parameter name is same as API parameter name

propertyAllowance // API parameter name: propertyIncomeAllowance  

otherCapitalAllowance // Parameter name is same as API parameter name  

electricChargePointAllowance // Parameter name is same as API parameter name

zeroEmissionsCarAllowance // Parameter name is same as API parameter name

structuredBuildingAllowance // Parameter name is same as API parameter name

enhancedStructuredBuildingAllowance // Parameter name is same as API parameter name

rarReliefClaimed // Amount of UK non-FHLrent claimed  

&nbsp;

// NOTE: The Property Income Allowance is a £1,000 tax-free allowance available to customers who receive income from property rentals. If claimed, the customer cannot also deduct property expenses for that income.  

&nbsp;

// Other parameter used for calculations

totalDeductions

&nbsp;

// Calculate totalDeductions

if propertyAllowance > 0 then  

&nbsp;    totalDeductions = propertyAllowance  

else  

&nbsp;    totalDeductions = zeroEmissionsGoodsVehicleAllowance + annualInvestmentAllowance + costOfReplacingDomesticItems + businessPremisesRenovationAllowance + otherCapitalAllowance + electricChargePointAllowance + zeroEmissionsCarAllowance + structuredBuildingAllowance + enhancedStructuredBuildingAllowance + rarReliefClaimed

end if  

&nbsp;  

// Apply rounding

totalDeductions = ceiling(totalDeductions, 2) // Round up to 2 decimal places
````
### Calculate total taxable property profit

The steps for calculating total taxable profit for a property income source are as follows:

1. Net Profit (or Loss) = Total Income - Total Expenses
2. Taxable Profit/Loss Amount = Net Profit/Loss + Total Additions - Total Deductions

## State benefits

For information about state benefits, refer to [Tax-free and taxable state benefits (GOV.UK)](https://www.gov.uk/income-tax/taxfree-and-taxable-state-benefits).

All parameters used as inputs for state benefits calculations are in the [Individuals State Benefits API](https://developer.service.hmrc.gov.uk/api-documentation/docs/api/service/individuals-state-benefits-api/).

Below is the calculation pseudocode for state benefits.

````
// Input parameters

// Parameter names are same as API parameter names

bereavementAllowance

employmentSupportAllowance

incapacityBenefit

jobSeekersAllowance

otherStateBenefits

statePension

statePensionLumpSum

// Each input parameter can have up to 2 decimal places

// Other parameter used for calculations

totalStateBenefitsIncomeExcludingStatePensionLumpSumBenefit

// Calculate totalStateBenefitsIncomeExcludingStatePensionLumpSumBenefit

totalStateBenefitsIncomeExcludingStatePensionLumpSumBenefit = bereavementAllowance + employmentSupportAllowance + incapacityBenefit + jobSeekersAllowance + otherStateBenefits + statePension // No rounding

## Income summary totals

Customers with income from multiple sources will have source level calculations handled in the individual sections, while the aggregation happens in this section.  
<br/>The scenario only covers self-employment, property and state benefits.

// Input parameters

totalUntaxedInterest

totalGrossUkInterest

foreignSavingsInterest

totalGrossSecurities

untaxedUKGainsIncome

untaxedForeignGainsIncome

totalOccupationalPensionIncome

totalEmploymentIncomePlusBenefitsInKindMinusExpenses

totalProfitFromSelfEmployment

taxableProfitFromShareSchemes

totalStateBenefits

totalOverseasIncomeAndGains

otherIncomesWhileAbroad

foreignPensionIncome

chargeableForeignBenefitsAndGifts

postCessationTradeReceipts

totalDividendIncomeForUkOtherAndForeign

totalProfitFromTaxedUkGains

totalProfitFromTaxedForeignGains

totalEmploymentLumpSumsNotLiableForPP

// Other parameters used for calculations

totalSavingsIncome

totalProfitFromProperty

totalEmploymentIncome

totalProfitFromPayPensionsProfit

totalIncomeFromAllSources

// Calculate totalSavingsIncome

totalSavingsIncome = totalUntaxedInterest + totalGrossUkInterest + foreignSavingsInterest + totalGrossSecurities + untaxedUKGainsIncome + untaxedForeignGainsIncome

// Calculate totalProfitFromProperty

totalProfitFromProperty = taxableProfitFromUkPropertyOther + taxableProfitFromUkPropertyFhl + taxableProfitFromForeignPropertyOther + taxableProfitFromEeaPropertyFhl

// Calculate totalEmploymentIncome

totalEmploymentIncome = totalOccupationalPensionIncome + totalEmploymentIncomePlusBenefitsInKindMinusExpenses

// Calculate totalProfitFromPayPensionsProfit

totalProfitFromPayPensionsProfit = totalProfitFromProperty + totalProfitFromSelfEmployment + taxableProfitFromShareSchemes + totalStateBenefits + totalEmploymentIncome + totalOverseasIncomeAndGains + otherIncomesWhileAbroad + foreignPensionIncome + chargeableForeignBenefitsAndGifts + postCessationTradeReceipts

// Calculate totalIncomeFromAllSources

totalIncomeFromAllSources = totalDividendIncomeForUkOtherAndForeign + totalSavingsIncome + totalProfitFromPayPensionsProfit + totalProfitFromTaxedUkGains + totalProfitFromTaxedForeignGains + totalEmploymentLumpSumsNotLiableForPPP
````