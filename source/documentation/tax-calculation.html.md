---
title: Tax calculation | Tax Logic service guide
weight: 4
description: Further details of the calculations used for income tax.
---

# Tax calculation

Income tax is calculated by applying progressive rates to income after deducting the Personal Allowance, taking into account income bands, allowances, reliefs, and National Insurance contributions.

## Adjusted net income

Adjusted net income is total taxable income before any Personal Allowances and less certain tax reliefs. For more information, refer to [Personal Allowances: adjusted net income (GOV.UK)](https://www.gov.uk/guidance/adjusted-net-income).

Below is calculation pseudocode for adjusted net income.

<pre>
   <code>
    // Input parameters
    totalIncomeFromAllSources // Refer to <a href="income-and-benefits.html#income-summary-totals">Income summary totals</a>
    giftOfInvestmentsAndPropertyToCharity
    grossGiftAidPayments
    lossesAppliedToGeneralIncome
    grossAnnuityPayments
    qualifyingLoanInterestFromInvestments
    postCessationTradeReliefs
    totalPensionContributionsAllowance
    totalPensionContributionsRelief

    // Other parameters used for calculations
    totalDeductionsForAdjustedNetIncome
    adjustedNetIncome

    // Calculate totalIncomeFromAllSources (Refer to <a href="income-and-benefits.html#income-summary-totals">Income summary totals</a>)
    totalIncomeFromAllSources = totalDividendIncomeForUkOtherAndForeign + totalSavingsIncome + totalProfitFromPayPensionsProfit + totalProfitFromTaxedUkGains + totalProfitFromTaxedForeignGains + totalEmploymentLumpSumsNotLiableForPPP

    // Calculate totalDeductionsForAdjustedNetIncome
    totalDeductionsForAdjustedNetIncome = giftOfInvestmentsAndPropertyToCharity + grossGiftAidPayments + lossesAppliedToGeneralIncome + grossAnnuityPayments + qualifyingLoanInterestFromInvestments + postCessationTradeReliefs + totalPensionContributionsAllowance + totalPensionContributionsRelief

    // Calculate adjustedNetIncome
    adjustedNetIncome = totalIncomeFromAllSources – totalDeductionsForAdjustedNetIncome
   </code>
</pre>

## Income Tax liability – Only Pay pensions Profit

Income Tax liability is calculated based on taxable income and the applicable tax rates for different income bands.

> **Note:** This section is based on Default Ordering.

<pre>
   <code>
   // Initialise Pay Pensions Profit (PPP) Bands
   pppBasicRateName = "BRT" // Basic rate band for PPP income
   pppBasicRate = 20% // Tax rate for the basic rate band
   pppBasicRateThreshold = 37700
   pppBasicRateLimit = pppBasicRateThreshold + Basic rate extension // Upper limit of the basic rate band
   PppBasicRateAllocatedIncome // Income allocated to this band
   PppBasicRateTax // Tax calculated for this band

   pppHigherRateName = "HRT" // Higher rate band for PPP income
   pppHigherRate = 40% // Tax rate for the higher rate band
   pppHigherRateLimit = 125140 // Upper limit of the higher rate band
   pppHigherRateAllocatedIncome // Income allocated to this band
   pppHigherRateTax // Tax calculated for this band

   pppAdditionalRateName = "ART" // Additional rate band for PPP income
   pppAdditionalRate = 45% // Tax rate for the additional rate band
   pppAdditionalRateLimit // No upper limit for the additional rate band
   pppAdditionalRateAllocatedIncome // Income allocated to this band
   pppAdditionalRateTax // Tax calculated for this band

   // Personal Allowance for 2024/25
   personalAllowance = 12570 // £12,570 (in this scenario; it can be reduced allowance in some cases)
   personalAllowanceReduction // Reduced amount in Personal Allowance

   // This snippet includes allowances relevant to the example scenario presented. There are other allowances and deductions that will be applicable in an ideal scenario.

   // Income Sources
   totalProfitFromPayPensionsProfit// Refer to <a href="income-and-benefits.html#income-summary-totals">Income summary totals</a>

   // Other parameters used for calculations
   totalPayPensionsProfitTaxableIncome // Taxable income from employment, pensions, self-employment profits, and property rental income after applying any deductions or allowances
   totalTaxPPP // Total tax on pay, pensions, and profits

   // Step 1: Allocate Personal Allowance
   // Deduct Personal Allowance from non-savings income first

    if totalProfitFromPayPensionsProfit <= personalAllowance then
       totalPayPensionsProfitTaxableIncome = 0
    else
       totalPayPensionsProfitTaxableIncome = totalProfitFromPayPensionsProfit – Personal Allowance
       remainingAllowance = 0
    end if

    // Step 2: Allocate non-savings income across bands
    // Basic rate band calculations

    if totalPayPensionsProfitTaxableIncome <= pppBasicRateLimit then
       pppBasicRateAllocatedIncome = totalPayPensionsProfitTaxableIncome
       pppBasicRateTax = floor(pppBasicRateAllocatedIncome \* pppBasicRate, 2) // Round down to 2 decimal places
       pppHigherRateAllocatedIncome = 0
       pppAdditionalRateAllocatedIncome = 0
       remainingBasicRateBand = pppBasicRateLimit - pppBasicRateAllocatedIncome
    else if totalPayPensionsProfitTaxableIncome <= pppHigherRateLimit then
       pppBasicRateAllocatedIncome = pppBasicRateLimit
       pppBasicRateTax = floor(pppBasicRateAllocatedIncome \* pppBasicRate, 2) // Round down to 2 decimal places
       pppHigherRateAllocatedIncome = totalPayPensionsProfitTaxableIncome - pppBasicRateLimit
       pppHigherRateTax = floor(pppHigherRateAllocatedIncome \* pppHigherRate, 2) // Round down to 2 decimal places
       pppAdditionalRateAllocatedIncome = 0
       remainingBasicRateBand = 0
       remainingHigherRateBand = pppHigherRateLimit – pppBasicRateThreshold - pppHigherRateAllocatedIncome
    else
       pppBasicRateAllocatedIncome = pppBasicRateLimit
       pppBasicRateTax = floor(pppBasicRateAllocatedIncome \* pppBasicRate, 2) // Round down to 2 decimal places
       pppHigherRateAllocatedIncome = pppHigherRateLimit - pppBasicRateThreshold
       pppHigherRateTax = floor(pppHigherRateAllocatedIncome \* pppHigherRate, 2) // Round down to 2 decimal places
       pppAdditionalRateAllocatedIncome = totalPayPensionsProfitTaxableIncome - (pppBasicRateLimit + pppHigherRateLimit)
       pppAdditionalRateTax = floor(pppAdditionalRateAllocatedIncome \* pppAdditionalRate, 2) // Round down to 2 decimal places
       remainingHigherRateBand = 0
    end if

    // Calculate total PPP tax
    totalTaxPPP = pppBasicRateTax + pppHigherRateTax + pppAdditionalRateTax
    totalTaxPPP = floor(totalTaxPPP, 2) // Rounding down to nearest penny
   </code>
</pre>

## National Insurance

For general information about National Insurance, refer to [National Insurance: introduction (GOV.UK)](https://www.gov.uk/national-insurance). For information about National Insurance rates and thresholds for self-employed customers during tax year 2024-25, refer to [Rates and allowances: National Insurance contributions (GOV.UK)](https://www.gov.uk/government/publications/rates-and-allowances-national-insurance-contributions/rates-and-allowances-national-insurance-contributions).

> **Note:** From April 2024, self-employed customers no longer have to pay Class 2 National Insurance contributions (NICs). However, they can still opt to pay Class 2 NICs voluntarily to protect eligibility for certain state benefits and to contribute to State Pension qualification.

Below is the calculation pseudocode for National Insurance.

````
// Income source
totalSelfEmploymentTaxableProfit // NICs are calculated on the combined total of profits from all of a customer's self-employment income sources

// Class 2 National Insurance threshold for tax year 2024-25 (self-employed)
smallProfitsThreshold = 6725 // Small profits threshold amount per year: £6,725 (SPT)

// Class 4 National Insurance thresholds and rates for tax year 2024-25 (self-employed)
lowerProfitsLimit = 12570 // Lower Profits Limit: £12,570 per year (LPL)
upperProfitsLimit = 50270 // Upper Profits Limit: £50,270 per year (UPL)
aboveUplRate = 2% // Rate above UPL
lplToUplRate = 6% // Rate between LPL and UPL

// Class 4 NICs exemption data
class4NicsExemptionReason // Self Employment Business API parameter to indicate a reason why a customer is exempt from paying Class 4 NICs, such as age

// Other parameters used for calculations
class2Nic // Calculated Class 2 NICs amount
class2NicAmount // Class 2 NICs amount provided by external HMRC system
class2NicLiable // Indicates if the customer is liable for Class 2 NICs
customerIsLiableToPayClass2NicsAndWantsToPayVoluntarily // Indicates if customer is liable for Class 2 NICs and has opted to pay voluntarily for state benefits or State Pension reasons
totalClass4NIC // Total calculated Class 4 NICs amount

// Initialise National Insurance Bands
niZeroRateName = "ZRT" // Zero-rate band for NI
niZeroRate = 0 // NIC rate for zero-rate band
niZeroRateLimit = lowerProfitsLimit // LPL serves as the upper limit for this band (£12,570)
niZeroRateAllocatedIncome // Income allocated to this band
niZeroRateNIC // NIC calculated for this band
niBasicRateName = "BRT" // Basic rate band for NI
niBasicRate = 6% // NIC rate for the basic rate band
niBasicRateLimit = upperProfitsLimit // UPL serves as the upper limit for this band (£50,270)
niBasicRateAllocatedIncome // Income allocated to this band
niBasicRateNIC // NIC calculated for this band
niHigherRateName = "HRT" // Higher rate band for NI
niHigherRate = 2% // NIC rate for the higher rate band
niHigherRateLimit // No upper limit for this band
niHigherRateAllocatedIncome // Income allocated to this band
niHigherRateNIC // NIC calculated for this band

// Round down totalSelfEmploymentTaxableProfit to nearest penny
totalSelfEmploymentTaxableProfit = roundDown(totalSelfEmploymentTaxableProfit, 2)

// Set up band rates for calculations
aboveUplRate = floor(2 / 100, 10) // Results in 0.0200000000
lplToUplRate = floor(6 / 100, 10) // Results in 0.0600000000

// Calculate Class 2 NICs using new rules for tax year 2024-25
if totalSelfEmploymentTaxableProfit <= smallProfitsThreshold then
    class2NicLiable = false // Customer is not liable for Class 2 NICs because total self-employment profits are below SPT
    class2Nic = 0 // No NI is due
else if totalSelfEmploymentTaxableProfit > smallProfitsThreshold and totalSelfEmploymentTaxableProfit <= lowerProfitsLimit
         class2NicLiable = false // Customer is not liable for Class 2 NICs because total profits are between SPT and LPL
         class2Nic = 0 // No NI is due because Class 2 NICs are ‘treated as paid’ for self-employment profits above SPT
else if customerIsLiableToPayClass2NicsAndWantsToPayVoluntarily then
     if class2NicAmount > 0 then // Verify that Class 2 NICs amount provided by external HMRC system is valid
        class2Nic = class2NicAmount // Valid amount provided
     else
        class2Nic = 0 // No valid amount provided
     end if
else
class2NicLiable = false // Customer is exempt and does not choose to pay voluntarily
class2Nic = 0 // No NI is due
end if

// Calculate Class 4 NICs

// Check for Class 4 NICs exemption
if class4NicsExemptionReason is not null then
    totalClass4NIC = 0 // Customer is exempt
    // No further calculations required
else if totalSelfEmploymentTaxableProfit < lowerProfitsLimit then
     totalClass4NIC = 0 // No NICs due for income below LPL
else
    // Allocate income across NI bands
    if totalSelfEmploymentTaxableProfit <= niZeroRateLimit then
    niZeroRateAllocatedIncome = totalSelfEmploymentTaxableProfit
    niZeroRateNIC = 0 // No NIC for Zero Rate Band
    remainingIncome = 0 // All income fits within Zero Rate Band
else if totalSelfEmploymentTaxableProfit > niZeroRateLimit and totalSelfEmploymentTaxableProfit <= niBasicRateLimit then
    niZeroRateAllocatedIncome = niZeroRateLimit
    niZeroRateNIC = 0 // No NIC for Zero Rate Band
    remainingIncome = totalSelfEmploymentTaxableProfit - niZeroRateLimit // Income exceeding Zero Rate Band
    niBasicRateAllocatedIncome = remainingIncome
    niBasicRateNIC = floor(niBasicRateAllocatedIncome \* niBasicRate, 2) // NIC for Basic Rate Band
else
    // Income exceeds Basic Rate Band
    niZeroRateAllocatedIncome = niZeroRateLimit
    niZeroRateNIC = 0 // No NIC for Zero Rate Band
    niBasicRateAllocatedIncome = niBasicRateLimit - niZeroRateLimit
    niBasicRateNIC = floor(niBasicRateAllocatedIncome \* niBasicRate, 2) // NIC for Basic Rate Band
    remainingIncome = totalSelfEmploymentTaxableProfit - niBasicRateLimit // Income exceeding Basic and Zero Rate Bands
    niHigherRateAllocatedIncome = remainingIncome
    niHigherRateNIC = floor(niHigherRateAllocatedIncome \* niHigherRate, 2) // NIC for Higher Rate Band
end if

// Calculate total NICs
totalClass4NIC = niZeroRateNIC + niBasicRateNIC + niHigherRateNIC
totalClass4NIC = floor(totalClass4NIC, 2) // Round down to nearest penny
````