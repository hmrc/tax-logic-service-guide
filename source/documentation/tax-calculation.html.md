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
<font color="#85994b">// Input parameter</font>
totalIncomeFromAllSources <font color="#85994b">// Refer to <a href="income-and-benefits.html#income-summary-totals">Income summary totals</a></font>
giftOfInvestmentsAndPropertyToCharity
grossGiftAidPayments
lossesAppliedToGeneralIncome
grossAnnuityPayments
qualifyingLoanInterestFromInvestments
postCessationTradeReliefs
totalPensionContributionsAllowance
totalPensionContributionsRelief

<font color="#85994b">// Other parameters used for calculations</font>
totalDeductionsForAdjustedNetIncome
adjustedNetIncome

<font color="#85994b">// Calculate totalDeductionsForAdjustedNetIncome</font>
totalDeductionsForAdjustedNetIncome = giftOfInvestmentsAndPropertyToCharity + grossGiftAidPayments + lossesAppliedToGeneralIncome + grossAnnuityPayments + qualifyingLoanInterestFromInvestments + postCessationTradeReliefs + totalPensionContributionsAllowance + totalPensionContributionsRelief

<font color="#85994b">// Calculate adjustedNetIncome</font>
adjustedNetIncome = totalIncomeFromAllSources – totalDeductionsForAdjustedNetIncome
   </code>
</pre>

## Income Tax liability – Only Pay pensions Profit

Income Tax liability is calculated based on taxable income and the applicable tax rates for different income bands.

> **Note:** This section is based on Default Ordering.

<pre>
   <code>
<font color="#85994b">// Initialise Pay Pensions Profit (PPP) Bands</font>
pppBasicRateName = "BRT" <font color="#85994b">// Basic rate band for PPP income</font>
pppBasicRate = 20% <font color="#85994b">// Tax rate for the basic rate band</font>
pppBasicRateThreshold = 37700
pppBasicRateLimit = pppBasicRateThreshold + Basic rate extension <font color="#85994b">// Upper limit of the basic rate band</font>
pppBasicRateAllocatedIncome <font color="#85994b">// Income allocated to this band</font>
pppBasicRateTax <font color="#85994b">// Tax calculated for this band</font>

pppHigherRateName = "HRT" <font color="#85994b">// Higher rate band for PPP income</font>
pppHigherRate = 40% <font color="#85994b">// Tax rate for the higher rate band</font>
pppHigherRateLimit = 125140 <font color="#85994b">// Upper limit of the higher rate band</font>
pppHigherRateAllocatedIncome <font color="#85994b">// Income allocated to this band</font>
pppHigherRateTax <font color="#85994b">// Tax calculated for this band</font>

pppAdditionalRateName = "ART" <font color="#85994b">// Additional rate band for PPP income</font>
pppAdditionalRate = 45% <font color="#85994b">// Tax rate for the additional rate band</font>
pppAdditionalRateLimit <font color="#85994b">// No upper limit for the additional rate band</font>
pppAdditionalRateAllocatedIncome <font color="#85994b">// Income allocated to this band</font>
pppAdditionalRateTax <font color="#85994b">// Tax calculated for this band</font>

<font color="#85994b">// Personal Allowance for 2024/25</font>
personalAllowance = 12570 <font color="#85994b">// £12,570 (in this scenario; it can be reduced allowance in some cases)</font>
personalAllowanceReduction <font color="#85994b">// Reduced amount in Personal Allowance</font>

<font color="#85994b">// This snippet includes allowances relevant to the example scenario presented. There are other allowances and deductions that will be applicable in an ideal scenario.</font>

<font color="#85994b">// Income Sources</font>
totalProfitFromPayPensionsProfit <font color="#85994b">// Refer to <a href="income-and-benefits.html#income-summary-totals">Income summary totals</a></font>

<font color="#85994b">// Other parameters used for calculations</font>
totalPayPensionsProfitTaxableIncome <font color="#85994b">// Taxable income from employment, pensions, self-employment profits, and property rental income after applying any deductions or allowances</font>
totalTaxPPP <font color="#85994b">// Total tax on pay, pensions, and profits</font>

<font color="#85994b">// Step 1: Allocate Personal Allowance</font>
<font color="#85994b">// Deduct Personal Allowance from non-savings income first</font>

<font color="#1d70b8">if</font> totalProfitFromPayPensionsProfit <= personalAllowance <font color="#1d70b8">then</font>
   totalPayPensionsProfitTaxableIncome = 0
<font color="#1d70b8">else</font>
    totalPayPensionsProfitTaxableIncome = totalProfitFromPayPensionsProfit – Personal Allowance
    remainingAllowance = 0
<font color="#1d70b8">end if</font>

<font color="#85994b">// Step 2: Allocate non-savings income across bands</font>
<font color="#85994b">// Basic rate band calculations</font>

<font color="#1d70b8">if</font> totalPayPensionsProfitTaxableIncome <= pppBasicRateLimit <font color="#1d70b8">then</font>
   pppBasicRateAllocatedIncome = totalPayPensionsProfitTaxableIncome
   pppBasicRateTax = roundDown(pppBasicRateAllocatedIncome \* pppBasicRate, 2) <font color="#85994b">// Round down to 2 decimal places</font>
   pppHigherRateAllocatedIncome = 0
   pppAdditionalRateAllocatedIncome = 0
   remainingBasicRateBand = pppBasicRateLimit - pppBasicRateAllocatedIncome
<font color="#1d70b8">else if</font> totalPayPensionsProfitTaxableIncome <= pppHigherRateLimit <font color="#1d70b8">then</font>
   pppBasicRateAllocatedIncome = pppBasicRateLimit
   pppBasicRateTax = roundDown(pppBasicRateAllocatedIncome \* pppBasicRate, 2) <font color="#85994b">// Round down to 2 decimal places</font>
   pppHigherRateAllocatedIncome = totalPayPensionsProfitTaxableIncome - pppBasicRateLimit
   pppHigherRateTax = roundDown(pppHigherRateAllocatedIncome \* pppHigherRate, 2) <font color="#85994b">// Round down to 2 decimal places</font>
   pppAdditionalRateAllocatedIncome = 0
   remainingBasicRateBand = 0
   remainingHigherRateBand = pppHigherRateLimit – pppBasicRateThreshold - pppHigherRateAllocatedIncome
<font color="#1d70b8">else</font>
   pppBasicRateAllocatedIncome = pppBasicRateLimit
   pppBasicRateTax = roundDown(pppBasicRateAllocatedIncome \* pppBasicRate, 2) <font color="#85994b">// Round down to 2 decimal places</font>
   pppHigherRateAllocatedIncome = pppHigherRateLimit - pppBasicRateThreshold
   pppHigherRateTax = roundDown(pppHigherRateAllocatedIncome \* pppHigherRate, 2) <font color="#85994b">// Round down to 2 decimal places</font>
   pppAdditionalRateAllocatedIncome = totalPayPensionsProfitTaxableIncome - (pppBasicRateLimit + pppHigherRateLimit)
   pppAdditionalRateTax = roundDown(pppAdditionalRateAllocatedIncome \* pppAdditionalRate, 2) <font color="#85994b">// Round down to 2 decimal places</font>
   remainingHigherRateBand = 0
<font color="#1d70b8">end if</font>

<font color="#85994b">// Calculate total PPP tax</font>
totalTaxPPP = pppBasicRateTax + pppHigherRateTax + pppAdditionalRateTax
totalTaxPPP = roundDown(totalTaxPPP, 2) <font color="#85994b">// Round down to 2 decimal places</font>
   </code>
</pre>

## National Insurance

For general information about National Insurance, refer to [National Insurance: introduction (GOV.UK)](https://www.gov.uk/national-insurance). For information about National Insurance rates and thresholds for self-employed customers during tax year 2024-25, refer to [Rates and allowances: National Insurance contributions (GOV.UK)](https://www.gov.uk/government/publications/rates-and-allowances-national-insurance-contributions/rates-and-allowances-national-insurance-contributions).

> **Note:** From April 2024, self-employed customers no longer have to pay Class 2 National Insurance contributions (NICs). However, they can still opt to pay Class 2 NICs voluntarily to protect eligibility for certain state benefits and to contribute to State Pension qualification.

Below is the calculation pseudocode for National Insurance.

<pre>
   <code>
<font color="#85994b">// Income source</font>
totalSelfEmploymentTaxableProfit <font color="#85994b">// NICs are calculated on the combined total of profits from all of a customer's self-employment income sources</font>

<font color="#85994b">// Class 2 National Insurance threshold for tax year 2024-25 (self-employed)</font>
smallProfitsThreshold = 6725 <font color="#85994b">// Small profits threshold amount per year: £6,725 (SPT)</font>

<font color="#85994b">// Class 4 National Insurance thresholds and rates for tax year 2024-25 (self-employed)</font>
lowerProfitsLimit = 12570 <font color="#85994b">// Lower Profits Limit: £12,570 per year (LPL)</font>
upperProfitsLimit = 50270 <font color="#85994b">// Upper Profits Limit: £50,270 per year (UPL)</font>
aboveUplRate = 2% <font color="#85994b">// Rate above UPL</font>
lplToUplRate = 6% <font color="#85994b">// Rate between LPL and UPL</font>

<font color="#85994b">// Class 4 NICs exemption data</font>
class4NicsExemptionReason <font color="#85994b">// Self Employment Business API parameter to indicate a reason why a customer is exempt from paying Class 4 NICs, such as age</font>

<font color="#85994b">// Other parameters used for calculations</font>
class2Nic <font color="#85994b">// Calculated Class 2 NICs amount</font>
class2NicAmount <font color="#85994b">// Class 2 NICs amount provided by external HMRC system</font>
class2NicLiable <font color="#85994b">// Indicates if the customer is liable for Class 2 NICs</font>
customerIsLiableToPayClass2NicsAndWantsToPayVoluntarily <font color="#85994b">// Indicates if customer is liable for Class 2 NICs and has opted to pay voluntarily for state benefits or State Pension reasons</font>
totalClass4NIC <font color="#85994b">// Total calculated Class 4 NICs amount</font>

<font color="#85994b">// Initialise National Insurance Bands</font>
niZeroRateName = "ZRT" <font color="#85994b">// Zero-rate band for NI</font>
niZeroRate = 0 <font color="#85994b">// NIC rate for zero-rate band</font>
niZeroRateLimit = lowerProfitsLimit <font color="#85994b">// LPL serves as the upper limit for this band (£12,570)</font>
niZeroRateAllocatedIncome <font color="#85994b">// Income allocated to this band</font>
niZeroRateNIC <font color="#85994b">// NIC calculated for this band</font>
niBasicRateName = "BRT" <font color="#85994b">// Basic rate band for NI</font>
niBasicRate = 6% <font color="#85994b">// NIC rate for the basic rate band</font>
niBasicRateLimit = upperProfitsLimit <font color="#85994b">// UPL serves as the upper limit for this band (£50,270)</font>
niBasicRateAllocatedIncome <font color="#85994b">// Income allocated to this band</font>
niBasicRateNIC <font color="#85994b">// NIC calculated for this band</font>
niHigherRateName = "HRT" <font color="#85994b">// Higher rate band for NI</font>
niHigherRate = 2% <font color="#85994b">// NIC rate for the higher rate band</font>
niHigherRateLimit <font color="#85994b">// No upper limit for this band</font>
niHigherRateAllocatedIncome <font color="#85994b">// Income allocated to this band</font>
niHigherRateNIC <font color="#85994b">// NIC calculated for this band</font>

<font color="#85994b">// Round down totalSelfEmploymentTaxableProfit to 2 decimal places</font>
totalSelfEmploymentTaxableProfit = roundDown(totalSelfEmploymentTaxableProfit, 2)

<font color="#85994b">// Set up band rates for calculations</font>
aboveUplRate = roundDown(2 / 100, 10) <font color="#85994b">// Results in 0.0200000000</font>
lplToUplRate = roundDown(6 / 100, 10) <font color="#85994b">// Results in 0.0600000000</font>

<font color="#85994b">// Calculate Class 2 NICs using new rules for tax year 2024-25</font>
<font color="#1d70b8">if</font> totalSelfEmploymentTaxableProfit <= smallProfitsThreshold <font color="#1d70b8">then</font>
    class2Nic = 0 <font color="#85994b">// No NI is due</font>
    <font color="#1d70b8">if</font>customerIsLiableToPayClass2NicsAndWantsToPayVoluntarily = true <font color="#1d70b8">then</font>
        <font color="#1d70b8">if</font> class2NicAmount > 0 <font color="#1d70b8">then</font> <font color="#85994b">// Verify that Class 2 NICs amount provided by external HMRC system is valid</font>
            class2Nic = class2NicAmount <font color="#85994b">// Valid amount provided</font>
        <font color="#1d70b8">else</font> 
            class2Nic = 0 <font color="#85994b">// No valid amount provided</font>
        <font color="#1d70b8">end if</font>
<font color="#1d70b8">else if</font> totalSelfEmploymentTaxableProfit > smallProfitsThreshold and totalSelfEmploymentTaxableProfit <= lowerProfitsLimit
    class2Nic = 0 <font color="#85994b">// No NI is due because Class 2 NICs are ‘treated as paid’ for self-employment profits above SPT</font>
<font color="#1d70b8">end if</font>

<font color="#85994b">// Calculate Class 4 NICs</font>

<font color="#85994b">// Check for Class 4 NICs exemption</font>
<font color="#1d70b8">if</font> class4NicsExemptionReason is not null <font color="#1d70b8">then</font>
    totalClass4NIC = 0 <font color="#85994b">// Customer is exempt</font>
    <font color="#85994b">// No further calculations required</font>
<font color="#1d70b8">else if</font> totalSelfEmploymentTaxableProfit < lowerProfitsLimit <font color="#1d70b8">then</font>
     totalClass4NIC = 0 <font color="#85994b">// No NICs due for income below LPL</font>
<font color="#1d70b8">else</font>
    <font color="#85994b">// Allocate income across NI bands</font>
    if totalSelfEmploymentTaxableProfit <= niZeroRateLimit <font color="#1d70b8">then</font>
    niZeroRateAllocatedIncome = totalSelfEmploymentTaxableProfit
    niZeroRateNIC = 0 <font color="#85994b">// No NIC for Zero Rate Band</font>
    remainingIncome = 0 <font color="#85994b">// All income fits within Zero Rate Band</font>
<font color="#1d70b8">else if</font> totalSelfEmploymentTaxableProfit > niZeroRateLimit and totalSelfEmploymentTaxableProfit <= niBasicRateLimit <font color="#1d70b8">then</font>
    niZeroRateAllocatedIncome = niZeroRateLimit
    niZeroRateNIC = 0 <font color="#85994b">// No NIC for Zero Rate Band</font>
    remainingIncome = totalSelfEmploymentTaxableProfit - niZeroRateLimit <font color="#85994b">// Income exceeding Zero Rate Band</font>
    niBasicRateAllocatedIncome = remainingIncome
    niBasicRateNIC = roundDown(niBasicRateAllocatedIncome \* niBasicRate, 2) <font color="#85994b">// NIC for Basic Rate Band</font>
<font color="#1d70b8">else</font>
    <font color="#85994b">// Income exceeds Basic Rate Band</font>
    niZeroRateAllocatedIncome = niZeroRateLimit
    niZeroRateNIC = 0 <font color="#85994b">// No NIC for Zero Rate Band</font>
    niBasicRateAllocatedIncome = niBasicRateLimit - niZeroRateLimit
    niBasicRateNIC = roundDown(niBasicRateAllocatedIncome \* niBasicRate, 2) <font color="#85994b">// NIC for Basic Rate Band</font>
    remainingIncome = totalSelfEmploymentTaxableProfit - niBasicRateLimit <font color="#85994b">// Income exceeding Basic and Zero Rate Bands</font>
    niHigherRateAllocatedIncome = remainingIncome
    niHigherRateNIC = roundDown(niHigherRateAllocatedIncome \* niHigherRate, 2) <font color="#85994b">// NIC for Higher Rate Band</font>
<font color="#1d70b8">end if</font>

<font color="#85994b">// Calculate total NICs</font>
totalClass4NIC = niZeroRateNIC + niBasicRateNIC + niHigherRateNIC
totalClass4NIC = roundDown(totalClass4NIC, 2) <font color="#85994b">// Round down to 2 decimal places</font>
</code>
</pre>