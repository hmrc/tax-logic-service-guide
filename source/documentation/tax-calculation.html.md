---
title: Tax calculation | Tax Logic service guide
weight: 4
description: Further details of the calculations used for income tax.
---

# Tax calculation

Income Tax is calculated by applying progressive rates to income after deducting the Personal Allowance, taking into account income bands, allowances, reliefs, and National Insurance contributions.

## Adjusted net income

Adjusted net income is total taxable income before any Personal Allowances and less certain tax reliefs. For more information, refer to [Personal Allowances: adjusted net income (GOV.UK)](https://www.gov.uk/guidance/adjusted-net-income).

Below is the calculation pseudocode for adjusted net income.

<pre>
   <code>
<font color="#85994b">// Input parameters</font>
totalIncomeFromAllSources <font color="#85994b">// Refer to Income summary totals</font>
giftOfInvestmentsAndPropertyToCharity <font color="#85994b">// Refer to Gifts to charity</font>
grossGiftAidPayments <font color="#85994b">// Refer to Gift Aid</font>
lossesAppliedToGeneralIncome <font color="#85994b">// Refer to Losses and loss claims</font>
grossAnnuityPayments <font color="#85994b">// Refer to Annuity payments</font>
qualifyingLoanInterestFromInvestments <font color="#85994b">// Refer to Losses and loss claims</font>
postCessationTradeReceipts <font color="#85994b">// Refer to totalPostCessationReceipts in Foreign and other income</font>
totalPensionContributionsAllowance <font color="#85994b">// Refer to totalPensionContributions in Pension contributions</font>
totalPensionContributionsRelief <font color="#85994b">// Refer to Pension contributions</font>

<font color="#85994b">// Other parameters used for calculations</font>
totalDeductionsForAdjustedNetIncome <font color="#85994b">// Total deductions for adjusted net income</font>
adjustedNetIncome <font color="#85994b">// Adjusted net income</font>

<font color="#85994b">// Calculate totalDeductionsForAdjustedNetIncome</font>
totalDeductionsForAdjustedNetIncome = giftOfInvestmentsAndPropertyToCharity + grossGiftAidPayments + lossesAppliedToGeneralIncome + grossAnnuityPayments + qualifyingLoanInterestFromInvestments + postCessationTradeReceipts + totalPensionContributionsAllowance + totalPensionContributionsRelief

<font color="#85994b">// Calculate adjustedNetIncome</font>
adjustedNetIncome = totalIncomeFromAllSources - totalDeductionsForAdjustedNetIncome
   </code>
</pre>

## Income Tax Liability

Income Tax Liability is calculated based on taxable income and the applicable tax rates for different income bands.

**Note:** This section is based on Default Ordering.

Below is the calculation pseudocode for Income Tax Liability (UK).

### UK

<pre>
   <code>
<font color="#85994b">// Initialise Pay Pensions Profit (PPP) Bands</font>
pppBasicRateName ="BRT" <font color="#85994b">// Basic rate </font> for PPP income. Refer to UK incomeTaxBands in the config file</font>
pppBasicRate =20% <font color="#85994b">// Basic rate band for PPP income. Refer to "BRT" rate under UK incomeTaxBands in the config file</font>
pppBasicRateLimit =37700 <font color="#85994b">// Basic rate threshold. Refer to "BRT" threshold under UK incomeTaxBands in the config file</font>
pppBasicRateAllocatedIncome <font color="#85994b">// Income allocated to this band</font>
pppBasicRateTax <font color="#85994b">// Tax calculated for this band</font>
pppHigherRateName ="HRT" <font color="#85994b">// Higher rate band for PPP income. Refer to UK incomeTaxBands in the config file</font>
pppHigherRate =40% <font color="#85994b">// Tax rate for the higher rate band. Refer to "HRT" rate under UK incomeTaxBands in the config file</font>
pppHigherRateLimit =125140 <font color="#85994b">// Upper limit of the higher rate band. Refer to "HRT" threshold under UK incomeTaxBands in the config file</font>
pppHigherRateAllocatedIncome <font color="#85994b">// Income allocated to this band</font>
pppHigherRateTax <font color="#85994b">// Tax calculated for this band</font>
pppAdditionalRateName ="ART" <font color="#85994b">// Additional rate band for PPP income. Refer to UK incomeTaxBands inthe config file</font>
pppAdditionalRate =45% <font color="#85994b">// Tax rate for the additional rate band. Refer to "ART" rate under UK incomeTaxBands in the config file</font>
pppAdditionalRateLimit = 99999999 <font color="#85994b">// No upper limit for the additional rate band. Refer to "ART" threshold under UK incomeTaxBands in the config file</font>
pppAdditionalRateAllocatedIncome <font color="#85994b">// Income allocated to this band</font>
pppAdditionalRateTax <font color="#85994b">// Tax calculated for this band</font>

<font color="#85994b">// Initialise Savings Bands</font>
savingsStartingRateName ="SSR" <font color="#85994b">// Starting rate for savings. Refer to savingsBands in the config file</font>
savingsStartingRate =0% <font color="#85994b">// Tax rate for the starting rate band. Refer to "SSR" rate under savingsBands in the config file</font>
savingsStartingRateLimit =5000 <font color="#85994b">// Maximum income for the starting rate band. Refer to "SSR" threshold under savingsBands in the config file</font>
savingsStartingRateAllocatedIncome <font color="#85994b">// Income allocated to this band</font>
savingsStartingRateTax <font color="#85994b">// Tax calculated for this band</font>
savingsPSAName ="PSA" <font color="#85994b">// Personal Savings Allowance band</font>
savingsPSARate =0% <font color="#85994b">// Tax rate for PSA band</font>
savingsPSALimit <font color="#85994b">// Maximum income covered by PSA (adjusts dynamically)</font>
psaBrtThreshold = 1000 <font color="#85994b">// PSA threshold for basic rate taxpayer. Refer to the config file</font>
psaHrtThreshold = 500 <font color="#85994b">// PSA threshold for higher rate taxpayer. Refer to the config file</font>
savingsPSA <font color="#85994b">// Income allocated to this band</font>
savingsPSATax <font color="#85994b">// Tax calculated for this band</font>
savingsBasicRateName ="BRT" <font color="#85994b">// Basic rate band for savings income. Refer to savingsBands in the config file</font>
savingsBasicRate =20% <font color="#85994b">// Tax rate for the basic rate band. Refer to "BRT" rate under savingsBands in the config file</font>
savingsBasicRateLimit =37700 <font color="#85994b">// Upper limit of the basic rate band. Refer to "BRT" threshold under savingsBands in the config file</font>
savingsBasicRateAllocatedIncome <font color="#85994b">// Income allocated to this band</font>
savingsBasicRateTax <font color="#85994b">// Tax calculated for this band</font>
savingsHigherRateName = "HRT" <font color="#85994b">// Higher rate band for savings income. Refer to savingsBands in the config file</font>
savingsHigherRate = 40% <font color="#85994b">// Tax rate for the higher rate band. Refer to "HRT" rate under savingsBands in the config file</font>
savingsHigherRateLimit = 125140 <font color="#85994b">// Upper limit of the higher rate band. Refer to "HRT" threshold under savingsBands in the config file</font>
savingsHigherRateAllocatedIncome <font color="#85994b">// Income allocated to this band</font>
savingsHigherRateTax <font color="#85994b">// Tax calculated for this band</font>
savingsAdditionalRateName = "ART" <font color="#85994b">// Additional rate band for savings income. Refer to savingsBands in the config file</font>
savingsAdditionalRate = 45% <font color="#85994b">// Tax rate for the additional rate band. Refer to "ART" rate under savingsBands in the config file</font>
savingsAdditionalRateLimit = 99999999 <font color="#85994b">// No upper limit for the additional rate band. Refer to "ART" threshold under savingsBands in the config file</font>
savingsAdditionalRateAllocatedIncome<font color="#85994b">// Income allocated to this band</font>
savingsAdditionalRateTax <font color="#85994b">// Tax calculated for this band</font>

<font color="#85994b">// Initialise Dividend Bands</font>
dividendZeroRateName = "ZRTBR" OR "ZRTHR" OR "ZRTAR" <font color="#85994b">// Zero-rate band for dividend. Refer to dividendBands in the config file</font>
dividendZeroRate =0% <font color="#85994b">// Tax rate for the zero-rate band. Refer to dividendBands in the config file</font>
dividendZeroRateLimit =500 <font color="#85994b">// Dividend allowance for tax year. Refer to dividendBands in the config file</font>
dividendZeroRateAllocatedIncome <font color="#85994b">// Income allocated to this band</font>
ZRTBRLimit <font color="#85994b">// ZRTBR limit</font>
ZRTHRLimit <font color="#85994b">// ZRTHR limit</font>
ZRTARLimit <font color="#85994b">// ZRTAR limit</font>
dividendZRTBRTax <font color="#85994b">// Tax calculated for this band</font>
dividendZRTHRTax <font color="#85994b">// Tax calculated for this band</font>
dividendZRTARTax <font color="#85994b">// Tax calculated for this band</font>
dividendBasicRateName ="BRT" <font color="#85994b">// Basic rate band for dividends. Refer to dividendBands in the config file</font>
dividendBasicRate =8.75% <font color="#85994b">// Tax rate for the basic rate band. Refer to "BRT" rate under dividendBands in the config file</font>
dividendBasicRateLimit =37700 <font color="#85994b">// Upper limit of the basic rate. Refer to "BRT" threshold under dividendBands in the config file</font>
dividendBasicRateAllocatedIncome <font color="#85994b">// Income allocated to this band</font>
dividendBasicRateTax <font color="#85994b">// Tax calculated for this band</font>
dividendHigherRateName ="HRT" <font color="#85994b">// Higher rate band for dividends. Refer to dividendBands in the config file</font>
dividendHigherRate =33.75% <font color="#85994b">// Tax rate for the higher rate band. Refer to "HRT" rate under dividendBands in the config file</font>
dividendHigherRateLimit =125140 <font color="#85994b">// Upper limit of the higher rate band. Refer to "HRT" threshold under dividendBands in the config file</font>
dividendHigherRateAllocatedIncome <font color="#85994b">// Income allocated to this band</font>
dividendHigherRateTax <font color="#85994b">// Tax calculated for this band</font>
dividendAdditionalRateName ="ART" <font color="#85994b">// Additional rate band for dividends. Refer to dividendBands in the config file</font>
dividendAdditionalRate =39.35% <font color="#85994b">// Tax rate for the additional rate band. Refer to "ART" rate under dividendBands in the config file</font>
dividendAdditionalRateLimit = 99999999 <font color="#85994b">// No upper limit for the additional rate band. Refer to "ART" threshold under dividendBands in the config file</font>
dividendAdditionalRateAllocatedIncome <font color="#85994b">// Income allocated to this band</font>
dividendAdditionalRateTax <font color="#85994b">// Tax calculated for this band</font>

<font color="#85994b">// Initialise Lump Sums Bands</font>
lumpSumBasicRateName ="BRT" <font color="#85994b">// Basic rate for lump sums. Refer to UK incomeTaxBands in the config file</font>
lumpSumBasicRate =20% <font color="#85994b">// Tax rate. Refer to "BRT" rate under UK incomeTaxBands in the config file</font>
lumpSumBasicRateLimit =37700 <font color="#85994b">// Upper limit for basic rate. Refer to "BRT" threshold under UK incomeTaxBands in the config file</font>
lumpSumBasicRateAllocatedIncome <font color="#85994b">// Income allocated to this band</font>
lumpSumBasicRateTax <font color="#85994b">// Tax calculated for this band</font>
lumpSumHigherRateName ="HRT" <font color="#85994b">// Higher rate for lump sums. Refer to UK incomeTaxBands in the config file</font>
lumpSumHigherRate =40% <font color="#85994b">// Tax rate. Refer to "HRT" rate under UK incomeTaxBands in the config file</font>
lumpSumHigherRateLimit =125140 <font color="#85994b">// Upper limit for higher rate. Refer to "HRT" threshold under UK incomeTaxBands in the config file</font>
lumpSumHigherRateAllocatedIncome <font color="#85994b">// Income allocated to this band</font>
lumpSumHigherRateTax <font color="#85994b">// Tax calculated for this band</font>
lumpSumAdditionalRateName ="ART" <font color="#85994b">// Additional rate for lump sums. Refer to UK incomeTaxBands in the config file</font>
lumpSumAdditionalRate =45% <font color="#85994b">// Tax rate. Refer to "ART" rate under UK incomeTaxBands in the config file</font>
lumpSumAdditionalRateLimit = 99999999 <font color="#85994b">// Upper limit for additional rate. Refer to "ART" threshold under UK incomeTaxBands in the config file</font>
lumpSumAdditionalRateAllocatedIncome <font color="#85994b">// Income allocated to this band. Refer to "ART" threshold under UK incomeTaxBands in the config file</font>
lumpSumAdditionalRateTax <font color="#85994b">// Tax calculated for this band</font>

<font color="#85994b">// Initialise Gains Bands
gainsStartingRateName = "SSR" <font color="#85994b">// Starting rate for gains. Refer to savingsBands in the config file</font>
gainsStartingRate = 0% <font color="#85994b">// Tax rate for the starting rate band. Refer to "SSR" rate under savingsBands in the config file</font>
gainsStartingRateLimit = 5000 <font color="#85994b">// Maximum income for the starting rate band. Refer to "SSR" threshold under savingsBands in the config file</font>
gainsStartingRateAllocatedIncome <font color="#85994b">// Income allocated to this  band</font>
gainsStartingRateTax <font color="#85994b">// Tax calculated for this band</font>
gainsPSAName = "PSA" <font color="#85994b">// Personal Savings Allowance band</font>
gainsPSARate = 0% <font color="#85994b">// Tax rate for PSA band</font>
gainsPSATax <font color="#85994b">// Tax calculated for this band</font>
gainsBasicRateName = "BRT" <font color="#85994b">// Basic rate for gains. Refer to UK incomeTaxBands in the config file</font>
gainsBasicRate = 20% <font color="#85994b">// Tax rate. Refer to "BRT" rate under UK incomeTaxBands in the config file</font>
gainsBasicRateLimit = 37700 <font color="#85994b">// Upper limit for basic rate. Refer to "BRT" threshold under UK incomeTaxBands in the config file
gainsBasicRateAllocatedIncome <font color="#85994b">// Income allocated to this band</font>
gainsBasicRateTax <font color="#85994b">// Tax calculated for this band</font>
gainsHigherRateName ="HRT" <font color="#85994b">// Higher rate for gains. Refer to UK incomeTaxBands in the config file</font>
gainsHigherRate =40% <font color="#85994b">// Tax rate. Refer to "HRT" rate under UK incomeTaxBands in the config file</font>
gainsHigherRateLimit =125140 <font color="#85994b">// Upper limit for higher rate. Refer to "HRT" threshold under UK incomeTaxBands in the config file</font>
gainsHigherRateAllocatedIncome <font color="#85994b">// Income allocated to this band</font>
gainsHigherRateTax <font color="#85994b">// Tax calculated for this band</font>
gainsAdditionalRateName ="ART" <font color="#85994b">// Additional rate for gains. Refer to UK incomeTaxBands in the config file</font>
gainsAdditionalRate =45% <font color="#85994b">// Tax rate. Refer to "ART" rate under UK incomeTaxBands in the config file</font>
gainsAdditionalRateLimit = 99999999 <font color="#85994b">// Upper limit for additional rate. Refer to "ART" threshold under UK incomeTaxBands in the config file</font>
gainsAdditionalRateAllocatedIncome <font color="#85994b">// Income allocated to this band</font>
gainsAdditionalRateTax <font color="#85994b">// Tax calculated for this band</font>
bandCategories <font color="#85994b">// Band categories for each type of income</font>
exclusions <font color="#85994b">// Band exclusions for each type of income</font>
rateExtensionList <font color="#85994b">// List containing rate exyensions</font>

<font color="#85994b">// Income Sources
totalProfitFromPayPensionsProfit <font color="#85994b">// Total profit from PayPensionsProfit. Refer to Income summary totals</font>
totalAllowancesAndDeductions <font color="#85994b">// Total allowances are used to reduce the amount of taxable income before tax is calculated. Refer to Total allowances</font>
totalSavingsIncome <font color="#85994b">// Total savings interest income before applying the Personal Savings Allowance or the starting rate for savings. Refer to Income summary totals</font>
totalDividendIncome <font color="#85994b">// Total dividend income received before applying the dividend allowance. Refer to totalDividendIncomeForUkOtherAndForeign in Income summary totals</font>
totalLumpSumsIncome <font color="#85994b">// Total lumpsums income received before applying the allowance. Refer to Employment income</font>
totalGainsIncome <font color="#85994b">// Total gains income received before applying the allowance. Refer to Top slicing relief</font>
adjustedNetIncome <font color="#85994b">// Adjusted net income. Refer to Adjusted net income</font>
personalAllowance <font color="#85994b">// Personal allowance. Refer to Personal Allowance</font>

<font color="#85994b">// Other parameters used for calculations</font>
remainingAllowance <font color="#85994b">// Remaining allowance</font>
totalPayPensionsProfitTaxableIncome <font color="#85994b">// Taxable income from employment, pensions, self-employment profits, and property rental income after applying any relevant allowances and deductions</font>
totalSavingsTaxableIncome <font color="#85994b">// Total savings interest income after applying any relevant allowances and deductions</font>
totalDividendTaxableIncome <font color="#85994b">// Taxable dividend income received after applying any relevant allowances and deductions</font>
totalLumpSumsTaxableIncome <font color="#85994b">// Taxable lumpsums income received after applying any relevant allowances and deductions</font>
totalGainsTaxableIncome <font color="#85994b">// Taxable gains income received after applying any relevant allowances and deductions</font>
remainingBasicRateBand <font color="#85994b">// Remaining basic rate band</font>
remainingHigherRateBand <font color="#85994b">// Remaining higher rate band</font>
totalTaxPPP <font color="#85994b">// Total tax on pay, pensions, and profits</font>
remainingSavingsIncome <font color="#85994b">// Remaining savings income</font>
totalSavingsTax <font color="#85994b">// Total tax calculated on savings income</font>
totalIncome<font color="#85994b">// Total income from PayPensionsProfit and savings</font>
remainingDividendIncome <font color="#85994b">// Remaining dividend income</font>
totalDividendTax <font color="#85994b">// Total tax calculated on dividend income</font>
totalLumpSumsTax <font color="#85994b">// Total tax calculated on lumpsums</font>
remainingPSA <font color="#85994b">// Remaining personal savings allowance</font>
remainingSSR <font color="#85994b">// Remaining savings starting rate limit</font>
remainingGainsTaxableIncome <font color="#85994b">// Remaining gains taxable income</font>
incomeTaxCharged <font color="#85994b">// Income tax charged</font>

-------------------------------------- Allowance deduction -------------------------------------

<font color="#85994b">// Deduct Allowances from non-savings income</font>
<font color="#1d70b8">if</font> totalProfitFromPayPensionsProfit <= totalAllowancesAndDeductions <font color="#1d70b8">then</font>
totalPayPensionsProfitTaxableIncome = 0 <font color="#85994b">// Fully covered by allowance</font>
remainingAllowance = totalAllowancesAndDeductions - totalProfitFromPayPensionsProfit
<font color="#1d70b8">else</font>
totalPayPensionsProfitTaxableIncome = totalProfitFromPayPensionsProfit - totalAllowancesAndDeductions
remainingAllowance = 0 <font color="#85994b">// No allowance left</font>
end <font color="#1d70b8">if</font>

<font color="#85994b">// Deduct remaining allowance from savings income</font>
<font color="#1d70b8">if</font> totalSavingsIncome <= remainingAllowance <font color="#1d70b8">then</font>
totalSavingsTaxableIncome = 0 <font color="#85994b">// Fully covered by remaining allowance</font>
remainingAllowance = remainingAllowance - totalSavingsIncome
<font color="#1d70b8">else</font>
totalSavingsTaxableIncome = totalSavingsIncome - remainingAllowance
remainingAllowance = 0 <font color="#85994b">// No allowance left</font>
end <font color="#1d70b8">if</font>

<font color="#85994b">// Deduct remaining allowance from dividend </font>
<font color="#1d70b8">if</font> totalDividendIncome <= remainingAllowance <font color="#1d70b8">then</font>
totalDividendTaxableIncome = 0 <font color="#85994b">// Fully covered by remaining allowance</font>
remainingAllowance = remainingAllowance - totalDividendIncome
<font color="#1d70b8">else</font>
totalDividendTaxableIncome = totalDividendIncome - remainingAllowance
remainingAllowance = 0 <font color="#85994b">// No allowance left</font>
end <font color="#1d70b8">if</font>

<font color="#85994b">// Deduct remaining allowance from lumpsums income</font>
<font color="#1d70b8">if</font> totalLumpSumsIncome <= remainingAllowance <font color="#1d70b8">then</font>
totalLumpSumsTaxableIncome = 0 <font color="#85994b">// Fully covered by remaining allowance</font>
remainingAllowance = remainingAllowance - totalLumpSumsIncome
<font color="#1d70b8">else</font>
totalLumpSumsTaxableIncome = totalLumpSumsIncome - remainingAllowance
remainingAllowance = 0 <font color="#85994b">// No allowance left</font>
end <font color="#1d70b8">if</font>

<font color="#85994b">// Deduct remaining allowance from gains income</font>
<font color="#1d70b8">if</font> totalGainsIncome <= remainingAllowance <font color="#1d70b8">then</font>
totalGainsTaxableIncome = 0 <font color="#85994b">// Fully covered by remaining allowance</font>
remainingAllowance = remainingAllowance - totalGainsIncome
<font color="#1d70b8">else</font>
totalGainsTaxableIncome = totalGainsIncome - remainingAllowance
remainingAllowance = 0 <font color="#85994b">// No allowance left</font>
end <font color="#1d70b8">if</font>

-------------------------------------- Threshold Extension -------------------------------------

<font color="#85994b">// Band categorisation and exclusions for tax adjustments</font>
bandCategories = {
pppBands: [BRT, HRT, ART],
savBands: [SSR, ZRTBR, ZRTHR, BRT, HRT, ART],
divBands: [ZRTBR, ZRTHR, ZRTAR, BRT, HRT, ART],
lumpSumBands: [BRT, HRT, ART],
gainsBands: [SSR, ZRTBR, ZRTHR, BRT, HRT, ART]
}
exclusions = {
pppBands: [SRT, ART],
savBands: [SSR, ZRTBR, ZRTHR, ART],
divBands: [ZRTBR, ZRTHR, ZRTAR, ART],
lumpSumBands: [SRT, ART],
gainsBands: [SSR, ZRTBR, ZRTHR, ART],
}
rateExtensionList = [grossGiftAidPayments, pensionContributionRelief]

<font color="#85994b">// Apply each allowance to all non-excluded bands across categories</font>
<font color="#1d70b8">for each extension in rateExtensionList:
<font color="#1d70b8">for each bands in bandCategories:
<font color="#1d70b8">for each band in bands where band not in exclusions:
band.threshold = band.threshold + allowance
end <font color="#1d70b8">for
end <font color="#1d70b8">for
end <font color="#1d70b8">for

------------------------------------ PSA and SSR Adjustment ------------------------------------

<font color="#85994b">// Determine Personal Savings Allowance (PSA)</font>
<font color="#85994b">// PSA depends on Adjusted net income: £1,000 for basic rate, £500 for higher rate, £0 for additional rate</font>
<font color="#1d70b8">if</font> adjustedNetIncome > pppHigherRateLimit <font color="#1d70b8">then</font>
savingsPSALimit = 0 <font color="#85994b">// No PSA for additional rate taxpayers</font>
<font color="#1d70b8">else if</font> adjustedNetIncome > pppBasicRateLimit <font color="#1d70b8">then</font>
savingsPSALimit = psaHrtThreshold <font color="#85994b">// Reduced PSA for higher rate taxpayers</font>
<font color="#1d70b8">else</font>
savingsPSALimit = psaBrtThreshold <font color="#85994b">// Full PSA for basic rate taxpayers</font>
end <font color="#1d70b8">if</font>

<font color="#85994b">// Adjust Starting Rate for Savings (SSR)</font>
<font color="#85994b">// Reduce SSR if non-savings income exceeds the Personal Allowance</font>
<font color="#1d70b8">if</font> totalPayPensionsProfitTaxableIncome > personalAllowance <font color="#1d70b8">then</font>
savingsStartingRateLimit = max(0, savingsStartingRateLimit - (totalPayPensionsProfitTaxableIncome -personalAllowance))
end <font color="#1d70b8">if</font>

------------------------------------ Allocation across bands -----------------------------------

<font color="#85994b">// Allocate non-savings (PPP) income</font>
<font color="#1d70b8">if</font> totalPayPensionsProfitTaxableIncome <= pppBasicRateLimit <font color="#1d70b8">then</font>
pppBasicRateAllocatedIncome = totalPayPensionsProfitTaxableIncome
pppHigherRateAllocatedIncome = 0
pppAdditionalRateAllocatedIncome = 0
<font color="#1d70b8">else if</font> totalPayPensionsProfitTaxableIncome <= pppHigherRateLimit <font color="#1d70b8">then</font>
pppBasicRateAllocatedIncome = pppBasicRateLimit
pppHigherRateAllocatedIncome = totalPayPensionsProfitTaxableIncome - pppBasicRateLimit
pppAdditionalRateAllocatedIncome = 0
<font color="#1d70b8">else</font>
pppBasicRateAllocatedIncome = pppBasicRateLimit
pppHigherRateAllocatedIncome = pppHigherRateLimit - pppBasicRateLimit
pppAdditionalRateAllocatedIncome = totalPayPensionsProfitTaxableIncome - pppHigherRateLimit
end <font color="#1d70b8">if</font>

<font color="#85994b">// Update remaining bands</font>
remainingBasicRateBand = max(pppBasicRateLimit - pppBasicRateAllocatedIncome, 0) <font color="#85994b">// Ensure non-negative value</font>
remainingHigherRateBand = max(pppHigherRateLimit - (pppBasicRateAllocatedIncome + pppHigherRateAllocatedIncome), 0) <font color="#85994b">// Ensure non-negative value</font>

<font color="#85994b">// Calculate PPP tax</font>
pppBasicRateTax = roundDown(pppBasicRateAllocatedIncome * (pppBasicRate / 100), 2) <font color="#85994b">// Round down to 2 decimal places</font>
pppHigherRateTax = roundDown(pppHigherRateAllocatedIncome * (pppHigherRate / 100), 2) <font color="#85994b">// Round down to 2 decimal places</font>
pppAdditionalRateTax = roundDown(pppAdditionalRateAllocatedIncome * (pppAdditionalRate / 100), 2) <font color="#85994b">// Round down to 2 decimal places</font>
totalTaxPPP = pppBasicRateTax + pppHigherRateTax + pppAdditionalRateTax

-------------------------------------------- Savings -------------------------------------------

<font color="#85994b">// Allocate savings income</font>
savingsPSA = min(totalSavingsTaxableIncome, savingsPSALimit)
remainingSavingsIncome = totalSavingsTaxableIncome - savingsPSA
remainingBasicRateBand = max(remainingBasicRateBand - savingsPSA - savingsStartingRateAllocatedIncome, 0) <font color="#85994b">// Ensure non-negative value</font>
<font color="#1d70b8">if</font> remainingSavingsIncome <= savingsStartingRateLimit <font color="#1d70b8">then</font>
savingsStartingRateAllocatedIncome = remainingSavingsIncome
savingsBasicRateAllocatedIncome = 0
savingsHigherRateAllocatedIncome = 0
savingsAdditionalRateAllocatedIncome = 0
<font color="#1d70b8">else if</font> remainingSavingsIncome <= (savingsStartingRateLimit + remainingBasicRateBand) <font color="#1d70b8">then</font>
savingsStartingRateAllocatedIncome = savingsStartingRateLimit
savingsBasicRateAllocatedIncome = remainingSavingsIncome - savingsStartingRateLimit
savingsHigherRateAllocatedIncome = 0
savingsAdditionalRateAllocatedIncome = 0
<font color="#1d70b8">else if</font> remainingSavingsIncome <= (savingsStartingRateLimit + remainingBasicRateBand + remainingHigherRateBand) <font color="#1d70b8">then</font>
savingsStartingRateAllocatedIncome = savingsStartingRateLimit
savingsBasicRateAllocatedIncome = remainingBasicRateBand
savingsHigherRateAllocatedIncome = remainingSavingsIncome - (savingsStartingRateLimit + remainingBasicRateBand)
savingsAdditionalRateAllocatedIncome = 0
<font color="#1d70b8">else</font>
savingsStartingRateAllocatedIncome = savingsStartingRateLimit
savingsBasicRateAllocatedIncome = remainingBasicRateBand
savingsHigherRateAllocatedIncome = remainingHigherRateBand
savingsAdditionalRateAllocatedIncome = remainingSavingsIncome - (savingsStartingRateLimit + remainingBasicRateBand + remainingHigherRateBand)
end <font color="#1d70b8">if</font>

<font color="#85994b">// Update remaining bands</font>
remainingBasicRateBand = max(remainingBasicRateBand - savingsBasicRateAllocatedIncome, 0) <font color="#85994b">// Ensure non-negative value</font>
remainingHigherRateBand = max(remainingHigherRateBand - savingsHigherRateAllocatedIncome, 0) <font color="#85994b">// Ensure non-negative value</font>

<font color="#85994b">// Calculate savings tax</font>
savingsStartingRateTax = roundDown(savingsStartingRateAllocatedIncome * (savingsStartingRate / 100), 2) <font color="#85994b">// Round down to 2 decimal places</font>
savingsPSATax = roundDown(savingsPSA * (savingsPSARate / 100), 2) <font color="#85994b">// Round down to 2 decimal places</font>
savingsBasicRateTax = roundDown(savingsBasicRateAllocatedIncome * (savingsBasicRate / 100), 2) <font color="#85994b">// Round down to 2 decimal places</font>
savingsHigherRateTax = roundDown(savingsHigherRateAllocatedIncome * (savingsHigherRate / 100), 2) <font color="#85994b">// Round down to 2 decimal places</font>
savingsAdditionalRateTax = roundDown(savingsAdditionalRateAllocatedIncome * (savingsAdditionalRate / 100), 2) <font color="#85994b">// Round down to 2 decimal places</font>
totalSavingsTax = savingsStartingRateTax + savingsPSATax + savingsBasicRateTax + savingsHigherRateTax + savingsAdditionalRateTax <font color="#85994b">// Round down to 2 decimal places</font>

------------------------------------------- Dividends ------------------------------------------

<font color="#85994b">// Calculate total income for dividend band logic</font>
totalIncome = totalPayPensionsProfitTaxableIncome + totalSavingsTaxableIncome

<font color="#85994b">// Dynamic allocation of ZRT based on totalIncome across thresholds</font>
<font color="#1d70b8">if</font> totalIncome + dividendZeroRateLimit <= dividendBasicRateLimit <font color="#1d70b8">then</font>
ZRTBRLimit = dividendZeroRateLimit
ZRTHRLimit = 0
ZRTARLimit = 0
<font color="#1d70b8">else if</font> (totalIncome < dividendBasicRateLimit) and (totalIncome + dividendZeroRateLimit > dividendBasicRateLimit) <font color="#1d70b8">then</font>
ZRTBRLimit = max(dividendBasicRateLimit -- totalIncome, 0) <font color="#85994b">// Ensure non-negative value</font>
ZRTHRLimit = dividendZeroRateLimit - ZRTBRLimit
ZRTARLimit = 0
<font color="#1d70b8">else if</font> (totalIncome >= dividendBasicRateLimit) and (totalIncome + dividendZeroRateLimit <= dividendHigherRateLimit) <font color="#1d70b8">then</font>
ZRTBRLimit = 0
ZRTHRLimit = dividendZeroRateLimit
ZRTARLimit = 0
<font color="#1d70b8">else if</font> (totalIncome < dividendAdditionalRateLimit) and (totalIncome + dividendZeroRateLimit > dividendHigherRateLimit) <font color="#1d70b8">then</font>
ZRTBRLimit = 0
ZRTHRLimit = max(dividendHigherRateLimit -- totalIncome, 0) <font color="#85994b">// Ensure non-negative value</font>
ZRTARLimit = dividendZeroRateLimit - ZRTHRLimit
<font color="#1d70b8">else</font>
ZRTBRLimit = 0
ZRTHRLimit = 0
ZRTARLimit = dividendZeroRateLimit
end <font color="#1d70b8">if</font>

<font color="#85994b">// Allocate taxable dividend income (Zero Rate)</font>
dividendZeroRateAllocatedIncome = ZRTBRLimit + ZRTHRLimit + ZRTARLimit
remainingDividendIncome = totalDividendTaxableIncome -- dividendZeroRateAllocatedIncome
remainingBasicRateBand = max(remainingBasicRateBand - ZRTBRLimit, 0) <font color="#85994b">// Ensure non-negative value</font>
remainingHigherRateBand = max(remainingHigherRateBand - dividendZeroRateAllocatedIncome - remainingBasicRateBand, 0) <font color="#85994b">// Ensure non-negative value</font>

<font color="#85994b">// Allocate taxable dividend income (remaining)</font>
<font color="#1d70b8">if</font> remainingDividendIncome <= remainingBasicRateBand <font color="#1d70b8">then</font>
dividendBasicRateAllocatedIncome = remainingDividendIncome
dividendHigherRateAllocatedIncome = 0
dividendAdditionalRateAllocatedIncome = 0
<font color="#1d70b8">else if</font> remainingDividendIncome <= (remainingBasicRateBand + remainingHigherRateBand) <font color="#1d70b8">then</font>
dividendBasicRateAllocatedIncome = remainingBasicRateBand
dividendHigherRateAllocatedIncome = remainingDividendIncome - remainingBasicRateBand
dividendAdditionalRateAllocatedIncome = 0
<font color="#1d70b8">else</font>
dividendBasicRateAllocatedIncome = remainingBasicRateBand
dividendHigherRateAllocatedIncome = remainingHigherRateBand
dividendAdditionalRateAllocatedIncome = remainingDividendIncome - (remainingBasicRateBand + remainingHigherRateBand + dividendZeroRateAllocatedIncome)
end <font color="#1d70b8">if</font>

<font color="#85994b">// Update remaining bands</font>
remainingBasicRateBand = max(remainingBasicRateBand - dividendBasicRateAllocatedIncome, 0) <font color="#85994b">// Ensure non-negative value</font>
remainingHigherRateBand = max(remainingHigherRateBand - dividendHigherRateAllocatedIncome, 0) <font color="#85994b">// Ensure non-negative value</font>

<font color="#85994b">// Calculate dividend tax</font>
dividendZRTBRTax = roundDown(ZRTBRLimit * (dividendZeroRate / 100), 2) <font color="#85994b">// Round down to 2 decimal places</font>
dividendZRTHRTax = roundDown(ZRTHRLimit * (dividendZeroRate / 100), 2) <font color="#85994b">// Round down to 2 decimal places</font>
dividendZRTARTax = roundDown(ZRTARLimit * (dividendZeroRate / 100), 2) <font color="#85994b">// Round down to 2 decimal places</font>
dividendBasicRateTax = roundDown(dividendBasicRateAllocatedIncome * (dividendBasicRate / 100), 2) <font color="#85994b">// Round down to 2 decimal places</font>
dividendHigherRateTax = roundDown(dividendHigherRateAllocatedIncome * (dividendHigherRate / 100), 2) <font color="#85994b">// Round down to 2 decimal places</font>
dividendAdditionalRateTax = roundDown(dividendAdditionalRateAllocatedIncome * (dividendAdditionalRate / 100), 2) <font color="#85994b">// Round down to 2 decimal places</font>
totalDividendTax = dividendZRTBRTax + dividendZRTHRTax + dividendZRTARTax + dividendBasicRateTax + dividendHigherRateTax + dividendAdditionalRateTax

------------------------------------------- Lump sums ------------------------------------------

<font color="#85994b">// Allocate lump sum income</font>
<font color="#1d70b8">if</font> totalLumpSumsTaxableIncome <= remainingBasicRateBand <font color="#1d70b8">then</font>
lumpSumBasicRateAllocatedIncome = totalLumpSumsTaxableIncome
lumpSumHigherRateAllocatedIncome = 0
lumpSumAdditionalRateAllocatedIncome = 0
<font color="#1d70b8">else if</font> totalLumpSumsTaxableIncome <= (remainingBasicRateBand + remainingHigherRateBand) <font color="#1d70b8">then</font>
lumpSumBasicRateAllocatedIncome = remainingBasicRateBand
lumpSumHigherRateAllocatedIncome = totalLumpSumsTaxableIncome - remainingBasicRateBand
lumpSumAdditionalRateAllocatedIncome = 0
<font color="#1d70b8">else</font>
lumpSumBasicRateAllocatedIncome = remainingBasicRateBand
lumpSumHigherRateAllocatedIncome = remainingHigherRateBand
lumpSumAdditionalRateAllocatedIncome = totalLumpSumsTaxableIncome - (remainingBasicRateBand + remainingHigherRateBand)
end <font color="#1d70b8">if</font>

<font color="#85994b">// Update remaining bands</font>
remainingBasicRateBand = max(remainingBasicRateBand - lumpSumBasicRateAllocatedIncome, 0) <font color="#85994b">// Ensure non-negative value</font>
remainingHigherRateBand = max(remainingHigherRateBand - lumpSumHigherRateAllocatedIncome, 0) <font color="#85994b">// Ensure non-negative value</font>

<font color="#85994b">// Calculate lump sum tax</font>
lumpSumBasicRateTax = roundDown(lumpSumBasicRateAllocatedIncome * (lumpSumBasicRate / 100), 2) <font color="#85994b">// Round down to 2 decimal places</font>
lumpSumHigherRateTax = roundDown(lumpSumHigherRateAllocatedIncome * (lumpSumHigherRate / 100), 2) <font color="#85994b">// Round down to 2 decimal places</font>
lumpSumAdditionalRateTax = roundDown(lumpSumAdditionalRateAllocatedIncome * (lumpSumAdditionalRate / 100), 2) <font color="#85994b">// Round down to 2 decimal places</font>
totalLumpSumsTax = lumpSumBasicRateTax + lumpSumHigherRateTax + lumpSumAdditionalRateTax

--------------------------------------------- Gains --------------------------------------------

<font color="#85994b">// Adjust the bands</font>
remainingPSA = savingsPSALimit - savingsPSA
remainingSSR = savingsStartingRateLimit - savingsStartingRateAllocatedIncome
remainingGainsTaxableIncome = totalGainsTaxableIncome - remainingPSA
remainingBasicRateBand = max(remainingBasicRateBand - remainingPSA - remainingSSR, 0) <font color="#85994b">// Ensure non-negative value</font>

<font color="#85994b">// Allocate gains income</font>
<font color="#1d70b8">if</font> remainingGainsTaxableIncome <= remainingSSR <font color="#1d70b8">then</font>
gainsStartingRateAllocatedIncome = remainingGainsTaxableIncome
gainsBasicRateAllocatedIncome = 0
gainsHigherRateAllocatedIncome = 0
gainsAdditionalRateAllocatedIncome = 0
<font color="#1d70b8">if</font> remainingGainsTaxableIncome <= remainingBasicRateBand <font color="#1d70b8">then</font>
gainsStartingRateAllocatedIncome = remainingSSR
gainsBasicRateAllocatedIncome = remainingGainsTaxableIncome
gainsHigherRateAllocatedIncome = 0
gainsAdditionalRateAllocatedIncome = 0
<font color="#1d70b8">else if</font> remainingGainsTaxableIncome <= (remainingBasicRateBand + remainingHigherRateBand) <font color="#1d70b8">then</font>
gainsStartingRateAllocatedIncome = remainingSSR
gainsBasicRateAllocatedIncome = remainingBasicRateBand
gainsHigherRateAllocatedIncome = remainingGainsTaxableIncome - remainingBasicRateBand
gainsAdditionalRateAllocatedIncome = 0
<font color="#1d70b8">else</font>
gainsStartingRateAllocatedIncome = remainingSSR
gainsBasicRateAllocatedIncome = remainingBasicRateBand
gainsHigherRateAllocatedIncome = remainingHigherRateBand
gainsAdditionalRateAllocatedIncome = remainingGainsTaxableIncome - (savingsStartingRateLimit + remainingBasicRateBand + remainingHigherRateBand)
end <font color="#1d70b8">if</font>

<font color="#85994b">// Calculate gains tax</font>
gainsStartingRateTax = roundDown(gainsStartingRateAllocatedIncome * (gainsStartingRate / 100), 2) <font color="#85994b">// Round down to 2 decimal places</font>
gainsPSATax = roundDown(remainingPSA * (gainsPSARate / 100), 2) <font color="#85994b">// Round down to 2 decimal places</font>
gainsBasicRateTax = roundDown(gainsBasicRateAllocatedIncome * (gainsBasicRate / 100), 2) <font color="#85994b">// Round down to 2 decimal places</font>
gainsHigherRateTax = roundDown(gainsHigherRateAllocatedIncome * (gainsHigherRate / 100), 2) <font color="#85994b">// Round down to 2 decimal places</font>
gainsAdditionalRateTax = roundDown(gainsAdditionalRateAllocatedIncome * (gainsAdditionalRate / 100), 2) <font color="#85994b">// Round down to 2 decimal places</font>
totalGainsTax = gainsStartingRateTax + gainsPSATax + gainsBasicRateTax + gainsHigherRateTax + gainsAdditionalRateTax

<font color="#85994b">// Final calculation
incomeTaxCharged = totalTaxPPP + totalSavingsTax + totalDividendTax + totalLumpSumsTax + totalGainsTax
   </code>
</pre>

### Scottish Tax Liability

<pre>
   <code>
<font color="#85994b">// Initialise Pay Pensions Profit (PPP) Bands</font>
pppStarterRateName = "SRT" <font color="#85994b">// Starter rate band for PPP income. Refer to Scotland incomeTaxBands in the config file</font>
pppStarterRate = 19% <font color="#85994b">// Starter rate for PPP income. Refer to "SRT" rate under Scotland incomeTaxBands in the config file</font>
pppStarterRateLimit = 2306 <font color="#85994b">// Starter rate threshold. Refer to "SRT" threshold under Scotland incomeTaxBands in the config file</font>
pppStarterRateAllocatedIncome <font color="#85994b">// Income allocated to this band</font> 
pppStarterRateTax <font color="#85994b">// Tax calculated for this band</font>
pppBasicRateName = "BRT" <font color="#85994b">// Basic rate band for PPP income. Refer to Scotland incomeTaxBands in the config file</font>
pppBasicRate = 20% <font color="#85994b">// Basic rate for PPP income. Refer to "BRT" rate under Scotland incomeTaxBands in the config file</font>
pppBasicRateLimit = 13991 <font color="#85994b">// Basic rate threshold. Refer to "BRT" threshold under Scotland incomeTaxBands in the config file</font>
pppBasicRateAllocatedIncome <font color="#85994b">// Income allocated to this band</font> 
pppBasicRateTax <font color="#85994b">// Tax calculated for this band</font>
pppIntermediateRateName = "IRT" <font color="#85994b">// Intermediate rate band for PPP income. Refer to Scotland incomeTaxBands in the config file</font>
pppIntermediateRate = 21% <font color="#85994b">// Intermediate rate for PPP income. Refer to "IRT" rate under Scotland incomeTaxBands in the config file</font>
pppIntermediateRateLimit = 31092 <font color="#85994b">// Intermediate rate threshold. Refer to "IRT" threshold under Scotland incomeTaxBands in the config file</font>
pppIntermediateRateAllocatedIncome <font color="#85994b">// Income allocated to this band</font> 
pppIntermediateRateTax <font color="#85994b">// Tax calculated for this band</font>
pppHigherRateName = "HRT" <font color="#85994b">// Higher rate band for PPP income. Refer to Scotland incomeTaxBands in the config file</font>
pppHigherRate = 42% <font color="#85994b">// Higher rate for PPP income. Refer to "HRT" rate under Scotland incomeTaxBands in the config file</font>
pppHigherRateLimit = 62430 <font color="#85994b">// Higher rate threshold. Refer to "HRT" threshold under Scotland incomeTaxBands in the config file</font>
pppHigherRateAllocatedIncome <font color="#85994b">// Income allocated to this band</font> 
pppHigherRateTax <font color="#85994b">// Tax calculated for this band</font>
pppAdvancedRateName = "AVRT" <font color="#85994b">// Advanced rate band for PPP income. Refer to Scotland incomeTaxBands in the config file</font>
pppAdvancedRate = 45% <font color="#85994b">// Advanced rate for PPP income. Refer to "AVRT" rate under Scotland incomeTaxBands in the config file</font>
pppAdvancedRateLimit = 125140 <font color="#85994b">// Advanced rate threshold. Refer to "AVRT" threshold under Scotland incomeTaxBands in the config file</font>
pppAdvancedRateAllocatedIncome <font color="#85994b">// Income allocated to this band</font> 
pppAdvancedRateTax <font color="#85994b">// Tax calculated for this band</font>
pppAdditionalRateName = "ART" <font color="#85994b">// Additional rate band for PPP income. Refer to Scotland incomeTaxBands in the config file</font>
pppAdditionalRate = 48% <font color="#85994b">// Additional rate for PPP income. Refer to "ART" rate under Scotland incomeTaxBands in the config file</font>
pppAdditionalRateLimit = 99999999 <font color="#85994b">// No upper limit for the additional rate band. Refer to "ART" threshold under Scotland incomeTaxBands in the config file</font>
pppAdditionalRateAllocatedIncome <font color="#85994b">// Income allocated to this band</font> 
pppAdditionalRateTax <font color="#85994b">// Tax calculated for this band</font>

<font color="#85994b">// Initialise Savings Bands
savingsStartingRateName ="SSR" <font color="#85994b">// Starting rate for savings. Refer to savingsBands in the config file</font>
savingsStartingRate =0% <font color="#85994b">// Tax rate for the starting rate band. Refer to "SSR" rate under savingsBands in the config file</font>
savingsStartingRateLimit =5000 <font color="#85994b">// Maximum income for the starting rate band. Refer to "SSR" threshold under savingsBands in the config file</font>
savingsStartingRateAllocatedIncome <font color="#85994b">// Income allocated to this band</font>
savingsStartingRateTax <font color="#85994b">// Tax calculated for this band</font>
savingsPSAName ="PSA"<font color="#85994b">// Personal Savings Allowance band</font>   
savingsPSARate =0% <font color="#85994b">// Tax rate for PSA band</font>    
savingsPSALimit <font color="#85994b">// Maximum income covered by PSA (adjusts dynamically)
psaBrtThreshold = 1000 <font color="#85994b">// PSA threshold for basic rate taxpayer. Refer to the config file</font>
psaHrtThreshold = 500<font color="#85994b">// PSA threshold for higher rate taxpayer. Refer to the config file</font>
savingsPSA <font color="#85994b">// Income allocated to this band</font>    
savingsPSATax <font color="#85994b">// Tax calculated for this band</font>
savingsBasicRateName = "BRT" <font color="#85994b">// Basic rate band for savings income. Refer to savingsBands in the config file</font>
savingsBasicRate = 20% <font color="#85994b">// Tax rate for the basic rate band. Refer to "BRT" rate under savingsBands in the config file</font>
savingsBasicRateLimit = 37700 <font color="#85994b">// Upper limit of the basic rate band. Refer to "BRT" threshold under savingsBands in the config file</font>
savingsBasicRateAllocatedIncome <font color="#85994b">// Income allocated to this band</font> 
savingsBasicRateTax <font color="#85994b">// Tax calculated for this band</font>
savingsHigherRateName = "HRT" <font color="#85994b">// Higher rate band for savings income. Refer to savingsBands in the config file</font>
savingsHigherRate = 40% <font color="#85994b">// Tax rate for the higher rate band. Refer to "HRT" rate under savingsBands in the config file</font>
savingsHigherRateLimit = 125140 <font color="#85994b">// Upper limit of the higher rate band. Refer to "HRT" threshold under savingsBands in the config file</font>
savingsHigherRateAllocatedIncome <font color="#85994b">// Income allocated to this band</font> 
savingsHigherRateTax <font color="#85994b">// Tax calculated for this band</font>
savingsAdditionalRateName = "ART" <font color="#85994b">// Additional rate band for savings income. Refer to savingsBands in the config file</font>
savingsAdditionalRate = 45% <font color="#85994b">// Tax rate for the additional rate band. Refer to "ART" rate under savingsBands in the config file</font>
savingsAdditionalRateLimit = 99999999<font color="#85994b">// No upper limit for the additional rate band. Refer to "ART" threshold under savingsBands in the config file</font>
savingsAdditionalRateAllocatedIncome <font color="#85994b">// Income allocated to this band</font> 
savingsAdditionalRateTax <font color="#85994b">// Tax calculated for this band</font>

<font color="#85994b">// Initialise Dividend Bands
dividendZeroRateName = "ZRTBR" OR "ZRTHR" OR "ZRTAR" <font color="#85994b">// Zero-rate band for dividend. Refer to dividendBands in the config file</font>
dividendZeroRate =0% <font color="#85994b">// Tax rate for the zero-rate band. Refer to dividendBands in the config file</font>
dividendZeroRateLimit =500 <font color="#85994b">// Dividend allowance for tax year. Refer to dividendBands in the config file</font>
dividendZeroRateAllocatedIncome <font color="#85994b">// Income allocated to this band</font>
ZRTBRLimit <font color="#85994b">// ZRTBR limit</font>
ZRTHRLimit <font color="#85994b">// ZRTHR limit</font>
ZRTARLimit <font color="#85994b">// ZRTAR limit</font>
dividendZRTBRTax <font color="#85994b">// Tax calculated for this band</font>
dividendZRTHRTax <font color="#85994b">// Tax calculated for this band</font>
dividendZRTARTax <font color="#85994b">// Tax calculated for this band</font>
dividendBasicRateName = "BRT" <font color="#85994b">// Basic rate band for dividends. Refer to dividendBands in the config file</font>
dividendBasicRate = 8.75% <font color="#85994b">// Tax rate for the basic rate band. Refer to "BRT" rate under dividendBands in the config file</font>
dividendBasicRateLimit = 37700 <font color="#85994b">// Upper limit of the basic rate. Refer to "BRT" threshold under dividendBands in the config file</font>
dividendBasicRateAllocatedIncome <font color="#85994b">// Income allocated to this band</font> 
dividendBasicRateTax <font color="#85994b">// Tax calculated for this band</font>
dividendHigherRateName = "HRT" <font color="#85994b">// Higher rate band for dividends. Refer to dividendBands in the config file</font>
dividendHigherRate = 33.75% <font color="#85994b">// Tax rate for the higher rate band. Refer to "HRT" rate under dividendBands in the config file</font>
dividendHigherRateLimit = 125140 <font color="#85994b">// Upper limit of the higher rate band. Refer to "HRT" threshold under dividendBands in the config file</font>
dividendHigherRateAllocatedIncome <font color="#85994b">// Income allocated to this band</font> 
dividendHigherRateTax <font color="#85994b">// Tax calculated for this band</font>
dividendAdditionalRateName = "ART" <font color="#85994b">// Additional rate band for dividends. Refer to dividendBands in the config file</font>
dividendAdditionalRate = 39.35% <font color="#85994b">// Tax rate for the additional rate band. Refer to "ART" rate under dividendBands in the config file</font>
dividendAdditionalRateLimit = 99999999<font color="#85994b">// No upper limit for the additional rate band. Refer to "ART" threshold under dividendBands in the config file</font>
dividendAdditionalRateAllocatedIncome <font color="#85994b">// Income allocated to this band</font> 
dividendAdditionalRateTax <font color="#85994b">// Tax calculated for this band</font>

<font color="#85994b">// Initialise Lumpsums Bands</font>
lumpSumStarterRateName = "SRT" <font color="#85994b">// Starter rate band for lump sums. Refer to Scotland incomeTaxBands in the config file</font>
lumpSumStarterRate = 19% <font color="#85994b">// Starter rate for lump sums. Refer to "SRT" rate under Scotland incomeTaxBands in the config file</font>
lumpSumStarterRateLimit = 2306<font color="#85994b">// Starter rate threshold. Refer to "SRT" threshold under Scotland incomeTaxBands in the config file</font>
lumpSumStarterRateAllocatedIncome <font color="#85994b">// Income allocated to this band</font> 
lumpSumStarterRateTax <font color="#85994b">// Tax calculated for this band</font>
lumpSumBasicRateName = "BRT" <font color="#85994b">// Basic rate band for lump sums. Refer to Scotland incomeTaxBands in the config file</font>
lumpSumBasicRate = 20% <font color="#85994b">// Basic rate for lump sums. Refer to "BRT" rate under Scotland incomeTaxBands in the config file</font>
lumpSumBasicRateLimit = 13991 <font color="#85994b">// Basic rate threshold. Refer to "BRT" threshold under Scotland incomeTaxBands in the config file</font>
lumpSumBasicRateAllocatedIncome <font color="#85994b">// Income allocated to this band</font> 
lumpSumBasicRateTax <font color="#85994b">// Tax calculated for this band</font>
lumpSumIntermediateRateName = "IRT" <font color="#85994b">// Intermediate rate band for lump sums. Refer to Scotland incomeTaxBands in the config file</font>
lumpSumIntermediateRate = 21% <font color="#85994b">// Intermediate rate for lump sums. Refer to "IRT" rate under Scotland incomeTaxBands in the config file</font>
lumpSumIntermediateRateLimit = 31092 <font color="#85994b">//Intermediate rate threshold. Refer to "IRT" threshold under Scotland incomeTaxBands in the config file</font>
lumpSumIntermediateRateAllocatedIncome <font color="#85994b">// Income allocated to this band</font> 
lumpSumIntermediateRateTax <font color="#85994b">// Tax calculated for this band</font>
lumpSumHigherRateName = "HRT" <font color="#85994b">// Higher rate band for lump sums. Refer to Scotland incomeTaxBands in the config file</font>
lumpSumHigherRate = 42% <font color="#85994b">// Higher rate for lump sums. Refer to "HRT" rate under Scotland incomeTaxBands in the config file</font>
lumpSumHigherRateLimit = 62430 <font color="#85994b">// Higher rate threshold. Refer to "HRT" threshold under Scotland incomeTaxBands in the config file</font>
lumpSumHigherRateAllocatedIncome <font color="#85994b">// Income allocated to this band</font> 
lumpSumHigherRateTax <font color="#85994b">// Tax calculated for this band</font>
lumpSumAdvancedRateName = "AVRT" <font color="#85994b">// Advanced rate band for lump sums. Refer to Scotland incomeTaxBands in the config file</font>
lumpSumAdvancedRate = 45% Refer to "AVRT" rate under Scotland incomeTaxBands in the config file</font>
lumpSumAdvancedRateLimit = 125140<font color="#85994b">// Advanced rate threshold. Refer to "AVRT" threshold under Scotland incomeTaxBands in the config file</font>
lumpSumAdvancedRateAllocatedIncome <font color="#85994b">// Income allocated to this band</font> 
lumpSumAdvancedRateTax <font color="#85994b">// Tax calculated for this band</font> 
lumpSumAdditionalRateName = "ART" <font color="#85994b">// Additional rate band for PPP income. Refer to Scotland incomeTaxBands in the config file</font>
lumpSumAdditionalRate = 48% <font color="#85994b">// Additional rate for PPP income. Refer to "ART" rate under Scotland incomeTaxBands in the config file</font>
lumpSumAdditionalRateLimit = 99999999 <font color="#85994b">// No upper limit for the additional rate band. Refer to "ART" threshold under Scotland incomeTaxBands in the config file</font>
lumpSumAdditionalRateAllocatedIncome <font color="#85994b">// Income allocated to this band</font> 
lumpSumAdditionalRateTax <font color="#85994b">// Tax calculated for this band</font>

<font color="#85994b">// Initialise Gains Bands
gainsStartingRateName = "SSR"<font color="#85994b">// Starting rate for gains. Refer to savingsBands in the config file</font>
gainsStartingRate = 0% <font color="#85994b">// Tax rate for the starting rate band. Refer to "SSR" rate under savingsBands in the config file</font>
gainsStartingRateLimit = 5000 <font color="#85994b">// Maximum income for the starting rate band. Refer to "SSR" threshold under savingsBands in the config file</font>
gainsStartingRateAllocatedIncome <font color="#85994b">// Income allocated to this band</font>
gainsStartingRateTax <font color="#85994b">// Tax calculated for this band</font>
gainsPSAName = "PSA" <font color="#85994b">// Personal Savings Allowance band</font>
gainsPSARate = 0% <font color="#85994b">// Tax rate for PSA band</font>
gainsPSATax <font color="#85994b">// Tax calculated for this band</font>
gainsBasicRateName = "BRT" <font color="#85994b">// Basic rate for gains. Refer to UK incomeTaxBands in the config file</font>
gainsBasicRate = 20% <font color="#85994b">// Tax rate. Refer to "BRT" rate under UK incomeTaxBands in the config file</font>
gainsBasicRateLimit = 37700<font color="#85994b">// Upper limit for basic rate. Refer to "BRT" threshold under UK incomeTaxBands in the config file</font>
gainsBasicRateAllocatedIncome <font color="#85994b">// Income allocated to this band</font> 
gainsBasicRateTax <font color="#85994b">// Tax calculated for this band</font>
gainsHigherRateName = "HRT" <font color="#85994b">// Higher rate for gains. Refer to UK incomeTaxBands in the config file</font>
gainsHigherRate = 40% <font color="#85994b">// Tax rate. Refer to "HRT" rate under UK incomeTaxBands in the config file</font>
gainsHigherRateLimit = 125140<font color="#85994b">// Upper limit for higher rate. Refer to "HRT" threshold under UK incomeTaxBands in the config file</font>
gainsHigherRateAllocatedIncome <font color="#85994b">// Income allocated to this band</font> 
gainsHigherRateTax <font color="#85994b">// Tax calculated for this band</font>
gainsAdditionalRateName = "ART" <font color="#85994b">// Additional rate for gains. Refer to UK incomeTaxBands in the config file</font>
gainsAdditionalRate = 45% <font color="#85994b">// Tax rate. Refer to "ART" rate under UK incomeTaxBands in the config file</font>
gainsAdditionalRateLimit = 99999999 <font color="#85994b">// Upper limit for additional rate. Refer to "ART" threshold under UK incomeTaxBands in the config file</font>
gainsAdditionalRateAllocatedIncome <font color="#85994b">// Income allocated to this band</font> 
gainsAdditionalRateTax <font color="#85994b">// Tax calculated for this band</font>
bandCategories<font color="#85994b">// Band categories for each type of income</font>
exclusions<font color="#85994b">// Band exclusions for each type of income</font>
rateExtensionList <font color="#85994b">// List containing rate extensions</font>

<font color="#85994b">// Income Sources</font>
totalProfitFromPayPensionsProfit <font color="#85994b">// Total profit from PayPensionsProfit. Refer to Income summary totals</font>
totalAllowancesAndDeductions <font color="#85994b">// Total allowances are used to reduce the amount of taxable income before tax is calculated. Refer to Total allowances</font>
totalSavingsIncome <font color="#85994b">// Total savings interest income before applying the Personal Savings Allowance or the starting rate for savings. Refer to Income summary totals</font>
totalDividendIncome <font color="#85994b">// Total dividend income received before applying the dividend allowance. Refer to totalDividendIncomeForUkOtherAndForeign in Income summary totals</font>
totalLumpSumsIncome <font color="#85994b">// Total lumpsums income received before applying the allowance.Refer to Employment income</font>
totalGainsIncome <font color="#85994b">// Total gains income received before applying the allowance. Refer to Top slicing relief</font>
adjustedNetIncome <font color="#85994b">// Adjusted net income. Refer to Adjusted net income</font>
personalAllowance <font color="#85994b">// Personal allowance. Refer to Personal Allowance</font>

<font color="#85994b">// Other parameters used for calculations</font>
remainingAllowance <font color="#85994b">// Remaining allowance</font>
totalPayPensionsProfitTaxableIncome <font color="#85994b">// Taxable income from employment, pensions, self-employment profits, and property rental income after applying any relevant allowances and deductions</font>
totalSavingsTaxableIncome <font color="#85994b">// Total savings interest income after applying any relevant allowances and deductions</font>
totalDividendTaxableIncome <font color="#85994b">// Taxable dividend income received after applying any relevant allowances and deductions</font>
totalLumpSumsTaxableIncome <font color="#85994b">// Taxable lumpsums income received after applying any relevant allowances and deductions</font>
totalGainsTaxableIncome <font color="#85994b">// Taxable gains income received after applying any relevant allowances and deductions</font>
remainingStarterRateBand <font color="#85994b">// Remaining starter rate band</font>
remainingBasicRateBand <font color="#85994b">// Remaining basic rate band</font>
remainingIntermediateRateBand <font color="#85994b">// Remaining intermediate rate band</font>
remainingHigherRateBand <font color="#85994b">// Remaining basic rate band</font>
remainingAdvancedRateBand <font color="#85994b">// Remaining basic rate band</font>
totalTaxPPP <font color="#85994b">// Total tax on pay, pensions, and profits</font>
remainingSavingsIncome <font color="#85994b">// Remaining savings income</font>
totalSavingsTax <font color="#85994b">// Total tax calculated on savings income</font>
totalIncome<font color="#85994b">// Total income from PayPensionsProfit and savings</font>
remainingDividendIncome <font color="#85994b">// Remaining dividend income</font>
totalDividendTax <font color="#85994b">// Total tax calculated on dividend income</font>
totalLumpSumsTax <font color="#85994b">// Total tax calculated on lumpsums</font>
remainingPSA <font color="#85994b">// Remaining personal savings allowance</font>
remainingSSR <font color="#85994b">// Remaining savings starting rate limit</font>
remainingGainsTaxableIncome <font color="#85994b">// Remaining gains taxable income</font>
incomeTaxCharged <font color="#85994b">// Income tax charged</font>

-------------------------------------- Allowance deduction -------------------------------------

<font color="#85994b">// Deduct Allowances from non-savings income</font>
<font color="#1d70b8">if</font> totalProfitFromPayPensionsProfit <= totalAllowancesAndDeductions <font color="#1d70b8">then</font>
totalPayPensionsProfitTaxableIncome = 0 <font color="#85994b">// Fully covered by allowance</font>
remainingAllowance = totalAllowancesAndDeductions - totalProfitFromPayPensionsProfit
<font color="#1d70b8">else</font>
totalPayPensionsProfitTaxableIncome = totalProfitFromPayPensionsProfit - totalAllowancesAndDeductions
remainingAllowance = 0 <font color="#85994b">// No allowance left</font>
end <font color="#1d70b8">if</font>

<font color="#85994b">// Deduct remaining allowance from savings income</font>
<font color="#1d70b8">if</font> totalSavingsIncome <= remainingAllowance <font color="#1d70b8">then</font>
totalSavingsTaxableIncome = 0 <font color="#85994b">// Fully covered by remaining allowance</font>
remainingAllowance = remainingAllowance - totalSavingsIncome
<font color="#1d70b8">else</font>
totalSavingsTaxableIncome = totalSavingsIncome - remainingAllowance
remainingAllowance = 0 <font color="#85994b">// No allowance left</font>
end <font color="#1d70b8">if</font>

<font color="#85994b">// Deduct remaining allowance from dividend income
<font color="#1d70b8">if</font> totalDividendIncome <= remainingAllowance <font color="#1d70b8">then</font>
totalDividendTaxableIncome = 0 <font color="#85994b">// Fully covered by remaining allowance</font>
remainingAllowance = remainingAllowance - totalDividendIncome
<font color="#1d70b8">else</font>
totalDividendTaxableIncome = totalDividendIncome - remainingAllowance
remainingAllowance = 0 <font color="#85994b">// No allowance left</font>
end <font color="#1d70b8">if</font>

<font color="#85994b">// Deduct remaining allowance from lumpsums income</font>
<font color="#1d70b8">if</font> totalLumpSumsIncome <= remainingAllowance <font color="#1d70b8">then</font>
totalLumpSumsTaxableIncome = 0 <font color="#85994b">// Fully covered by remaining allowance</font>
remainingAllowance = remainingAllowance - totalLumpSumsIncome
<font color="#1d70b8">else</font>
totalLumpSumsTaxableIncome = totalLumpSumsIncome - remainingAllowance
remainingAllowance = 0 <font color="#85994b">// No allowance left</font>
end <font color="#1d70b8">if</font>

<font color="#85994b">// Deduct remaining allowance from gains income</font>
<font color="#1d70b8">if</font> totalGainsIncome <= remainingAllowance <font color="#1d70b8">then</font>
totalGainsTaxableIncome = 0 <font color="#85994b">// Fully covered by remaining allowance</font>
remainingAllowance = remainingAllowance - totalGainsIncome
<font color="#1d70b8">else</font>
totalGainsTaxableIncome = totalGainsIncome - remainingAllowance
remainingAllowance = 0 <font color="#85994b">// No allowance left</font>
end <font color="#1d70b8">if</font>

-------------------------------------- Threshold Extension -------------------------------------

<font color="#85994b">// Band categorisation and exclusions for tax adjustments</font>
bandCategories = {
pppBands: [SRT, BRT, IRT, HRT, AVRT, ART],
savBands: [SSR, ZRTBR, ZRTHR, BRT, HRT, ART],
divBands: [ZRTBR, ZRTHR, ZRTAR, BRT, HRT, ART],
lumpSumBands: [BRT, HRT, ART],
gainsBands: [SSR, ZRTBR, ZRTHR, BRT, HRT, ART]
}
exclusions = {
pppBands [SRT, ART]
savBands [SSR, ZRTBR, ZRTHR, ART]
divBands [ZRTBR, ZRTHR, ZRTAR, ART]
lumpSumBands [SRT, IRT, HRT, AVRT, ART]
gainsBands [ART]
}
rateExtensionList = [grossGiftAidPayments, pensionContributionRelief]

<font color="#85994b">// Apply each allowance to all non-excluded bands across categories</font>
<font color="#1d70b8">for each extension in rateExtensionList:
<font color="#1d70b8">for each bands in bandCategories:
<font color="#1d70b8">for each band in bands where band not in exclusions:
band.threshold = band.threshold + allowance
end <font color="#1d70b8">for
end <font color="#1d70b8">for
end <font color="#1d70b8">for

------------------------------------ PSA and SSR Adjustment ------------------------------------

<font color="#85994b">// Determine Personal Savings Allowance (PSA)</font>
<font color="#85994b">// PSA depends on Adjusted net income: £1,000 for basic rate, £500 for higher rate, £0 for additional rate
<font color="#1d70b8">if</font> adjustedNetIncome > pppHigherRateLimit <font color="#1d70b8">then</font>
savingsPSALimit = 0 <font color="#85994b">// No PSA for additional rate taxpayers</font>
<font color="#1d70b8">else if</font> adjustedNetIncome > pppBasicRateLimit <font color="#1d70b8">then</font>
savingsPSALimit = psaHrtThreshold <font color="#85994b">// Reduced PSA for higher rate taxpayers</font>
<font color="#1d70b8">else</font>
savingsPSALimit = psaBrtThreshold <font color="#85994b">// Full PSA for basic rate taxpayers</font>
end <font color="#1d70b8">if</font>

<font color="#85994b">// Adjust Starting Rate for Savings (SSR)</font>
<font color="#85994b">// Reduce SSR if non-savings income exceeds the Personal Allowance</font>
<font color="#1d70b8">if</font> totalPayPensionsProfitTaxableIncome > personalAllowance <font color="#1d70b8">then</font>
savingsStartingRateLimit = max(0, savingsStartingRateLimit - (totalPayPensionsProfitTaxableIncome -personalAllowance))
end <font color="#1d70b8">if</font>

------------------------------------ Allocation across bands -----------------------------------

<font color="#85994b">// Allocate non-savings income across bands (with if-else statements)</font>
<font color="#1d70b8">if</font> totalPayPensionsProfitTaxableIncome <= pppStarterRateLimit <font color="#1d70b8">then</font>
pppStarterRateAllocatedIncome = totalPayPensionsProfitTaxableIncome
pppBasicRateAllocatedIncome = 0
pppIntermediateRateAllocatedIncome = 0
pppHigherRateAllocatedIncome = 0
pppAdvancedRateAllocatedIncome = 0
pppAdditionalRateAllocatedIncome = 0
<font color="#1d70b8">else if</font> totalPayPensionsProfitTaxableIncome <= pppBasicRateLimit <font color="#1d70b8">then</font>
pppStarterRateAllocatedIncome = pppStarterRateLimit
pppBasicRateAllocatedIncome = totalPayPensionsProfitTaxableIncome - pppStarterRateLimit
pppIntermediateRateAllocatedIncome = 0
pppHigherRateAllocatedIncome = 0
pppAdvancedRateAllocatedIncome = 0
pppAdditionalRateAllocatedIncome = 0
<font color="#1d70b8">else if</font> totalPayPensionsProfitTaxableIncome <= pppIntermediateRateLimit <font color="#1d70b8">then</font>
pppStarterRateAllocatedIncome = pppStarterRateLimit
pppBasicRateAllocatedIncome = pppBasicRateLimit - pppStarterRateLimit
pppIntermediateRateAllocatedIncome = totalPayPensionsProfitTaxableIncome - pppBasicRateLimit
pppHigherRateAllocatedIncome = 0
pppAdvancedRateAllocatedIncome = 0
pppAdditionalRateAllocatedIncome = 0
<font color="#1d70b8">else if</font> totalPayPensionsProfitTaxableIncome <= pppHigherRateLimit <font color="#1d70b8">then</font>
pppStarterRateAllocatedIncome = pppStarterRateLimit
pppBasicRateAllocatedIncome = pppBasicRateLimit - pppStarterRateLimit
pppIntermediateRateAllocatedIncome = pppIntermediateRateLimit - pppBasicRateLimit
pppHigherRateAllocatedIncome = totalPayPensionsProfitTaxableIncome - pppIntermediateRateLimit
pppAdvancedRateAllocatedIncome = 0
pppAdditionalRateAllocatedIncome = 0
<font color="#1d70b8">else if</font> totalPayPensionsProfitTaxableIncome <= pppAdvancedRateLimit <font color="#1d70b8">then</font>
pppStarterRateAllocatedIncome = pppStarterRateLimit
pppBasicRateAllocatedIncome = pppBasicRateLimit - pppStarterRateLimit
pppIntermediateRateAllocatedIncome = pppIntermediateRateLimit - pppBasicRateLimit
pppHigherRateAllocatedIncome = pppHigherRateLimit - pppIntermediateRateLimit
pppAdvancedRateAllocatedIncome = totalPayPensionsProfitTaxableIncome - pppHigherRateLimit
pppAdditionalRateAllocatedIncome = 0
<font color="#1d70b8">else</font>
pppStarterRateAllocatedIncome = pppStarterRateLimit
pppBasicRateAllocatedIncome = pppBasicRateLimit - pppStarterRateLimit
pppIntermediateRateAllocatedIncome = pppIntermediateRateLimit - pppBasicRateLimit
pppHigherRateAllocatedIncome = pppHigherRateLimit - pppIntermediateRateLimit
pppAdvancedRateAllocatedIncome = pppAdvancedRateLimit - pppHigherRateLimit
pppAdditionalRateAllocatedIncome = totalPayPensionsProfitTaxableIncome - pppAdvancedRateLimit
end <font color="#1d70b8">if</font>

remainingStarterRateBand = max(pppStarterRateLimit - pppStarterRateAllocatedIncome,0)
remainingBasicRateBand = max((pppBasicRateLimit - pppStarterRateLimit) - pppBasicRateAllocatedIncome,0) <font color="#85994b">// Ensure non-negative value</font>
remainingIntermediateRateBand = max((pppIntermediateRateLimit - pppBasicRateLimit) - pppIntermediateRateAllocatedIncome,0) <font color="#85994b">// Ensure non-negative value</font>
remainingHigherRateBand= max ((pppHigherRateLimit - pppIntermediateRateLimit) - pppHigherRateAllocatedIncome,0) <font color="#85994b">// Ensure non-negative value</font>
remainingAdvancedRateBand = max ((pppAdvancedRateLimit - pppHigherRateLimit) - pppAdvancedRateAllocatedIncome,0) <font color="#85994b">// Ensure non-negative value</font>

<font color="#85994b">// Calculate tax for each band</font>
pppStarterRateTax = roundDown(pppStarterRateAllocatedIncome * (pppStarterRate / 100), 2) <font color="#85994b">// Round down to 2 decimal places</font>
pppBasicRateTax = roundDown(pppBasicRateAllocatedIncome * (pppBasicRate / 100), 2) <font color="#85994b">// Round down to 2 decimal places</font>
pppIntermediateRateTax = roundDown(pppIntermediateRateAllocatedIncome * (pppIntermediateRate / 100), 2) <font color="#85994b">// Round down to 2 decimal places</font>
pppHigherRateTax = roundDown(pppHigherRateAllocatedIncome * (pppHigherRate / 100), 2) <font color="#85994b">// Round down to 2 decimal places</font>
pppAdvancedRateTax = roundDown(pppAdvancedRateAllocatedIncome * (pppAdvancedRate / 100), 2) <font color="#85994b">// Round down to 2 decimal places</font>
pppAdditionalRateTax = roundDown(pppAdditionalRateAllocatedIncome * (pppAdditionalRate / 100), 2) <font color="#85994b">// Round down to 2 decimal places</font>

<font color="#85994b">// Sum total non-savings income tax across bands</font>
totalTaxPPP = pppStarterRateTax + pppBasicRateTax + pppIntermediateRateTax + pppHigherRateTax + pppAdvancedRateTax + pppAdditionalRateTax

-------------------------------------------- Savings -------------------------------------------

<font color="#85994b">// Allocate savings income</font>
savingsPSA = min(totalSavingsTaxableIncome, savingsPSALimit)
remainingSavingsIncome = totalSavingsTaxableIncome - savingsPSA
remainingBasicRateBand = max(remainingBasicRateBand - savingsPSA - savingsStartingRateAllocatedIncome, 0) <font color="#85994b">// Ensure non-negative value</font>
<font color="#1d70b8">if</font> remainingSavingsIncome <= savingsStartingRateLimit <font color="#1d70b8">then</font>
savingsStartingRateAllocatedIncome = remainingSavingsIncome
savingsBasicRateAllocatedIncome = 0
savingsHigherRateAllocatedIncome = 0
savingsAdditionalRateAllocatedIncome = 0
<font color="#1d70b8">else if</font> remainingSavingsIncome <= (savingsStartingRateLimit + remainingBasicRateBand) <font color="#1d70b8">then</font>
savingsStartingRateAllocatedIncome = savingsStartingRateLimit
savingsBasicRateAllocatedIncome = remainingSavingsIncome - savingsStartingRateLimit
savingsHigherRateAllocatedIncome = 0
savingsAdditionalRateAllocatedIncome = 0
<font color="#1d70b8">else if</font> remainingSavingsIncome <= (savingsStartingRateLimit + remainingBasicRateBand + remainingHigherRateBand) <font color="#1d70b8">then</font>
savingsStartingRateAllocatedIncome = savingsStartingRateLimit
savingsBasicRateAllocatedIncome = remainingBasicRateBand
savingsHigherRateAllocatedIncome = remainingSavingsIncome - (savingsStartingRateLimit + remainingBasicRateBand)
savingsAdditionalRateAllocatedIncome = 0
<font color="#1d70b8">else</font>
savingsStartingRateAllocatedIncome = savingsStartingRateLimit
savingsBasicRateAllocatedIncome = remainingBasicRateBand
savingsHigherRateAllocatedIncome = remainingHigherRateBand
savingsAdditionalRateAllocatedIncome = remainingSavingsIncome - (savingsStartingRateLimit + remainingBasicRateBand + remainingHigherRateBand)
end <font color="#1d70b8">if</font>

<font color="#85994b">// Update remaining bands</font>
remainingBasicRateBand = max(remainingBasicRateBand - savingsBasicRateAllocatedIncome, 0) <font color="#85994b">// Ensure non-negative value</font>
remainingHigherRateBand = max(remainingHigherRateBand - savingsHigherRateAllocatedIncome, 0) <font color="#85994b">// Ensure non-negative value</font>

<font color="#85994b">// Calculate savings tax</font>
savingsStartingRateTax = roundDown(savingsStartingRateAllocatedIncome * (savingsStartingRate / 100), 2) <font color="#85994b">// Round down to 2 decimal places</font>
savingsPSATax = roundDown(savingsPSA * (savingsPSARate / 100), 2) <font color="#85994b">// Round down to 2 decimal places</font>
savingsBasicRateTax = roundDown(savingsBasicRateAllocatedIncome * (savingsBasicRate / 100), 2) <font color="#85994b">// Round down to 2 decimal places</font>
savingsHigherRateTax = roundDown(savingsHigherRateAllocatedIncome * (savingsHigherRate / 100), 2) <font color="#85994b">// Round down to 2 decimal places</font>
savingsAdditionalRateTax = roundDown(savingsAdditionalRateAllocatedIncome * (savingsAdditionalRate / 100), 2) <font color="#85994b">// Round down to 2 decimal places</font>

<font color="#85994b">// Sum total savings income tax across bands
totalSavingsTax = savingsStartingRateTax + savingsPSATax + savingsBasicRateTax + savingsHigherRateTax + savingsAdditionalRateTax

------------------------------------------- Dividends ------------------------------------------

<font color="#85994b">// Calculate total income for dividend band logic</font>
totalIncome = totalPayPensionsProfitTaxableIncome + totalSavingsTaxableIncome

<font color="#85994b">// Dynamic allocation of ZRT based on totalIncome across thresholds
<font color="#1d70b8">if</font> totalIncome + dividendZeroRateLimit <= dividendBasicRateLimit <font color="#1d70b8">then</font>
ZRTBRLimit = dividendZeroRateLimit
ZRTHRLimit = 0
ZRTARLimit = 0
<font color="#1d70b8">else if</font> (totalIncome < dividendBasicRateLimit) and (totalIncome + dividendZeroRateLimit > dividendBasicRateLimit) <font color="#1d70b8">then</font>
ZRTBRLimit = max(dividendBasicRateLimit - totalIncome, 0) <font color="#85994b">// Ensure non-negative value</font>
ZRTHRLimit = dividendZeroRateLimit - ZRTBRLimit
ZRTARLimit = 0
<font color="#1d70b8">else if</font> (totalIncome >= dividendBasicRateLimit) and (totalIncome + dividendZeroRateLimit <= dividendHigherRateLimit) <font color="#1d70b8">then</font>
ZRTBRLimit = 0
ZRTHRLimit = dividendZeroRateLimit
ZRTARLimit = 0
<font color="#1d70b8">else if</font> (totalIncome < dividendAdditionalRateLimit) and (totalIncome + dividendZeroRateLimit > dividendHigherRateLimit) <font color="#1d70b8">then</font>
ZRTBRLimit = 0
ZRTHRLimit = max(dividendHigherRateLimit - totalIncome, 0) <font color="#85994b">// Ensure non-negative value</font>
ZRTARLimit = dividendZeroRateLimit - ZRTHRLimit
<font color="#1d70b8">else</font>
ZRTBRLimit = 0
ZRTHRLimit = 0
ZRTARLimit = dividendZeroRateLimit
end <font color="#1d70b8">if</font>

<font color="#85994b">// Allocate taxable dividend income (Zero Rate)</font>
dividendZeroRateAllocatedIncome = ZRTBRLimit + ZRTHRLimit + ZRTARLimit
remainingDividendIncome = totalDividendTaxableIncome -- dividendZeroRateAllocatedIncome
remainingBasicRateBand = max(remainingBasicRateBand - ZRTBRLimit, 0) <font color="#85994b">// Ensure non-negative value</font>
remainingHigherRateBand = max(remainingHigherRateBand - dividendZeroRateAllocatedIncome - remainingBasicRateBand, 0) <font color="#85994b">// Ensure non-negative value</font>

<font color="#85994b">// Allocate taxable dividend income (remaining)</font>
<font color="#1d70b8">if</font> remainingDividendIncome <= remainingBasicRateBand <font color="#1d70b8">then</font>
dividendBasicRateAllocatedIncome = remainingDividendIncome
dividendHigherRateAllocatedIncome = 0
dividendAdditionalRateAllocatedIncome = 0
<font color="#1d70b8">else if</font> remainingDividendIncome <= (remainingBasicRateBand + remainingHigherRateBand) <font color="#1d70b8">then</font>
dividendBasicRateAllocatedIncome = remainingBasicRateBand
dividendHigherRateAllocatedIncome = remainingDividendIncome - remainingBasicRateBand
dividendAdditionalRateAllocatedIncome = 0
<font color="#1d70b8">else</font>
dividendBasicRateAllocatedIncome = remainingBasicRateBand
dividendHigherRateAllocatedIncome = remainingHigherRateBand
dividendAdditionalRateAllocatedIncome = remainingDividendIncome - (remainingBasicRateBand + remainingHigherRateBand - dividendZeroRateBasicRateAllocatedIncome)
end <font color="#1d70b8">if</font>

<font color="#85994b">// Update remaining bands</font>
remainingBasicRateBand = max(remainingBasicRateBand - dividendBasicRateAllocatedIncome, 0) <font color="#85994b">// Ensure non-negative value</font>
remainingHigherRateBand = max(remainingHigherRateBand - dividendHigherRateAllocatedIncome, 0) <font color="#85994b">// Ensure non-negative value</font>

<font color="#85994b">// Calculate dividend tax</font>
dividendZRTBRTax = roundDown(ZRTBRLimit * (dividendZeroRate / 100), 2) <font color="#85994b">// Round down to 2 decimal places</font>
dividendZRTHRTax = roundDown(ZRTHRLimit * (dividendZeroRate / 100), 2) <font color="#85994b">// Round down to 2 decimal places</font>
dividendZRTARTax = roundDown(ZRTARLimit * (dividendZeroRate / 100), 2) <font color="#85994b">// Round down to 2 decimal places</font>
dividendBasicRateTax = roundDown(dividendBasicRateAllocatedIncome * (dividendBasicRate / 100), 2) <font color="#85994b">// Round down to 2 decimal places</font>
dividendHigherRateTax = roundDown(dividendHigherRateAllocatedIncome * (dividendHigherRate / 100), 2) <font color="#85994b">// Round down to 2 decimal places</font>
dividendAdditionalRateTax = roundDown(dividendAdditionalRateAllocatedIncome * (dividendAdditionalRate / 100), 2) <font color="#85994b">// Round down to 2 decimal places</font>

<font color="#85994b">// Sum total dividends income tax across bands</font>
totalDividendTax = dividendZRTBRTax + dividendZRTHRTax + dividendZRTARTax + dividendBasicRateTax + dividendHigherRateTax + dividendAdditionalRateTax

------------------------------------------- Lump sums ------------------------------------------

<font color="#85994b">// Allocate lump sum income</font>
<font color="#1d70b8">if</font> totalLumpSumsTaxableIncome <= remainingStarterRateBand <font color="#1d70b8">then</font>
lumpSumStarterRateAllocatedIncome = totalLumpSumsTaxableIncome
lumpSumBasicRateAllocatedIncome = 0
lumpSumIntermediateRateAllocatedIncome = 0
lumpSumHigherRateAllocatedIncome = 0
lumpSumAdvancedRateAllocatedIncome = 0
lumpSumAdditionalRateAllocatedIncome = 0
<font color="#1d70b8">else if</font> totalLumpSumsTaxableIncome <= (remainingStarterRateBand + remainingBasicRateBand) <font color="#1d70b8">then</font>
lumpSumStarterRateAllocatedIncome = remainingStarterRateBand
lumpSumBasicRateAllocatedIncome = totalLumpSumsTaxableIncome - remainingStarterRateBand
lumpSumIntermediateRateAllocatedIncome = 0
lumpSumHigherRateAllocatedIncome = 0
lumpSumAdvancedRateAllocatedIncome = 0
lumpSumAdditionalRateAllocatedIncome = 0
<font color="#1d70b8">else if</font> totalLumpSumsTaxableIncome <= (remainingStarterRateBand + remainingBasicRateBand + remainingIntermediateRateBand) <font color="#1d70b8">then</font>
lumpSumStarterRateAllocatedIncome = remainingStarterRateBand
lumpSumBasicRateAllocatedIncome = remainingBasicRateBand
lumpSumIntermediateRateAllocatedIncome = totalLumpSumsTaxableIncome - (remainingStarterRateBand + remainingBasicRateBand)
lumpSumHigherRateAllocatedIncome = 0
lumpSumAdvancedRateAllocatedIncome = 0
lumpSumAdditionalRateAllocatedIncome = 0
<font color="#1d70b8">else if</font> totalLumpSumsTaxableIncome <= (remainingStarterRateBand + remainingBasicRateBand + remainingIntermediateRateBand + remainingHigherRateBand) <font color="#1d70b8">then</font>
lumpSumStarterRateAllocatedIncome = remainingStarterRateBand
lumpSumBasicRateAllocatedIncome = remainingBasicRateBand
lumpSumIntermediateRateAllocatedIncome = remainingIntermediateRateBand
lumpSumHigherRateAllocatedIncome = totalLumpSumsTaxableIncome - (remainingStarterRateBand + remainingBasicRateBand + remainingIntermediateRateBand)
lumpSumAdvancedRateAllocatedIncome = 0
lumpSumAdditionalRateAllocatedIncome = 0
<font color="#1d70b8">else if</font> totalLumpSumsTaxableIncome <= (remainingStarterRateBand + remainingBasicRateBand + remainingIntermediateRateBand + remainingHigherRateBand + remainingAdvancedRateBand) <font color="#1d70b8">then</font>
lumpSumStarterRateAllocatedIncome = remainingStarterRateBand
lumpSumBasicRateAllocatedIncome = remainingBasicRateBand
lumpSumIntermediateRateAllocatedIncome = remainingIntermediateRateBand
lumpSumHigherRateAllocatedIncome = remainingHigherRateBand
lumpSumAdvancedRateAllocatedIncome = totalLumpSumsTaxableIncome - (remainingStarterRateBand + remainingBasicRateBand + remainingIntermediateRateBand + remainingHigherRateBand)
lumpSumAdditionalRateAllocatedIncome = 0
<font color="#1d70b8">else</font>
lumpSumStarterRateAllocatedIncome = remainingStarterRateBand
lumpSumBasicRateAllocatedIncome = remainingBasicRateBand
lumpSumIntermediateRateAllocatedIncome = remainingIntermediateRateBand
lumpSumHigherRateAllocatedIncome = remainingHigherRateBand
lumpSumAdvancedRateAllocatedIncome = remainingAdvancedRateBand
lumpSumAdditionalRateAllocatedIncome = totalLumpSumsTaxableIncome - (remainingStarterRateBand + remainingBasicRateBand + remainingIntermediateRateBand + remainingHigherRateBand + remainingAdvancedRateBand)
end <font color="#1d70b8">if</font>

<font color="#85994b">// Update remaining bands</font>
remainingBasicRateBand = max(remainingBasicRateBand - lumpSumBasicRateAllocatedIncome, 0) <font color="#85994b">// Ensure non-negative value</font>
remainingHigherRateBand = max(remainingHigherRateBand - lumpSumHigherRateAllocatedIncome, 0) <font color="#85994b">// Ensure non-negative value</font>

<font color="#85994b">// Calculate tax for each band</font>
lumpSumStarterRateTax = roundDown(lumpSumStarterRateAllocatedIncome * (lumpSumStarterRate / 100), 2) <font color="#85994b">// Round down to 2 decimal places</font>
lumpSumBasicRateTax = roundDown(lumpSumBasicRateAllocatedIncome * (lumpSumBasicRate / 100), 2) <font color="#85994b">// Round down to 2 decimal places</font>
lumpSumIntermediateRateTax = roundDown(lumpSumIntermediateRateAllocatedIncome * (lumpSumIntermediateRate / 100), 2) <font color="#85994b">// Round down to 2 decimal places</font>
lumpSumHigherRateTax = roundDown(lumpSumHigherRateAllocatedIncome * (lumpSumHigherRate / 100), 2) <font color="#85994b">// Round down to 2 decimal places</font>
lumpSumAdvancedRateTax = roundDown(lumpSumAdvancedRateAllocatedIncome * (lumpSumAdvancedRate / 100), 2) <font color="#85994b">// Round down to 2 decimal places</font>
lumpSumAdditionalRateTax = roundDown(lumpSumAdditionalRateAllocatedIncome * (lumpSumAdditionalRate / 100), 2) <font color="#85994b">// Round down to 2 decimal places</font>

<font color="#85994b">// Sum total lump sum tax across bands</font>
totalLumpSumsTax = lumpSumStarterRateTax + lumpSumBasicRateTax + lumpSumIntermediateRateTax + lumpSumHigherRateTax + lumpSumAdvancedRateTax + lumpSumAdditionalRateTax

--------------------------------------------- Gains --------------------------------------------

<font color="#85994b">// Adjust the bands</font>
remainingPSA = savingsPSALimit - savingsPSA
remainingSSR = savingsStartingRateLimit - savingsStartingRateAllocatedIncome
remainingGainsTaxableIncome = totalGainsTaxableIncome - remainingPSA
remainingBasicRateBand = max(remainingBasicRateBand - remainingPSA - remainingSSR, 0) <font color="#85994b">// Ensure non-negative value</font>

<font color="#85994b">// Allocate gains income</font>
<font color="#1d70b8">if</font> remainingGainsTaxableIncome <= remainingSSR <font color="#1d70b8">then</font>
gainsStartingRateAllocatedIncome = remainingGainsTaxableIncome
gainsBasicRateAllocatedIncome = 0
gainsHigherRateAllocatedIncome = 0
gainsAdditionalRateAllocatedIncome = 0
<font color="#1d70b8">else if</font> remainingGainsTaxableIncome <= remainingBasicRateBand <font color="#1d70b8">then</font>
gainsStartingRateAllocatedIncome = remainingSSR
gainsBasicRateAllocatedIncome = remainingGainsTaxableIncome
gainsHigherRateAllocatedIncome = 0
gainsAdditionalRateAllocatedIncome = 0
<font color="#1d70b8">else if</font> remainingGainsTaxableIncome <= (remainingBasicRateBand + remainingHigherRateBand) <font color="#1d70b8">then</font>
gainsStartingRateAllocatedIncome = remainingSSR
gainsBasicRateAllocatedIncome = remainingBasicRateBand
gainsHigherRateAllocatedIncome = remainingGainsTaxableIncome - remainingBasicRateBand
gainsAdditionalRateAllocatedIncome = 0
<font color="#1d70b8">else</font>
gainsStartingRateAllocatedIncome = remainingSSR
gainsBasicRateAllocatedIncome = remainingBasicRateBand
gainsHigherRateAllocatedIncome = remainingHigherRateBand
gainsAdditionalRateAllocatedIncome = remainingGainsTaxableIncome - (savingsStartingRateLimit + remainingBasicRateBand + remainingHigherRateBand)
end <font color="#1d70b8">if</font>

<font color="#85994b">// Calculate gains tax</font>
gainsStartingRateTax = roundDown(gainsStartingRateAllocatedIncome * (gainsStartingRate / 100), 2) <font color="#85994b">// Round down to 2 decimal places</font>
gainsPSATax = roundDown(remainingPSA * (gainsPSARate / 100), 2) <font color="#85994b">// Round down to 2 decimal places</font>
gainsBasicRateTax = roundDown(gainsBasicRateAllocatedIncome * (gainsBasicRate / 100), 2) <font color="#85994b">// Round down to 2 decimal places</font>
gainsHigherRateTax = roundDown(gainsHigherRateAllocatedIncome * (gainsHigherRate / 100), 2) <font color="#85994b">// Round down to 2 decimal places</font>
gainsAdditionalRateTax = roundDown(gainsAdditionalRateAllocatedIncome * (gainsAdditionalRate / 100), 2) <font color="#85994b">// Round down to 2 decimal places</font>

<font color="#85994b">// Sum total gains tax across bands</font>
totalGainsTax = gainsStartingRateTax + gainsPSATax + gainsBasicRateTax + gainsHigherRateTax + gainsAdditionalRateTax

<font color="#85994b">// Final calculation</font>
incomeTaxCharged = totalTaxPPP + totalSavingsTax + totalDividendTax + totalLumpSumsTax + totalGainsTax
   </code>
</pre>

### Transitional Profits Tax Liability

> **Note:** The following is applicable for both UK and Scottish if there are transitional profits

<pre>
   <code>
<font color="#85994b">// Re-run income tax liability calculation to include Transitional Profits (TP)</font>
<font color="#85994b">// Input parameters</font>
incomeTaxCharged <font color="#85994b">// income tax liability excluding transitional profits. Refer to UK Income tax liability</font>
totalProfitFromPayPensionsProfit <font color="#85994b">// Total profit from PayPensionsProfit. Refer to Income summary totals</font>
remainingBroughtForwardIncomeTaxLosses <font color="#85994b">// Remaining brought forward income tax losses. Refer to Transitional Profits losses and loss claims</font>
transitionProfitsAfterIncomeTaxLossDeductions <font color="#85994b">// Transition profit after income tax loss deductions. Refer to Transitional Profits losses and loss claims</font>
totalTransitionProfitFromAllSE <font color="#85994b">// Total transition profit from all self employment income. Refer to Transitional Profits losses and loss claims</font>

<font color="#85994b">// Other parameters used for calculations</font>
totalBeforeReliefs_1 <font color="#85994b">// Income tax liability excluding Transitional Profits</font>
incomeTaxChargedAfterTransitionProfits <font color="#85994b">// Income tax calculated using updated totalProfitFromPayPensionsProfit</font>
totalBeforeReliefs_2 <font color="#85994b">// Income tax liability including Transitional Profits</font>

<font color="#85994b">// (1/2) Iteration:</font>
<font color="#85994b">// The first iteration calculates liability *without* TP</font>
<font color="#85994b">// Process Income Tax Liability</font>
totalBeforeReliefs_1 = incomeTaxCharged

<font color="#85994b">// (2/2) Iteration:</font>
<font color="#85994b">// This second iteration recalculates income tax liability *with* TP</font>
<font color="#85994b">// Override totalProfitFromPayPensionsProfit in Income Tax Liability Section</font>
<font color="#1d70b8">if</font> remainingBroughtForwardIncomeTaxLosses > 0 <font color="#1d70b8">then</font>
totalProfitFromPayPensionsProfit = totalProfitFromPayPensionsProfit + transitionProfitsAfterIncomeTaxLossDeductions  
<font color="#1d70b8">else</font>
    totalProfitFromPayPensionsProfit = totalProfitFromPayPensionsProfit + totalTransitionProfitFromAllSE
end <font color="#1d70b8">if</font>

<font color="#85994b">// Process Income Tax Liability</font>
<font color="#85994b">// Rerun tax liability calculation with updated totalProfitFromPayPensionsProfit</font>
totalBeforeReliefs_2 = incomeTaxChargedAfterTransitionProfits

<font color="#85994b">// Refer to Income Tax Liability Section for full band-based calculation logic
   </code>
</pre>

## Tax reductions

Tax reductions are applied after tax has been calculated on a customer's taxable income.

Below is the calculation pseudocode for total reductions.

<pre>
   <code>
<font color="#85994b">// Input parameters</font>
incomeTaxCharged <font color="#85994b">// Sum of all tax liabilities before reliefs. Refer to Income tax liability</font>
notionalTax <font color="#85994b">// Tax on income or benefits considered taxable but not received in cash</font>
totalReliefs <font color="#85994b">// Refer to Total reliefs</font>
marriageAllowanceRelief <font color="#85994b">// Refer to Marriage allowance</font>

<font color="#85994b">// Other parameters used for calculations (initialise parameters)</font>
incomeTaxDueAfterTaxReductions = 0 <font color="#85994b">// Income tax due after tax reductions</font>
netIncomeTaxDue <font color="#85994b">// Net income tax due</font>

<font color="#85994b">// Calculate the income tax charged before considering any reliefs or deductions</font>
netIncomeTaxDue = incomeTaxCharged -- totalReliefs

<font color="#85994b">// Calculate income tax due after tax reductions</font>
<font color="#85994b">// Apply notional tax and marriage allowance relief to reduce net income tax due</font>
<font color="#1d70b8">if</font> netIncomeTaxDue > 0 <font color="#1d70b8">then</font>
incomeTaxDueAfterTaxReductions = max(netIncomeTaxDue - notionalTax - marriageAllowanceRelief, 0) <font color="#85994b">// Ensure non-negative value</font>
<font color="#1d70b8">else</font>
incomeTaxDueAfterTaxReductions = 0
end <font color="#1d70b8">if</font>
   </code>
</pre>

### Tax reductions with Transitional Profits

> **Note:** The following is applicable if there are transitional profits (TP)

<pre>
   <code>
<font color="#85994b">// At this stage, two distinct income tax liability computations have been completed:</font>
<font color="#85994b">// (1) incomeTaxCharged - liability *without* transitional profits</font>
<font color="#85994b">// (2) incomeTaxChargedAfterTransitionProfits -- liability *with* transitional profits</font>

<font color="#85994b">// Input parameters</font>
incomeTaxCharged <font color="#85994b">// Income tax charged. Refer to Income tax liability</font>
totalBeforeReliefs_1 <font color="#85994b">// Income tax liability excluding transitional profits. Refer to Transitional Profits Income tax liability</font>
totalBeforeReliefs_2 <font color="#85994b">// Income tax liability including transitional profits. Refer to Transitional Profits Income tax liability</font>

<font color="#85994b">// Other parameters for calculation</font>
incomeTaxChargedOnTransitionProfits <font color="#85994b">// Income tax charged on transition profits</font>

<font color="#85994b">// Override incomeTaxCharged in tax reductions section</font>
incomeTaxCharged = totalBeforeReliefs_2

<font color="#85994b">// Calculate the difference between incomeTaxChargedAfterTransitionProfits and incomeTaxCharged reflects the tax impact of transitional profits</font>
incomeTaxChargedOnTransitionProfits = totalBeforeReliefs_2 - totalBeforeReliefs_1

## Gift Aid on Income Tax Liability

Some parameters used as inputs for self-employment calculations are in the [Individual Calculations API](https://developer.service.hmrc.gov.uk/api-documentation/docs/api/service/self-employment-business-api/) and [Individuals Reliefs API](https://developer.service.hmrc.gov.uk/api-documentation/docs/api/service/self-employment-business-api/).

Below is the calculation pseudocode for income tax liability after Gift Aid.

<font color="#85994b">// Input parameters</font>
investmentRelief = [
investmentReliefs {
uniqueInvestmentRef, <font color="#85994b">// Unique Investment Reference (UIR) or name of authorising tax office</font>
dateOfInvestment, <font color="#85994b">// date of investment</font>
amountInvested, <font color="#85994b">// Amount invested</font>
reliefClaimed <font color="#85994b">// Amount of relief claimed</font>
}
]
deficiencyReliefsAllowable <font color="#85994b">// Refer to Deficiency relief</font>
tsrReliefAmount <font color="#85994b">// Refer to Top slicing relief</font>
totalResidentialFinanceCostsRelief <font color="#85994b">// Refer to Total Residential finance costs</font>
redemptionAmountUsed <font color="#85994b">// Refer to Qualifying distribution redemption of shares and securities</font>
deficiencyReliefsAllowable <font color="#85994b">// Refer to Deficiency relief</font>
tsrReliefAmount <font color="#85994b">// Refer to Top slicing relief</font>
totalResidentialFinanceCostsRelief <font color="#85994b">// Refer to Residential finance costs</font>
redemptionAmountUsed <font color="#85994b">// Refer to Shares and securities</font>
marriageAllowanceRelief<font color="#85994b">// Refer toMarriage Allowance</font>
giftAidTaxableAmount <font color="#85994b">// Taxable amount from Gift Aid payments. Refer to Gift Aid payments</font>
notionalTax <font color="#85994b">// Tax on income or benefits considered taxable but not received in cash</font>
incomeTaxDueAfterTaxReductions <font color="#85994b">// Income tax due after tax reductions. Refer to Tax reductions</font>
incomeTaxCharged <font color="#85994b">// Income tax charged. Refer to Income Tax Liability</font>

<font color="#85994b">// Other parameters used for calculation</font>
totalInvestmentReliefs <font color="#85994b">// Total investment reliefs</font>
totalGiftAidTaxReductionsReliefs <font color="#85994b">// Sum of various allowable tax reliefs</font>
giftAidTaxReductions <font color="#85994b">// Gift Aid tax reductions</font>
incomeTaxChargedAfterGiftAidTaxReductions <font color="#85994b">// Income Tax charged after Gift Aid tax reductions</font>
incomeTaxDueAfterGiftAid<font color="#85994b">// Income Tax due after Gift Aid</font>

<font color="#85994b">// Calculate total individual reliefs</font>
for each investmentRelief in investmentReliefs
totalInvestmentReliefs = totalInvestmentReliefs + reliefClaimed
end for

<font color="#85994b">// Calculate total Gift Aid tax reductions and reliefs</font>
totalGiftAidTaxReductionsReliefs = deficiencyReliefsAllowable + tsrReliefAmount + totalInvestmentReliefs + totalResidentialFinanceCostsRelief + redemptionAmountUsed + marriageAllowanceRelief

<font color="#85994b">// Calculate Gift Aid tax reductions</font>
giftAidTaxReductions = totalGiftAidTaxReductionsReliefs + notionalTax

<font color="#85994b">// Apply Gift Aid reductions</font>
<font color="#1d70b8">if</font> giftAidTaxReductionsis not null <font color="#1d70b8">then</font>
incomeTaxChargedAfterGiftAidTaxReductions = max(incomeTaxCharged - giftAidTaxReductions, 0)<font color="#85994b">// Ensure non-negative value</font>
<font color="#1d70b8">else</font>
incomeTaxChargedAfterGiftAidTaxReductions = incomeTaxCharged
end <font color="#1d70b8">if</font>

<font color="#85994b">// Calculate Gift Aid charge</font>
giftAidCharge = max(giftAidTaxableAmount - incomeTaxChargedAfterGiftAidTaxReductions, 0)<font color="#85994b">// No negative charge

<font color="#85994b">// Final Income Tax Due after Gift Aid</font>
<font color="#1d70b8">if</font> giftAidCharge > incomeTaxDueAfterTaxReductions or giftAidTaxableAmount > incomeTaxCharged <font color="#1d70b8">then</font>
incomeTaxDueAfterGiftAid = giftAidCharge + incomeTaxDueAfterTaxReductions
<font color="#1d70b8">else</font>
incomeTaxDueAfterGiftAid = 0
end <font color="#1d70b8">if</font>
   </code>
</pre>

## Pension savings tax charges

For information about pension scheme charges, refer to [HS345 Pension savings --- tax charges (2024)](https://www.gov.uk/government/publications/pensions-tax-charges-on-any-excess-over-the-lifetime-allowance-annual-allowance-special-annual-allowance-and-on-unauthorised-payments-hs345-self/hs345-pension-savings-tax-charges-2024).

Some of the parameters used as inputs for Pension scheme charges calculations are in the [Individuals Charges API.](https://developer.service.hmrc.gov.uk/api-documentation/docs/api/service/individuals-charges-api/3.0)

<pre>
   <code>
<font color="#85994b">// Input parameters</font>
noSurchargeAmount <font color="#85994b">// Unauthorised payment for pension scheme with no surcharge. API parameter name: pensionSchemeUnauthorisedPayments.noSurcharge.amount</font>
pensionSchemeUnauthorisedPaymentsNoSurchargesRates <font color="#85994b">// Refer to pensionSchemeUnauthorisedPaymentsNoSurchargeRates in the config file</font>
surchargeAmount <font color="#85994b">// Unauthorised payment for pension scheme with surcharge. API parameter name: pensionSchemeUnauthorisedPayments.surcharge.amount</font>
pensionSchemeUnauthorisedPaymentsSurchargesRates <font color="#85994b">// Refer to pensionSchemeUnauthorisedPaymentsSurchargeRates in the config file</font>
pensionSchemeOverseasTransfersRates <font color="#85994b">// Refer to pensionSchemeOverseasTransferRates in the config file</font>
surchargeforeignTaxPaid <font color="#85994b">// Foreign tax paid for unauthorised payments of type surcharge. API parameter name: surcharge.foreignTaxPaid</font>
noSurchargeForeignTaxPaid <font color="#85994b">// Foreign tax paid for unauthorised payments of type no surcharge. API parameter name: noSurcharge.foreignTaxPaid</font>
ssrLBLimit <font color="#85994b">// Refer to the config file</font>
pcrLowerBand <font color="#85994b">// Refer to the config file</font>
pcrUpperBand <font color="#85994b">// Refer to the config file</font>
pppBasicRateThreshold <font color="#85994b">// Threshold for Basic rate band. Refer to "BRT" threshold under UK incomeTaxBands in the config file</font>
totalTaxableIncome <font color="#85994b">// Refer to incometaxcharged in Income Tax Liability
pppBasicRate <font color="#85994b">// Refer to "BRT" rate under UK incomeTaxBands in the config file</font>
pppIntermediateRateThreshold <font color="#85994b">// Threshold for Intermediate rate band. Refer to "IRT" threshold under Scotland incomeTaxBands in the config file</font>
pppIntermediateRate <font color="#85994b">// Refer to "IRT" rate under Scotland incomeTaxBands in the config file</font>
pppHigherRateLimit <font color="#85994b">// Threshold for Higher rate band. Refer to "HRT" threshold under corresponding regimes incomeTaxBands in the config file</font>
pppHigherRate <font color="#85994b">// Refer to "HRT" rate under corresponding regimes incomeTaxBands in the config file</font>
pppAdvancedRateLimit <font color="#85994b">// Threshold for Advanced rate band. Refer to "AVRT" threshold under Scotland incomeTaxBands in the config file</font>
pppAdvancedRate <font color="#85994b">// Refer to "AVRT" rate under Scotland incomeTaxBands in the config file</font>
pppAdditionalRateLimit <font color="#85994b">// Threshold for Additional rate band. Refer to "ART" threshold under UK incomeTaxBands in the config file</font>
pppAdditionalRate <font color="#85994b">// Refer to "ART" rate under UK incomeTaxBands in the config file</font>

<font color="#85994b">// Parameter name same as API parameter name</font>
transferCharge <font color="#85994b">// Overseas transfer charge</font>
transferChargeTaxPaid <font color="#85994b">// Tax paid on overseas transfer charge</font>
shortServiceRefund <font color="#85994b">// Short service refund amount</font>
shortServiceRefundTaxPaid <font color="#85994b">// Short service refund tax paid</font>
inExcessOfTheAnnualAllowance <font color="#85994b">// Excess of annual allowance</font>
annualAllowanceTaxPaid <font color="#85994b">// Annual allowance tax paid on pension contributions</font>

<font color="#85994b">// Other parameters used for calculations</font>
chargeableAmountTypeNoSurcharge <font color="#85994b">// Chargeable amount for unauthorised payment of type no surcharge</font>
chargeableAmountTypeSurcharge <font color="#85994b">// Chargeable amount for unauthorised payment of type surcharge</font>
totalChargeableAmountForPensionSchemeUnauthorisedPayments <font color="#85994b">// Total chargeable amount for unauthorised payments</font>
totalTaxPaidForPensionSchemeUnauthorisedPayments <font color="#85994b">// Total tax paid for unauthorised payments</font>
totalTaxPaidForPensionSchemeUnauthorisedPaymentsValue <font color="#85994b">// Total tax paid for unauthorised payments value</font>
pensionSchemeOverseasTransfersChargeableAmountDue <font color="#85994b">// Overseas transfer chargeable amount due</font>
totalPensionCharges <font color="#85994b">// Total pension charges</font>
totalTaxPaid <font color="#85994b">// Total tax paid</font>
totalShortServiceRefund <font color="#85994b">// Total short service refund amount</font>
lowerBand <font color="#85994b">// Lower band for refund taxation</font>
shortServiceRefundAmount <font color="#85994b">// Short service refund amount</font>
upperBand <font color="#85994b">// Upper band for refund taxation</font>
shortServiceRefundCharge1 <font color="#85994b">// Short service refund amount 1</font>
shortServiceRefundCharge2 <font color="#85994b">// Short service refund amount 2</font>
totalShortServiceRefundCharge <font color="#85994b">// Total short service refund charge</font>
totalShortServiceRefundChargeDue <font color="#85994b">// Total short service refund charge due</font>
unusedBRT <font color="#85994b">// Unused Basic Rate Threshold (BRT) allowance</font>
incomeAboveBRT <font color="#85994b">// Income above Basic Rate Threshold (BRT)</font>
basicAllocation <font color="#85994b">// Income allocated to Basic Rate Threshold (BRT)</font>
basicChargeAmount <font color="#85994b">// Amount charged at basic rate</font>
unusedIRT <font color="#85994b">// Unused Intermediate Rate Threshold (IRT) allowance</font>
incomeAboveIRT <font color="#85994b">// Income above Intermediate Rate Thresheld (IRT)</font>
intermediateAllocation <font color="#85994b">// Income allocated to Intermediate Rate Threshold (IRT)</font>
intermediateChargeAmount <font color="#85994b">// Amount charged at intermediate rate</font>
unusedHRT <font color="#85994b">// Unused Higher Rate Threshold (HRT) allowance</font>
incomeAboveHRT <font color="#85994b">// Income above Higher Rate Threshold (HRT)</font>
higherAllocation <font color="#85994b">// Income allocated to Higher Rate Threshold (HRT)</font>
higherChargeAmount <font color="#85994b">// Amount charged at higher rate</font>
unusedAVRT <font color="#85994b">// Unused Advanced Rate Threshold (AVRT) allowance</font>
incomeAboveAVRT <font color="#85994b">// Income above Advanced Rate Threshold (AVRT)</font>
advancedAllocation <font color="#85994b">// Income allocated to Advanced Rate Threshold (AVRT)</font>
additionalChargeAmount1 <font color="#85994b">// Amount charged at Advanced rate</font>
additionalChargeAmount2 <font color="#85994b">// Amount charged at Additional rate</font>
totalChargeAmount <font color="#85994b">// Total charge amount</font>
applicableTaxPaid <font color="#85994b">// Applicable tax paid</font>
totalPensionSavingsTaxCharges <font color="#85994b">// Total pension charges due</font>

----------------------------- Pension scheme unauthorised payments -----------------------------

<font color="#85994b">// Calculate chargeable amounts for unauthorised payments type no surcharge
<font color="#1d70b8">if</font> noSurchargeAmount is not null <font color="#1d70b8">then</font>
chargeableAmountTypeNoSurcharge = roundDown(noSurchargeAmount * (pensionSchemeUnauthorisedPaymentsNoSurchargesRates / 100), 2) <font color="#85994b">// Round down to 2 decimal places</font>
chargeableAmountTypeNoSurcharge = roundUp(chargeableAmountTypeNoSurcharge, 2) <font color="#85994b">// Round up to 2 decimal places</font>
<font color="#1d70b8">else</font>
chargeableAmountTypeNoSurcharge = 0
end <font color="#1d70b8">if</font>

<font color="#85994b">// Calculate chargeable amounts for unauthorised payments type surcharge
<font color="#1d70b8">if</font> surchargeAmount is not null <font color="#1d70b8">then</font>
chargeableAmountTypeSurcharge = roundDown(surchargeAmount * (pensionSchemeUnauthorisedPaymentsSurchargesRates / 100), 2) <font color="#85994b">// Round down to 2 decimal places</font>
chargeableAmountTypeSurcharge = roundUp(chargeableAmountTypeSurcharge, 2) <font color="#85994b">// Round up to 2 decimal places</font>
<font color="#1d70b8">else</font>
chargeableAmountTypeSurcharge = 0
end <font color="#1d70b8">if</font>

<font color="#85994b">// Sum up total chargeable amount and total tax paid</font>
totalChargeableAmountForPensionSchemeUnauthorisedPayments = chargeableAmountTypeNoSurcharge + chargeableAmountTypeSurcharge
totalTaxPaidForPensionSchemeUnauthorisedPayments = noSurchargeForeignTaxPaid + surchargeForeignTaxPaid
totalTaxPaidForPensionSchemeUnauthorisedPaymentsValue = min(totalChargeableAmountForPensionSchemeUnauthorisedPayments, totalTaxPaidForPensionSchemeUnauthorisedPayments)

----------------------------- Pension scheme overseas transfers -------------------------------

<font color="#85994b">// Calculate overseas transfer chargeable amount</font>
<font color="#1d70b8">if</font> transferCharge is not null <font color="#1d70b8">then</font>
pensionSchemeOverseasTransfersChargeableAmountDue = roundDown(transferCharge * ( pensionSchemeOverseasTransfersRates / 100), 2) <font color="#85994b">// Round down to 2 decimal places</font>
pensionSchemeOverseasTransfersChargeableAmountDue = roundUp(pensionSchemeOverseasTransfersChargeableAmountDue, 2) <font color="#85994b">// Round up to 2 decimal places</font>
<font color="#1d70b8">else</font>
pensionSchemeOverseasTransfersChargeableAmountDue = 0
end <font color="#1d70b8">if</font>

<font color="#85994b">// Calculate total pension charges and total tax paid</font>
totalPensionCharges = totalChargeableAmountForPensionSchemeUnauthorisedPayments + pensionSchemeOverseasTransfersChargeableAmountDue

<font color="#85994b">// Note: Raised CL to account for min to cap</font>
totalTaxPaid = totalTaxPaidForPensionSchemeUnauthorisedPaymentsValue + transferChargeTaxPaid

-------------------------------- Overseas pension contribution ---------------------------------

<font color="#85994b">// Step 1: Retrieve total short service refund amount</font>
totalShortServiceRefund = shortServiceRefund

<font color="#85994b">// Step 2: Determine upper and lower band for refund taxation</font>
<font color="#1d70b8">if</font> totalShortServiceRefund > ssrLBLimit <font color="#1d70b8">then</font>
lowerBand = ssrLBLimit
shortServiceRefundAmount = totalShortServiceRefund - ssrLBLimit
upperBand = shortServiceRefundAmount
<font color="#1d70b8">else</font>
lowerBand = totalShortServiceRefund
<font color="#85994b">// upperBand is null</font>
end <font color="#1d70b8">if</font>

<font color="#85994b">// Step 3: Calculate short service refund charges</font>
shortServiceRefundCharge1 = roundDown(lowerBand * (pcrLowerBand / 100), 2) <font color="#85994b">// Round down to 2 decimal places</font>
shortServiceRefundCharge1 = roundUp(shortServiceRefundCharge1, 2) <font color="#85994b">// Round up to 2 decimal places</font>
<font color="#1d70b8">if</font> upperBand is not null <font color="#1d70b8">then</font>
shortServiceRefundCharge2 = roundDown(upperBand * (pcrUpperBand / 100), 2) <font color="#85994b">// Round down to 2 decimal places</font>
shortServiceRefundCharge2 = roundUp(shortServiceRefundCharge2, 2) <font color="#85994b">// Round up to 2 decimal places</font>
<font color="#1d70b8">else</font>
shortServiceRefundCharge2 = 0
end <font color="#1d70b8">if</font>

<font color="#85994b">// Step 4: Calculate total short service refund charge</font>
totalShortServiceRefundCharge = shortServiceRefundCharge1 + shortServiceRefundCharge2

<font color="#85994b">// Step 5: Calculate total pension charges</font>
totalPensionCharges = totalPensionCharges + totalShortServiceRefundCharge

<font color="#85994b">// Step 6: Calculate total tax paid and total short service refund charge due
totalTaxPaid = totalTaxPaid + shortServiceRefundTaxPaid</font>
totalShortServiceRefundChargeDue = max(totalShortServiceRefundCharge -- shortServiceRefundTaxPaid, 0) <font color="#85994b">// Ensure non-negative value</font>

<font color="#85994b">// Note: Raised CL to account for min to cap</font>

---------------------- Pension contribution in excess of annual allowance ---------------------

<font color="#85994b">// Allocate Contributions to Basic Rate Band (BRT)</font>
unusedBRT = max(pppBasicRateThreshold - totalTaxableIncome, 0) <font color="#85994b">// Substitute zero if negative</font>
incomeAboveBRT = totalTaxableIncome - pppBasicRateThreshold
basicAllocation = min(unusedBRT, inExcessOfTheAnnualAllowance)
inExcessOfTheAnnualAllowance = inExcessOfTheAnnualAllowance - basicAllocation
basicChargeAmount = roundDown(basicAllocation * (pppBasicRate / 100), 2) <font color="#85994b">// Round down to 2 decimal places</font>
basicChargeAmount = roundUp(basicChargeAmount, 2) <font color="#85994b">// Round up to 2 decimal places</font>

<font color="#85994b">// Allocate Contributions to Intermediate Rate Band (IRT)</font>
<font color="#85994b">// if National Regime is not Scotland intermediateChargeAmount = 0</font>

unusedIRT = pppIntermediateRateThreshold - incomeAboveBRT
incomeAboveIRT = totalTaxableIncome - (pppBasicRateThreshold + pppIntermediateRateThreshold)
intermediateAllocation = min(unusedIRT, inExcessOfTheAnnualAllowance)
inExcessOfTheAnnualAllowance = inExcessOfTheAnnualAllowance - intermediateAllocation
intermediateChargeAmount = roundDown(intermediateAllocation * (pppIntermediateRate / 100), 2) <font color="#85994b">// Round down to 2 decimal places</font>
intermediateChargeAmount = roundUp(intermediateChargeAmount, 2) <font color="#85994b">// Round up to 2 decimal places</font>

<font color="#85994b">// Allocate Contributions to Higher Rate Band (HRT)
unusedHRT = (pppHigherRateLimit - pppBasicRateThreshold) - incomeAboveIRT
incomeAboveHRT = totalTaxableIncome - (pppBasicRateLimit + pppIntermediateRateThreshold + (pppHigherRateLimit - pppBasicRateThreshold))
higherAllocation = min(unusedHRT, inExcessOfTheAnnualAllowance)
inExcessOfTheAnnualAllowance = inExcessOfTheAnnualAllowance - higherAllocation
higherChargeAmount = (roundDown(higherAllocation * (pppHigherRate / 100), 2) <font color="#85994b">// Round down to 2 decimal places</font>
higherChargeAmount = roundUp(higherChargeAmount, 2) <font color="#85994b">// Round up to 2 decimal places</font>

<font color="#85994b">// Allocate Contributions to Advanced Rate Band (AVRT)</font>
<font color="#85994b">// if National Regime is not Scotland AdditionalChargeAmount1 = 0</font>
unusedAVRT = pppAdvancedRateLimit - incomeAboveHRT
incomeAboveAVRT = totalTaxableIncome - (pppBasicRateThreshold + pppIntermediateRateThreshold + (pppHigherRateLimit - pppBasicRateThreshold) + pppAdditionalRateLimit)
advancedAllocation = min(unusedAVRT, inExcessOfTheAnnualAllowance)
inExcessOfTheAnnualAllowance = inExcessOfTheAnnualAllowance - advancedAllocation
additionalChargeAmount1 = roundDown(advancedAllocation * (pppAdvancedRate / 100), 2) <font color="#85994b">// Round down to 2 decimal places</font>
additionalChargeAmount1 = roundUp(additionalChargeAmount1, 2) <font color="#85994b">// Round up to 2 decimal places</font>

<font color="#85994b">// Allocate Contributions to Additional Rate Band (ART)</font>
additionalChargeAmount2 = roundDown(incomeAboveAVRT * (pppAdditionalRate / 100), 2) <font color="#85994b">// Round down to 2 decimal places</font>
additionalChargeAmount2 = roundUp(additionalChargeAmount2, 2) <font color="#85994b">// Round up to 2 decimal places</font>

<font color="#85994b">// Sum up contribution amounts</font>
totalChargeAmount = basicChargeAmount + intermediateChargeAmount + higherChargeAmount + additionalChargeAmount1 + additionalChargeAmount2
applicableTaxPaid = min(annualAllowanceTaxPaid, totalChargeAmount)

<font color="#85994b">// Update total pension charges and total tax paid</font>
totalPensionCharges = totalPensionCharges + totalChargeAmount
totalTaxPaid = roundUp(totalTaxPaid + applicableTaxPaid, 2) <font color="#85994b">// Round up to 2 decimal places</font>

--------------------------------------------- Final --------------------------------------------

<font color="#85994b">// Final pensions charge due calculation</font>
totalPensionSavingsTaxCharges = max(totalPensionCharges - totalTaxPaid, 0) <font color="#85994b">// Ensure non-negative value</font>
totalPensionSavingsTaxCharges = roundDown(totalPensionSavingsTaxCharges, 2) <font color="#85994b">// Round down to 2 decimal places</font>
   </code>
</pre>

## National Insurance

For general information about National Insurance, refer to [National Insurance: introduction (GOV.UK)](https://www.gov.uk/national-insurance). For information about National Insurance rates and thresholds for self-employed customers during tax year 2024-25, refer to [Rates and allowances: National Insurance contributions (GOV.UK)](https://www.gov.uk/government/publications/rates-and-allowances-national-insurance-contributions/rates-and-allowances-national-insurance-contributions).

> Note: From April 2024, self-employed customers no longer have to pay Class 2 National Insurance contributions (NICs). However, they can still opt to pay Class 2 NICs voluntarily to protect eligibility for certain state benefits and to contribute to State Pension qualification.

Below is the calculation pseudocode for National Insurance.

<pre>
   <code>
<font color="#85994b">// Input parameters
<font color="#85994b">// Income source
totalSelfEmploymentTaxableProfit <font color="#85994b">// NICs are calculated on the combined total of profits from all of a customer's self-employment income sources

<font color="#85994b">// Class 2 National Insurance threshold for tax year 2024-25 (self-employed)</font>
smallProfitsThreshold <font color="#85994b">// Small profits threshold amount per year (SPT). Refer to class2NicsLimit in the config file</font>
class2NicAmount <font color="#85994b">// Class 2 NICs amount provided by external HMRC system</font>
class2NicLiable <font color="#85994b">// Indicates if the customer is liable for Class 2 NICs</font>
chosenToPayClass2Nic <font color="#85994b">// Indicates if customer has voluntarily opted to pay for state benefits or State Pension reasons</font>

<font color="#85994b">// Class 4 National Insurance thresholds and rates for tax year 2024-25 (self-employed)</font>
lowerProfitsLimit <font color="#85994b">// Lower Profits Limit (LPL). Refer to "ZRT" threshold under class4NicBands in the config file</font>
upperProfitsLimit <font color="#85994b">// Upper Profits Limit (UPL). Refer to "BRT" threshold under class4NicBands in the config file</font>
lplToUpl <font color="#85994b">// Rate between LPL and UPL. Refer to "BRT" rate under class4NicBands in the config file</font>
aboveUpl <font color="#85994b">// Rate above UPL. Refer to "HRT" rate under class4NicBands in the config file</font>

<font color="#85994b">// Class 4 NICs exemption data</font>
class4NicsExemptionReason <font color="#85994b">// Self Employment Business API parameter to indicate a reason why a customer is exempt from paying Class 4 NICs, such as age (parameter name is same as API parameter name)</font>

<font color="#85994b">// Other parameters used for calculations</font>
class2Nic <font color="#85994b">// Calculated Class 2 NICs amount</font>
remainingincome <font color="#85994b">// Income exceeding Rate Band</font>
totalClass4NIC <font color="#85994b">// Total calculated Class 4 NICs amount</font>
totalNic <font color="#85994b">// Total National Insurance contributions</font>

<font color="#85994b">// Initialise National Insurance Bands</font>
niZeroRateName ="ZRT" <font color="#85994b">// Zero-rate band for NI</font>
niZeroRate <font color="#85994b">// NIC rate for zero-rate band</font>
niZeroRateLimit = lowerProfitsLimit <font color="#85994b">// LPL serves as the upper limit for this band</font>
niZeroRateAllocatedIncome <font color="#85994b">// Income allocated to this band</font>
niZeroRateNIC <font color="#85994b">// NIC calculated for this band</font>
niBasicRateName ="BRT"<font color="#85994b">// Basic rate band for NI</font>
niBasicRate <font color="#85994b">// NIC rate for the basic rate band</font>
niBasicRateLimit = upperProfitsLimit <font color="#85994b">// UPL serves as the upper limit for this band</font>
niBasicRateAllocatedIncome <font color="#85994b">// Income allocated to this band</font>
niBasicRateNIC <font color="#85994b">// NIC calculated for this band</font>
niHigherRateName ="HRT" <font color="#85994b">// Higher rate band for NI</font>
niHigherRate <font color="#85994b">// NIC rate for the higher rate band</font>
niHigherRateLimit <font color="#85994b">// No upper limit for this band</font>
niHigherRateAllocatedIncome <font color="#85994b">// Income allocated to this band</font>
niHigherRateNIC <font color="#85994b">// NIC calculated for this band</font>

<font color="#85994b">// Round down totalSelfEmploymentTaxableProfit to 2 decimal places</font>
totalSelfEmploymentTaxableProfit = roundDown(totalSelfEmploymentTaxableProfit, 2) <font color="#85994b">// Round down to 2 decimal places</font>

<font color="#85994b">// Calculate Class 2 NICs using new rules for tax year 2024-25</font>
<font color="#1d70b8">if</font> totalSelfEmploymentTaxableProfit <= smallProfitsThreshold <font color="#1d70b8">then</font>
class2Nic = 0 <font color="#85994b">// No NI is due</font>
<font color="#1d70b8">if</font> class2NicLiable orchosenToPayClass2Nic = true <font color="#1d70b8">then</font>
<font color="#1d70b8">if</font> class2NicAmount > 0 <font color="#1d70b8">then</font> <font color="#85994b">// Verify that Class 2 NICs amount provided by external HMRC system is valid</font>
class2Nic = class2NicAmount <font color="#85994b">// Valid amount provided</font>
<font color="#1d70b8">else</font>
class2Nic = 0 <font color="#85994b">// No valid amount provided</font>
end <font color="#1d70b8">if</font>
<font color="#1d70b8">else if</font> totalSelfEmploymentTaxableProfit > smallProfitsThreshold and totalSelfEmploymentTaxableProfit <= lowerProfitsLimit
class2Nic = 0 <font color="#85994b">// No NI is due because Class 2 NICs are 'treated as paid' for self-employment profits above SPT</font>
end <font color="#1d70b8">if</font>

<font color="#85994b">// Calculate Class 4 NICs</font>
<font color="#85994b">// Check for Class 4 NICs exemption</font>
<font color="#1d70b8">if</font> class4NicsExemptionReason isnotnull <font color="#1d70b8">then</font>
totalClass4NIC =0 <font color="#85994b">// Customer is exempt</font>
<font color="#85994b">// No further calculations required</font>
<font color="#1d70b8">else if</font>> totalSelfEmploymentTaxableProfit < lowerProfitsLimit <font color="#1d70b8">then</font>
totalClass4NIC =0 <font color="#85994b">// No NICs due for income below LPL</font>
<font color="#1d70b8">else</font>
<font color="#85994b">// Allocate income across NI bands</font>
<font color="#1d70b8">if</font> totalSelfEmploymentTaxableProfit <= niZeroRateLimit <font color="#1d70b8">then</font>
niZeroRateAllocatedIncome = roundDown(totalSelfEmploymentTaxableProfit, 0) <font color="#85994b">// Round down to nearest whole pound</font>
niZeroRateNIC =0<font color="#85994b">// No NIC for Zero Rate Band</font>
remainingIncome =0<font color="#85994b">// All income fits within Zero Rate Band</font>
<font color="#1d70b8">else if</font>> totalSelfEmploymentTaxableProfit > niZeroRateLimit and totalSelfEmploymentTaxableProfit <= niBasicRateLimit <font color="#1d70b8">then</font>
niZeroRateAllocatedIncome = niZeroRateLimit
niZeroRateNIC =0 <font color="#85994b">// No NIC for Zero Rate Band</font>
remainingIncome = totalSelfEmploymentTaxableProfit - niZeroRateLimit <font color="#85994b">// Income exceeding Zero Rate Band</font>
niBasicRateAllocatedIncome = remainingIncome
niBasicRateNIC = roundDown(niBasicRateAllocatedIncome * (niBasicRate / 100), 2) <font color="#85994b">// Round down to 2 decimal places</font>
<font color="#1d70b8">else</font>

<font color="#85994b">// Income exceeds Basic Rate Band</font>
niZeroRateAllocatedIncome = niZeroRateLimit
niZeroRateNIC =0<font color="#85994b">// No NIC for Zero Rate Band</font>
niBasicRateAllocatedIncome = niBasicRateLimit - niZeroRateLimit
niBasicRateNIC = roundDown(niBasicRateAllocatedIncome * (niBasicRate / 100), 2) <font color="#85994b">// Round down to 2 decimal places</font>
remainingIncome = totalSelfEmploymentTaxableProfit -- niBasicRateLimit <font color="#85994b">// Income exceeding Basic and Zero Rate Bands
niHigherRateAllocatedIncome = remainingIncome</font>
niHigherRateNIC = roundDown(niHigherRateAllocatedIncome * (niHigherRate / 100), 2) <font color="#85994b">// Round down to 2 decimal places</font>
endif

<font color="#85994b">// Calculate total NICs</font>
totalClass4NIC = roundDown((niZeroRateNIC + niBasicRateNIC + niHigherRateNIC), 2) <font color="#85994b">// Round down to 2 decimal places</font>

<font color="#85994b">// Calculate Total Nics</font>
totalNic = class2Nic + totalClass4NIC
   </code>
</pre>

### Transitional Profits National Insurance

**Note:** the following is applicable if there are transitional profits (TP)

<pre>
   <code>
<font color="#85994b">// Re-run National Insurance pseudocode to recalculate Class 4 National Insurance Contributions (NICs) to include transitional profits (TP)</font>
<font color="#85994b">// Input parameter</font>
totalIncomeLiableToClass4Charge <font color="#85994b">// Total income liable to class 4. Refer to Transitional Profits losses and loss claims</font>

<font color="#85994b">// Other parameters for calculations</font>
totalSelfEmploymentTaxableProfit <font color="#85994b">// Total self employment taxable profit</font>

<font color="#85994b">// Override totalSelfEmploymentTaxableProfit in national insurance section</font>
totalSelfEmploymentTaxableProfit = totalIncomeLiableToClass4Charge
   </code>
</pre>

## Student loans

The student loan deduction will be calculated based on the percentage of total Self-Assessment income above the threshold. For information about student and postgraduate loan deductions, refer to [Tell HMRC about a student or postgraduate loan in your tax return (GOV.UK)](https://www.gov.uk/guidance/tell-hmrc-about-a-student-loan-in-your-tax-return) and [Student loan and postgraduate loan repayment guidance for employers (GOV.UK)](https://www.gov.uk/guidance/special-rules-for-student-loans).

Below is the calculation pseudocode for student and postgraduate loan deductions.

<pre>
   <code>
<font color="#85994b">// Student loan deductions - plan types, thresholds, and loan rates for the tax year 2024-25</font>
<font color="#85994b">// All plan thresholds and rates are dynamically sourced from the config file (xx)</font>
<font color="#85994b">// Input Parameters</font>
taxableUkInterest <font color="#85994b">// Refer to totalUntaxedUkSavings in UK savings</font>
taxableSecuritiesIncome <font color="#85994b">// Refer to grossSecurities in UK savings</font>
ukDividends <font color="#85994b">// Refer to UK dividends</font>
otherUkDividends <font color="#85994b">// Refer to UK dividends</font>
taxableOtherDividends <font color="#85994b">// Refer to otherDividends in UK dividends</font>
foreignInterest <font color="#85994b">// Refer to totalForeignSavings in Foreign savings</font>
foreignDividends <font color="#85994b">// Refer to totalChargeableForeignDividends in Foreign dividends</font>
foreignPensionsIncome <font color="#85994b">// Refer to totalForeignPensionIncome in Foreign income and pensions</font>
overseasIncomeAndGainsAmount <font color="#85994b">// Refer to overseasIncomeAndGains in Foreign income and pensions</font>
chargeableForeignBenefitsAndGiftsAmount <font color="#85994b">// Refer to totalForeignBenefitsAndGifts in Foreign income and pensions</font>
incomeAbroadAmount <font color="#85994b">// Refer to chargeableAllOtherIncomeReceivedWhilstAbroad in Foreign income and pensions</font>
postCessationReceipts <font color="#85994b">// Refer to totalPostCessationReceipts in Foreign income and pensions</font>
employmentSupportAllowance <font color="#85994b">// Refer to State benefits</font>
jobSeekersAllowance <font color="#85994b">// Refer to State benefits</font>
incapacityBenefit <font color="#85994b">// Refer to State benefits</font>
statePension <font color="#85994b">// Refer to State benefits</font>
statePensionLumpSum <font color="#85994b">// Refer to State benefits</font>
bereavementAllowance <font color="#85994b">// Refer to State benefits</font>
otherStateBenefits <font color="#85994b">// Refer to State benefits</font>
totalSelfEmploymentTaxableProfitsBeforeLosses <font color="#85994b">// Refer to taxableProfitFromSelfEmployment in Calculating total taxable property profit</font>
taxableOtherUkIncome <font color="#85994b">// Refer to taxableProfitFromUkPropertyOther in Calculating total taxable property profit</font>
taxableProfitFromForeignPropertyOther <font color="#85994b">// Refer to Calculating total taxable property profit</font>
taxableProfitFromUkPropertyFhl <font color="#85994b">// Refer to Calculating total taxable property profit</font>
taxableProfitFromEeaPropertyFhl <font color="#85994b">// Refer to Calculating total taxable property profit</font>
unearnedIncomeThreshold <font color="#85994b">// Refer to studentLoansUnearnedIncomeThreshold in the config file</font>
totalIncomeFromShareSchemes <font color="#85994b">// Refer to totalProfitFromShareSchemes in Income summary totals</font>
employmentIncome <font color="#85994b">// Refer to totalPayPayeEmploymentIncome in Employment income</font>
occupationalPensionIncome <font color="#85994b">// Refer to totalOccupationalPensionIncome in Employment income</font>
benefitsInKindIncomeForStudentLoan <font color="#85994b">// Sum of the benefits: entertaining, mileage, nonQualifyingRelocationExpenses, travelAndSubsistence, vouchersAndCreditCards, personalIncidentalExpenses, nonCash, telephone, taxableExpenses, expenses</font>
lumpSumsIncome <font color="#85994b">// Lump sum payments, such as redundancy payments. Refer to Employment income</font>
employmentExpenses <font color="#85994b">// Deductible expenses related to employment. Refer to totalSelfEmploymentExpenses in Employment expenses</font>
totalOtherDeductions <font color="#85994b">// Other allowable deductions. Refer to totalEmploymentDeductions in Employment deductions</font>
foreignTaxForFTCRNotClaimed <font color="#85994b">// Foreign tax paid but not claimed for relief</font>
csgiLosses <font color="#85994b">// Refer to Losses and loss claims</font>
pensionContributions <font color="#85994b">// Refer to totalPensionCOntributions in Pension contributions</font>
postCessationTradeReliefs <font color="#85994b">// Post-cessation trade reliefs. API parameter name: postCessationTradeReliefAndCertainOtherLosses</font>
unearnedIncomeThreshold = 2000<font color="#85994b">// Threshold for including unearned income in repayment. Refer to studentLoansUnearnedIncomeThreshold in the config file</font>
planType <font color="#85994b">// Type of student loan plan (Plan 1, 2, 3, or 4). Refer to the config file</font>
incomeThreshold <font color="#85994b">// Income threshold for student loan repayment (depends on plan type). Refer to the config file</font>
loanRate <font color="#85994b">// Repayment rate as a percentage (6% or 9%, depending on plan type). Refer to the config file</font>
uglDeductionAmount <font color="#85994b">// Undergraguate student loan deduction amount. Parameter name same as API parameter name</font>
pglDeductionAmount <font color="#85994b">// Postgraguate student loan deduction amount. Parameter name same as API parameter name</font>

<font color="#85994b">//Other parameters used for calculations</font>
nonPayeUnearnedIncome <font color="#85994b">// Non-PAYE unearned income</font>
nonPayeEarnedIncome <font color="#85994b">// Non PAYE earned income</font>
stateBenefitsIncomeForStudentLoan <font color="#85994b">// State benefits income for student loan</font>
nonPayeIncomeForStudentLoan <font color="#85994b">// Non-PAYE income for student loan</font>
employmentDeductions <font color="#85994b">// Deductions from employment</font>
payeIncomeForStudentLoan <font color="#85994b">// PAYE income for student loan</font>
totalPostCessationTradeReliefs <font color="#85994b">// total post cessation trade reliefs</font>
totalIncome <font color="#85994b">// Total calculated income for repayment</font>
totalIncomeAboveThreshold <font color="#85994b">// Income exceeding the repayment threshold</font>
repaymentAmount <font color="#85994b">// Repayment amount owed before deductions</font>
repaymentAmountNetOfDeductions <font color="#85994b">// Final repayment amount after deductions</font>
totalNetRepaymentAmounts <font color="#85994b">// Total repayment amount across all loan plans</font>

<font color="#85994b">// Calculate Non-PAYE Income for Student Loan   </font>
nonPayeUnearnedIncome = taxableUkInterest + taxableUkDividends + taxableOtherDividends + foreignDividends + taxableOtherUkIncome + employmentSupportAllowance + jobSeekersAllowance + foreignInterest + foreignPensionsIncome + overseasIncomeAndGainsAmount + chargeableForeignBenefitsAndGiftsAmount + gainsOnLifeInsurancePolicies + taxableSecuritiesIncome + incomeAbroadAmount + postCessationReceipts + taxableProfitFromForeignPropertyOther

<font color="#85994b">// Calculate Non-PAYE Earned Income</font>
nonPayeEarnedIncome = totalSelfEmploymentTaxableProfitsBeforeLosses + taxableProfitFromUkPropertyFhl + taxableProfitFromEeaPropertyFhl

<font color="#85994b">// Calculate State Benefits Income for Student Loan  </font>
stateBenefitsIncomeForStudentLoan = incapacityBenefit + statePension + statePensionLumpSum, bereavementAllowance + otherStateBenefits
<font color="#1d70b8">if</font> nonPayeUnearnedIncome > unearnedIncomeThreshold <font color="#1d70b8">then</font>
nonPayeIncomeForStudentLoan = nonPayeEarnedIncome + nonPayeUnearnedIncome
<font color="#1d70b8">else</font>
nonPayeIncomeForStudentLoan = nonPayeEarnedIncome
end <font color="#1d70b8">if</font>

<font color="#85994b">// NOTE: Unearned income below £2,000 is ignored, but if it exceeds £2,000, the entire amount is included in the calculation</font>

<font color="#85994b">// Calculate PAYE Income for Student Loan</font>
employmentDeductions= totalOtherDeductions + foreignTaxForFTCRNotClaimed
payeIncomeForStudentLoan = (totalIncomeFromShareSchemes + employmentIncome + benefitsInKindIncomeForStudentLoan + lumpSumsIncome - employmentExpenses -- employmentDeductions, 0) <font color="#85994b">// Round down to nearest whole pound</font>

<font color="#85994b">// Calculate Total Post Cessation Trade Reliefs</font>
for each postCessationTradeRelief in postCessationTradeReliefs
totalpostCessationTradeReliefs = totalpostCessationTradeReliefs + amount
end for

<font color="#85994b">// Calculate totalIncome, considering deductions and reliefs</font>
<font color="#85994b">// csgiLosses is sum of selfEmploymentCsgiLosses, ukOtherCsgiLosses, generalCsgiLosses</font>
totalIncome = max((nonPayeIncomeForStudentLoan + payeIncomeForStudentLoan) - csgiLosses - pensionContributions - totalPostCessationTradeReliefs , 0) 
<font color="#85994b">// Ensure non-negative value</font>
totalIncomeAboveThreshold = max((totalIncome - incomeThreshold), 0) <font color="#85994b">// Use the correct threshold for plan type and ensure non-negative value</font>
repaymentAmount = roundDown((totalIncomeAboveThreshold * (loanRate / 100)), 0) <font color="#85994b">// Use the correct loan rate for plantype and round down to nearest whole pound</font>
repaymentAmount = roundDown(repaymentAmount, 2) <font color="#85994b">// Round down to 2 decimal places</font>
repaymentAmountNetOfDeductions = repaymentAmount -- uglDeductionAmount - pglDeductionAmount <font color="#85994b">// Only uglDeductionAmount or pglDeductionAmount will be present</font>
studentLoanRepaymentAmount = repaymentAmountNetOfDeductions
   </code>
</pre>

## Tax deductions

Tax deductions reduce a customer's tax liability where tax has already been deducted at source.

Below is the calculation pseudocode for total deductions.

<pre>
   <code>
<font color="#85994b">// Input parameters</font>
fhlTaxDeducted <font color="#85994b">// Tax deducted on Fhl property. API parameter name: ukFhlProperty.income.taxDeducted in the Property Business API</font>
ukOtherTaxDeducted <font color="#85994b">// Tax deducted on UK property.API parameter name: ukNonFhlProperty.income.taxDeducted in the Property Business API</font>
taxedUkInterest <font color="#85994b">// UK savings annual interest.Parameter name same as Individuals Savings Income API parameter name</font>
grossUkInterest <font color="#85994b">// Amount of interest before tax is taken off. Refer to totalGrossUkTaxedSavings in [UK savings](#_UK_savings)</font>
cisTaxDeducted <font color="#85994b">// Tax deducted on Construction Industry Scheme (CIS).API parameter name: periodData.deductionAmount in the CIS Deductions API</font>
securitiesTaxDeducted <font color="#85994b">// Tax deducted on Securities.API parameter name: securities.taxTakenOff in the Individuals Savings Income API</font>
voidedIsaTaxPaidAmount</font> <font color="#85994b">// Tax deducted on voidedIsa.API parameter name: voidedIsa.taxPaidAmount in the Individuals Insurance Policies Income API</font>
stateBenefitsTaxPaid <font color="#85994b">// Tax paid on State Benefits.API parameter name: taxPaid in the Individuals State Benefits API</font>
benefitFromEmployerFinancedRetirementSchemeTaxPaid <font color="#85994b">// Tax paid on benefit from employer financed retirement scheme. API parameter name: lumpSums. benefitFromEmployerFinancedRetirementSchemeTaxPaid.taxPaid in the Individuals Employment Income API</font>
redundancyCompensationPaymentsOverExemptionTaxPaid <font color="#85994b">// Tax paid on redundancy compensation payments over exemption. API parameter name: lumpSums.redundancyCompensationPaymentsOverExemption.taxPaid in the Individuals Employment Income API</font>
taxableLumpSumsAndCertainIncomeTaxPaid <font color="#85994b">// Tax paid on taxable lump sums and certain income. API parameter name: lumpSums.taxableLumpSumsAndCertainIncome.taxPaid in the Individuals Employments Income API</font>
occupationalPension <font color="#85994b">// Indicates whether employment has occupational pension. Parameter name same as Individuals Employments Income API parameter name</font>
totalTaxToDate <font color="#85994b">// Total tax deducted to date.Parameter name same as Individuals Employments Income API parameter name</font>
inYearAdjustments <font color="#85994b">// In Year Adjustments. API parameter name: inYearAdjustments.amountin the Self Assessment Accounts API</font>
taxTakenOffTradingIncome <font color="#85994b">// Tax deducted from trading income. API parameter name: periodIncome.taxTakenOffTradingIncome in the Self Employment Business API</font>
saUnderpayments <font color="#85994b">// List of all the Self-assessment (SA) Underpayments. API parameter name: selfAssessmentUnderPayment in the Self Assessment Accounts API</font>

<font color="#85994b">// Other parameters used for calculations (initialise parameters)</font>
totalPropertyTaxDeducted = 0 <font color="#85994b">// Total property tax deducted</font>
ukInterestTaxDeducted = 0 <font color="#85994b">// Tax deducted on UK savings interest</font>
totalTaxDeductedOnTaxedInterest = 0 <font color="#85994b">// Total tax deducted on UK savings interest</font>
totalTaxDeductedOnCis = 0 <font color="#85994b">// Total tax deducted on Construction Industry Scheme (CIS)</font>
totalTaxDeductedOnSecurities = 0 <font color="#85994b">// Total tax deducted on Securities</font>
totalTaxDeductedOnVoidedIsa = 0 <font color="#85994b">// Total tax deducted on Voided Isas</font>
totalStateBenefitsTaxPaid = 0 <font color="#85994b">// Total tax paid on State Benefits</font>
totalTaxDeductedOnLumpSums = 0 <font color="#85994b">// Total tax deducted on Lump Sums</font>
totalTaxDeductedOnPayeEmployments = 0 <font color="#85994b">// Total tax deducted on Paye employments</font>
totalTaxDeductedOnOccupationalPensions = 0<font color="#85994b">// Total tax deducted on occupational pensions</font>
totalInYearAdjustments = 0 <font color="#85994b">// Total in year adjustments</font>
totalTaxTakenOffTradingIncome = 0 <font color="#85994b">// Total tax deducted from trading income</font>
totalTaxDeducted = 0 <font color="#85994b">// Total tax deducted</font>
taxDeductedAvailableForSAUnderPayments = 0<font color="#85994b">// Tax deducted available for Self-assessment (SA) under payments</font>
amountRemainingForSA <font color="#85994b">// Available tax deductions remaining to offset Self-assessment (SA) underpayments</font>
amountCollectedForSA = 0 <font color="#85994b">// Amount collected for Self-assessment (SA) under payments</font>
amountNotCollectedForSA = 0 <font color="#85994b">// Amount not collected for Self-assessment (SA) under payments</font>
adjustedTaxDeductedonPayeEmploymentsAndOccupationalPensions = 0<font color="#85994b">// Adjusted PAYE and Occupational Pensions with tax deducted</font>

<font color="#85994b">// Calculate totalPropertyTaxDeducted</font>
<font color="#85994b">// Sum up for all UK FHL income and UK non-FHL income of customer</font>
totalPropertyTaxDeducted = roundDown(fhlTaxDeducted, 2) + roundDown(ukOtherTaxDeducted, 2) <font color="#85994b">// Round down each subtotal to 2 decimal places

<font color="#85994b">// Calculate totalTaxDeductedOnTaxedInterest</font>
<font color="#85994b">// Calculate tax deducted on UK savings interest by rounding down gross interest and subtracting rounded-up taxed interest</font>
ukInterestTaxDeducted = roundDown(grossUkInterest, 2) - roundUp(taxedUkInterest, 2)

<font color="#85994b">// Sum up ukInterestTaxDeducted for all UK savings accounts of customer</font>
totalTaxDeductedOnTaxedInterest = sum([ukInterestTaxDeducted])

<font color="#85994b">// Calculate totalTaxDeductedOnCis</font>
<font color="#85994b">// Sum up cisTaxDeducted for all CIS deductions of customer</font>
totalTaxDeductedOnCis = sum([cisTaxDeducted])

<font color="#85994b">// Calculate totalTaxDeductedOnSecurities</font>
<font color="#85994b">// Sum up securitiesTaxDeducted for all securities income of customer</font>
totalTaxDeductedOnSecurities = securitiesTaxDeducted

<font color="#85994b">// Calculate totalTaxDeductedOnVoidedIsa</font>
<font color="#85994b">// Sum up taxPaidAmount for all void ISA life insurance policies of customer</font>
totalTaxDeductedOnVoidedIsa = sum([voidedIsaTaxPaidAmount])

<font color="#85994b">// Calculate totalStateBenefitsTaxPaid</font>
<font color="#85994b">// Sum up tax paid on State Pension of customer</font>
totalStateBenefitsTaxPaid = sum([stateBenefitsTaxPaid])

<font color="#85994b">// Calculate totalTaxDeductedOnLumpSums</font>
<font color="#85994b">// Sum up tax paid from various lump sum sources of customer</font>
totalTaxDeductedOnLumpSums = benefitFromEmployerFinancedRetirementSchemeTaxPaid + redundancyCompensationPaymentsOverExemptionTaxPaid + taxableLumpSumsAndCertainIncomeTaxPaid

<font color="#85994b">// Calculate totalTaxDeductedOnPayeEmployments and totalTaxDeductedOnOccupationalPensions</font>
<font color="#1d70b8">if</font> occupationalPension == false <font color="#1d70b8">then</font>

<font color="#85994b">// Calulate PAYE tax and tax paid on employment-related lump sums</font>
totalTaxDeductedOnPayeEmployments = sum([totalTaxToDate]) + totalTaxDeductedOnLumpSums
<font color="#1d70b8">else</font>

<font color="#85994b">// Calculate tax paid on occupational pensions</font>
totalTaxDeductedOnOccupationalPensions = sum([totalTaxToDate])
end <font color="#1d70b8">if</font>

<font color="#85994b">// Calculate tax deducted available for SA underpayments</font>
taxDeductedAvailableForSAUnderPayments = totalTaxDeductedOnOccupationalPensions + totalTaxDeductedOnPayeEmployments

<font color="#85994b">// Offset SA underpayments with available tax deductions</font>
amountRemainingForSA = taxDeductedAvailableForSAUnderPayments
for each underpayment in saUnderpayments
<font color="#1d70b8">if</font> amountRemainingForSA >= selfAssessmentunderpayment.amount
amountCollectedForSA = amountCollectedForSA + selfAssessmentunderpayment.amount
amountRemainingForSA = amountRemainingForSA -selfAssessmentunderpayment.amount
<font color="#1d70b8">else</font>
amountCollectedForSA = amountCollectedForSA + amountRemainingForSA
amountNotCollectedForSA = amountNotCollectedForSA + selfAssessmentunderpayment.amount - amountRemainingForSA
amountRemainingForSA = 0
end <font color="#1d70b8">if</font>
end for

<font color="#85994b">// Adjust PAYE and Occupational Pensions tax deducted</font>
adjustedTaxDeductedonPayeEmploymentsAndOccupationalPensions = max((totalTaxDeductedOnPayeEmployments + totalTaxDeductedOnOccupationalPensions) - amountCollectedForSA, 0) <font color="#85994b">// Ensure non-negative value</font>

<font color="#85994b">// Calculate totalInYearAdjustments</font>
<font color="#85994b">// Sum up In Year Adjustments</font>
totalInYearAdjustments = sum([inYearAdjustments])

<font color="#85994b">// Calculate totalTaxTakenOffTradingIncome</font>
<font color="#85994b">// Sum up tax deducted from trading income if customer has one or more self-employment income sources</font>
totalTaxTakenOffTradingIncome = sum([taxTakenOffTradingIncome])

<font color="#85994b">// Calculate totalTaxDeducted</font>
totalTaxDeducted = totalPropertyTaxDeducted + totalTaxDeductedOnTaxedInterest + totalTaxDeductedOnCis + totalTaxDeductedOnSecurities + totalTaxDeductedOnVoidedIsa + totalStateBenefitsTaxPaid + adjustedTaxDeductedonPayeEmploymentsAndOccupationalPensions + totalInYearAdjustments + totalTaxTakenOffTradingIncome
   </code>
</pre>

## Capital gains

For information about capital gains, refer to [Capital Gains Tax: what you pay it on, rates and allowances (GOV.UK),](https://www.gov.uk/capital-gains-tax) [Report and pay your Capital Gains Tax: If you sold a property in the UK on or after 6 April 2020 (GOV.UK)](https://www.gov.uk/report-and-pay-your-capital-gains-tax/if-you-sold-a-property-in-the-uk-on-or-after-6-april-2020) or [Tell HMRC about Capital Gains Tax on UK property or land if you're not a UK resident (GOV.UK)](https://www.gov.uk/guidance/capital-gains-tax-for-non-residents-uk-residential-property).

Some of the parameters used as inputs for capital gains and losses calculations are in the [Individuals Capital Gains Income API](https://developer.service.hmrc.gov.uk/api-documentation/docs/api/service/individuals-capital-gains-income-api/).

Below is the calculation pseudocode for capital gains and losses. For information about the calculation of Capital Gains Tax, see [Capital Gains Tax](#_Capital_Gains_Tax).

<pre>
   <code>
<font color="#85994b">// Input Parameters</font>
<font color="#85994b">// Parameter names are same as API parameter names</font>
multiplePropertyDisposals <font color="#85994b">// List of Multiple property disposals</font>
singlePropertyDisposals <font color="#85994b">// List of Single property disposals</font>
customerAddedDisposals <font color="#85994b">// List of Customer disposals</font>
carriedInterestGain <font color="#85994b">// Carried interest</font>
broughtForwardLossesCurrentYear <font color="#85994b">// Brought forward losses for the current year</font>
setAgainstInYearGeneralIncome <font color="#85994b">// Other asset disposal losses already set against in-year general income</font>
setAgainstEarlierYear <font color="#85994b">// Other asset disposal losses already set against earlier year</font>
attributedGains <font color="#85994b">// Attributed Gains</font>
PpdYearToDate <font color="#85994b">// Property payment disposal (PPD) year to date</font>
otherNonStandardGains <font color="#85994b">// Other non standard gains. API parameter name: nonStandardGains.otherGains</font>
totalIncomeFromAllSources <font color="#85994b">// Refer to Income summary totals</font>

<font color="#85994b">// Most of the Input Parameters are not available in the APIs but are taken from Other HMRC Sources</font>
nonBusinessAssetDisposals <font color="#85994b">// List of filtered disposals excluding BAD and INV from disposals</font>
businessAssetDisposals <font color="#85994b">// List of filtered disposals including BAD and INV from disposals</font>
cgtAnnualExemptionAmount <font color="#85994b">// Tax-free capital gains allowance. Refer to capitalGainsTaxAnnualExemptionAmount in the config file</font>
currentTotalAnnualExemptionAmountUsed <font color="#85994b">// Portion of exemption used in the current year</font>
OtherGainsERtaxrate <font color="#85994b">// OtherGainsErtaxrate. Refer to config file</font>
incomeTaxCharged <font color="#85994b">// Refer to Tax reductions</font>
gains <font color="#85994b">// List of calculated gains like insurance, life annuity, capital redemption and voidedIsa</font>
gainsNotAnnualised <font color="#85994b">// Gains that are not spread over multiple years for tax calculation</font>
basicRateBandThreshold <font color="#85994b">// Threshold for Basic rate band. Refer to "BRT" threshold under UK incomeTaxBands in the config file</font>
lowerRateOfCGTForRPCI <font color="#85994b">// Lower rate for Residential Property and Carried Interest (RPCI). Refer to "RPCI" lowerRate under cgtRates in the config file</font>
higherRateOfCGTForRPCI <font color="#85994b">// Higher rate for Residential Property and Carried Interest (RPCI). Refer to "RPCI" higherRate under cgtRates in the config file</font>
lowerRateOfCGTForOthers <font color="#85994b">// Lower rate for other gains. Refer to "CG" lowerRate under cgtRates in the config file</font>
higherRateOfCGTForOthers <font color="#85994b">// Higher rate for other gains. Refer to "CG" higherRate under cgtRates in the config file</font>
IncomeSummaries <font color="#85994b">// Income summaries</font>
foreignTaxCreditRelief <font color="#85994b">// Foreign Tax Credit Relief</font>
otherGainsDisposals <font color="#85994b">// Other Gains disposals</font>
RttTaxPaidOnNonStandardGains <font color="#85994b">// Total of RTT tax paid on non-standard capital gains like carriedInterestRttTaxPaid, attributedGainsRttTaxPaid, otherGainsRttTaxPaid</font>

<font color="#85994b">// Other parameters used for calculations (initialise parameters)</font>
totalNetGainMultipleDisposals <font color="#85994b">// Total net gain for multiple property disposals</font>
totalNetGainForSinglePropertyDisposal <font color="#85994b">// Total proceeds for single property disposal</font>
totalDisposalCosts <font color="#85994b">// Total disposal costs</font>
totalDisposalCostsForAllSinglePropertyDisposals <font color="#85994b">// Total disposal costs for all single property disposals</font>
totalNetGainSingleDisposals <font color="#85994b">// Total disposal costs for single properties subtracted from total net gain</font>
totalNetGainForAllCustomerAddedDisposals <font color="#85994b">// Total proceeds for customer added disposals</font>
totalDisposalCostsForAllCustomerAddedDisposals <font color="#85994b">// Total disposal costs for all customer added disposals</font>
netProceedsCustomerAddedDisposal <font color="#85994b">// Total disposal costs for customer added disposals subtracted from total net gain</font>
totalGainsBeforeLossesRPCI <font color="#85994b">// Total gains before losses for RPCI</font>
totalGainsBeforeLossesOthers <font color="#85994b">// Total gains before losses for other gains, excluding BAD and INV</font>
totalGainsBeforeLossesBADAndINV <font color="#85994b">// Total gains before losses for BAD and INV only</font>
totalGains <font color="#85994b">// Sum of all gains before losses</font>
totalLossesSinglePropertyDisposals <font color="#85994b">// Total losses for single property disposals</font>
totalLossesCustomerAddedDisposals <font color="#85994b">// Total losses for customer added disposals</font>
totalLossesPreviousYear <font color="#85994b">// Total losses for previous year</font>
totalBroughtForwardLossesRPCI <font color="#85994b">// Total brought forward losses for RPCI</font>
broughtForwardLossesRPCI <font color="#85994b">// Final brought forward losses for RPCI</font>
lossesAvailableForOtherGains <font color="#85994b">// Losses available for other gains</font>
broughtForwardLossesOtherGains <font color="#85994b">// Brought forward losses for other gains</font>
lossesAvailableForBADAndINV <font color="#85994b">// Losses available for BAD and INV gains only</font>
broughtForwardLossesBADAndINV <font color="#85994b">// Brought forward losses for BAD and INV gains only</font>
gainsAfterDeductionRPCI <font color="#85994b">// RPCI gains after deductions of losses</font>
gainsAfterDeductionOthers <font color="#85994b">// Other gains, excluding BAD and INV, after deductions of losses</font>
gainsAfterDeductionBADandINV <font color="#85994b">// Other gains, BAD and INV, after deductions of losses</font>
totalLossesMultiplePropertyDisposals <font color="#85994b">// Total losses for multiple property disposals</font>
calculatedLoss <font color="#85994b">// Total disposal costs subtracted from proceeds</font>
totalLossesRPCICurrentYear <font color="#85994b">// Total losses for RPCI for current year</font>
totalLossAfterRelief <font color="#85994b">// Total losses after relief</font>
totalLossesForAllGainsCurrentYear <font color="#85994b">// Total losses for all gains for the current year</font>
tradingLossesOtherGains <font color="#85994b">// Trading losses for other gains, excluding BAD and INV, for the current year</font>
totalLossForCurrentYear <font color="#85994b">// Total losses for RPCI and other gains set against in-year gains</font>
lossesArisingInCurrentYearForRPCI <font color="#85994b">// Losses arising for RPCI for current year</font>
lossesArisingInCurrentYearForOtherGains <font color="#85994b">// Losses arising for other gains, excluding BAD and INV, for current year</font>
lossesArisingInCurrentYearForBADAndINV <font color="#85994b">// Losses arising for BAD and INV gains only for current year</font>
gainsAfterCurrentLossesRPCI <font color="#85994b">// Gains for RPCI after deductions of losses arising in the current year</font>
gainsAfterCurrentLossesOthers <font color="#85994b">// Other gains, excluding BAD and INV, after deductions of losses arising in the current year</font>
gainsAfterCurrentLossesBADAndINV <font color="#85994b">// BAD and INV gains after deductions of losses arising in the current year</font>
gainsAfterCurrentLossesOthersWithAttributedGains <font color="#85994b">// Sum of gains after current losses and attributed gains</font>
annualExemptionAmountRPCI <font color="#85994b">// RPCI annual exemption amount</font>
allowanceAvailableToOtherGains <font color="#85994b">// Allowance available for other gains</font>
annualExemptionAmountUsedByOtherGains <font color="#85994b">// Other gains exemption amount</font>
allowanceAvailableToBADAndINV <font color="#85994b">// Allowance available for BAD and INV</font>
annualExemptionAmountUsedByBADandINV <font color="#85994b">// Annual exemption amount used by BAD and INV</font>
gainsAfterAllowancesRPCI <font color="#85994b">// RPCI gains after allowances have been applied</font>
gainsAfterAllowancesOthers <font color="#85994b">// Other gains, excluding BAD and INV, after allowances have been applied</font>
gainsAfterAllowancesBADandINV <font color="#85994b">// BAD and INV gains after allowances have been applied</font>
totalAnnualExemptionAmountUsedBADandINV <font color="#85994b">// Total annual exemption amount used by BAD and INV</font>
totalAnnualExemptionAmountUsedRPCI <font color="#85994b">// Total annual exemption amount used by RPCI</font>
totalAnnualExemptionAmountUsedOther <font color="#85994b">// Total annual exemption amount used by other gains</font>
totalAnnualExemptionAmountUsed <font color="#85994b">// Total annual exemption amount used</font>
taxAmountForBADAndINV <font color="#85994b">// Tax amount for Bad and INV</font>
totalTaxableIncome <font color="#85994b">// Total taxable income</font>
annualisedGainAmount <font color="#85994b">// Annualised gains from life policies</font>
totalAnnualisedGains <font color="#85994b">// Total annualised gains from life policies</font>
totalTaxableIncomeWithAnnualisedGains <font color="#85994b">// Total taxable income with annualised gains</font>
totalNotAnnualisedGains <font color="#85994b">// Total gains income, not annualised</font>
annualisedGainBeforeRelief <font color="#85994b">// Annualised gain before relief</font>
totalDeficiencyRelief <font color="#85994b">// Total deficiency relief</font>
annualisedGainAfterDeficiencyRelief <font color="#85994b">// Annualised gain after deficiency relief</font>
portionOfBasicRateBandAvailableToCapitalGains <font color="#85994b">// Portion of basic rate band available to Capital Gains</font>
unusedAmountOfBasicRateBand <font color="#85994b">// Unused amount of basic rate band</font>
gainsChargeableAtRPCILowerRate <font color="#85994b">// Gains chargeable at RPCI lower rate</font>
taxAmountForRPCIChargeableAtLowerRate <font color="#85994b">// Tax amount for gains chargeable at RPCI lower rate</font>
gainsChargeableAtRPCIHigherRate <font color="#85994b">// Gains chargeable at RPCI higher rate</font>
taxAmountForRPCIChargeableAtHigherRate <font color="#85994b">// Tax amount for gains chargeable at RPCI higher rate</font>
amountOfBasicRateBandAfterNRCGT <font color="#85994b">// Amount of basic rate band available after Non-resident Capital Gains Tax</font>
gainsChargeableAtLowerRateForOthers <font color="#85994b">// Other gains chargeable at lower rate</font>
taxAmountForOthersChargeableAtLowerRate <font color="#85994b">// Tax amount for other gains chargeable at lower rate</font>
gainsChargeableAtOthersHigherRate <font color="#85994b">// Other gains chargeable at higher rate</font>
taxAmountForOthersChargeableAtHigherRate <font color="#85994b">// Tax amount for other gains chargeable at higher rate</font>
TotalCGTCharged <font color="#85994b">// Total Capital Gains Tax charged</font>
TotalCGTAdjustments <font color="#85994b">// Total Capital Gains Tax adjustments</font>
RevisedCGTCharged <font color="#85994b">// Total Capital Gains Tax after adjustments</font>
NetCGTAfterFTCR <font color="#85994b">// Net Capital Gains Tax after Foreign Tax Credit Relief</font>
totalRttTaxPaidOtherAssets <font color="#85994b">// Tax on Real Time Transactions for other gains already charged</font>
totalTaxOnRTTGainsAlreadyCharged <font color="#85994b">// Tax on Real Time Transactions already charged</font>
capitalGainsTaxDue <font color="#85994b">// Capital Gains Tax Due</font>
capitalGainsTaxOverpaid <font color="#85994b">// Capital Gains Tax overpaid</font>

-------------------------------------- Gains before losses -------------------------------------

<font color="#85994b">// Step 1: Calculate total gains before losses for residential property disposals, plus carried interest (if any)</font>
<font color="#85994b">// Process multiple property disposal instances</font>
for each multiplePropertyDisposal in multiplePropertyDisposals
totalNetGainMultipleDisposals = totalNetGainMultipleDisposals + multiplePropertyDisposal.amountOfNetGain
end for

<font color="#85994b">// Process single property disposal instances</font>
foreach singlePropertyDisposal in singlePropertyDisposals
totalNetGainForSinglePropertyDisposal = totalNetGainForSinglePropertyDisposal + singlePropertyDisposals.proceeds
totalDisposalCosts = singlePropertyDisposal.acquisitionAmount
+ singlePropertyDisposal.improvementCosts
+ singlePropertyDisposal.additionalCosts
+ singlePropertyDisposal.prfAmount
+ singlePropertyDisposal.otherReliefAmount
totalDisposalCostsForAllSinglePropertyDisposals = totalDisposalCostsForAllSinglePropertyDisposals + totalDisposalCosts
end for
totalNetGainSingleDisposals = max(totalNetGainForSinglePropertyDisposable -- totalDisposalCostsForAllSinglePropertyDisposals,0) <font color="#85994b">// Ensure non-negative value</font>

<font color="#85994b">// Process customer added disposal instances</font>
for each customerAddedDisposal in customerAddedDisposals
totalNetGainForAllCustomerAddedDisposals = totalNetGainForAllCustomerAddedDisposals + customerAddedDisposal.proceeds
totalDisposalCosts = customerAddedDisposal.acquisitionAmount
+ customerAddedDisposal.improvementCosts
+ customerAddedDisposal.additionalCosts
+ customerAddedDisposal.prfAmount
+ customerAddedDisposal.otherReliefAmount
totalDisposalCostsForAllCustomerAddedDisposals = totalDisposalCostsForAllCustomerAddedDisposals + totalDisposalCosts
end for
netProceedsCustomerAddedDisposal = max(totalNetGainForAllCustomerAddedDisposals -- totalDisposalCostsForAllCustomerAddedDisposals, 0) <font color="#85994b">// Ensure non-negative value</font>
totalGainsBeforeLossesRPCI = roundDown(totalNetGainMultipleDisposals + totalNetGainSingleDisposals + netProceedsCustomerAddedDisposal + carriedInterestGain) <font color="#85994b">// Round down to nearest whole pound</font>

<font color="#85994b">// Step 2: Calculate total gains before losses for other gains (i.e. gains income), excluding Business Asset Disposals (BAD) and Investors' Relief (INV)</font>
for each nonBusinessAssetDisposal in nonBusinessAssetDisposals
totalGainsBeforeLossesOthers = totalGainsBeforeLossesOthers + (nonBusinessAssetDisposal.gainsAfterRelief or nonBusinessAssetDisposal.gains)
end for
totalGainsBeforeLossesOthers = roundDown(totalGainsNonBusinessAssetDisposals + otherNonStandardGains) <font color="#85994b">// Round down to nearest whole pound</font>

<font color="#85994b">// Step 3: Calculate total gains before losses for Business Asset Disposals (BAD) and Investors' Relief (INV) only</font>
for each businessAssetDisposal in businessAssetDisposals
totalGainsBeforeLossesBADAndINV = totalGainsBeforeLossesBADAndINV + (businessAssetDisposal.gainAfterRelief or businessAssetDisposal.gainAfterRelief)
end for
totalGainsBeforeLossesBADAndINV = roundDown(totalGainsBeforeLossesBADAndINV) <font color="#85994b">// Round down to nearest whole pound</font>

<font color="#85994b">// Calculate sum total of all gains before losses (from Steps 1, 2, and 3)
totalGains = totalGainsBeforeLossesRPCI + totalGainsBeforeLossesOthers + totalGainsBeforeLossesBADAndINV

----------------------------------- Brought Forward Losses ----------------------------------

<font color="#85994b">// Step 4: Calculate total losses for residential property disposals, including any brought-forward losses</font>
<font color="#85994b">// Calculate sum of losses from previous year for residential property disposals</font>
for each singlePropertyDisposal in singlePropertyDisposals
totalLossesSinglePropertyDisposals = totalLossesSinglePropertyDisposals + singlePropertyDisposal.lossesFromPreviousYear
end for

<font color="#85994b">// Process all customer added disposals for losses from previous year</font>
for each customerAddedDisposal in customerAddedDisposals
totalLossesCustomerAddedDisposals = totalLossesCustomerAddedDisposals + customerAddedDisposal.lossesFromPreviousYear
end for
totalLossesPreviousYear = totalLossesSinglePropertyDisposals + totalLossesCustomerAddedDisposals
totalBroughtForwardLossesRPCI = broughtForwardLossesCurrentYear + totalLossesPreviousYear
broughtForwardLossesRPCI = min(totalGainsBeforeLossesRPCI, totalBroughtForwardLossesRPCI)

<font color="#85994b">// Step 5: Determine losses available for other gains (excluding Business Asset Disposals (BAD) and Investors' Relief (INV))</font>
<font color="#85994b">// Calculate losses available for other gains</font>
lossesAvailableForOtherGains = max(totalBroughtForwardLossesRPCI - totalGainsBeforeLossesRPCI, 0) <font color="#85994b">// Ensure non-negative value</font>

<font color="#85994b">// Calculate brought-forward losses for other gains</font>
broughtForwardLossesOtherGains = min(totalGainsBeforeLossesOthers, lossesAvailableForOtherGains)

<font color="#85994b">// Step 6: Determine losses available for other gains - Business Asset Disposals (BAD) and Investors' Relief (INV)</font>
lossesAvailableForBADAndINV = max(totalBroughtForwardLossesRPCI - totalGainsBeforeLossesRPCI - totalGainsBeforeLossesOthers,0) <font color="#85994b">// Ensure non-negative value</font>

<font color="#85994b">// Determine the lower of losses available for BAD and INV and total gains before losses on BAD and INV</font>
broughtForwardLossesBADAndINV = min(totalGainsBeforeLossesBADAndINV, lossesAvailableForBADAndINV)

------------------------------------- Gains After Deduction ------------------------------------

<font color="#85994b">// Step 7: Calculate Residential Property and Carried Interest (RPCI) gains after deductions of losses</font>
gainsAfterDeductionRPCI = max(totalGainsBeforeLossesRPCI - broughtForwardLossesRPCI, 0) <font color="#85994b">// Ensure non-negative value</font>

<font color="#85994b">// Step 8: Calculate other gains, excluding BAD and INV, after deductions of losses
gainsAfterDeductionOthers = max(totalGainsBeforeLossesOthers - broughtForwardLossesOtherGains, 0) <font color="#85994b">// Ensure non-negative value</font>

<font color="#85994b">// Step 9: Calculate other gains, BAD and INV only, after deductions of losses
gainsAfterDeductionBADandINV = max(totalGainsBeforeLossesBADAndINV - broughtForwardLossesBADAndINV, 0) <font color="#85994b">// Ensure non-negative value</font>

--------------------------------------- Losses Current Year ------------------------------------

<font color="#85994b">// Step 10: Determine losses for Residential Property and Carried Interest (RPCI) for the current year</font>
foreach muliplePropertyDisposal in muliplePropertyDisposals
totalLossesMultiplePropertyDisposals = totalLossesMultiplePropertyDisposals + muliplePropertyDisposal.lossesFromCurrentYear
end for
for each singlePropertyDisposal in singlePropertyDisposals
totalDisposalCosts = singlePropertyDisposal.acquisitionAmount
+ singlePropertyDisposal.improvementCosts
+ singlePropertyDisposal.additionalCosts
+ singlePropertyDisposal.prfAmount
+ singlePropertyDisposal.otherReliefAmount
calculatedLoss = singlePropertyDisposal.proceeds - totalDisposalCosts

<font color="#85994b">// If the calculated loss is negative, add to total losses for the current year</font>
<font color="#1d70b8">if</font> calculatedLoss < 0
totalLossesSinglePropertyDisposals = totalLossesSinglePropertyDisposals + calculatedLoss
end <font color="#1d70b8">if</font>
end for
for each customerDisposal in customerAddedDisposals
totalDisposalCosts = customerDisposal.acquisitionAmount
+ customerDisposal.improvementCosts
+ customerDisposal.additionalCosts
+ customerDisposal.privateResidenceRelief
+ customerDisposal.otherReliefAmount
calculatedLoss = customerDisposal.proceeds - totalDisposalCosts

<font color="#85994b">// If the calculated loss is negative, add to total losses for the current year</font>
<font color="#1d70b8">if</font> calculatedLoss < 0
totalLossesCustomerAddedDisposals = totalLossesCustomerAddedDisposals + calculatedLoss
end <font color="#1d70b8">if</font>
end for

<font color="#85994b">// Sum up total losses from different sources</font>
totalLossesRPCICurrentYear = roundUp(totalLossesMultiplePropertyDisposals + totalLossesSinglePropertyDisposals + totalLossesCustomerAddedDisposals) <font color="#85994b">// Round up to nearest whole pound

<font color="#85994b">// Step 11: Determine losses for all gains, for the current year</font>
for each businessAssetDisposal in businessAssetDisposals
<font color="#1d70b8">if</font>(businessAssetDisposal.lossAfterRelief != null)
totalLossAfterRelief = totalLossAfterRelief + (businessAssetDisposal.lossAfterRelief or businessAssetDisposal.loss)
end <font color="#1d70b8">if</font>
end for

<font color="#85994b">// Total of other asset disposal losses for current year</font>
<font color="#85994b">// Note: This step does not split between "BAD and INV" and other election codes. All are included in the disposals</font>
totalLossesForAllGainsCurrentYear = roundUp((max(totalLossAfterRelief - setAgainstInYearGeneralIncome -- setAgainstEarlierYear),0)) <font color="#85994b">// Round up to nearest whole pound</font>
</font>
<font color="#85994b">// Step 12: Determine trading losses for other gains, excluding Business Asset Disposals (BAD) and Investors' Relief (INV), for the current year</font>
tradingLossesOtherGains = roundUp(setAgainstInYearGains) <font color="#85994b">// Round up to nearest whole pound</font>

--------------------------------- Total Losses Arising Current Year ----------------------------

<font color="#85994b">// Step 13: Determine total losses for Residential Property and Carried Interest (RPCI) and other gains, set against in-year gains
totalLossForCurrentYear = max(totalLossesRPCICurrentYear + totalLossesForAllGainsCurrentYear + tradingLossesOtherGains, 0) <font color="#85994b">// Ensure non-negative value</font>
<font color="#1d70b8">if</font> gainsAfterDeductionRPCI is not null
lossesArisingInCurrentYearForRPCI = min(totalLossForCurrentYear, gainsAfterDeductionRPCI)
<font color="#1d70b8">else</font>
lossesArisingInCurrentYearForRPCI = min(totalLossForCurrentYear, totalGainsBeforeLossesRPCI)
end <font color="#1d70b8">if</font>

<font color="#85994b">// Step 14: Determine losses arising in the current year available to other gains, excluding Business Asset Disposals (BAD) and Investors' Relief (INV)</font>
lossesArisingInCurrentYearAvailableToOtherGains = max(totalLossForCurrentYear - gainsAfterDeductionRPCI, 0 ) <font color="#85994b">//Ensure non-negative value
<font color="#1d70b8">if</font> gainsAfterDeductionOthers is not null
lossesArisingInCurrentYearForOtherGains = min(lossesArisingInCurrentYearAvailableToOtherGains, gainsAfterDeductionOthers)
<font color="#1d70b8">else</font>
lossesArisingInCurrentYearForOtherGains = min(lossesArisingInCurrentYearAvailableToOtherGains, totalGainsBeforeLossesOthers)
end <font color="#1d70b8">if</font>

<font color="#85994b">// Step 15: Determine losses arising in the current year available to other gains including Business Asset Disposals (BAD) and Investors' Relief (INV) only</font>
lossesArisingInCurrentYearAvailableToBADAndINV = max(totalLossForCurrentYear - gainsAfterDeductionRPCI - gainsAfterDeductionOthers, 0) <font color="#85994b">// Ensure non-negative value</font>
<font color="#1d70b8">if</font> gainsAfterDeductionBADandINV is not null
lossesArisingInCurrentYearForBADAndINV = min(lossesArisingInCurrentYearAvailableToBADAndINV, gainsAfterDeductionBADandINV )
<font color="#1d70b8">else</font>
lossesArisingInCurrentYearForBADAndINV = min(lossesArisingInCurrentYearAvailableToBADAndINV, totalGainsBeforeLossesBADAndINV)
end <font color="#1d70b8">if</font>

---------------------------------- Gains After Deduction Current Year --------------------------

<font color="#85994b">// Step 16: Determine Residential Property and Carried Interest (RPCI) gains after deductions of losses arising in the current year</font>
gainsAfterCurrentLossesRPCI = max(gainsAfterDeductionRPCI - lossesArisingInCurrentYearForRPCI, 0) <font color="#85994b">// Ensure non-negative value</font>

<font color="#85994b">// Step 17: Determine other gains, excluding Business Asset Disposals (BAD) and Investors' Relief (INV), after deductions of losses arising in the current year</font>
gainsAfterCurrentLossesOthers = max(gainsAfterDeductionOthers- lossesArisingInCurrentYearForOtherGains, 0) <font color="#85994b">// Ensure non-negative value</font>

<font color="#85994b">// Step 18: Determine other gains, Business Asset Disposals (BAD) and Investors' Relief (INV) only, after deductions of losses arising in the current year</font>
gainsAfterCurrentLossesBADAndINV = max(gainsAfterDeductionBADandINV - lossesArisingInCurrentYearForBADAndINV, 0) <font color="#85994b">// Ensure non-negative value</font>

----------------------------------- Identify Attributed Gains ----------------------------------

<font color="#85994b">// Step 19: Identify attributed gains</font>
attributedGains = roundDown(attributedGains, 0) <font color="#85994b">//Round down to nearest whole pound

<font color="#85994b">// Step 20: Determine other gains, excluding Business Asset Disposals (BAD) and Investors' Relief (INV), after losses deductions but with attributed gains</font>
gainsAfterCurrentLossesOthersWithAttributedGains = gainsAfterCurrentLossesOthers + attributedGains

----------------------------------- Annual Exemption Amount -----------------------------------

<font color="#85994b">// Step 21: Identify CGT Annual Exemption Amount and Determine Residential Property and Carried Interest (RPCI) Annual Exemption Amount</font>
<font color="#1d70b8">if</font> gainsAfterCurrentLossesRPCI is not null
annualExemptionAmountRPCI = min(cgtAnnualExemptionAmount, gainsAfterCurrentLossesRPCI)
<font color="#1d70b8">else if</font> gainsAfterDeductionRPCI is not null
annualExemptionAmountRPCI = min(cgtAnnualExemptionAmount, gainsAfterDeductionRPCI)
<font color="#1d70b8">else</font>
annualExemptionAmountRPCI = min(cgtAnnualExemptionAmount, totalGainsBeforeLossesRPCI)
end <font color="#1d70b8">if</font>

<font color="#85994b">// Step 22: Determine allowance available and used by to other gains, excluding Business Asset Disposals (BAD) and Investors' Relief (INV)</font>
<font color="#85994b">// Note: Include attributedGains so that that AEA amount used considers attributed gains</font>
allowanceAvailableToOtherGains = max(cgtAnnualExemptionAmount - gainsAfterCurrentLossesRPCI, 0) <font color="#85994b">// Ensure non-negative value</font>
<font color="#1d70b8">if</font> gainsAfterCurrentLossesOthers is not null <font color="#1d70b8">then</font>
annualExemptionAmountUsedByOtherGains = min(allowanceAvailableToOtherGains, gainsAfterCurrentLossesOthers) + attributedGains
<font color="#1d70b8">else if</font> gainsAfterDeductionOthers is not null <font color="#1d70b8">then</font>
annualExemptionAmountUsedByOtherGains = min(allowanceAvailableToOtherGains, gainsAfterDeductionOthers) + attributedGains
<font color="#1d70b8">else</font>
annualExemptionAmountUsedByOtherGains = min(allowanceAvailableToOtherGains, totalGainsBeforeLossesOthers) + attributedGains
end <font color="#1d70b8">if</font>

<font color="#85994b">// Step 23: Determine allowance available and used by other gains - Business Asset Disposals (BAD) and Investors' Relief (INV) only</font>
allowanceAvailableToBADAndINV = max(allowanceAvailableToOtherGains - gainsAfterCurrentLossesOthersWithAttributedGains, 0) <font color="#85994b">// Ensure non-negative value</font>
<font color="#1d70b8">if</font> gainsAfterCurrentLossesBADAndINV is not null <font color="#1d70b8">then</font>
annualExemptionAmountUsedByBADandINV = min(allowanceAvailableToBADAndINV, gainsAfterCurrentLossesBADAndINV)
<font color="#1d70b8">else if</font> gainsAfterDeductionBADandINV is not null <font color="#1d70b8">then</font>
annualExemptionAmountUsedByBADandINV = min(allowanceAvailableToBADAndINV, gainsAfterDeductionBADandINV)
<font color="#1d70b8">else</font>
annualExemptionAmountUsedByBADandINV = min(allowanceAvailableToBADAndINV, totalGainsBeforeLossesBADAndINV)
end <font color="#1d70b8">if</font>

--------------------------------- Gains After Allowance Applied -------------------------------

<font color="#85994b">// Step 24: Determine Residential Property and Carried Interest (RPCI) gains after allowances applied</font>
gainsAfterAllowancesRPCI = roundDown(max(gainsAfterCurrentLossesRPCI - cgtAnnualExemptionAmount, 0), 2) <font color="#85994b">// Round down to 2 decimal places, ensure non-negative value</font>

<font color="#85994b">// Step 25: Determine other gains, excluding Business Asset Disposals (BAD) and Investors' Relief (INV), after allowances applied
gainsAfterAllowancesOthers = roundDown(max(gainsAfterCurrentLossesOthersWithAttributedGains - annualExemptionAmountUsedByOtherGains, 0), 2) <font color="#85994b">// Round down to 2 decimal places, ensure non-negative value</font>

<font color="#85994b">// Step 26: Determine other gains, Business Asset Disposals (BAD) and Investors' Relief (INV) only, after allowances applied
gainsAfterAllowancesBADandINV = roundDown(max(gainsAfterCurrentLossesBADAndINV - annualExemptionAmountUsedByBADandINV, 0), 2) <font color="#85994b">// Round down to 2 decimal places, ensure non-negative value</font>

-------------------------------- Total Annual Exemption Amount ---------------------------------

<font color="#85994b">// Step 26a: Determine total Annual Exemption Amount used by the 3 gain types</font>
totalAnnualExemptionAmountUsedBADandINV = currentTotalAnnualExemptionAmountUsed + annualExemptionAmountUsedByBADandINV
totalAnnualExemptionAmountUsedRPCI = totalAnnualExemptionAmountUsedBADandINV + annualExemptionAmountRPCI
totalAnnualExemptionAmountUsedOther = totalAnnualExemptionAmountUsedRPCI + annualExemptionAmountUsedByOtherGains

<font color="#85994b">// Final total annual exemption amount used</font>
totalAnnualExemptionAmountUsed = totalAnnualExemptionAmountUsedOther

<font color="#85994b">// Step 27: Determine tax amount for other gains - Business Asset Disposals (BAD) and Investors' Relief (INV) only</font>
taxAmountForBADAndINV = ((gainsAfterAllowancesBADandINV * otherGainsERtaxrate ) / 100)

--------------------------------- Gains Chargeable At Different Rates --------------------------

<font color="#85994b">// Step 28: Retrieve total taxable income</font>
totalTaxableIncome = totalIncomeFromAllSources

<font color="#85994b">// Step 29: Calculate annualised gains</font>
for each gain in gains
<font color="#1d70b8">if</font> gain.yearsHeld > 0 <font color="#1d70b8">then</font>
annualisedGainAmount = roundDown(gain.gainAmount / min(gain.yearsHeldSinceLastGain, gain.yearsHeld), 2) <font color="#85994b">// Round down to 2 decimal places</font>
<font color="#1d70b8">else</font>
annualisedGainAmount = 0
end <font color="#1d70b8">if</font>
totalAnnualisedGains = totalAnnualisedGains + annualisedGainAmount
end for

<font color="#85994b">// Step 30: Calculate the sum of taxable income and annualised gains</font>
totalTaxableIncomeWithAnnualisedGains = totalTaxableIncome + totalAnnualisedGains

<font color="#85994b">// Step 31: Determine total gains income (with and without tax paid) not annualised</font>
for each gain in gainsNotAnnualised
totalNotAnnualisedGains = totalNotAnnualisedGains + gain.gainAmount
end for

<font color="#85994b">// Step 32: Subtract total gains income (with and without tax paid) not annualised, from sum of taxable income and annualised gains</font>
annualisedGainBeforeRelief = max(totalTaxableIncomeWithAnnualisedGains - totalNotAnnualisedGains, 0) <font color="#85994b">// Ensure non-negative value</font>

<font color="#85994b">// Step 33: Determine total deficiency relief</font>
for each gain in gainsNotAnnualised
totalDeficiencyRelief = totalDeficiencyRelief + gain.deficiencyRelief
end for

<font color="#85994b">// Step 34: Calculate annualised gain after deducting deficiency relief</font>
annualisedGainAfterDeficiencyRelief = max(annualisedGainBeforeRelief - totalDeficiencyRelief, 0) <font color="#85994b">//Ensure non-negative value</font>

<font color="#85994b">// Step 35: Retrieve basic rate band - may include Gift Aid or pension payments extensions</font>
basicRateBandThreshold

<font color="#85994b">// Step 36: Calculate the portion (if any) of the basic rate band available to capital gains</font>
portionOfBasicRateBandAvailableToCapitalGains = max(basicRateBandThreshold - annualisedGainAfterDeficiencyRelief, 0) <font color="#85994b">// Ensure non-negative value</font>

<font color="#85994b">// Step 37: Calculate the unused amount of basic rate band available to capital gains</font>
unusedAmountOfBasicRateBand = max(portionOfBasicRateBandAvailableToCapitalGains - gainsAfterAllowancesBADandINV, 0) <font color="#85994b">// Ensure non-negative value</font>

<font color="#85994b">// Step 38: Determine the gains chargeable at the Residential Property and Carried Interest (RPCI) lower rate</font>
gainsChargeableAtRPCILowerRate = roundDown(min(gainsAfterAllowancesRPCI, unusedAmountOfBasicRateBand), 2) <font color="#85994b">// Round down to 2 decimal places</font>

<font color="#85994b">// Step 39: Determine the tax amount for gains chargeable at the lower rate of Capital Gains Tax for Residential Property and Carried Interest (RPCI)
taxAmountForRPCIChargeableAtLowerRate = roundDown((gainsChargeableAtRPCILowerRate * lowerRateOfCGTForRPCI) / 100), 2) <font color="#85994b">// Round down to 2 decimal places</font>

<font color="#85994b">// Step 40: Determine the gains chargeable at the Residential Property and Carried Interest (RPCI) higher rate
gainsChargeableAtRPCIHigherRate = roundDown(max(gainsAfterAllowancesRPCI - gainsChargeableAtRPCILowerRate, 0), 2)<font color="#85994b">// Round down to 2 decimal places</font>, ensure non-negative value

<font color="#85994b">// Step 41: Determine the tax amount for gains chargeable at the higher rate of Capital Gains Tax for Residential Property and Carried Interest (RPCI)
taxAmountForRPCIChargeableAtHigherRate = roundDown(((gainsChargeableAtRPCIHigherRate * higherRateOfCGTForRPCI) / 100), 2) <font color="#85994b">// Round down to 2 decimal places</font>

<font color="#85994b">// Step 42: Determine amount of basic rate band available after Non-resident Capital Gains Tax (NRCGT)</font>
amountOfBasicRateBandAfterNRCGT = max(unusedAmountOfBasicRateBand - gainsAfterAllowancesRPCI, 0) <font color="#85994b">// Ensure non-negative value</font>

<font color="#85994b">// Step 43: Determine the gains chargeable at the lower rate for other gains (non-RPCI)</font>
gainsChargeableAtLowerRateForOthers = roundDown(min(gainsAfterAllowancesOthers, amountOfBasicRateBandAfterNRCGT), 2) <font color="#85994b">// Round down to 2 decimal places</font>

<font color="#85994b">// Step 44: Determine the tax amount for gains chargeable at the lower rate of Capital Gains Tax for other gains (non-RPCI)</font>
taxAmountForOthersChargeableAtLowerRate = roundDown(((gainsChargeableAtLowerRateForOthers * lowerRateOfCGTForOthers) / 100), 2) <font color="#85994b">// Round down to 2 decimal places</font>

<font color="#85994b">// Step 45: Determine the gains chargeable at the higher rate for other chargeable assets (non-RPCI)</font>
gainsChargeableAtOthersHigherRate = roundDown(max(gainsAfterAllowancesOthers - gainsChargeableAtLowerRateForOthers, 0), 2) <font color="#85994b">// Round down to 2 decimal places</font>, ensure non-negative value

<font color="#85994b">// Step 46: Determine the tax amount for gains chargeable at the higher rate of Capital Gains Tax for other assets (non-RPCI)</font>
taxAmountForOthersChargeableAtHigherRate = roundDown(((gainsChargeableAtOthersHigherRate * higherRateOfCGTForOthers) / 100 ), 2) <font color="#85994b">// Round down to 2 decimal places</font>

<font color="#85994b">// Step 47: Determine total CGT charge</font>
totalCGTCharged = taxAmountForBADAndINV
+ taxAmountForRPCIChargeableAtLowerRate
+ taxAmountForRPCIChargeableAtHigherRate
+ taxAmountForOthersChargeableAtLowerRate
+ taxAmountForOthersChargeableAtHigherRate

--------------------------------------- CGT Adjustments -------------------------------------

<font color="#85994b">// Step 48: Determine CGT adjustments</font>
for each incomeSummary in incomeSummaries
totalCGTAdjustments = totalCGTAdjustments + incomeSummary.adjustments
end for

<font color="#85994b">// Step 49: Calculate revised CGT charged</font>
revisedCGTCharged = max(totalCGTCharged + totalCGTAdjustments,0) <font color="#85994b">// Ensure non-negative value</font>

<font color="#85994b">// Step 50: Foreign Tax Credit Relief</font>
<font color="#85994b">// Not in use at present; Value defaulted to zero for now
foreignTaxCreditRelief = 0

<font color="#85994b">// Step 51: Subtract Foreign Tax Credit Relief (FTCR) from revised CGT</font>
netCGTAfterFTCR = max(revisedCGTCharged - foreignTaxCreditRelief, 0) <font color="#85994b">// Ensure non-negative value</font>

<font color="#85994b">// Step 52: Trusts - currently out of scope for Making Tax Digital</font>
<font color="#85994b">// (No action needed, just a note)

<font color="#85994b">// Step 53: Non-resident Landlords - currently out of scope for Making Tax Digital</font>
<font color="#85994b">// (No action needed, just a note)

<font color="#85994b">// Step 54: Calculate tax on Real Time Transactions (RTT) gains already charged</font>
for each disposal in otherGainsDisposals
<font color="#1d70b8">if</font> (disposal.RTTTaxPaid != null)
totalRttTaxPaidOtherAssets = totalRttTaxPaidOtherAssets + disposal.RTTTaxPaid
end <font color="#1d70b8">if</font>
end for
totalTaxOnRTTGainsAlreadyCharged = roundUp(ppdYearToDate + rttTaxPaidOnNonStandardGains + totalRttTaxPaidOtherAssets) <font color="#85994b">// Round up to nearest whole pound</font>

------------------------------------ Final Capital Gains Due -----------------------------------

<font color="#85994b">// Step 55: Determine Capital Gains Tax due</font>
capitalGainsTaxDue = max(netCGTAfterFTCR - totalTaxOnRTTGainsAlreadyCharged, 0) <font color="#85994b">// Trusts and Landlords to be added later, ensure non-negative value</font>

<font color="#85994b">// Step 56: Determine Capital Gains Tax overpaid</font>
capitalGainsTaxOverpaid = max(totalTaxOnRTTGainsAlreadyCharged - netCGTAfterFTCR, 0) <font color="#85994b">// Trusts and Landlords to be added later, ensure non-negative value</font>
   </code>
</pre>

## Final Tax Calculation

Below is the calculation pseudocode for final tax calculation.

<pre>
   <code>
<font color="#85994b">// Input parameters</font>
grossAnnuityPayments <font color="#85994b">// Full amount of income paid out by an annuity before any deductions or taxes. Refer to Annuity payments</font>
annuityPercentage <font color="#85994b">// Calculated using annuityRate aligned to "BRT" rate under UK incomeTaxBands in the config file</font>
ukBasicRate<font color="#85994b">// Refer to "BRT" rate under UK incomeTaxBands in the config file</font>
netRoyaltiesPayments <font color="#85994b">// Net royalty payments. API parameter name: royaltyPayments.royaltyPaymentsAmount</font>
studentLoanRepaymentAmount <font color="#85994b">// Student loan repayment amount. Refer to Student loans</font>
taxDeducted <font color="#85994b">// Total tax deducted. Refer to totalTaxDeducted in Tax deductions</font>
giftAidTaxableAmount <font color="#85994b">// Taxable amount from Gift Aid payments. Refer toGift Aid payments</font>
incomeTaxDueAfterTaxReductions <font color="#85994b">// Refer to Tax reductions</font>
incomeTaxDueAfterGiftAid <font color="#85994b">// Income tax due after Gift Aid. Refer to Gift Aid on income Tax Liability</font>
capitalGainsTaxDue <font color="#85994b">// Capital Gains tax due. Refer to Capital gains</font>

<font color="#85994b">// Additional charges and adjustments </font>
payeUnderpaymentsCodedOut <font color="#85994b">// PAYE underpayments coded out. API parameter name: codedOutUnderpayments.totalPayeUnderpayments</font>
totalPensionSavingsTaxCharges <font color="#85994b">// Total pension savings tax charges. Refer to Pension scheme charges</font>
statePensionLumpSumList <font color="#85994b">// List of state pension lumpsums. Refer to benefitType = statePensionLumpSum in the Individuals State Benefits API</font>
totalNic <font color="#85994b">// Total National Insurance contributions. Refer to National Insurance</font>

<font color="#85994b">// Other parameters used for calculations</font>
annuityTaxDue <font color="#85994b">// Annuity tax due</font>
grossRoyaltiesPayments <font color="#85994b">// Gross royalties payments</font>
royaltyPaymentsTaxCharged <font color="#85994b">// Royalty payments tax charged</font>
totalNic <font color="#85994b">// Total National Insurance contributions</font>
showTotalIncomeTaxDue <font color="#85994b">// Flag to check whether to show total income tax due</font>
totalIncomeTaxNicsCharged <font color="#85994b">// Total income tax and nics charged</font>
statePensionLumpSumCharge<font color="#85994b">// Total state pension lump sums charge</font>
totalIncomeTaxDue <font color="#85994b">// Total income tax due</font>
totalIncomeTaxAndNicsDue <font color="#85994b">// Total income tax and Nics due</font>
totalIncomeTaxAndNicsAndCgt<font color="#85994b">// Total income tax, Nics and Capital gains tax due</font>

<font color="#85994b">// Calculate annuityTaxDue</font>
annuityTaxDue = roundUp(grossAnnuityPayments * annuityPercentage, 2) <font color="#85994b">// Round up to 2 decimal places</font>

<font color="#85994b">// Calculate grossRoyaltiesPayments</font>
grossRoyaltiesPayments = max(roundDown(netRoyaltiesPayments / (1 - (ukBasicRate / 100)), 2), 0) <font color="#85994b">// Round down to 2 decimal places and ensure non-negative</font>

<font color="#85994b">// Calculate royaltyPaymentsTaxCharged</font>
royaltyPaymentsTaxCharged = grossRoyaltiesPayments - netRoyaltiesPayments

<font color="#85994b">// Determine whether to show total income tax due based on the presence of certain parameters</font>
<font color="#1d70b8">if</font> totalPensionSavingsTaxCharges or statePensionLumpSum or payeUnderpaymentsCodedOut is not null <font color="#1d70b8">then</font> 
showTotalIncomeTaxDue = true
<font color="#1d70b8">else</font>
showTotalIncomeTaxDue = false
end <font color="#1d70b8">if</font>

<font color="#85994b">// Calculate Total income tax and NICs charged</font>
<font color="#1d70b8">if</font> showTotalIncomeTaxDue == false

<font color="#85994b">// If 'showTotalIncomeTaxDue' is false, calculate income tax due after tax reliefs and reductions</font>
totalIncomeTaxNicsCharged = max(incomeTaxDueAfterTaxReductions, giftAidTaxableAmount) + totalNic + annuityTaxDue + royaltyPaymentsTaxCharged
<font color="#1d70b8">else</font>
for each statePensionLumpSum in statePensionLumpSumList

<font color="#85994b">// Note: State Pension Lump Sum Taxation Rule</font>
<font color="#85994b">// If taxable income (excluding lump sum) is less than allowances, the lump sum rate is 0%.</font>
<font color="#85994b">// If taxable income (excluding lump sum) minus allowances is positive, the lump sum is taxed at the highest rate.</font>
<font color="#85994b">// If taxable income (excluding lump sum) minus allowances is within savings/dividend allowance,the lump sum is taxed at 20%. </font>
statePensionLumpSum.charge = roundDown(statePensionLumpSum.amount * (statePensionLumpSum.rate / 100), 2) <font color="#85994b">// Round down to 2 decimal places</font>
statePensionLumpSumCharge = statePensionLumpSumCharge + statePensionLumpSum.charge
end for 

<font color="#85994b">// If 'showTotalIncomeTaxDue' is true, calculate income tax due after tax reductions</font>
<font color="#1d70b8">if</font> incomeTaxDueAfterGiftAid is not null <font color="#1d70b8">then</font>
totalIncomeTaxDue = incomeTaxDueAfterGiftAid + totalPensionSavingsTaxCharges + statePensionLumpSumCharge + payeUnderpaymentsCodedOut
<font color="#1d70b8">else</font>
totalIncomeTaxDue =max(incomeTaxDueAfterTaxReductions, giftAidTaxableAmount) + totalPensionSavingsTaxCharges + statePensionLumpSumCharge + payeUnderpaymentsCodedOut
end <font color="#1d70b8">if</font>
totalIncomeTaxNicsCharged = totalIncomeTaxDue + totalNic + annuityTaxDue + royaltyPaymentsTaxCharged
end <font color="#1d70b8">if</font>

<font color="#85994b">// Calculate Total Income Tax And Nics Due</font>
totalIncomeTaxAndNicsDue = totalIncomeTaxNicsCharged + studentLoanRepaymentAmount - taxDeducted <font color="#85994b">// If amount is negative, customer has overpaid tax by that amount

<font color="#85994b">// Calculate Total Income Tax And Nics CGT</font>
totalIncomeTaxAndNicsAndCgt = totalIncomeTaxAndNicsDue + capitalGainsTaxDue <font color="#85994b">// If amount is negative, customer has overpaid tax by that amount
   </code>
</pre>