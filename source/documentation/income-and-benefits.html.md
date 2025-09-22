---
title: Income and benefits | Tax Logic service guide
weight: 2
description: Details of the calculations used for income and benefits.
---

# Income and benefits

Income tax calculations cover a range of income sources, including employment earnings, benefits in kind, self-employment profits, property income, savings, dividends, foreign, pension and other income. These combined sources form the basis of taxable income.

## Self-employment

All parameters used as inputs for self-employment calculations are in the [Self-employment Business API](https://developer.service.hmrc.gov.uk/api-documentation/docs/api/service/self-employment-business-api/) and [Business Source Adjustable Summary API](https://developer.service.hmrc.gov.uk/api-documentation/docs/api/service/self-assessment-bsas-api/7.0). However, some parameter names in the pseudocode differ slightly from those in the API and are noted in pseudocode comments.

> **Note:**  For calculation purposes, self-employment data is processed for each income source. Customers with multiple self-employments will have source-level calculations, with totals across all sources calculated in the [Income summary totals](#_Income_summary_totals) section.

### Self-employment income

Self-employment income refers to sole trader self-employment income and not income earned through partnerships or limited companies. For more information about identifying self-employment income, refer to [Working for yourself (GOV.UK)](https://www.gov.uk/working-for-yourself).

Below is the calculation pseudocode for each self-employment income source.

<pre>
   <code>
<font color="#85994b">// Input parameters</font>
<font color="#85994b">// Parameter names are same as API parameter names</font>
turnover <font color="#85994b">// The takings, fees, sales or money earned by the business</font>
other <font color="#85994b">// Any other business income not included in turnover</font>

<font color="#85994b">// Other parameter used for calculations</font>
totalSelfEmploymentIncome <font color="#85994b">// Total self-employment income</font>

<font color="#85994b">// Calculate totalSelfEmploymentIncome</font>
totalSelfEmploymentIncome= roundDown(turnover + other, 2) <font color="#85994b">// Round down to 2 decimal places</font>
   </code>
</pre>

### Self-employment expenses

For information about self-employment expenses, refer to [Expenses if you're self-employed (GOV.UK)](https://www.gov.uk/expenses-if-youre-self-employed).

Below is the calculation pseudocode for self-employment expenses.

<pre>
   <code>
<font color="#85994b">// Input parameters</font>
consolidatedExpenses <font color="#85994b">// The sum of all allowable expenses for the specified period. Parameter name is same as API parameter name</font>
costOfGoodsAllowable <font color="#85994b">// Cost of goods bought for resale or goods used. API parameter name: costofGoods</font>
paymentsToSubcontractorsAllowable <font color="#85994b">// Payments to construction industry subcontractors. API parameter name: paymentsToSubcontractors</font>
wagesAndStaffCostsAllowable <font color="#85994b">// Wages, salaries and other staff costs. API parameter name: wagesAndStaffCosts</font>
carVanTravelExpensesAllowable <font color="#85994b">// Car, van and travel expenses associated with the running of the business. API parameter name: carVanTravelExpenses</font>
premisesRunningCostsAllowable <font color="#85994b">// Rent, rates, power and insurance costs. Expenses associated with the running of the business. API parameter name: premisesRunningCosts</font>
maintenanceCostsAllowable <font color="#85994b">// Repairs and renewals of property and equipment. API parameter name: maintenanceCosts</font>
adminCostsAllowable <font color="#85994b">// Phone, fax, stationery and other office costs. API parameter name: adminCosts</font>
interestOnBankOtherLoansAllowable <font color="#85994b">// Interest on bank and other loans. API parameter name: interestOnBankOtherLoans</font>
financeChargesAllowable <font color="#85994b">// Bank, credit card and other financial charges. API parameter name: financeCharges</font>
irrecoverableDebtsAllowable <font color="#85994b">// Irrecoverable debts written off. API parameter name: irrecoverableDebts</font>
professionalFeesAllowable <font color="#85994b">// Accountancy, legal and other professional fees. API parameter name: professionalFees</font>
depreciationAllowable <font color="#85994b">// Depreciation and loss/profit on sales of assets. API parameter name: depreciation</font>
otherExpensesAllowable <font color="#85994b">// Other business expenses associated with the running of the business. API parameter name: otherExpenses</font>
advertisingCostsAllowable <font color="#85994b">// Advertising costs. API parameter name: advertisingCosts</font>
businessEntertainmentCostsAllowable <font color="#85994b">// Business entertainment costs. API parameter name: businessEntertainmentCosts</font>

<font color="#85994b">// Other parameter used for calculations</font>
totalSelfEmploymentExpenses <font color="#85994b">// Total self-employment expense, value can be negative</font>

<font color="#85994b">// Calculate totalSelfEmploymentExpenses</font>
<font color="#85994b">// NOTE: Self Employment Business API returns either consolidatedExpenses or the other expenses listed</font>
totalSelfEmploymentExpenses = roundUp(consolidatedExpenses + costOfGoodsAllowable + paymentsToSubcontractorsAllowable + wagesAndStaffCostsAllowable + carVanTravelExpensesAllowable + premisesRunningCostsAllowable + maintenanceCostsAllowable + adminCostsAllowable + interestOnBankOtherLoansAllowable + financeChargesAllowable + irrecoverableDebtsAllowable + professionalFeesAllowable + depreciationAllowable + otherExpensesAllowable + advertisingCostsAllowable + businessEntertainmentCostsAllowable, 2) <font color="#85994b">// Round up to 2 decimal places</font>
   </code>
</pre>

### Self-employment additions

For calculation purposes, 'additions' refer to disallowable expenses and certain adjustments. For information about self-employment disallowable expenses, refer to [HS222 How to calculate your taxable profits (2024) (GOV.UK)](https://www.gov.uk/government/publications/how-to-calculate-your-taxable-profits-hs222-self-assessment-helpsheet/hs222-how-to-calculate-your-taxable-profits-2024).

Below is the calculation pseudocode for self-employment additions.

<pre>
   <code>
<font color="#85994b">// Input parameters</font>
<font color="#85994b">// Disallowable expenses</font>
<font color="#85994b">// Parameter names are same as API parameter names</font>
costOfGoodsDisallowable <font color="#85994b">// Cost of goods bought for resale or goods used</font>
paymentsToSubcontractorsDisallowable <font color="#85994b">// Payments to subcontractors - Construction Industry Scheme (CIS)</font>
wagesAndStaffCostsDisallowable <font color="#85994b">// Wages, salaries and other staff costs</font>
carVanTravelExpensesDisallowable <font color="#85994b">// Car, van and travel expenses</font>
premisesRunningCostsDisallowable <font color="#85994b">// Rent, rates, power and insurance costs</font>
maintenanceCostsDisallowable <font color="#85994b">// Repairs and renewals of property and equipment</font>
adminCostsDisallowable <font color="#85994b">// Phone, fax, stationery and other office costs</font>
interestOnBankOtherLoansDisallowable <font color="#85994b">// Interest on bank and other loans</font>
financeChargesDisallowable <font color="#85994b">// Bank, credit card and other financial charges</font>
irrecoverableDebtsDisallowable <font color="#85994b">// Irrecoverable debts written off</font>
professionalFeesDisallowable <font color="#85994b">// Legal and other professional fees</font>
depreciationDisallowable <font color="#85994b">// Depreciation and loss/profit on sales of assets</font>
otherExpensesDisallowable <font color="#85994b">// Other business expenses</font>
advertisingCostsDisallowable <font color="#85994b">// Advertising costs</font>
businessEntertainmentCostsDisallowable <font color="#85994b">// Business entertainment costs</font>

<font color="#85994b">// Adjustments treated as additions</font>
<font color="#85994b">// Parameter names are same as API parameter names</font>
outstandingBusinessIncome <font color="#85994b">// Any other business income not included in other fields</font>
balancingChargeOther <font color="#85994b">// Balancing charge on sale or cessation of business use (where you have disposed of assets for more than their tax value)</font>
balancingChargeBpra <font color="#85994b">// Balancing charge on sale or cessation of business use (only where Business Premises Renovation Allowance has been claimed)</font>
goodAndServicesOwnUse <font color="#85994b">// Value of the normal sale price of goods or stock have been taken out of the business</font>

<font color="#85994b">// Other parameter used for calculations</font>
totalSelfEmploymentAdditions <font color="#85994b">// Total self-employment additions</font>

<font color="#85994b">// Calculate totalSelfEmploymentAdditions</font>
totalSelfEmploymentAdditions = roundDown(costOfGoodsDisallowable + paymentsToSubcontractorsDisallowable + wagesAndStaffCostsDisallowable + carVanTravelExpensesDisallowable + premisesRunningCostsDisallowable + maintenanceCostsDisallowable + adminCostsDisallowable + interestOnBankOtherLoansDisallowable + financeChargesDisallowable + irrecoverableDebtsDisallowable + professionalFeesDisallowable + depreciationDisallowable + otherExpensesDisallowable + advertisingCostsDisallowable + businessEntertainmentCostsDisallowable + outstandingBusinessIncome + balancingChargeOther + balancingChargeBpra + goodAndServicesOwnUse, 2) <font color="#85994b">// Round down to 2 decimal places</font>
   </code>
</pre>

### Self-employment deductions

For information about self-employment deductions, refer to [Tax-free allowances on property and trading income (GOV.UK)](https://www.gov.uk/guidance/tax-free-allowances-on-property-and-trading-income).

Below is the calculation pseudocode for self-employment deductions.

<pre>
   <code>
<font color="#85994b">// Input parameters
// Deduction allowances
// Parameter names are same as API parameter </font>
annualInvestmentAllowance <font color="#85994b">// Annual investment allowance on items that qualify up to the AIA amount</font>
capitalAllowanceMainPool <font color="#85994b">// Capital allowances at 18% on equipment, including cars with lower CO2 emissions</font>
capitalAllowanceSpecialRatePool <font color="#85994b">// Capital allowances at 8% on equipment, including cars with higher CO2 emissions</font>
businessPremisesRenovationAllowance <font color="#85994b">//Business Premises Renovation Allowance if converting or renovating unused qualifying business premises</font>
enhancedCapitalAllowance <font color="#85994b">// Other enhanced capital allowances</font>
allowanceOnSales <font color="#85994b">// Allowances on sale or cessation of business use (where you have disposed of assets for less than their tax value)</font>
capitalAllowanceSingleAssetPool <font color="#85994b">// Claim to capital allowances in respect of all single asset pools</font>
electricChargePointAllowance <font color="#85994b">// The expenditure incurred on electric charge-point equipment</font>
zeroEmissionsCarAllowance <font color="#85994b">// Zero emissions goods vehicle allowance for goods vehicles purchased for business use</font>
tradingAllowance <font color="#85994b">// The amount of trading allowance (can not be supplied with any other allowances). API parameter name: tradingIncomeAllowance</font>
zeroEmmissionGoods <font color="#85994b">// The amount of zero emissions car allowance. API parameter name: zeroEmissionsGoodsVehicleAllowance</font>
structuredBuildingAllowance <font color="#85994b">// The amount of structured building allowance. API parameter name:structuredBuildingAllowance.amount</font>
enhancedStructuredBuildingAllowance <font color="#85994b">// The amount of enhanced structured building allowance. API parameter name: enhancedStructuredBuildingAllowance.amount</font>

<font color="#85994b">// Adjustments parameter treated as a deduction</font>
includedNonTaxableProfits <font color="#85994b">// Income, receipts and other profits included in business income or expenses but not taxable as business profits</font>

<font color="#85994b">// Other parameter used for calculations</font>
totalSelfEmploymentDeductions <font color="#85994b">// Total Self-employment deductions</font>

<font color="#85994b">// Calculate totalSelfEmploymentDeductions</font>
totalSelfEmploymentDeductions = roundUp(tradingAllowance + annualInvestmentAllowance + capitalAllowanceMainPool + capitalAllowanceSpecialRatePool + zeroEmmissionGoods + businessPremisesRenovationAllowance + enhancedCapitalAllowance + allowanceOnSales + capitalAllowanceSingleAssetPool + electricChargePointAllowance + zeroEmissionsCarAllowance + structuredBuildingAllowance + enhancedStructuredBuildingAllowance + includedNonTaxableProfits, 2) <font color="#85994b">// Round up to 2 decimal places</font>
   </code>
</pre>

### Self-employment accounting adjustments

For information about self-employment accounting adjustments, refer to [Adjust your business income (GOV.UK)](https://www.gov.uk/guidance/use-making-tax-digital-for-income-tax/adjust-your-business-income).

Below is the calculation pseudocode for self-employment adjustments.

<pre>
   <code>
<font color="#85994b">// Input parameters</font>
<font color="#85994b">// Parameter names are same as API parameter names</font>
basisAdjustment <font color="#85994b">// If your basis period is not the same as your accounting period, enter the adjustment needed to arrive at the profit or loss for the basis period -- if the adjustment needs to be taken off the profit figure, this should be negative</font>
accountingAdjustment <font color="#85994b">// Adjustment for change of accounting practice</font>
averagingAdjustment <font color="#85994b">// Averaging adjustment (only for farmers, market gardeners and creators of literary or artistic works) -- if the adjustment needs to be taken off the profit figure, this should be negative</font>

<font color="#85994b">// Other parameter used for calculations</font>
totalSelfEmploymentAccountingAdjustments <font color="#85994b">// Total Self-employment accounting adjustments</font>

<font color="#85994b">// Calculate totalSelfEmploymentAccountingAdjustments</font>
totalSelfEmploymentAccountingAdjustments = basisAdjustment + accountingAdjustment + averagingAdjustment
   </code>
</pre>

### Calculating total taxable self-employment profit

Below is the calculation pseudocode for total taxable self-employment profit or loss.

<pre>
   <code>
<font color="#85994b">// Input Parameters</font>
totalSelfEmploymentIncome <font color="#85994b">// Total self-employment income. Refer to <a href="income-and-benefits.html#self-employment-income">Self-employment income</a></font>
totalSelfEmploymentExpenses <font color="#85994b">// Total self-employment expenses. Refer to <a href="income-and-benefits.html#self-employment-expenses">Self-employment expenses</a></font>
totalSelfEmploymentAdditions <font color="#85994b">// Total self-employment additions. Refer to <a href="income-and-benefits.html#self-employment-additions">Self-employment additions</a></font>
totalSelfEmploymentDeductions <font color="#85994b">// Total self-employment deductions. Refer to <a href="income-and-benefits.html#self-employment-deductions">Self-employment deductions</a></font>
totalSelfEmploymentAccountingAdjustments <font color="#85994b">// Total self-employment accounting adjustments. Refer to <a href="income-and-benefits.html#self-employment-accounting-adjustments">Self-employment accounting adjustments</a></font>

<font color="#85994b">// Other parameters used for calculations (initialise parameters)</font>
netProfitFromSelfEmployment = 0 <font color="#85994b">// Net profit before additions, deductions and adjustments</font>
netLossFromSelfEmployment = 0 <font color="#85994b">// Net loss before additions, deductions and adjustments</font>
taxableSelfEmploymentAmount <font color="#85994b">// Taxable amount after additions, deductions and adjustments</font>
taxableProfitFromSelfEmployment <font color="#85994b">// Final taxable profit after additions, deductions and adjustments</font>
taxableLossFromSelfEmployment <font color="#85994b">// Final taxable loss after additions, deductions and adjustments</font>

<font color="#85994b">// Calculate net profit or loss</font>
if totalSelfEmploymentIncome >= totalSelfEmploymentExpenses then
netProfitFromSelfEmployment = roundDown(totalSelfEmploymentIncome -- totalSelfEmploymentExpenses, 2) <font color="#85994b">// Round down to 2 decimal places</font>
else
netLossFromSelfEmployment = roundup(totalSelfEmploymentExpenses - totalSelfEmploymentIncome, 2) <font color="#85994b">// Round up to 2 decimal places</font>
end if

<font color="#85994b">// Calculate taxableSelfEmploymentAmount</font>
taxableSelfEmploymentAmount = totalSelfEmploymentIncome - totalSelfEmploymentExpenses + totalSelfEmploymentAdditions - totalSelfEmploymentDeductions + totalSelfEmploymentAccountingAdjustments

<font color="#85994b">// Determine if the adjusted amount is a taxable profit or loss</font>
if taxableSelfEmploymentAmount >= 0then
taxableProfitFromSelfEmployment = roundDown(taxableSelfEmploymentAmount, 0) <font color="#85994b">// Round down to nearest whole pound</font>
else
taxableLossFromSelfEmployment = taxableSelfEmploymentAmount
end if
   </code>
</pre>

## Property

All parameters used as inputs for property calculations are in the [Property Business API](https://developer.service.hmrc.gov.uk/api-documentation/docs/api/service/property-business-api/). However, some parameter names in the pseudocode differ slightly from those in the API and are noted in pseudocode comments.

**Note:** For calculation purposes, all foreign property data is handled at country level, with totals across all countries calculated in the [Income summary totals](#_Income_summary_totals) section.

### Property income

A customer's property income includes rental income and other receipts from foreign and UK land or property, income from letting furnished rooms in the customer's own home and from holiday lettings in the UK. For more information, refer to [Work out your rental income when you let property (GOV.UK)](https://www.gov.uk/guidance/income-tax-when-you-rent-out-a-property-working-out-your-rental-income).

#### UK non-FHL income

Below is the calculation pseudocode for UK non-FHL property income calculations.

<pre>
   <code>
<font color="#85994b">// Input parameters</font>
totalRentsReceived <font color="#85994b">// Total rents from property, but not ground rents, rent charges and rent-a-room rental income. API parameter name: periodAmount</font>
premiumsOfLeaseGrant <font color="#85994b">// Premiums received for the grant of a lease and other lump sums to possess a property. Parameter name is same as API parameter name</font>
reversePremiums <font color="#85994b">// Amount paid by a landlord or outgoing tenant to induce a new tenant to enter into a leasehold agreement. Parameter name is same as API parameter name</font>
otherPropertyIncome <font color="#85994b">// Total amount of rent and any income for services provided to tenants. API parameter name: otherIncome</font>
rarRentReceived <font color="#85994b">// Total rents received from properties (rent-a-room only). API parameter name: rentARoom.rentsReceived</font>

<font color="#85994b">// Other parameter used for calculations</font>
totalIncomeFromUkPropertyOther <font color="#85994b">// Total income from UK non-FHL property</font>

<font color="#85994b">// Calculate totalIncomeFromUkPropertyOther</font>
totalIncomeFromUkPropertyOther = roundDown(totalRentsReceived + premiumsOfLeaseGrant + reversePremiums + otherPropertyIncome + rarRentReceived, 2) <font color="#85994b">// Round down to 2 decimal places</font>
   </code>
</pre>

#### UK FHL income

Below is the calculation pseudocode for UK FHL property income calculations.

<pre>
   <code>
<font color="#85994b">// Input parameters</font>
rentReceived <font color="#85994b">// Total rents from property, ground rents and rent charges but not rent-a-room. API parameter name: periodAmount</font>
rarRentReceived <font color="#85994b">// Total rents received from properties (rent-a-room only). API parameter name: rentARoom.rentsReceived</font>

<font color="#85994b">// Other parameter used for calculations</font>
totalIncomeFromUkPropertyFhl <font color="#85994b">// Total income from UK FHL property</font>

<font color="#85994b">// Calculate totalIncomeFromUkPropertyFhl</font>
totalIncomeFromUkPropertyFhl = roundDown(rentReceived + rarRentReceived, 2) <font color="#85994b">// Round down to 2 decimal places</font>
   </code>
</pre>

#### Foreign non-FHL income

Below is the calculation pseudocode for foreign non-FHL property income calculations.

<pre>
   <code>
<font color="#85994b">// Input parameters
// Parameter name is same as API parameter name</font>
premiumsOfLeaseGrant <font color="#85994b">// Premiums received for the grant of a lease and other lump sums to possess a property</font>
otherPropertyIncome <font color="#85994b">// Other income from property, such as rent charges and ground rents</font>
rentReceived <font color="#85994b">// Total rent and other income from property. API parameter name: rentIncome.rentAmount</font>

<font color="#85994b">// Other parameter used for calculations</font>
totalIncomeFromForeignPropertyOther <font color="#85994b">// Total income from Foreign non-FHL property</font>

<font color="#85994b">// Calculate totalIncomeFromForeignPropertyOther</font>
totalIncomeFromForeignPropertyOther=roundDown(rentReceived + premiumsOfLeaseGrant + otherPropertyIncome, 2) <font color="#85994b">// Round down to 2 decimal places</font>
   </code>
</pre>

#### Foreign FHL EEA income

Below is the calculation pseudocode for foreign FHL EEA property income calculations.

<pre>
   <code>
<font color="#85994b">// Input parameters</font>
rentReceived <font color="#85994b">// Total rent and other income from property. API parameter name: rentAmount</font>

<font color="#85994b">// Other parameter used for calculations</font>
totalIncomeFromEeaPropertyFhl <font color="#85994b">// Total income from foreign FHL EEA property income calculations</font>

<font color="#85994b">// Calculate totalIncomeFromEeaPropertyFhl</font>
totalIncomeFromEeaPropertyFhl = roundDown(rentReceived, 2) <font color="#85994b">// Round down to 2 decimal places</font>
   </code>
</pre>

### Property expenses

For information about property expenses, refer to [Work out your rental income when you let property (GOV.UK)](https://www.gov.uk/guidance/income-tax-when-you-rent-out-a-property-working-out-your-rental-income).

#### UK non-FHL expenses

Below is the calculation pseudocode for UK non-FHL property expenses.

<pre>
   <code>
<font color="#85994b">// Input parameters
// Parameter names are same as API parameter names
// Parameter values can be negative</font>
consolidatedExpenses <font color="#85994b">// The sum of all allowable expenses for the specified period</font>
premisesRunningCosts <font color="#85994b">// Rent, rates, insurance, ground rents and other costs</font>
repairsAndMaintenance <font color="#85994b">// Property repairs and maintenance</font>
financialCosts <font color="#85994b">// Loan interest and other financial costs</font>
professionalFees <font color="#85994b">// Legal, management and other professional fees</font>
costOfServices <font color="#85994b">// Cost of services provided, including wages</font>
other <font color="#85994b">// Other allowable property expenses</font>
travelCosts <font color="#85994b">// Car, van and travel costs incurred in running a property business</font>

<font color="#85994b">// NOTE: Property Business API returns either consolidatedExpenses or the other expenses listed
// Other parameter used for calculations</font>
totalExpensesFromUkPropertyOther <font color="#85994b">// Total expenses from UK non-FHL property, value can be negative</font>

<font color="#85994b">// Calculate totalExpensesFromUkPropertyOther</font>
totalExpensesFromUkPropertyOther = roundUp(consolidatedExpenses + premisesRunningCosts + repairsAndMaintenance + financialCosts + professionalFees + costOfServices + other + travelCosts, 2) <font color="#85994b">// Round up to 2 decimal places</font>
   </code>
</pre>

#### UK FHL expenses

Below is the calculation pseudocode for UK FHL property expenses.

<pre>
   <code>
<font color="#85994b">// Input parameters
// Parameter names are same as API parameter names
// Parameter values can be negative</font>
consolidatedExpenses <font color="#85994b">// The sum of all allowable expenses for the specified period</font>
repairsAndMaintenance <font color="#85994b">// Property repairs and maintenance</font>
financialCosts <font color="#85994b">// Loan interest and other financial costs</font>
professionalFees <font color="#85994b">// Legal, management and other professional fees</font>
costOfServices <font color="#85994b">// Cost of services provided, including wages</font>
travelCosts <font color="#85994b">// Car, van and travel costs incurred in running a property business</font>
other <font color="#85994b">// Other allowable property expenses</font>
premisesRunningCosts <font color="#85994b">// Rent, rates, insurance, ground rents and other costs</font>

<font color="#85994b">// NOTE: Property Business API returns either consolidatedExpenses or the other expenses listed</font>
// Other parameter used for calculations</code>
totalExpensesFromUkPropertyFhl <font color="#85994b">// Total expenses from UK FHL property, value can be negative</font>

<font color="#85994b">// Calculate totalExpensesFromUkPropertyFhl</font>
totalExpensesFromUkPropertyFhl = roundUp(consolidatedExpenses + repairsAndMaintenance + financialCosts + professionalFees + costOfServices + travelCosts + other + premisesRunningCosts, 2) <font color="#85994b">// Round up to 2 decimal places</font>
   </code>
</pre>

#### Foreign non-FHL expenses

Below is the calculation pseudocode for foreign non-FHL property expenses (country level).

<pre>
   <code>
<font color="#85994b">// Input parameters
// Parameter names are same as API parameter names
// Parameter values can be negative</font>
repairsAndMaintenance <font color="#85994b">// Property repairs and maintenance</font>
financialCosts <font color="#85994b">// Loan interest and other financial costs</font>
professionalFees <font color="#85994b">// Legal, management and other professional fees</font>
costOfServices <font color="#85994b">// Cost of services provided, including wages</font>
travelCosts <font color="#85994b">// Car, van and travel costs incurred in running a property business</font>
other <font color="#85994b">// Other allowable property expenses</font>
premisesRunningCosts <font color="#85994b">// Rent, rates, insurance, ground rents and other costs</font>
consolidatedExpenseAmount <font color="#85994b">// The sum of all allowable expenses for the specified period. API parameter name: consolidatedExpenses</font>

<font color="#85994b">// NOTE: Property Business API returns either consolidatedExpenseAmount or the other expenses listed
// Other parameter used for calculations</font>
totalExpensesFromForeignPropertyOther <font color="#85994b">// Total expenses from foreign property, value can be negative</font>

<font color="#85994b">// Calculate totalExpensesFromForeignPropertyOther</font>
totalExpensesFromForeignPropertyOther = roundUp(consolidatedExpenseAmount + repairsAndMaintenance + financialCosts + professionalFees + costOfServices + travelCosts + other + premisesRunningCosts, 2) <font color="#85994b">// Round up to 2 decimal places</font>
   </code>
</pre>

#### Foreign FHL EEA expenses

Below is the calculation pseudocode for foreign FHL European Economic Area property expenses.

<pre>
   <code>
<font color="#85994b">// Input parameters
// Parameter names are same as API parameter names
// Parameter values can be negative</font>
repairsAndMaintenance <font color="#85994b">// Property repairs and maintenance</font>
financialCosts <font color="#85994b">// Loan interest and other financial costs</font>
professionalFees <font color="#85994b">// Legal, management and other professional fees</font>
costOfServices <font color="#85994b">// Cost of services provided, including wages</font>
travelCosts <font color="#85994b">// Car, van and travel costs incurred in running a property business</font>
other <font color="#85994b">// Other allowable property expenses</font>
premisesRunningCosts <font color="#85994b">// Rent, rates, insurance, ground rents and other costs</font>
consolidatedExpenseAmount <font color="#85994b">// API parameter name: consolidatedExpenses</font>

<font color="#85994b">// NOTE: Property Business API returns either consolidatedExpenseAmount or the other expenses listed
// Other parameter used for calculations</font>
totalExpensesFromEeaPropertyFhl <font color="#85994b">// Total expenses from foreign FHL property, value can be negative</font>

<font color="#85994b">// Calculate totalExpensesFromEeaPropertyFhl</font>
totalExpensesFromEeaPropertyFhl = roundUp(consolidatedExpenseAmount + repairsAndMaintenance + financialCosts + professionalFees + costOfServices + travelCosts + other + premisesRunningCosts, 2) <font color="#85994b">// Round up to 2 decimal places</font>
   </code>
</pre>

### Property additions

For calculation purposes, 'additions' refer to certain adjustments. There are no accounting adjustments for property income.

#### UK non-FHL additions

Below is the calculation pseudocode for UK non-FHL property additions.

<pre>
   <code>
<font color="#85994b">// Input parameters</font>
privateUseAdjustment <font color="#85994b">// Any adjustments that are not solely for the property business. Parameter name is same as API parameter name</font>
balancingCharge <font color="#85994b">// If an item for which capital allowance was claimed has been sold, given away or is no longer in use. Parameter name is same as API parameter name</font>
bpraBalancingCharge <font color="#85994b">// Income from the sale or grant of a long lease for a premium of renovated business premises within 7 years of first use. API parameter name: businessPremisesRenovationAllowanceBalancingCharges</font>

<font color="#85994b">// Other parameter used for calculations</font>
totalAdditionsFromUkPropertyOther <font color="#85994b">// Total additions from UK property</font>

<font color="#85994b">// Calculate totalAdditionsFromUkPropertyOther</font>
totalAdditionsFromUkPropertyOther = roundDown(privateUseAdjustment + balancingCharge + bpraBalancingCharge, 2) <font color="#85994b">// Round down to 2 decimal places</font>
   </code>
</pre>

#### UK FHL additions

Below is the calculation pseudocode for UK FHL property additions.

<pre>
   <code>
<font color="#85994b">// Input parameters</font>
privateUseAdjustment <font color="#85994b">// Any adjustments that are not solely for the property business. Parameter name is same as API parameter name</font>
balancingCharge <font color="#85994b">// If an item for which capital allowance was claimed has been sold, given away or is no longer in use. Parameter name is same as API parameter name</font>
bpraBalancingCharge <font color="#85994b">// Income from the sale or grant of a long lease for a premium of renovated business premises within 7 years of first use. API parameter name: businessPremisesRenovationAllowanceBalancingCharges</font>

<font color="#85994b">// Other parameter used for calculations</font>
totalAdditionsFromUkPropertyFhl <font color="#85994b">// Total additions from UK FHL property</font>

<font color="#85994b">// Calculate totalAdditionsFromUkPropertyFhl</font>
totalAdditionsFromUkPropertyFhl = roundDown(privateUseAdjustment + balancingCharge + bpraBalancingCharge, 2) <font color="#85994b">// Round down to 2 decimal places</font>
   </code>
</pre>

#### Foreign non-FHL additions

Below is the calculation pseudocode for foreign non-FHL property additions (country level).

<pre>
   <code>
<font color="#85994b">// Input parameters
// Parameter names are same as API parameter names</font>
privateUseAdjustment <font color="#85994b">// Any adjustments that are not solely for the property business</font>
balancingCharge <font color="#85994b">// If an item for which capital allowance was claimed has been sold, given away or is no longer in use</font>

<font color="#85994b">// Other parameter used for calculations</font>
totalAdditionsFromForeignPropertyOther <font color="#85994b">// Total additions from foreign property</font>

<font color="#85994b">// Calculate totalAdditionsFromForeignPropertyOther</font>
totalAdditionsFromForeignPropertyOther =roundDown(privateUseAdjustment + balancingCharge, 2) <font color="#85994b">// Round down to 2 decimal places</font>
   </code>
</pre>

#### Foreign FHL EEA additions

Below is the calculation pseudocode for foreign FHL European Economic Area property additions.

<pre>
   <code>
<font color="#85994b">// Input parameters
// Parameter names are same as API parameter names</font>
privateUseAdjustment <font color="#85994b">// Any adjustments that are not solely for the property business</font>
balancingCharge <font color="#85994b">// If an item for which capital allowance was claimed has been sold, given away or is no longer in use</font>

<font color="#85994b">// Other parameter used for calculations</font>
totalAdditionsFromEeaPropertyFhl <font color="#85994b">// Total additions from foreign FHL property</font>

<font color="#85994b">// Calculate totalAdditionsFromEeaPropertyFhl</font>
totalAdditionsFromEeaPropertyFhl = roundDown(privateUseAdjustment + balancingCharge, 2) <font color="#85994b">// Round down to 2 decimal places</font>
   </code>
</pre>

### Property deductions

For information about property deductions, refer to [Tax-free allowances on property and trading income (GOV.UK)](https://www.gov.uk/guidance/tax-free-allowances-on-property-and-trading-income).

#### UK non-FHL deductions

Below is the calculation pseudocode for UK non-FHL property deductions.

<pre>
   <code>
<font color="#85994b">// Input parameters
// Parameter names are same as API parameter names</font>
zeroEmissionsGoodsVehicleAllowance <font color="#85994b">// The amount of zero emissions goods vehicle allowance for goods vehicles purchased for business use</font>
annualInvestmentAllowance <font color="#85994b">// The amount claimed on equipment bought (except cars) up to maximum annual amount</font>
costOfReplacingDomesticItems <font color="#85994b">// Cost of Replacing Domestic Items - formerly Wear and Tear allowance</font>
businessPremisesRenovationAllowance // Allowance for renovation or conversion of derelict business properties
otherCapitalAllowance <font color="#85994b">// All other capital allowances</font>
electricChargePointAllowance <font color="#85994b">// The expenditure incurred on electric charge-point equipment</font>
zeroEmissionsCarAllowance <font color="#85994b">// The amount of zero emissions car allowance</font>
propertyAllowance <font color="#85994b">// The amount of tax exemption for individuals with income from land or property. API parameter name: propertyIncomeAllowance</font>
structuredBuildingAllowance <font color="#85994b">// The amount of structured building allowance. API parameter name: structuredBuildingAllowance.amount</font>
enhancedStructuredBuildingAllowance <font color="#85994b">// The amount of enhanced structured building allowance. API parameter name: enhancedStructuredBuildingAllowance.amount</font>
rarReliefClaimed <font color="#85994b">// Amount of UK non-FHL rent claimed. API Parameter name: rentARoom.amountClaimed</font>
<font color="#85994b">// NOTE: The Property Income Allowance is a £1,000 tax-free allowance available to customers who receive income from property rentals. If claimed, the customer cannot also deduct property expenses for that income.</font>

<font color="#85994b">// Other parameter used for calculations</font>
totalDeductionsFromUkPropertyOther <font color="#85994b">// Total deductions from UK property</font>

<font color="#85994b">// Calculate totalDeductionsFromUkPropertyOther</font>
<font color="#1d70b8">if</font> propertyAllowance > 0 <font color="#1d70b8">then</font>
totalDeductionsFromUkPropertyOther = propertyAllowance
<font color="#1d70b8">else</font>
totalDeductionsFromUkPropertyOther = zeroEmissionsGoodsVehicleAllowance + annualInvestmentAllowance + costOfReplacingDomesticItems + businessPremisesRenovationAllowance + otherCapitalAllowance + electricChargePointAllowance + zeroEmissionsCarAllowance + structuredBuildingAllowance + enhancedStructuredBuildingAllowance + rarReliefClaimed
<font color="#1d70b8">endif</font>

<font color="#85994b">// Apply rounding</font>
totalDeductionsFromUkPropertyOther = roundUp(totalDeductionsFromUkPropertyOther, 2) <font color="#85994b">// Round up to 2 decimal places</font>
   </code>
</pre>

#### UK FHL deductions

Below is the calculation pseudocode for UK FHL property deductions.

<pre>
   <code>
<font color="#85994b">// Input parameters
// Parameter names are same as API parameter names</font>
annualInvestmentAllowance <font color="#85994b">// The amount claimed on equipment bought (except cars) up to maximum annual amount</font>
otherCapitalAllowance <font color="#85994b">// All other capital allowances</font>
businessPremisesRenovationAllowance <font color="#85994b">// Allowance for renovation or conversion of derelict business properties</font>
electricChargePointAllowance <font color="#85994b">// The expenditure incurred on electric charge-point equipment</font>
zeroEmissionsCarAllowance <font color="#85994b">// The amount of zero emissions car allowance</font>
rarReliefClaimed <font color="#85994b">// Amount of UK FHL rent claimed (depends on rarRentReceived). API Parameter name: rentARoom.amountClaimed</font>
propertyAllowance <font color="#85994b">// The amount of tax exemption for individuals with income from land or property. API parameter name: propertyIncomeAllowance</font>
<font color="#85994b">// NOTE: The Property Income Allowance is a £1,000 tax-free allowance available to customers who receive income from property rentals. If claimed, the customer cannot also deduct property expenses for that income.</font>

<font color="#85994b">// Other parameter used for calculations</font>
totalDeductionsFromUkPropertyFhl <font color="#85994b">// Total deductions from UK FHL property</font>

<font color="#85994b">// Calculate totalDeductionsFromUkPropertyFhl</font>
<font color="#1d70b8">if</font> propertyAllowance > 0<font color="#1d70b8">then</font>
totalDeductionsFromUkPropertyFhl = propertyAllowance
<font color="#1d70b8">else</font>
totalDeductionsFromUkPropertyFhl = rarReliefClaimed + annualInvestmentAllowance + otherCapitalAllowance + businessPremisesRenovationAllowance + propertyAllowance + electricChargePointAllowance + zeroEmissionsCarAllowance
<font color="#1d70b8">endif</font>

<font color="#85994b">// Apply rounding</font>
totalDeductionsFromUkPropertyFhl = roundUp(totalDeductionsFromUkPropertyFhl, 2) <font color="#85994b">// Round up to 2 decimal places</font>
   </code>
</pre>

#### Foreign non-FHL deductions

Below is the calculation pseudocode for foreign non-FHL property deductions (country level).

<pre>
   <code>
<font color="#85994b">// Input parameters</font>
propertyAllowance <font color="#85994b">// The amount of tax exemption for individuals with income from land or property. API parameter name: propertyIncomeAllowance</font>
structuredBuildingAllowance <font color="#85994b">// The amount of structured building allowance. API parameter name: structuredBuildingAllowance.amount</font>
<font color="#85994b">//Parameter names are same as API parameter names</font>
annualInvestmentAllowance <font color="#85994b">// The amount claimed on equipment bought (except cars) up to maximum annual amount</font>
otherCapitalAllowance <font color="#85994b">// All other capital allowances</font>
costOfReplacingDomesticItems <font color="#85994b">// Cost of Replacing Domestic Items - formerly Wear and Tear allowance</font>
zeroEmissionsGoodsVehicleAllowance <font color="#85994b">// The amount of zero emissions car allowance</font><font color="#85994b">
electricChargePointAllowance <font color="#85994b">// The expenditure incurred on electric charge-point equipment</font>
zeroEmissionsCarAllowance <font color="#85994b">// The amount of zero emissions car allowance</font>
<font color="#85994b">// NOTE: The Property Income Allowance is a £1,000 tax-free allowance available to customers who receive income from property rentals. If claimed, the customer cannot also deduct property expenses for that income.</font>

<font color="#85994b">// Other parameter used for calculations</font>
totalDeductionsFromForeignPropertyOther <font color="#85994b">// Total deductions from foreign property</font>

<font color="#85994b">// Calculate totalDeductionsFromForeignPropertyOther</font>
<font color="#1d70b8">if</font></font></font> propertyAllowance >0 <font color="#1d70b8">then</font></font></font>
totalDeductionsFromForeignPropertyOther = propertyAllowance
<font color="#1d70b8">else</font></font></font>
totalDeductionsFromForeignPropertyOther = annualInvestmentAllowance + otherCapitalAllowance + costOfReplacingDomesticItems + zeroEmissionsGoodsVehicleAllowance + structuredBuildingAllowance + electricChargePointAllowance + zeroEmissionsCarAllowance
<font color="#1d70b8">endif</font></font></font>

<font color="#85994b">// Apply rounding</font>
totalDeductionsFromForeignPropertyOther = roundUp(totalDeductionsFromForeignPropertyOther, 2) <font color="#85994b">// Round up to 2 decimal places</font>
   </code>
</pre>

#### Foreign FHL EEA deductions

Below is the calculation pseudocode for foreign FHL European Economic Area property deductions.

<pre>
   <code>
<font color="#85994b">// Input parameters
// Parameter names are same as API parameter names</font>
annualInvestmentAllowance <font color="#85994b">// The amount claimed on equipment bought (except cars) up to maximum annual amount</font>
otherCapitalAllowance <font color="#85994b">// All other capital allowances</font>
electricChargePointAllowance <font color="#85994b">// The expenditure incurred on electric charge-point equipment</font>
zeroEmissionsCarAllowance <font color="#85994b">// The amount of zero emissions car allowance</font>
propertyAllowance <font color="#85994b">// The amount of tax exemption for individuals with income from land or property. API parameter name: propertyIncomeAllowance</font>
<font color="#85994b">// NOTE: The Property Income Allowance is a £1,000 tax-free allowance available to customers who receive income from property rentals. If claimed, the customer cannot also deduct property expenses for that income.</font>

<font color="#85994b">// Other parameter used for calculations</font>
totalDeductionsFromEeaPropertyFhl // Total deductions from foreign FHL property

<font color="#85994b">// Calculate totalDeductionsFromEeaPropertyFhl</font>
<font color="#1d70b8">if</font> propertyAllowance >0 <font color="#1d70b8">then</font>
totalDeductionsFromEeaPropertyFhl = propertyAllowance
<font color="#1d70b8">else</font>
totalDeductionsFromEeaPropertyFhl = annualInvestmentAllowance + otherCapitalAllowance + electricChargePointAllowance + zeroEmissionsCarAllowance
<font color="#1d70b8">endif</font>

<font color="#85994b">// Apply rounding</font>
totalDeductionsFromEeaPropertyFhl = roundUp(totalDeductionsFromEeaPropertyFhl, 2) <font color="#85994b">// Round up to 2 decimal places</font>
   </code>
</pre>

### Calculating total taxable property profit

Below is the calculation pseudocode for total taxable property profit or loss.

<pre>
   <code>
<font color="#85994b">// Input Parameters</font>
totalIncomeFromUkPropertyOther <font color="#85994b">// Refer to UK non-FHL income\</font>
totalExpensesFromUkPropertyOther <font color="#85994b">// Refer to UK non-FHL expenses\</font>
totalAdditionsFromUkPropertyOther <font color="#85994b">// Refer to UK non-FHL additions\</font>
totalDeductionsFromUkPropertyOther <font color="#85994b">// Refer to UK non-FHL deductions</font>

totalIncomeFromUkPropertyFhl <font color="#85994b">// Refer to UK FHL income\</font>
totalExpensesFromUkPropertyFhl <font color="#85994b">// Refer to UK FHL expenses\</font>
totalAdditionsFromUkPropertyFhl <font color="#85994b">// Refer to UK FHL additions\</font>
totalDeductionsFromUkPropertyFhl <font color="#85994b">// Refer to UK FHL deductions</font>

totalIncomeFromForeignPropertyOther <font color="#85994b">// Refer to Foreign non-FHL income\</font>
totalExpensesFromForeignPropertyOther <font color="#85994b">// Refer to Foreign non-FHL expenses\</font>
totalAdditionsFromForeignPropertyOther <font color="#85994b">// Refer to Foreign non-FHL additions\</font>
totalDeductionsFromForeignPropertyOther <font color="#85994b">// Refer to Foreign non-FHL deductions</font>

totalIncomeFromEeaPropertyFhl <font color="#85994b">// Refer to Foreign FHL EEA income\</font>
totalExpensesFromEeaPropertyFhl <font color="#85994b">// Refer to Foreign FHL EEA expenses\</font>
totalAdditionsFromEeaPropertyFhl <font color="#85994b">// Refer to Foreign FHL EEA additions\</font>
totalDeductionsFromEeaPropertyFhl <font color="#85994b">// Refer to Foreign FHL EEA deductions</font>

<font color="#85994b">// Other parameters used for calculations (initialise parameters)\</font>
netProfitFromUkPropertyOther = 0\
netLossFromUkPropertyOther = 0\
taxableAmountFromUkPropertyOther = 0\
taxableProfitFromUkPropertyOther = 0\
taxableLossFromUkPropertyOther = 0

netProfitFromUkPropertyFhl = 0\
netLossFromUkPropertyFhl = 0\
taxableAmountFromUkPropertyFhl = 0\
taxableProfitFromUkPropertyFhl = 0\
taxableLossFromUkPropertyFhl = 0

netProfitFromForeignPropertyOther = 0\
netLossFromForeignPropertyOther = 0\
taxableAmountFromForeignPropertyOther = 0\
taxableProfitFromForeignPropertyOther = 0\
taxableLossFromForeignPropertyOther = 0

netProfitFromEeaPropertyFhl = 0\
netLossFromEeaPropertyFhl = 0\
taxableAmountFromEeaPropertyFhl = 0\
taxableProfitFromEeaPropertyFhl = 0\
taxableLossFromEeaPropertyFhl = 0\

---------------------------Calculation of net profit or loss ----------------------------------
<font color="#85994b">// Calculate net profit or loss for UK Property Other\</font>
<font color="#1d70b8">if </font>totalIncomeFromUkPropertyOther >= totalExpensesFromUkPropertyOther <font color="#1d70b8">then\</font>
netProfitFromUkPropertyOther = roundDown(totalIncomeFromUkPropertyOther -- totalExpensesFromUkPropertyOther, 2)<font color="#85994b">// Round down to 2 decimal places\</font>
<font color="#1d70b8">else\</font>
netLossFromUkPropertyOther = roundDown(totalExpensesFromUkPropertyOther -- totalIncomeFromUkPropertyOther, 2)<font color="#85994b">// Round down to 2 decimal places\</font>
end <font color="#1d70b8">if</font>

<font color="#85994b">// Calculate net profit or loss for UK Property FHL\</font>
<font color="#1d70b8">if</font> totalIncomeFromUkPropertyFhl >= totalExpensesFromUkPropertyFhl <font color="#1d70b8">then\</font>
netProfitFromUkPropertyFhl = roundDown(totalIncomeFromUkPropertyFhl -- totalExpensesFromUkPropertyFhl, 2)<font color="#85994b">// Round down to 2 decimal places\</font>
<font color="#1d70b8">else\</font>
netLossFromUkPropertyFhl = roundDown(totalExpensesFromUkPropertyFhl -- totalIncomeFromUkPropertyFhl, 2)<font color="#85994b">// Round down to 2 decimal places\</font>
end <font color="#1d70b8">if</font>

<font color="#85994b">// Calculate net profit or loss for Foreign Property Other\</font>
<font color="#1d70b8">if</font> totalIncomeFromForeignPropertyOther >= totalExpensesFromForeignPropertyOther <font color="#1d70b8">then\</font>
netProfitFromForeignPropertyOther = roundDown(totalIncomeFromForeignPropertyOther -- totalExpensesFromForeignPropertyOther, 2)<font color="#85994b">// Round down to 2 decimal places\</font>
<font color="#1d70b8">else\</font>
netLossFromForeignPropertyOther = roundDown(totalExpensesFromForeignPropertyOther --totalIncomeFromForeignPropertyOther, 2)<font color="#85994b">// Round down to 2 decimal places\</font>
end <font color="#1d70b8">if</font>

<font color="#85994b">// Calculate net profit or loss for EEA Property FHL</font>
<font color="#1d70b8">if</font> totalIncomeFromEeaPropertyFhl >= totalExpensesFromEeaPropertyFhl <font color="#1d70b8">then\</font>
netProfitFromEeaPropertyFhl = roundDown(totalIncomeFromEeaPropertyFhl -- totalExpensesFromEeaPropertyFhl, 2)<font color="#85994b">// Round down to 2 decimal places\</font>
<font color="#1d70b8">else\</font>
netLossFromEeaPropertyFhl = roundDown(totalExpensesFromEeaPropertyFhl -- totalIncomeFromEeaPropertyFhl, 2)<font color="#85994b">// Round down to 2 decimal places\</font>
<font color="#1d70b8">end if\</font>

-------------------------- Calculation of taxable profit or loss -------------------------------
<font color="#85994b">// Calculate taxable profit or loss for UK Property Other\</font>
taxableAmountFromUkPropertyOther = totalIncomeFromUkPropertyOther - totalExpensesFromUkPropertyOther + totalAdditionsFromUkPropertyOther -- totalDeductionsFromUkPropertyOther\
<font color="#1d70b8">if</font> taxableAmountFromUkPropertyOther >= 0 <font color="#1d70b8">then\</font>
taxableProfitFromUkPropertyOther = roundDown(taxableAmountFromUkPropertyOther, 0) <font color="#85994b">// Round down to nearest whole pound\</font>
<font color="#1d70b8">else\</font>
taxableLossFromUkPropertyOther = roundDown(taxableAmountFromUkPropertyOther, 0) <font color="#85994b">// Round down to nearest whole pound\</font>
end <font color="#1d70b8">if</font>

<font color="#85994b">// Calculate taxable profit or loss for UK Property FHL\<font color="#85994b">
taxableAmountFromUkPropertyFhl = totalIncomeFromUkPropertyFhl - totalExpensesFromUkPropertyFhl + totalAdditionsFromUkPropertyFhl -- totalDeductionsFromUkPropertyFhl\
<font color="#1d70b8">if taxableAmountFromUkPropertyFhl>= 0 then\</font>
taxableProfitFromUkPropertyFhl = roundDown(taxableAmountFromUkPropertyFhl, 0)<font color="#85994b">// Round down to nearest whole pound\
<font color="#1d70b8">else\</font>
taxableLossFromUkPropertyFhl = roundDown(taxableAmountFromUkPropertyFhl, 0)<font color="#85994b">// Round down to nearest whole pound\</font>
end <font color="#1d70b8">if</font>

<font color="#85994b">// Calculate taxable profit or loss for Foreign Property Other\</font> 
taxableAmountFromForeignPropertyOther = totalIncomeFromForeignPropertyOther - totalExpensesFromForeignPropertyOther + totalAdditionsFromForeignPropertyOther -- totalDeductionsFromForeignPropertyOther\
<font color="#1d70b8">if</font> taxableAmountFromForeignPropertyOther >= 0 <font color="#1d70b8">then\</font>
taxableProfitFromForeignPropertyOther = roundDown(taxableAmountFromForeignPropertyOther, 0)<font color="#85994b">// Round down to nearest whole pound\</font>
<font color="#1d70b8">else\</font>
taxableLossFromForeignPropertyOther = roundDown(taxableAmountFromForeignPropertyOther, 0)<font color="#85994b">// Round down to nearest whole pound\</font>
end <font color="#1d70b8">if</font>

<font color="#85994b">// Calculate taxable profit or loss for EEA Property FHL\</font>
taxableAmountFromEeaPropertyFhl = totalIncomeFromEeaPropertyFhl - totalExpensesFromEeaPropertyFhl + totalAdditionsFromEeaPropertyFhl -- totalDeductionsFromEeaPropertyFhl\
<font color="#1d70b8">if</font> taxableAmountFromEeaPropertyFhl >= 0 <font color="#1d70b8">then\
taxableProfitFromEeaPropertyFhl = roundDown(taxableAmountFromEeaPropertyFhl, 0)<font color="#85994b">// Round down to nearest whole pound\</font>
<font color="#1d70b8">else\</font>
taxableLossFromEeaPropertyFhl = roundDown(taxableAmountFromEeaPropertyFhl, 0)<font color="#85994b">// Round down to nearest whole pound\</font>
end <font color="#1d70b8">if</font>
   </code>
</pre>

## Employment

All parameters used as inputs for employment calculations are in the [Individuals Employments Income API](https://developer.service.hmrc.gov.uk/api-documentation/docs/api/service/individuals-employments-income-api/), [Individuals Expenses API](https://developer.service.hmrc.gov.uk/api-documentation/docs/api/service/individuals-expenses-api/) and [Other Deductions API](https://developer.service.hmrc.gov.uk/api-documentation/docs/api/service/other-deductions-api/). However, some parameter names in the pseudocode differ slightly from those in the APIs and are noted in pseudocode comments.

> **Note:** For calculation purposes, all employment data is handled at employment income source level.

### Employment income

For information about employment income, refer to [Self Assessment: Employment (GOV.UK)](https://www.gov.uk/government/publications/self-assessment-employment-sa102).

Below is the calculation pseudocode for employment income sources.

<pre>
   <code>
<font color="#85994b">// Input parameters</font>
OccupationalPensionIncome <font color="#85994b">// Taxable pay to date for a PAYE source that have the occupational pension indicator as true. API parameter name: taxablePayToDate AND occupationalPension: true</font>
PayPayeEmploymentIncome <font color="#85994b">// Taxable pay to date for a PAYE source that have the occupational pension indicator as false (API parameter name: taxablePayToDate AND occupationalPension: false)</font>
totalTipsIncome <font color="#85994b">// Total tips received through employment during tax year. API parameter name: tips</font>

<font color="#85994b">// Different types of Benefits in kind Income
// Parameter names are same as API parameter names</font>
accommodation <font color="#85994b">// The value of accommodation costs provided by the employer</font>
assets <font color="#85994b">// The value of any goods provided by the employer not exclusively used for work</font>
assetTransfer <font color="#85994b">// The value of any company assets signed over by the employer</font>
beneficialLoan <font color="#85994b">// The amount of interest free or low interest loans given by the employer</font>
car <font color="#85994b">// The cash equivalent of any cars made available by the employer</font>
carFuel <font color="#85994b">// The amount paid for fuel when using company cars</font>
educationalServices <font color="#85994b">// Scholarships or school fees paid by the employer</font>
entertaining <font color="#85994b">// Entertainment costs paid by the employer either directly or reimbursed to the employee</font>
expenses <font color="#85994b">// Expenses reimbursed by the employer to the employee</font>
medicalInsurance <font color="#85994b">// The sum of insurance premiums paid by the employer for medical or dental insurance</font>
telephone <font color="#85994b">// Telephone costs paid by the employer that are not exempt</font>
service <font color="#85994b">// Services used by an employee and paid for by the employer</font>
taxableExpenses <font color="#85994b">// Taxable expenses reimbursed by the employer to the employee</font>
van <font color="#85994b">// The cash equivalent of any vans made available by the employer</font>
vanFuel <font color="#85994b">// The amount paid by the employer for fuel costs when using company vans</font>
mileage <font color="#85994b">// The mileage amount paid over HMRC's approved rate by the employer for use of employee's own car for work</font>
nonQualifyingRelocationExpenses <font color="#85994b">// Other costs involved in relocation paid for directly by the employer or reimbursed to the employee</font>
nurseryPlaces <font color="#85994b">// Childcare costs paid by the employer or voucher or commercial childcare costs above the exempt limit</font>
otherItems <font color="#85994b">// The value of any other benefits</font>
paymentsOnEmployeesBehalf <font color="#85994b">// Other costs incurred by the employee paid for by the employer</font>
personalIncidentalExpenses <font color="#85994b">// Incidental (non-business) expenses incurred by an employee while travelling on business</font>
qualifyingRelocationExpenses <font color="#85994b">// Employer paid costs associated with employee relocation including bridging loans</font>
employerProvidedProfessionalSubscriptions <font color="#85994b">// Professional fees and subscriptions paid for by the employer</font>
employerProvidedServices <font color="#85994b">// The value of services provided by the employer</font>
incomeTaxPaidByDirector <font color="#85994b">// Non PAYE Income Tax for directors deducted from the employer by HMRC</font>
travelAndSubsistence <font color="#85994b">// The cost of any travel and subsistence (accommodation, meals and so on) paid for by the employer, that is not exempt</font>
vouchersAndCreditCards <font color="#85994b">// The value of vouchers given by the employer and the expenditure of any employer provided credit cards</font>
noncash <font color="#85994b">// The value of any other non-cash benefits paid to the employee</font>
taxableLumpSumsAndCertainIncome <font color="#85994b">// The amount of the taxable lump sum. API parameter name: taxableLumpSumsAndCertainIncome.amount</font>
benefitFromEmployerFinancedRetirementScheme <font color="#85994b">// The amount of the benefit received. API parameter name: benefitFromEmployerFinancedRetirementScheme.amount</font>
redundancyCompensationPaymentsOverExemption <font color="#85994b">// The amount of the redundancy compensation payment over exemption. API parameter name: redundancyCompensationPaymentsOverExemption.amount</font>

<font color="#85994b">// Other parameters for used calculations</font>
totalOccupationalPensionIncome <font color="#85994b">// Sum of taxable pay to date from all PAYE sources that have the occupational pension indicator as true</font>
totalPayPayeEmploymentIncome <font color="#85994b">// Sum of taxable pay to date from all PAYE sources that have the occupational pension indicator as false</font>
benefitsInKindIncome <font color="#85994b">// Sum of benefits in kind income from a PAYE source</font>
totalBenefitsInKindIncome <font color="#85994b">// Sum of benefits in kind income from all PAYE sources</font>
lumpSumsIncome <font color="#85994b">// Sum of lump sums income from a PAYE source</font>
totalLumpSumsIncome <font color="#85994b">// Sum of lump sums income from all PAYE sources</font>
totalEmploymentIncome <font color="#85994b">// Total employment income</font>

<font color="#85994b">// Calculate totalOccupationalPensionIncome</font>
totalOccupationalPensionIncome = sum[OccupationalPensionIncome]</font>
totalOccupationalPensionIncome = roundDown(totalOccupationalPensionIncome, 0)<font color="#85994b">// Round down to nearest whole pound</font>

<font color="#85994b">// Calculate totalPayPayeEmploymentIncome</font>
totalPayPayeEmploymentIncome = sum[PayPayeEmploymentIncome]</font>
totalPayPayeEmploymentIncome = roundDown(totalPayPayeEmploymentIncome, 0) <font color="#85994b">// Round down to nearest whole pound</font>

<font color="#85994b">// Calculate benefitsInKindIncome\</font>
benefitsInKindIncome = roundDown(accommodation + assets + assetTransfer + beneficialLoan + car + carFuel + educationalServices + entertaining + expenses + medicalInsurance + telephone + service + taxableExpenses + van + vanFuel + mileage + nonQualifyingRelocationExpenses + nurseryPlaces + otherItems + paymentsOnEmployeesBehalf + personalIncidentalExpenses + qualifyingRelocationExpenses + employerProvidedProfessionalSubscriptions + employerProvidedServices + incomeTaxPaidByDirector + travelAndSubsistence + vouchersAndCreditCards + noncash, 0) <font color="#85994b">// Round down to nearest whole pound</font>

<font color="#85994b">// Calculate totalBenefitsInKindIncome\</font>
totalBenefitsInKindIncome = sum[benefitsInKindIncome]\
totalBenefitsInKindIncome = roundDown(totalBenefitsInKindIncome, 0) <font color="#85994b">// Round down to nearest whole pound</font>

<font color="#85994b">// Calculate lumpSumsIncome\</font>
lumpSumsIncome = taxableLumpSumsAndCertainIncome + benefitFromEmployerFinancedRetirementScheme + redundancyCompensationPaymentsOverExemption

<font color="#85994b">// Calculate totallumpSumsIncome\</font>
totalLumpSumsIncome = sum[lumpSumsIncome]\
totalLumpSumsIncome = roundDown(totalLumpSumsIncome, 0) <font color="#85994b">// Round down to nearest whole pound</font>

<font color="#85994b">// Calculate totalEmploymentIncome\</font>
totalEmploymentIncome = totalOccupationalPensionIncome + totalPayPayeEmploymentIncome + totalBenefitsInKindIncome + totalLumpSumsIncome + totalTipsIncome
   </code>
</pre>

### Employment expenses

For information about employments expenses, refer to [Claim tax relief for your job expenses (GOV.UK).](https://www.gov.uk/tax-relief-for-employees)

Below is the calculation pseudocode for all employment expenses.

<pre>
   <code>
<font color="#85994b">// Input parameters
<font color="#85994b">// Parameter names are same as API parameter names</font>
businessTravelCosts <font color="#85994b">// Expenses associated with business travel</font>
jobExpenses <font color="#85994b">// The actual expense of replacing or maintaining tools or special work clothes</font>
flatRateJobExpenses <font color="#85994b">// Fixed rate expenses applied for replacing or maintaining tools or special work clothes</font>
professionalSubscriptions <font color="#85994b">// Fees or subscriptions to professional bodies, required in order to undertake the employment</font>
hotelAndMealExpenses <font color="#85994b">// Subsistence costs incurred with work</font></font>
otherAndCapitalAllowances <font color="#85994b">// The expense from purchasing small items required for this employment</font>
vehicleExpenses <font color="#85994b">// Vehicle expenses for using own car, van or motorcycle for business mileage occurred during work</font>
mileageAllowanceRelief <font color="#85994b">// The shortfall incurred when the employer pays less than the approved mileage rate</font>

<font color="#85994b">// Other parameter used for calculations</font>
totalEmploymentExpenses <font color="#85994b">// Total employment expenses. API parameter name: totalExpenses</font>

<font color="#85994b">// Calculate totalEmploymentExpenses</font>
totalEmploymentExpenses = roundUp(businessTravelCosts + jobExpenses + flatRateJobExpenses + professionalSubscriptions + hotelAndMealExpenses + otherAndCapitalAllowances + vehicleExpenses + mileageAllowanceRelief, 2) <font color="#85994b">// Round up to 2 decimal places</font>
</code>
</pre>

### Employment deductions

For information about other deductions, refer to [Seafarers' Earnings Deduction: tax relief if you work on a ship (GOV.UK)](https://www.gov.uk/guidance/seafarers-earnings-deduction-tax-relief-if-you-work-on-a-ship).

Below is the calculation pseudocode for other deductions.

<font color="#85994b">// Input parameter</font>
otherDeductions = [
seafarers {
customerReference, <font color="#85994b">// A reference the user supplies to identify the record</font>
amountDeducted, <font color="#85994b">// Deduction from Seafarer's Earnings</font>
nameOfShip, <font color="#85994b">// The name of the ship worked on</font>
fromDate, <font color="#85994b">// The date work started in the format YYYY-MM-DD</font>
toDate <font color="#85994b">// The date work ended in format YYYY-MM-DD</font>
}
]

<font color="#85994b">// Other parameter used for calculations (iniatialise parameter)
totalEmploymentDeductions = 0<font color="#85994b">// Total amount of deductions from seafarer's earnings</font>

<font color="#85994b">// Add up the amounts deducted from seafarer's earnings</font>
for each seafarers in otherDeductions:
totalEmploymentDeductions = totalEmploymentDeductions + seafarers.amountDeducted

<font color="#85994b">// Apply rounding</font>
totalEmploymentDeductions = roundUp(totalEmploymentDeductions, 2) <font color="#85994b">// Round up to 2 decimal places</font>
   </code>
</pre>

### Calculating total taxable employment income

Below is the calculation pseudocode for total taxable property profit or loss.

<pre>
   <code>
<font color="#85994b">// Input Parameters\</font>
totalEmploymentIncome <font color="#85994b">// Refer to <a href="income-and-benefits.html#employment-income">Employment income</a></font>
totalOccupationalPensionIncome <font color="#85994b">// Refer to <a href="income-and-benefits.html#employment-income">Employment income</a></font>
totalEmploymentExpenses <font color="#85994b">// Refer to <a href="income-and-benefits.html#employment-expense">Employment expenses</a></font>
totalEmploymentDeductions <font color="#85994b">// Refer to <a href="income-and-benefits.html#employment-deductions">Employment deductions</a></font>

<font color="#85994b">// Other parameters used for calculations\</font>
netEmploymentIncome <font color="#85994b">// Net employment income\</font>
totalEmploymentAdjustments <font color="#85994b">// Total employment adjustments\</font>
totalTaxableEmploymentIncome <font color="#85994b">// Total taxable employment income</font>

<font color="#85994b">// Calculate net employment income\</font>
netEmploymentIncome = totalEmploymentIncome - totalOccupationalPensionIncome

<font color="#85994b">// Calculate total adjustments\</font>
totalEmploymentAdjustments = totalEmploymentExpenses + totalEmploymentDeductions

<font color="#85994b">// Calculate total taxable employment income\</font>
totalTaxableEmploymentIncome = max(netEmploymentIncome -- totalEmploymentAdjustments, 0) + totalOccupationalPensionIncome
   </code>
</pre>

## Savings income

For information about savings income, refer to [How to complete your tax return for Self Assessment (GOV.UK)](#supplementary-pages).

All parameters used as inputs for savings income calculations are in the [Individuals Savings Income API](https://developer.service.hmrc.gov.uk/api-documentation/docs/api/service/individuals-savings-income-api/).

### UK savings

Below is the calculation pseudocode for UK savings income.

<pre>
   <code>
<font color="#85994b">// Input parameters</font>
ukSavings = [
ukSavingsInterestAnnual {
taxedUkInterest, <font color="#85994b">// Total net taxed interest for the specified savings account</font>
untaxedUkInterest, <font color="#85994b">// Total untaxed interest for the specified savings account</font>
incomeSourceId <font color="#85994b">// Unique identifier for savings income source</font>
}
]
grossSecurities <font color="#85994b">// Gross amount of Gilt Edge interest, securities, and accrued income profits including tax deducted. API parameter name: grossAmount</font>
ukBasicRate <font color="#85994b">// Refer to "BRT" rate under UK incomeTaxBands in the <a href="downloads/taxyear24-25.yml" download>config file</a></font>

<font color="#85994b">// Other parameters used for calculations (initialise parameters)</font>
totalTaxedUkSavings =0<font color="#85994b">// Total taxed UK savings</font>
totalUntaxedUkSavings =0<font color="#85994b">// Total untaxed UK savings</font>
totalGrossUkTaxedSavings =0 <font color="#85994b">// Total gross UK taxed savings</font>
totalUkSavingsAndGains =0 <font color="#85994b">// Total UK savings and gains</font>

<font color="#85994b">// Process all UK interest income summaries</font>
<font color="#1d70b8">for each</font> ukSavingsInterestAnnual in ukSavings

<font color="#85994b">// Check and process taxed UK interest</font>
<font color="#1d70b8">if</font> ukSavingsInterestAnnual.taxedUkInterest isnotnull <font color="#1d70b8">then</font>
totalTaxedUkSavings = totalTaxedUkSavings + ukSavingsInterestAnnual.taxedUkInterest

<font color="#85994b">// Check and process untaxed UK interest</font>
<font color="#1d70b8">if</font> ukSavingsInterestAnnual.untaxedUkInterest isnotnull <font color="#1d70b8">then</font>
totalUntaxedUkSavings = totalUntaxedUkSavings + ukSavingsInterestAnnual.untaxedUkInterest
end <font color="#1d70b8">if</font>
end <font color="#1d70b8">for</font>

<font color="#85994b">// Calculate totalGrossUkTaxedSavings</font>
totalGrossUkTaxedSavings = roundDown(totalTaxedUkSavings / ((100 - ukBasicRate) / 100) , 0) <font color="#85994b">//
Round down to nearest whole pound</font>

<font color="#85994b">// Calculate totalUkSavingsAndGains</font>
totalUntaxedUkSavings = roundDown(totalUntaxedUkSavings, 0) <font color="#85994b">// Round down to nearest whole pound</font>

<font color="#85994b">// Calculate grossSecurities</font>
grossSecurities = roundDown(grossSecurities, 0) <font color="#85994b">// Round down to nearest whole pound</font>

<font color="#85994b">// Calculate totalUkSavingsAndGains</font>
totalUkSavingsAndGains = totalUntaxedUkSavings + totalGrossUkTaxedSavings + grossSecurities
   </code>
</pre>

### Foreign savings

Below is the calculation pseudocode for foreign savings income.

<pre>
   <code>
<font color="#85994b">// Input parameters </font>
foreignInterests = [
  foreignInterest {  
    countryCode, <font color="#85994b">// A three-letter code that represents a country name  </font>
    amountBeforeTax, <font color="#85994b">// Total income (in UK pounds) before foreign tax deduction  </font>
    taxTakenOff, <font color="#85994b">// Total foreign tax deducted from income  </font>
    specialWithholdingTax, <font color="#85994b">// Total Special Withholding Tax (SWT) and any UK tax deducted  </font>
    foreignTaxCreditRelief, <font color="#85994b">// Indicates if Foreign Tax Credit Relief (FTCR) is claimed  </font>
    taxableAmount <font color="#85994b">// Total taxable amount on savings  </font>
  }  
]  

<font color="#85994b">// Other parameters used for calculations (initialise parameters)</font> 
totalForeignSavings =0<font color="#85994b">// Total taxable amount of all foreign </font>
chargeableForeignSavingsAndGains =0<font color="#85994b">// Total foreign savings and gains subject to Income Tax</font>

<font color="#85994b">// Process all foreign income summaries </font>
<font color="#1d70b8">for each</font> foreignInterest in foreignInterests:

<font color="#85994b">// Check and process taxable amount </font>
    <font color="#1d70b8">if</font> foreignInterest.taxableAmount isnotnull <font color="#1d70b8">then</font>
        totalForeignSavings = totalForeignSavings + foreignInterest.taxableAmount
end <font color="#1d70b8">if</font>
end <font color="#1d70b8">for</font>
chargeableForeignSavingsAndGains = roundDown(totalForeignSavings, 0) <font color="#85994b">//Round down to whole pounds</font>
   </code>
</pre>

## Dividends income

You may need to pay tax on dividends if you own shares in a company. For information about dividends income, refer to [Tax on dividends (GOV.UK)](https://www.gov.uk/tax-on-dividends).

All parameters used as inputs for dividends income calculations are in the [Individuals Dividends Income API](https:<font//developer.service.hmrc.gov.uk/api-documentation/docs/api/service/individuals-dividends-income-api/).

### UK dividends

Below is the calculation pseudocode for UK dividends income.

<pre>
   <code>
<font color="#85994b">// Input parameters</font>
<font color="#85994b">// Parameter names are same as API parameter names</font>
ukDividends <font color="#85994b">// Total dividends payments received from UK companies</font>
otherUkDividends <font color="#85994b">// Total dividends received from authorised unit trusts, open-ended investment companies or investment trusts, including dividends from accumulation units or shares, which are automatically reinvested</font>
bonusIssuesSecurities <font color="#85994b">// Total bonus issues of securities income. API parameter name: bonusIssuesOfSecurities.grossAmount</font>
closeCompanyLoans <font color="#85994b">// Total close company loans written-off income. API parameter name: closeCompanyLoansWrittenOff.grossAmount</font>
redeemableShares <font color="#85994b">// Total redeemable shares income. API parameter name: redeemableShares.grossAmount</font>
stockDividends <font color="#85994b">// Total stock dividends income. API parameter name: stockDividend.grossAmount</font>

<font color="#85994b">// Other parameters used for calculations</font>
otherDividends <font color="#85994b">// Investment income</font>
totalUkDividends <font color="#85994b">// Total UK dividends</font>

<font color="#85994b">// Calculate otherDividends</font>
otherDividends = roundDown(bonusIssuesSecurities + closeCompanyLoans + redeemableShares + stockDividends, 2) <font color="#85994b">// Round down to 2 decimal places</font>

<font color="#85994b">// Calculate totalUkDividends</font>
totalUkDividends = roundDown(ukDividends + otherUkDividends + otherDividends, 0) <font color="#85994b">// Round down to nearest whole pound</font>
   </code>
</pre>

### Foreign dividends

Below is the calculation pseudocode for foreign dividends income.

<pre>
   <code>
<font color="#85994b">// Input parameters </font>
foreignDividendsFromForeignCompanies = [
foreignDividend{
  countryCode,<font color="#85994b">// A three-letter code that represents a country name    </font>
    grossIncome, <font color="#85994b">// Total income (in UK pounds) before foreign tax deduction. API parameter name: amountBeforeTax  </font>
    netIncome, <font color="#85994b">// Net income after foreign tax deduction.   </font>
    taxDeducted, <font color="#85994b">// Total foreign tax deducted from income. API parameter name: taxTakenoff   </font>
    taxableAmount, <font color="#85994b">// Total taxable amount on dividends   </font>
    specialWithholdingTax,<font color="#85994b">// Total Special Withholding Tax (SWT) and any UK tax deducted </font>foreignTaxCreditRelief <font color="#85994b">// Indicates if Foreign Tax Credit Relief (FTCR) is claimed   </font>
  }   
]   

dividendIncomeReceivedWhilstAbroad = [
foreignDividend {   
  countryCode, <font color="#85994b">// A three-letter code that represents a country name </font>
    grossIncome, <font color="#85994b">// Total income (in UK pounds) before foreign tax deduction. API parameter name: amountBeforeTax  </font>
    netIncome, <font color="#85994b">// Net income after foreign tax deduction   </font>
    taxDeducted, <font color="#85994b">// Total foreign tax deducted from income. API parameter name: taxTakenoff   </font>
    taxableAmount, <font color="#85994b">// Total taxable amount on dividends  </font>
    specialWithholdingTax,<font color="#85994b">// Total Special Withholding Tax (SWT) and any UK tax deducted</font>
    foreignTaxCreditRelief <font color="#85994b">// Indicates if Foreign Tax Credit Relief (FTCR) is claimed   </font>
  }   
]    

<font color="#85994b">// Other parameter used for calculations  </font>
totalChargeableForeignDividends <font color="#85994b">// Total amount of foreign dividends that are subject to UK tax  </font>
sumFromForeignCompanies =0 <font color="#85994b">// Initialise sum for dividends from foreign companies  </font>
sumFromAbroad =0 <font color="#85994b">// Initialise sum for dividends received while abroad</font>

<font color="#85994b">// Calculate totalChargeableForeignDividends   </font>
<font color="#85994b">// Add up the taxable amounts from each foreign dividend received from foreign companies </font>
<font color="#1d70b8">for each</font> foreignDividend in foreignDividendsFromForeignCompanies:
    sumFromForeignCompanies = sumFromForeignCompanies + foreignDividend.taxableAmount
end <font color="#1d70b8">for</font>

<font color="#85994b">// Add up the taxable amounts from each foreign dividend received whilst abroad </font>
<font color="#1d70b8">for each</font> foreignDividend in dividendIncomeReceivedWhilstAbroad:
    sumFromAbroad = sumFromAbroad + foreignDividend.taxableAmount
end <font color="#1d70b8">for</font>

<font color="#85994b">// Combine both sums  </font>
totalChargeableForeignDividends = roundDown(sumFromForeignCompanies + sumFromAbroad, 0)<font color="#85994b">// Round down to nearest whole pound</font>
   </code>
</pre>

## Foreign and other income

Foreign income is any income that is earned outside England, Scotland, Wales and Northern Ireland. For information about foreign income, refer to [Tax on foreign income (GOV.UK)](https://www.gov.uk/tax-foreign-income). For information about pensions income, refer to [Self Assessment: Foreign (SA106) (GOV.UK)](https://www.gov.uk/government/publications/self-assessment-foreign-sa106) and [Self Assessment: additional information SA101 (GOV.UK)](https://www.gov.uk/government/publications/self-assessment-additional-information-sa101).

All of the parameters used as inputs for Foreign and other income calculations are in the [Individuals Other Income API](https://developer.service.hmrc.gov.uk/api-documentation/docs/api/service/individuals-other-income-api/2.0/oas/page) or [Individuals Pensions Income API](https://developer.service.hmrc.gov.uk/api-documentation/docs/api/service/individuals-pensions-income-api/2.0).

Below is the calculation pseudocode for foreign and other income.

<pre>
   <code>
<font color="#85994b">// Input parameters </font>
<font color="#85994b">// Parameter names aresame as API parameter names</font>
allOtherIncomeReceivedWhilstAbroad = [
income {
    countryCode, <font color="#85994b">// A three-letter code that represents a country name </font>
    amountBeforeTax, <font color="#85994b">// Total income (in UK pounds) before foreign tax deduction</font>
    taxTakenOff, <font color="#85994b">// Total foreign tax deducted from income</font>
    specialWitholdingTax, <font color="#85994b">// Total Special Withholding Tax (SWT) and any UK tax deducted</font>
    foreignTaxCreditRelief, <font color="#85994b">// Indicates if Foreign Tax Credit Relief (FTCR) is claimed  </font>
    taxableAmount, <font color="#85994b">// Total taxable amount on other income received whilst abroad</font>
    residentialFinancialCostAmount, <font color="#85994b">// Residential financial cost amount</font>
    broughtFwdResidentialFinancialCostAmount <font color="#85994b">// Brought forward residential financial cost amount</font>
  }
]

foreignPensions = [
  pension { 
  countryCode, <font color="#85994b">// A three-letter code that represents a country name </font>
    amountBeforeTax, <font color="#85994b">// Total income (in UK pounds) before foreign tax deduction.</font>
    specialWithholdingTax,<font color="#85994b">// Total Special Withholding Tax (SWT) and any UK tax deducted</font>
    foreignTaxCreditRelief, <font color="#85994b">// Indicates if Foreign Tax Credit Relief (FTCR) is claimed</font>  
    taxableAmount <font color="#85994b">// Total taxable amount on other income received whilst abroad</font>
  }
]

postCessationReceipts = [
income {
amount <font color="#85994b">// Amount for postCessationReceipt</font>
}
]

overseasIncomeAndGains {
gainAmount <font color="#85994b">// Overseas income and gains amount. Parameter names same as API parameter name</font>
}

chargeableForeignBenefitsAndGifts {
<font color="#85994b">// Parameter names same as API parameter names</font>
transactionBenefit <font color="#85994b">// Benefit received on an overseas transaction</font>
protectedForeignIncomeSourceBenefit <font color="#85994b">// Benefit received on a protected foreign income source</font>
protectedForeignIncomeOnwardGift <font color="#85994b">//Protected foreign income gifted</font>
benefitReceivedAsASettler <font color="#85994b">//Benefit received as a settler</font>
onwardGiftReceivedAsASettler <font color="#85994b">// Gift received as a settler</font>
}

<font color="#85994b">// Other parameters used for calculations (initialise parameters)</font>
chargeableAllOtherIncomeReceivedWhilstAbroad = 0 <font color="#85994b">// Chargeable all other income received whilst abroad</font>
overseasIncomeAndGains <font color="#85994b">// Overseas income and gains</font>
totalForeignBenefitsAndGifts <font color="#85994b">// Total foreign benefits and gifts</font>
totalPostCessationReceipts = 0 <font color="#85994b">// Total post cessation receipts</font>
totalForeignPensionIncome =0 <font color="#85994b">// Total foreign pension income</font>

<font color="#85994b">// Calculate chargeable all other income received whilst abroad</font>
<font color="#1d70b8">for each</font> income inallOtherIncomeReceivedWhilstAbroad:
    chargeableAllOtherIncomeReceivedWhilstAbroad = roundDown((chargeableAllOtherIncomeReceivedWhilstAbroad + income.taxableAmount), 2)<font color="#85994b">// Round down to 2 decimal places</font>
end <font color="#1d70b8">for</font>

<font color="#85994b">// Calculate total overseas income and gains </font>
overseasIncomeAndGains = gainAmount

<font color="#85994b">// Calculate total foreign benefits and gifts </font>
totalForeignBenefitsAndGifts = roundDown((transactionBenefit + protectedForeignIncomeSourceBenefit + protectedForeignIncomeOnwardGift + benefitReceivedAsASettler + onwardGiftReceivedAsASettler), 2)<font color="#85994b">// Round down to 2 decimal places</font>

<font color="#85994b">// Calculate post-cessation receipts</font>
<font color="#1d70b8">for each</font> income in postCessationReceipts:
totalPostCessationReceipts = totalPostCessationReceipts + income.amount
end <font color="#1d70b8">for</font>

<font color="#85994b">// Calculate total foreign pension income</font>
<font color="#1d70b8">for each</font> foreignIncome in foreignPensions:
totalForeignPensionIncome = roundDown((totalForeignPensionIncome + foreignPensions.taxableAmount), 2)<font color="#85994b">// Round down to 2 decimal places</font>
end <font color="#1d70b8">for</font>
   </code>
</pre>

## State benefits

For information about state benefits, refer to [Tax-free and taxable state benefits (GOV.UK)](https://www.gov.uk/income-tax/taxfree-and-taxable-state-benefits). All parameters used as inputs for state benefits calculations are in the [Individuals State Benefits API](https://developer.service.hmrc.gov.uk/api-documentation/docs/api/service/individuals-state-benefits-api/).

Below is the calculation pseudocode for state benefits.

<pre>
   <code>
<font color="#85994b">// Input parameters</font>
<font color="#85994b">// Parameter names are same as in the API and are represented as enum values under the benefitType parameter in the API</font>
bereavementAllowance
employmentSupportAllowance
incapacityBenefit
jobSeekersAllowance
otherStateBenefits
statePension

<font color="#85994b">// Other parameter used for calculations</font>
totalStateBenefitsIncomeExcludingStatePensionLumpSumBenefit

<font color="#85994b">// Calculate totalStateBenefitsIncomeExcludingStatePensionLumpSumBenefit</font>
totalStateBenefitsIncomeExcludingStatePensionLumpSumBenefit = bereavementAllowance + employmentSupportAllowance + incapacityBenefit + jobSeekersAllowance + otherStateBenefits + statePension <font color="#85994b">// No rounding</font>
   </code>
</pre>

## Losses and loss claims

For information about losses, refer to [HS227 Losses (2024) (GOV.UK)](https://www.gov.uk/government/publications/losses-hs227-self-assessment-helpsheet/hs227-losses-2024).

Some of the parameters used as inputs for losses and loss claims calculations are in the [Individual Losses API](https://developer.service.hmrc.gov.uk/api-documentation/docs/api/service/individual-losses-api/).

Below is the calculation pseudocode for losses and loss claims.

<pre>
   <code>
<font color="#85994b">// Input parameters
incomeSummaries <font color="#85994b">// List of income summaries</font>
lossAndClaimList <font color="#85994b">// List of losses and claims</font>
reliefs = [
relief {
reliefType, <font color="#85994b">// Type of relief</font>
amountClaimed, <font color="#85994b">// Amount claimed for the relief</font>
}
]

lossesSetAgainstInYearGeneralIncome <font color="#85994b">// Losses set against in year general income. Refer to setAgainstInYearGeneralIncome in <a href="tax-calculation.html#capital-gains">Capital gains</a></font>
payrollGivingRelief <font color="#85994b">// Payroll giving relief. API parameter name: payrollGiving.reliefClaimed</font>
qualifyingLoanInterestList <font color="#85994b</font>">// List of qualifying loan interest payments. API parameter name: qualifyingLoanInterestPayments</font>
postCessationTradeReliefList <font color="#85994b">// List of Post cessation trade reliefs. API parameter name: postCessationTradeReliefAndCertainOtherLosses</font>
totalIncomeFromAllSources <font color="#85994b">// Total income from all sources. Refer to Income summary totals</font>

<font color="#85994b">// Methods</font>
getLossAndClaims <font color="#85994b">// Gets losses and claims for specific income</font>
sortByPriority <font color="#85994b">// Sorts losses by priority</font>
<a href="allowances-and-reliefs.html#annuity-payments">
<font color="#85994b">// Other parameters used for calculations (initialise parameters)</font>
taxableAmount <font color="#85994b">// Taxable amount from income</font>
incomeSourceId <font color="#85994b">// Unique identifier of income source</font>
incomeSourceType <font color="#85994b">// Income source type</font>
applicableLossAndClaims <font color="#85994b">// loss and claims applicable to income source and type</font>
ukOtherList <font color="#85994b">// Losses and claims from UK property</font>
csFhlLosses <font color="#85994b">// CSFHL losses and claims</font>
filteredLossAndClaims <font color="#85994b">// Filtered loss and claims</font>
maxAmountToUse <font color="#85994b">// Maximum amount of taxable profit to apply losses to</font>
amountUsed <font color="#85994b">// Amount of losses used</font>
remainingProfit <font color="#85994b">// Remaining profit</font>
csgiLossAndClaims <font color="#85994b">// CSGI losses and claims</font>
lossesAvailableToGeneralIncomeBeforeRestriction = 0 <font color="#85994b">// Losses available to general income before restrictions</font>
reliefAmount <font color="#85994b">// Relief amount</font>
csgiAllowanceUsed <font color="#85994b">// Csgi allowance used</font>
allowanceCap <font color="#85994b">// Allowance cap. Refer to lossCap in the <a href="downloads/taxyear24-25.yml" download>config file</a></font>
incomeIncludingPayrollGiving<font color="#85994b">// Income including payroll giving</font>
quarterOfTaxableProfit <font color="#85994b">// Quarter of taxable profit</font>
restrictedAllowance <font color="#85994b">// Restricted allowance</font>
amountToReduceLossesBy <font color="#85994b">// Amount to reduce losses by</font>
remainingReduction <font color="#85994b">// Remaining reduction</font>
lossesUsed <font color="#85994b">// Losses used</font>
capitalGainsSetAgainstInYearGeneralIncome <font color="#85994b">// Capital gains set against in year general income</font>
reliefUsed <font color="#85994b">// Amount of relief used</font>
qualifyingLoanInterestFromInvestments = 0<font color="#85994b">// Qualifying loan interest from investments</font>
claimApplied <font color="#85994b">// Claim applied</font>
lossesAppliedToGeneralIncome = 0<font color="#85994b">// Losses applied to general income</font>
postCessationTradeReliefs = 0<font color="#85994b">// Post cessation trade reliefs</font>
totalFromAllSelfEmploymentsBeforeLossApplied = 0<font color="#85994b">// Total taxable amount from self employment prior to losses being applied</font>
nics4LossesAppliedToGeneralIncome <font color="#85994b">// Class 4 nics losses applied to general income</font>
currentLossValue <font color="#85994b">// Current loss value</font>
lossType <font color="#85994b">// Loss type</font>
totalBroughtForwardIncomeTaxLosses <font color="#85994b">// Total brought forward income tax losses</font>
broughtForwardIncomeTaxLossesUsed <font color="#85994b">// Brought forward income tax losses used</font>
totalBroughtForwardClass4Losses <font color="#85994b">// Total brought forward Class 4 losses</font>
broughtForwardClass4LossesUsed <font color="#85994b">// Brought forward class 4 losses used</font>
totalIncomeTaxLossesCarriedForward <font color="#85994b">// Total income tax losses carried forward</font>
totalClass4LossesCarriedForward <font color="#85994b">// Total class 4 losses carried forward</font>
carrySidewaysIncomeTaxLossesUsed <font color="#85994b">// Carry sideways income tax losses</font>
carrySidewaysClass4LossesUsed <font color="#85994b">// Carry sideways class 4 losses used</font>
broughtForwardCarrySidewaysLosses <font color="#85994b">// Brought forward carry sideways losses</font>
broughtForwardCarrySidewaysLossesUsed <font color="#85994b">// Brought forward carry sideways losses</font>
totalLossForCSFHL <font color="#85994b">// Total loss for CSFHL</font>

<font color="#85994b">// Rules used in the calculation below:</font>
// Sort all applicable LossAndClaims in order of priority (Highest Priority First).
// Sorting follows a multi-level rule set:
// 1. Sort by `taxYearLossIncurred` in CHRONOLOGICAL ORDER (older years first)
// 2. If `taxYearLossIncurred` is the same, sort by the following claim-level rules:
//    a. `taxYearClaimMade` --- Older claims are applied first (i.e., lower year first)
//    b. `claimType` --- Use the following priority values (lower number = higher priority):
//       - CSFHL   = "10"  => (highest priority)
//       - CF      = "20"
//       - CFCSGI  = "30"
//       - CSGI    = "40"  => (lowest priority)
//    c. For `CSGI` and `CFCSGI` claims only:
//       - Sort by `sequence` (as an integer) in ascending order
//    d. For all other claim types (CSFHL, CF):
//       - Sort by `incomeSourceType` using the following 2-digit code priority:
//       - Self Employment    = "01"  => (highest priority)
//       - UK Property        = "02"
//       - FHL Property -- EEA = "03"
//       - FHL Property -- UK  = "04"  => (lowest priority)</font>

---------------------- Apply Non CSGI Claims to "INCOME" Type Losses ---------------------------
<font color="#85994b">// Applying (any non CSGI) Claims to Income Summaries - of types: "SELF_EMPLOYMENT, UK_OTHER, UK_FHL, EEA_FHL, FOREIGN_PROPERTY_OTHER that contain a Taxable Profit</font>
for each incomeSummary in incomeSummaries
    <font color="#85994b">// For each income summary, apply non-CSGI losses</font>
    taxableAmount = incomeSummary.taxableAmount
    incomeSourceId = incomeSummary.incomeSourceId
    incomeSourceType = incomeSummary.incomeSourceType 

    <font color="#85994b">// Fetch loss and claims based on income source and type</font>
    applicableLossAndClaims = getLossAndClaims(incomeSourceId, incomeSourceType)

    <font color="#85994b">// Make any special adjustments based on income source type</font>
<font color="#1d70b8">if</font> incomeSourceType = '02' <font color="#1d70b8">then</font>
    <font color="#85994b">// UK Other: Exclude CSFHL claims</font>
      applicableLossAndClaims.exclude(claimType('CSFHL'))
    <font color="#1d70b8">else if</font> incomeSourceType = '04'
      <font color="#85994b">// UK FHL: Include CSFHL losses from UK Other</font>
      ukOtherList = lossAndClaimList.filter(incomeSourceType = '02')
      csFhlLosses = ukOtherList.filter(claimType('CSFHL'))
    <font color="#1d70b8">for each</font> loss in csFhlLosses
applicableLossAndClaims.add(loss)
      end <font color="#1d70b8">for</font>
    end <font color="#1d70b8">if</font>

    <font color="#85994b">// Filter to income-type losses of type CF and CSFHL</font>
    filteredLossAndClaims = []
    <font color="#1d70b8">for each</font> lossAndClaim in applicableLossAndClaims
    <font color="#1d70b8">if</font> lossAndClaim.lossType = "INCOME"and lossAndClaim.incomeSourceId = incomeSummary.incomeSourceId <font color="#1d70b8">and</font> lossAndClaim.incomeSourceType = incomeSummary.incomeSourceType and lossAndClaim.claimType is not "CSGI"
filteredLossAndClaims.add(lossAndClaim)
end <font color="#1d70b8">if</font>
end <font color="#1d70b8">for</font>

    <font color="#85994b">// Refer to the rules in Rules Section</font>
    filteredLossAndClaims = sortByPriority(filteredLossAndClaims)

    <font color="#85994b">// Apply filtered losses to the remaining profit</font>
for each lossAndClaim in filteredLossAndClaims
    maxAmountToUse = taxableAmount
    <font color="#1d70b8">if</font> maxAmountToUse > lossAndClaim.currentLossValue
    amountUsed = lossAndClaim.currentLossValue
<font color="#1d70b8">else</font>
    amountUsed = maxAmountToUse
    end <font color="#1d70b8">if</font>
    lossAndClaim.currentLossValue = lossAndClaim.currentLossValue - amountUsed
      remainingProfit = max((maxAmountToUse - amountUsed), 0) <font color="#85994b">// Ensure non-negative value
    <font color="#1d70b8">if</font> remainingProfit = 0
         break
end <font color="#1d70b8">for</font>

   <font color="#85994b">// Store the applied loss value directly on the income summary object</font>
   remainingProfit = roundDown(remainingProfit, 0) <font color="#85994b">// Round down to nearest whole pound</font>
   incomeSummary.lossAmountAppliedToProfit = taxableAmount - remainingProfit
end <font color="#1d70b8">for</font>

---------------------- Apply Non CSGI Claims to "CLASS_4_NICS" type losses --------------------
<font color="#85994b">// Applying non-CSGI, carry forward claim to any SELF_EMPLOYMENT Income Summaries</font>
<font color="#1d70b8">for each</font> incomesummary in incomeSummaries.findIncomeSummaries(SELF_EMPLOYMENT)

<font color="#85994b">// Get the taxable amount for the self-employment income</font>
    taxableAmount = incomesummary.taxableAmount
    incomeSourceId = incomesummary.incomeSourceId
    incomeSourceType = incomesummary.incomeSourceType
    <font color="#85994b">// fetch loss and claims based on income source and type</font>
    applicableLossAndClaims = getLossAndClaims(incomeSourceId, incomeSourceType)
    <font color="#85994b">// Filter to Class 4 NICS losses of type CF</font>
    filteredLossAndClaims = []
<font color="#1d70b8">for each</font> lossAndClaim in applicableLossAndClaims
    <font color="#1d70b8">if</font> lossAndClaim.lossType = "CLASS_4_NICS"and lossAndClaim.incomeSourceId = incomeSummary.incomeSourceId and lossAndClaim.incomeSourceType = incomeSummary.incomeSourceType and lossAndClaim.claimType is not "CSGI"
filteredLossAndClaims.add(lossAndClaim)
end <font color="#1d70b8">for</font>

    <font color="#85994b">// Refer to the rules in Rules Section</font>
    filteredLossAndClaims = sortByPriority(filteredLossAndClaims)

    <font color="#85994b">// Apply filtered losses to the remaining profit</font>
    <font color="#1d70b8">for each lossAndClaim in filteredLossAndClaims</font>

<font color="#85994b">// [Transitional Profits (TP)]
// If transitional profits exist (standard and/or accelerated), refer to the TP section
// to ensure TP are included in the remaining profit before applying losses</font>
    remainingProfit = taxableAmount
      maxAmountToUse = remainingProfit
      <font color="#1d70b8">if</font> maxAmountToUse > lossAndClaim.currentLossValue
        amountUsed = lossAndClaim.currentLossValue
      <font color="#1d70b8">else</font>
          amountUsed = maxAmountToUse
      end <font color="#1d70b8">if</font>
      lossAndClaim.currentLossValue = lossAndClaim.currentLossValue - amountUsed
      remainingProfit = max((maxAmountToUse - amountUsed), 0) // Ensure non-negative value
      <font color="#1d70b8">if</font> remainingProfit = 0
         break
end <font color="#1d70b8">for</font>

   <font color="#85994b">// Store the applied loss value directly on the self-employment object</font>
   remainingProfit = roundDown(remainingProfit, 0) <font color="#85994b">// Round down to nearest whole pound</font>
   incomesummary.lossAmountAppliedToNicsProfit = taxableAmount - remainingProfit
end <font color="#1d70b8">for</font>

------------------------- Apply CSGI Claims to "INCOME" Type Losses -------------------------
<font color="#85994b">// Add relevant loss and claims to the list</font>
<font color="#1d70b8">for each</font> lossAndClaim in lossAndClaimList
<font color="#1d70b8">if</font> lossAndClaim.claimType = "CSGI"and taxYear = 2025and lossAndClaim.lossType = "INCOME"
      csgiLossAndClaims.add(lossAndClaim)
   end <font color="#1d70b8">if</font>
end <font color="#1d70b8">for</font>

<font color="#85994b">// Refer to the rules in Rules Section - 2.c</font>
csgiLossAndClaims = sortByPriority(csgiLossAndClaims)

<font color="#85994b">// Calculate Losses available before restriction</font>
<font color="#1d70b8">if</font> totalIncomeFromAllSources is not null
<font color="#1d70b8">for each</font> lossAndClaim in csgiLossAndClaims
    lossesAvailableToGeneralIncomeBeforeRestriction = lossesAvailableToGeneralIncomeBeforeRestriction + lossAndClaim.currentLossValue
    <font color="#1d70b8">end for</font>
<font color="#1d70b8">if</font> lossType = "INCOME"then
    <font color="#85994b">// Add Capital Gains Losses, if applicable</font>
      lossesAvailableToGeneralIncomeBeforeRestriction = lossesAvailableToGeneralIncomeBeforeRestriction + lossesSetAgainstInYearGeneralIncome
      <font color="#85994b">// Add Relief Amount, if applicable</font>
    <font color="#1d70b8">for each</font> relief in reliefs
<font color="#1d70b8">if relief.reliefType = "POST_CESSATION_TRADE_RELIEF"or relief.reliefType = "QUALIFYING_LOAN_INTEREST"
        reliefAmount = relief.amountClaimed + reliefAmount
end <font color="#1d70b8">if</font>
      end <font color="#1d70b8">for</font>
      lossesAvailableToGeneralIncomeBeforeRestriction = lossesAvailableToGeneralIncomeBeforeRestriction + reliefAmount
end <font color="#1d70b8">if</font>

    <font color="#85994b">// Apply CSGI allowance cap</font>
    csgiAllowanceUsed = min(lossesAvailableToGeneralIncomeBeforeRestriction, allowanceCap)
end <font color="#1d70b8">if</font>

<font color="#85994b">// Calculate restricted allowance</font>
incomeIncludingPayrollGiving = payrollGivingRelief + totalIncomeFromAllSources
quarterOfTaxableProfit = roundup((incomeIncludingPayrollGiving / 4), 0) <font color="#85994b">// Round up to nearest whole pound
restrictedAllowance = min(lossesAvailableToGeneralIncomeBeforeRestriction, max(csgiAllowanceUsed, quarterOfTaxableProfit))
<font color="#1d70b8">if</font> restrictedAllowance < totalIncomeFromAllSources <font color="#1d70b8">then</font>
amountToReduceLossesBy = restrictedAllowance
<font color="#1d70b8">else</font>
    amountToReduceLossesBy = totalIncomeFromAllSources
end <font color="#1d70b8">if</font>
remainingReduction = amountToReduceLossesBy

<font color="#85994b">// Apply Capital gains losses</font>
<font color="#1d70b8">if</font> lossType = "INCOME"and lossesSetAgainstInYearGeneralIncome is not null <font color="#1d70b8">then</font>

<font color="#85994b">// Adjust remaining reduction by subtracting total capital gains losses</font>
lossesUsed = min(lossesSetAgainstInYearGeneralIncome, remainingReduction)
capitalGainsSetAgainstInYearGeneralIncome = lossesUsed
   remainingReduction = max((remainingReduction - lossesUsed), 0) <font color="#85994b">// Ensure non-negative value</font>
end <font color="#1d70b8">if</font>

<font color="#85994b">// Apply qualifying loan interest from investments losses</font>
<font color="#1d70b8">if </font>lossType = "INCOME"then
<font color="#1d70b8">for each</font> relief in qualifyingLoanInterestList
    reliefUsed = min(reliefClaimed, remainingReduction)
        qualifyingLoanInterestFromInvestments = qualifyingLoanInterestFromInvestments + reliefUsed
remainingReduction = max((remainingReduction - reliefUsed), 0) = 0

<font color="#85994b">// Exit the loop if no remaining reduction</font>
<font color="#1d70b8">if</font> remainingReduction = 0 <font color="#1d70b8">then</font>
break
    end <font color="#1d70b8">for</font>
end <font color="#1d70b8">if</font>

<font color="#85994b">// Apply general income losses</font>
<font color="#1d70b8">for each</font> claim in csgiLossAndClaims:
<font color="#1d70b8">if</font> remainingReduction > claim.currentLossValue <font color="#1d70b8">then</font>
remainingReduction = remainingReduction - claim.currentLossValue
lossesAppliedToGeneralIncome = lossesAppliedToGeneralIncome + claim.currentLossValue
<font color="#1d70b8">else</font>
lossesAppliedToGeneralIncome = lossesAppliedToGeneralIncome + remainingReduction
remainingReduction = 0
end <font color="#1d70b8">if</font>

    <font color="#85994b">// Exit the loop if no remaining reduction</font>
    <font color="#1d70b8">if</font> remainingReduction = 0 <font color="#1d70b8">then</font>
    break
end <font color="#1d70b8">for</font>

<font color="#85994b">// Apply post Cessation Trade Relief losses</font>
<font color="#1d70b8">if</font> lossType = "INCOME" <font color="#1d70b8">then</font>
<font color="#1d70b8">for each</font> relief in postCessationTradeReliefList
    reliefUsed = min(relief.amount, remainingReduction)
        postCessationTradeReliefs = postCessationTradeReliefs + reliefUsed
        remainingReduction = max((remainingReduction - reliefUsed), 0) <font color="#85994b">// Ensure non-negative value
// Exit the loop if no remaining reduction</font>
    <font color="#1d70b8">if</font> remainingReduction = 0 <font color="#1d70b8">then</font>
    break
end <font color="#1d70b8">for</font>
end <font color="#1d70b8">if</font>

postCessationTradeReliefs = roundUp(postCessationTradeReliefs, 2) <font color="#85994b">// Round up to 2 decimal places</font>

<font color="#85994b">// Carry Forward CFCSGI Claims</font>
<font color="#85994b">// Note: A CFCSGI can only be used once. After that they just become CF</font>
<font color="#1d70b8">for each</font> claim in csgiLossAndClaims
<font color="#1d70b8">if</font> claim.claimType = "CFCSGI"and claim.currentLossValue >= 0 <font color="#1d70b8">and</font> claim.lossMadeThisYear = false
    claim.canBringForward = false
      <font color="#85994b">// Create a CF claim if we find any CFCSGI claims with losses to carry forward from last year</font>
lossAndClaimList.add(defaultClaim)
end <font color="#1d70b8">if</font>
end <font color="#1d70b8">for</font>

----------------------- Apply CSGI Claims to "CLASS_4_NICS" Type Losses-------------------------
<font color="#85994b">// Calculate total from all self employments before loss applied</font>
<font color="#1d70b8">for each</font> incomesummary in incomeSummaries.findIncomeSummaries("SELF_EMPLOYMENT")

<font color="#85994b">// Get the taxable amount for the self-employment income</font>
totalFromAllSelfEmploymentsBeforeLossApplied = totalFromAllSelfEmploymentsBeforeLossApplied + incomesummary.taxableAmount
end <font color="#1d70b8">for</font>

<font color="#85994b">// Add relevant loss and claims to the list</font>
<font color="#1d70b8">for each</font> lossAndClaim in lossAndClaimList
<font color="#1d70b8">if</font></font> lossAndClaim.claimType = "CSGI"and taxYear = 2025and lossAndClaim.lossType = "CLASS_4_NICS"
csgiLossAndClaims.add(lossAndClaim)
    end <font color="#1d70b8">if</font>
end <font color="#1d70b8">for</font>

<font color="#85994b">// Refer to the rules in Rules Section - 2.c</font>
csgiLossAndClaims = sortByPriority(csgiLossAndClaims)

<font color="#85994b">// Calculate Losses available before restriction</font>
<font color="#1d70b8">if</font> totalIncomeFromAllSources is not null
<font color="#1d70b8">for each</font> loss in csgiLossAndClaims
    lossesAvailableToGeneralIncomeBeforeRestriction = lossesAvailableToGeneralIncomeBeforeRestriction + loss.csgiLossAndClaimsAmount
    end <font color="#1d70b8">for</font>
    <font color="#85994b">// Apply CSGI allowance cap</font>
    csgiAllowanceUsed = min(lossesAvailableToGeneralIncomeBeforeRestriction, allowanceCap)
end <font color="#1d70b8">if</font>

<font color="#85994b">// Calculate restricted allowance</font>
incomeIncludingPayrollGiving = payrollGivingRelief + totalIncomeFromAllSources
quarterOfTaxableProfit = roundup((incomeIncludingPayrollGiving / 4), 0) <font color="#85994b">// Round up to nearest whole pound</font>
restrictedAllowance = min(lossesAvailableToGeneralIncomeBeforeRestriction, max(csgiAllowanceUsed, quarterOfTaxableProfit))
<font color="#1d70b8">if</font> restrictedAllowance < totalFromAllSelfEmploymentsBeforeLossApplied <font color="#1d70b8">then</font>
    amountToReduceLossesBy = restrictedAllowance
<font color="#1d70b8">else</font>
    amountToReduceLossesBy = totalFromAllSelfEmploymentsBeforeLossApplied
end <font color="#1d70b8">if</font>
remainingReduction = amountToReduceLossesBy

<font color="#85994b">// Apply general income losses</font>
<font color="#1d70b8">for each</font> claim in csgiLossAndClaims
<font color="#1d70b8">if</font> remainingReduction > claim.currentLossValue <font color="#1d70b8">then</font>
remainingReduction = remainingReduction - claim.currentLossValue
nics4LossesAppliedToGeneralIncome = nics4LossesAppliedToGeneralIncome + claim.currentLossValue
<font color="#1d70b8">else</font>
nics4LossesAppliedToGeneralIncome = nics4LossesAppliedToGeneralIncome + remainingReduction
remainingReduction = 0
end <font color="#1d70b8">if</font>
    <font color="#85994b">// Exit the loop if no remaining reduction</font>
    <font color="#1d70b8">if</font> remainingReduction = 0 <font color="#1d70b8">then</font>
    break
end <font color="#1d70b8">for</font>

------------------------------- Update Business Profit and Loss --------------------------------
for each lossAndClaim in lossesAndClaims
incomeSourceId = lossAndClaim.incomeSourceId
    incomeSourceType = lossAndClaim.incomeSourceType
    lossType = lossAndClaim.lossType
    currentLossValue = lossAndClaim.currentLossValue
    <font color="#85994b">// Set Brought Forward Losses</font>
<font color="#1d70b8">if</font> lossAndClaim has losses and lossMadeThisYear = false
    <font color="#1d70b8">if</font> lossAndClaim.currentLossValue is not null and lossAndClaim.lossType = "INCOME"
        totalBroughtForwardIncomeTaxLosses = roundUp(lossAndClaim.currentLossValue, 0) <font color="#85994b">// Round down to nearest whole pound</font>
         broughtForwardIncomeTaxLossesUsed = roundUp(lossAndClaim.lossUsed, 0) <font color="#85994b">// Round up to nearest whole pound</font>
      end <font color="#1d70b8">if</font>
<font color="#1d70b8">if lossAndClaim.currentLossValue is not null and lossAndClaim.lossType = "CLASS_4_NICS"
        totalBroughtForwardClass4Losses = roundUp(lossAndClaim.currentLossValue, 0) <font color="#85994b">// Round up to nearest whole pound</font>
          broughtForwardClass4LossesUsed = roundUp(lossAndClaim.lossUsed, 0) <font color="#85994b">// Round up to nearest whole pound</font>
    end <font color="#1d70b8">if</font>
end <font color="#1d70b8">if</font>
    <font color="#85994b">// Set Losses Carry Forward</font>
   <font color="#1d70b8">if</font> lossesAndClaim has losses and lossMadeThisYear = trueand lossAndClaim.claimType = "CF"
<font color="#1d70b8">if</font> lossAndClaim.currentLossValue is not null and lossAndClaim.lossType = "INCOME"
        totalIncomeTaxLossesCarriedForward = roundUp(lossAndClaim.currentLossValue, 0) <font color="#85994b">// Round up to nearest whole pound</font>
      end <font color="#1d70b8">if</font>
      <font color="#1d70b8">if</font> lossAndClaim.currentLossValue is not null and lossAndClaim.lossType = "CLASS_4_NICS"
        totalClass4LossesCarriedForward = roundUp(lossAndClaim.currentLossValue, 0) <font color="#85994b">// Round up to nearest whole pound</font>
end <font color="#1d70b8">if</font>
end <font color="#1d70b8">if</font>

</font>    <font color="#85994b">// Set Carry Sideways Losses</font>
    <font color="#1d70b8">if </font>lossesAndClaim has losses and lossAndClaim.claimType = "CSGI"
<font color="#1d70b8">if</font></font> lossAndClaim.currentLossValue is not null and lossAndClaim.lossType = "INCOME"
        carrySidewaysIncomeTaxLossesUsed = roundUp(lossAndClaim.currentLossValue, 0) <font color="#85994b">// Round up to nearest whole pound</font>
      end <font color="#1d70b8">if</font>
      <font color="#1d70b8">if</font> lossAndClaim.currentLossValue is not null and lossAndClaim.lossType = "CLASS_4_NICS"
        carrySidewaysClass4LossesUsed = roundUp(lossAndClaim.currentLossValue, 0) <font color="#85994b">// Round up to nearest whole pound</font>
      end <font color="#1d70b8">if</font>
end <font color="#1d70b8">if</font>

    <font color="#85994b">// Special Adjustment</font>
    <font color="#1d70b8">if</font> lossAndClaim.incomeSourceType = 02 and isBroughtForwardCarrySideways = true
    broughtForwardCarrySidewaysLosses = roundUp(lossAndClaim.currentLossValue, 0) <font color="#85994b">// Round up to nearest whole pound</font>
      broughtForwardCarrySidewaysLossesUsed = roundUp(lossAndClaim.lossUsed, 0) <font color="#85994b">// Round up to nearest whole pound</font>
    end <font color="#1d70b8">if</font>
    <font color="#1d70b8">if</font> lossAndClaim.incomeSourceType = 04and lossAndClaim.claimType = "CSFHL"
    totalLossForCSFHL = roundUp(lossAndClaim.currentLossValue, 0) <font color="#85994b">// Round up to nearest whole pound</font>
    end <font color="#1d70b8">if</font>
end <font color="#1d70b8">for</font>
   </code>
</pre>

### Transitional Profits losses and loss claims

Transitional Profits affect the following areas: Losses & Loss Claims, Income Tax Liability, Tax Reductions, National Insurance. You can find the pseudocode for each of these sections under the 'Note' for each respective section. For more detailed information, please refer to [Work out your Basis Period Reform transition profit - GOV.UK](https://www.gov.uk/guidance/work-out-your-transition-profit).

> **Note:** the following is applicable if there are transitional profits (TP)

<pre>
   <code>
<font color="#85994b">// Input parameters</font>
incomeSummaries = [
incomeSummary {
    transitionProfitAmount <font color="#85994b">// Transition profit amount</font>
    transitionProfitAccelerationAmount <font color="#85994b">// Transition profit acceleration amount</font>
}
]
transitionProfitAmount <font color="#85994b">// Transition profit amount. Parameter name is same as API parameter name</font>
transitionProfitAccelerationAmount <font color="#85994b">// Transition profit acceleration amount. Parameter name is same as API parameter name </font>
taxableAmount <font color="#85994b">// Income turnover from self employment. API parameter name: periodIncome.turnover</font>

<font color="#85994b">// Methods</font>
GetLossAndClaims <font color="#85994b">// Retrieves losses and claims for a specific income source</font>

<font color="#85994b">// Other parameters used for calculation</font>
taxableAmount <font color="#85994b">// Taxable income</font>
incomeSourceId <font color="#85994b">// Unique identifier of income source</font>
incomeSourceType <font color="#85994b">// Income source type</font>
applicableLossAndClaims <font color="#85994b">// losses and claims applicable to specific income</font>
filteredLossAndClaims <font color="#85994b">// List of filtered losses and claims</font>
remainingProfit <font color="#85994b">// After applying Transitional profits</font>
remainingBroughtForwardIncomeTaxLosses = 0<font color="#85994b">// Remaining brought forward income tax losses</font>
maxAmountToUse <font color="#85994b">// Maximum amount of taxable profit to apply losses to</font>
amountUsed <font color="#85994b">// Amount of losses used</font>
broughtForwardIncomeTaxLossesUsed <font color="#85994b">// Brought forward income tax losses used</font>
transitionProfitsAfterIncomeTaxLossDeductions <font color="#85994b">// Transition profits after income tax loss deductions</font>
totalTransitionProfit <font color="#85994b">// Total transition profit</font>
taxableAmountIncludingTransitionProfit <font color="#85994b">// Taxable amount including transition profit</font>
totalTransitionProfitFromAllSE = 0 <font color="#85994b">// Total transition profit from all self-employment</font>
totalIncomeLiableToClass4Charge <font color="#85994b">// Total income liable to class 4 charges</font>

<font color="#85994b">// Note:
// if TP is present, sections being affected are:
// - Losses & Loss Claims
// - Income Tax Liability
// - National Insurance
// - Tax Reductions</font>
---------------------------------------- loss type: INCOME-------------------------------------
<font color="#85994b">// This section applies any remaining losses against the total transitional profits (TP)
// (1/2) Iteration:
// The first iteration applies the losses and claims to regular taxable profits
    // Offset losses against current year regular profits
    // This updates current loss value for each loss
    // Refer to Losses and Loss Claims Section for more detail
// (2/2) Iteration:
// The second iteration reapplies losses and claims to TP, using any remaining losses from the first iteration

// Process loss and claims</font>>
for each incomeSummary in incomeSummaries.findIncomeSummaries(SELF_EMPLOYMENT)

<font color="#85994b">// Get total transition profit</font>
    taxableAmount = roundDown((incomeSummary.transitionProfitAmount + incomeSummary.transitionProfitAccelerationAmount), 0) <font color="#85994b">// Round down to nearest whole pound</font>
    incomeSourceId = incomeSummary.sourceId
    incomeSourceType = incomeSummary.incomeSourceType
    <font color="#85994b">// fetch loss and claims based on income source and type</font>
    applicableLossAndClaims = getLossAndClaims(incomeSourceId, incomeSourceType)
    <font color="#85994b">// filter list to LossTypes.INCOME and getClaimType() = CF</font>
    filteredLossAndClaims = []
    <font color="#1d70b8">for each</font> lossAndClaim in applicableLossAndClaims
        <font color="#1d70b8">if</font> lossAndClaim.lossType = "INCOME" and lossAndClaim.claimType = "CF"
            add lossAndClaim to filteredLossAndClaims
        end <font color="#1d70b8">if</font>
    end <font color="#1d70b8">for</font>
    remainingProfit = taxableAmount
    <font color="#85994b">// Apply filtered losses to the remaining profit</font>
    <font color="#1d70b8">for each</font> lossAndClaim in filteredLossAndClaims
    <font color="#85994b">// Set remaining brought forward income tax losses in transition profits</font>
        remainingBroughtForwardIncomeTaxLosses = roundDown((remainingBroughtForwardIncomeTaxLosses + currentLossValue), 0) <font color="#85994b">// Round down to nearest whole pound</font>
maxAmountToUse = remainingProfit
        <font color="#1d70b8">if</font> maxAmountToUse > currentLossValue
            amountUsed = currentLossValue
        <font color="#1d70b8">else</font>
            amountUsed = maxAmountToUse
        end <font color="#1d70b8">if</font>
        lossAndClaim.currentLossValue = currentLoss - amountUsed
        remainingProfit = max((maxAmountToUse - amountUsed), 0) <font color="#85994b">// Ensure non-negative value</font>
        broughtForwardIncomeTaxLossesUsed = roundDown((broughtForwardIncomeTaxLossesUsed + amountUsed), 0) <font color="#85994b">// Round down to nearest whole pound</font>
        <font color="#1d70b8">if</font> remainingProfit = 0
        break
        end <font color="#1d70b8">if</font>
    end <font color="#1d70b8">for</font>
   <font color="#85994b">// Update transition profit field</font>
   transitionProfitsAfterIncomeTaxLossDeductions = (remainingProfit, 0) <font color="#85994b">// Round down to nearest whole pound</font>
end <font color="#1d70b8">for</font>

--------------------------------- loss type: CLASS_4_NICS -------------------------------------
<font color="#85994b">// This section integrates transition profit into the loss and claims logic and should only be executed when TP exist
// Calculate total TP (standard + accelerated)</font>
totalTransitionProfit = roundDown(transitionProfitAmount + transitionProfitAccelerationAmount, 0) <font color="#85994b">// Round down to nearest whole pound</font>

<font color="#85994b">// Set taxable amount including TP</font>
<font color="#1d70b8">if</font> taxableAmount <= 0
taxableAmountIncludingTransitionProfit = totalTransitionProfit
<font color="#1d70b8">else</font>
    taxableAmountIncludingTransitionProfit = taxableAmount + totalTransitionProfit
end <font color="#1d70b8">if</font>

<font color="#85994b">// Override max amount to use to include TP</font>
remainingProfit = taxableAmountIncludingTransitionProfit

<font color="#85994b">// Set total TP from all self employment</font>
totalTransitionProfitFromAllSE = totalTransitionProfitFromAllSE + totalTransitionProfit

<font color="#85994b">// Update total income liable to class 4 charge **before** loss application</font>
totalIncomeLiableToClass4Charge = totalIncomeLiableToClass4Charge + remainingProfit

<font color="#85994b">// Refer back to 'Apply Claims to "CLASS_4_NICS" type losses' in losses and loss claims section to apply filtered losses to the remaining profit</font>
   </code>
</pre>

## Income summary totals

Calculation of total income is the first step in determining Income Tax Liability. All taxable income sources are added together to form the Income Summary total.

Below is the calculation pseudocode for income summary totals.

<pre>
   <code>
<font color="#85994b">// Input parameters</font>
taxableProfitFromSelfEmployment <font color="#85994b">// Refer to Calculate total taxable self-employment profit</font>
taxableProfitFromUkPropertyOther <font color="#85994b">// Refer to Calculate total taxable property profit</font>
taxableProfitFromUkPropertyFhl <font color="#85994b">// Refer to Calculate total taxable property profit</font>
taxableProfitFromForeignPropertyOther <font color="#85994b">// Refer to Calculate total taxable property profit</font>
taxableProfitFromEeaPropertyFhl <font color="#85994b">// Refer to Calculate total taxable property profit</font>
totalTaxableEmploymentIncome <font color="#85994b">// Refer to <a href="income-and-benefits.html#employment-income">Employment income</a></font>
employmentLumpSumsNotLiableForPPP <font color="#85994b">// Refer to redundancyCompensationPaymentsOverExemption in <a href="income-and-benefits.html#employment-income">Employment income</a></font>
totalUntaxedInterest <font color="#85994b">// Refer to totalUntaxedUkSavings in <a href="income-and-benefits.html#uk-savings">UK savings</a></font>
totalGrossUkInterest <font color="#85994b">// Refer to totalGrossUkTaxedSavings in <a href="income-and-benefits.html#uk-savings">UK savings</a></font>
totalGrossSecurities <font color="#85994b">// Refer to grossSecurities in <a href="income-and-benefits.html#uk-savings">UK savings</a></font>
foreignSavingsInterest <font color="#85994b">// Refer to chargeableForeignSavingsAndGains in <a href="income-and-benefits.html#foreign-savings">Foreign savings</a></font>
totalUkDividends <font color="#85994b">// Refer to <a href="income-and-benefits.html#uk-dividends">UK dividends</a></font>
totalChargeableForeignDividends <font color="#85994b">// Refer to <a href="income-and-benefits.html#foreign-dividends">Foreign dividends</a></font>
totalOverseasIncomeAndGains <font color="#85994b">// Refer to overseasIncomeAndGains in <a href="income-and-benefits.html#foreign-and-other-income">Foreign and other income</a></font>
otherIncomesWhileAbroad <font color="#85994b">// Refer chargeableAllOtherIncomeReceivedWhilstAbroad to <a href="income-and-benefits.html#foreign-and-other-income">Foreign and other income</a></font>
foreignPensionIncome <font color="#85994b">// Refer to totalForeignPensionIncome in <a href="income-and-benefits.html#foreign-and-other-income">Foreign and other income</a></font>
chargeableForeignBenefitsAndGifts <font color="#85994b">// Refer to totalForeignBenefitsAndGifts <a href="income-and-benefits.html#foreign-and-other-income">Foreign and other income</a></font>
postCessationTradeReceipts <font color="#85994b">// Refer to totalPostCessationReceipts in <a href="income-and-benefits.html#foreign-and-other-income">Foreign and other income</a></font>
totalStateBenefitsIncomeExcludingStatePensionLumpSumBenefit <font color="#85994b">// Refer to <a href="income-and-benefits.html#state-benefits">State Benefits</a></font>
taxableProfitFromShareOptions <font color="#85994b">// Taxable profit from share options. API parameter name: shareOption.taxableamount</font>
taxableProfitFromSharesAwardedOrReceived <font color="#85994b">// Taxable profit from shares awarded or received. API parameter name: SharesAwardedOrReceived.taxableAmount</font>
gains = [ <font color="#85994b">// Gains including Life Insurance, Life Annuity, Capital Redemption, Voided ISAs and Foreign gains</font>
{
gainType, <font color="#85994b">// Type of gain</font>
gainAmount, <font color="#85994b">// Amount of the gain</font>
taxpaid, <font color="#85994b">// Indicator for tax paid (True or False)</font>
}

<font color="#85994b">// Other parameters used for calculations (initialise parameters)</font>
totalProfitFromSelfEmployment <font color="#85994b">// Total profit from self-employment</font>
totalProfitFromShareSchemes <font color="#85994b">// Total profit from share schemes</font>
totalEmploymentLumpSumsNotLiableForPPP <font color="#85994b">// Total employment lump sums not liable for PPP</font>
totalProfitFromUntaxedUkGains = 0 <font color="#85994b">// Total profit from untaxed UK gains</font>
totalProfitUntaxedForeignGains = 0 <font color="#85994b">// Total profit untaxed Foreign gains</font>
totalSavingsIncome <font color="#85994b">// Total savings income</font>
totalProfitFromProperty <font color="#85994b">// Total profit from property</font>
totalProfitFromPayPensionsProfit <font color="#85994b">// Total profit from PayPensionsProfit</font>
totalDividendIncomeForUkOtherAndForeign <font color="#85994b">// Total dividend income for UK other and Foreign</font>
totalProfitFromTaxedUkGains = 0 <font color="#85994b">// Total profit from taxed UK gains</font>
totalProfitFromTaxedForeignGains = 0 <font color="#85994b">// Total profit untaxed foreign gains</font>
totalIncomeFromAllSources <font color="#85994b">// Total income from all sources</font>

<font color="#85994b">// Calculate totalProfitFromSelfEmployment</font>
totalProfitFromSelfEmployment =sum[taxableProfitFromSelfEmployment] <font color="#85994b">// Sum of taxable profits for all self employments</font>

<font color="#85994b">// Calculate totalProfitFromProperty</font>
totalProfitFromProperty = taxableProfitFromUkPropertyOther + taxableProfitFromUkPropertyFhl + taxableProfitFromForeignPropertyOther + taxableProfitFromEeaPropertyFhl

<font color="#85994b">// Calculate totalProfitFromShareSchemes</font>
totalProfitFromShareSchemes = sum[taxableProfitFromShareOptions] + sum[taxableProfitFromSharesAwardedOrReceived] <font color="#85994b">// Sum of taxable profits for all share schemes</font>

<font color="#85994b">// Calculate totalProfitFromPayPensionsProfit</font>
totalProfitFromPayPensionsProfit = totalProfitFromProperty + totalProfitFromSelfEmployment + totalProfitFromShareSchemes + totalStateBenefitsIncomeExcludingStatePensionLumpSumBenefit + totalTaxableEmploymentIncome + totalOverseasIncomeAndGains + otherIncomesWhileAbroad + foreignPensionIncome + chargeableForeignBenefitsAndGifts + postCessationTradeReceipts

<font color="#85994b">// Calculate totalSavingsIncome</font>
totalSavingsIncome = totalUntaxedInterest + totalGrossUkInterest + foreignSavingsInterest + totalGrossSecurities + totalProfitFromUntaxedUkGains + totalProfituntaxedForeignGains

<font color="#85994b">// Calculate totalDividendIncomeForUkOtherAndForeign</font>
totalDividendIncomeForUkOtherAndForeign = totalUkDividends + totalChargeableForeignDividends

<font color="#85994b">// Calculate totalProfitFromUntaxedUkGains and totalProfituntaxedForeignGains</font>
<font color="#1d70b8">for each</font> gain in gains
<font color="#1d70b8">if</font> taxpaid is false and gainType is foreign <font color="#1d70b8">then</font>
totalProfitUntaxedForeignGains = totalProfitUntaxedForeignGains + gainAmount
<font color="#1d70b8">else</font>
totalProfitFromUntaxedUkGains = totalProfitFromUntaxedUkGains + gainAmount
end <font color="#1d70b8">if</font>
end <font color="#1d70b8">for</font>
totalProfitUntaxedForeignGains = roundDown(totalProfitUntaxedForeignGains, 0) <font color="#85994b">// Round down to nearest whole pound</font>
totalProfitFromUntaxedUkGains = roundDown(totalProfitFromUntaxedUkGains, 0) <font color="#85994b">// Round down to nearest whole pound</font>

<font color="#85994b">// Calculate totalProfitFromTaxedUkGains and totalProfitTaxedForeignGains</font>
<font color="#1d70b8">for each</font> gain in gains
<font color="#1d70b8">if</font> taxpaid is true <font color="#1d70b8">then</font> and gainType is foreign <font color="#1d70b8">then</font>
totalProfitFromTaxedForeignGains = totalProfitFromTaxedForeignGains + gainAmount
<font color="#1d70b8">else</font>
totalProfitFromTaxedUkGains = totalProfitFromTaxedUkGains + gainAmount
end <font color="#1d70b8">if</font></font>
end <font color="#1d70b8">for</font>

totalProfitFromTaxedForeignGains = roundDown(totalProfitFromTaxedForeignGains, 0) <font color="#85994b">// Round down to nearest whole pound</font>
totalProfitFromTaxedUkGains = roundDown(totalProfitFromTaxedUkGains, 0) <font color="#85994b">// Round down to nearest whole pound</font>

<font color="#85994b">// Calculate totalEmploymentLumpSumsNotLiableForPPP</font>
totalEmploymentLumpSumsNotLiableForPPP = roundDown(sum[employmentLumpSumsNotLiableForPPP], 0) <font color="#85994b">// Sum of total Employment Lump Sums Not Liable For PPP rounded down to nearest whole pound</font>

<font color="#85994b">// Calculate totalIncomeFromAllSources</font>
totalIncomeFromAllSources = totalProfitFromPayPensionsProfit + totalSavingsIncome + totalDividendIncomeForUkOtherAndForeign + totalProfitFromTaxedUkGains + totalProfitFromTaxedForeignGains + totalEmploymentLumpSumsNotLiableForPPP
   </code>
</pre>