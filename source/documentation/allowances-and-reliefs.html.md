---
title: Allowances and reliefs | Tax Logic service guide
weight: 3
description: Details of the calculations used for allowances and reliefs.
---

# Allowances and reliefs

Income Tax allowances and reliefs help reduce the amount of tax that customers pay.

## Personal Allowance

For information about Personal Allowance, refer to [Income Tax rates and Personal Allowances (GOV.UK)](https://www.gov.uk/income-tax-rates).

Below is the calculation pseudocode for Personal Allowance.

<pre>
   <code>
<font color="#85994b">// Personal Allowances for tax year 2024-25</font> 
<font color="#85994b">// Earnings <= £100,000: Full Personal Allowance (£12,570)</font> 
<font color="#85994b">// Earnings £100,001--£125,140: Personal Allowance reduced by £1 for every £2 earned over £100,000</font> 
<font color="#85994b">// Earnings >= £125,140: Personal Allowance is £0</font> 
<font color="#85994b">// Input parameters</font> 
adjustedNetIncome <font color="#85994b">// Total taxable income before any Personal Allowances and less certain tax reliefs. Refer to Adjusted net income</font> 
reducedAllowanceLimit <font color="#85994b">// £100,000 for tax year 2024-25. Refer to the configfile</font> 

<font color="#85994b">// Other parameter used for calculations</font> 
personalAllowance <font color="#85994b">// Personal allowance for the tax year</font> 
allowanceReductionAmount <font color="#85994b">// Amount to reduce Personal Allowance for incomes > £100,000</font> 

<font color="#85994b">// Calculate personalAllowance</font> 
<font color="#1d70b8">if</font>  adjustedNetIncome <= reducedAllowanceLimit <font color="#1d70b8">then</font> 
personalAllowance =12570
<font color="#1d70b8">else</font>  if adjustedNetIncome > reducedAllowanceLimit and adjustedNetIncome < 125140 <font color="#1d70b8">then</font> 
allowanceReductionAmount = roundDown((adjustedNetIncome - reducedAllowanceLimit) / 2, 0) <font color="#85994b">// Reduce by £1 for every £2 over £100,000 and round down to nearest whole pound</font> 
personalAllowance = roundUp(personalAllowance - allowanceReductionAmount, 0) <font color="#85994b">// Round up to nearest whole pound</font> 
<font color="#1d70b8">else</font> if adjustedNetIncome >=125140 <font color="#1d70b8">then</font>
personalAllowance =0
end <font color="#1d70b8">if</font>
   </code>
</pre>

## Marriage Allowance

Marriage Allowance lets you transfer some of your Personal Allowance to your spouse. For information about Marriage Allowance, refer to [Marriage Allowance (GOV.UK)](https://www.gov.uk/marriage-allowance).

<pre>
   <code>
<font color="#85994b">// Input parameters</font>
isTransferorOfMAT <font color="#85994b">// Indicates if the customer is the transferor of Marriage Allowance Transfer</font>
basicRateBandThreshold <font color="#85994b">// Threshold for Basic rate band. Refer to "BRT" threshold under UK incomeTaxBands in the config file</font>
grossGiftAidPayments <font color="#85994b">// Total Gift Aid amount that extends the Basic Rate band, If applicable. Refer to Gift Aid</font>
grossTotalPensionContributionsReliefs <font color="#85994b">// Total pension contributions reliefs, if applicable. Refer to totalPensionContributionsRelief in Pension contributions</font>
totalIncomeFromAllSources <font color="#85994b">// Total income from all sources. Refer to Income summary totals</font>
personalAllowance <font color="#85994b">// Personal allowance for the tax year. Refer to Personal Allowance</font>
matInRate <font color="#85994b">// Refer to marriageAllowanceTransferInRate in the config file</font>
isMarriageAllowanceTransferringOrReceivingAllowed <font color="#85994b">// Flag to check if Marriage Allowance transfer/receipt is allowed</font>
isMarriageAllowanceAllowed <font color="#85994b">// Indicates that marriage allowance transfer is allowed</font>
marriageAllowanceTransferOutAmount <font color="#85994b">// Amount to be transferred out as Marriage Allowance. Refer to marriageAllowanceTransferInAndOutAmount in the config file</font>

<font color="#85994b">// Other parameters used for calculations\</font>
totalBasicRateBandThreshold <font color="#85994b">// Total threshold for the basic rate band</font>
marriageAllowanceReceivedFromTransferor <font color="#85994b">// Amount of marriage allowance received from transferor</font>
marriageAllowanceRelief <font color="#85994b">// Relief for marriage allowance</font>

<font color="#85994b">// Calculate the total basic rate band threshold</font>
totalBasicRateBandThreshold = basicRateBandThreshold + grossGiftAidPayments + grossTotalPensionContributionsReliefs

<font color="#85994b">// Check if the customer is the transferor of Marriage Allowance</font>
<font color="#1d70b8">if</font> isTransferorOfMAT is true <font color="#1d70b8">then</font>

<font color="#85994b">------------------------------ Transferor of the Marriage Allowance ---------------------------</font>
    <font color="#85994b">// Check if Marriage Allowance transfer or receipt is allowed based on income and thresholds</font>
<font color="#1d70b8">if</font> (totalIncomeFromAllSources - personalAllowance) ≤ totalBasicRateBandThreshold <font color="#1d70b8">then</font>
        isMarriageAllowanceTransferringOrReceivingAllowed = true
    <font color="#1d70b8">else</font>
isMarriageAllowanceTransferringOrReceivingAllowed = false
    end <font color="#1d70b8">if</font>

    <font color="#85994b">// End Marriage Allowance rule</font>
<font color="#85994b">// Proceed if transfer is allowed
 <font color="#1d70b8">if</font> isMarriageAllowanceTransferringOrReceivingAllowed is true <font color="#1d70b8">then</font>

<font color="#85994b">// Mark Marriage Allowance as allowed</font>
        isMarriageAllowanceAllowed=true

<font color="#85994b">// Calculate transfer amount rounded up to 2 decimal places</font>
        marriageAllowanceTransferOutAmount = roundUp(marriageAllowanceTransferOutAmount, 2)
<font color="#1d70b8">else</font>
        <font color="#85994b">// Mark Marriage Allowance as not allowed</font>
        isMarriageAllowanceAllowed = false
    end <font color="#1d70b8">if</font>
<font color="#1d70b8">else</font>

<font color="#85994b">------------------------------ Receiver of the Marriage Allowance ----------------------------</font>
<font color="#1d70b8">if</font> isMarriageAllowanceAllowed is true <font color="#1d70b8">then</font>

<font color="#85994b">// Calculate the relief amount </font>
        marriageAllowanceReceivedFromTransferor = marriageAllowanceTransferOutAmount
        marriageAllowanceRelief = roundUp(marriageAllowanceReceivedFromTransferor * (matInRate / 100),2) <font color="#85994b">// Round up to 2 decimal places</font>
    end <font color="#1d70b8">if</font>
end <font color="#1d70b8">if</font>
   </code>
</pre>

## Gift Aid

If a customer pays tax at a rate above the basic rate, they are entitled to additional tax relief for Gift Aid payments. A customer can also treat certain Gift Aid payments as if paid in the previous or next tax year. For information about Gift Aid payments, refer to [Tax relief when you donate to a charity (GOV.UK)](https://www.gov.uk/donating-to-charity/gift-aid).

Some parameters used as inputs for Gift Aid payments calculations are in the [Individuals Reliefs API](https://developer.service.hmrc.gov.uk/api-documentation/docs/api/service/individuals-reliefs-api/).

Below is the calculation pseudocode for Gift Aid payments.

<pre>
   <code>
<font color="#85994b">// Input parameters\</font>
giftAidCurrentYear <font color="#85994b">// The total amount of Gift Aid payments made for the specified tax year. API parameter name: </giftAidPayments.totalAmount\
giftAidNextYearTreatedAsCurrentYear <font color="#85994b">// The amount of Gift Aid payments brought forward from the following tax year, treated as if made in the specified tax year .API parameter name: giftAidPayments.amountTreatedAsSpecifiedTaxYear\</font>
giftAidCurrentYearTreatedAsPreviousYear <font color="#85994b">// The amount of Gift Aid payments made within the specified tax year that should be treated as if they were made in the previous tax year .API parameter name: giftAidPayments.amountTreatedAsPreviousTaxYear</font>
ukbasicRate <font color="#85994b">// Refer to "BRT" rate under UK incomeTaxBands in the config file\</font>

<font color="#85994b">// Other parameters used for calculations </font>
giftAidPaymentMade <font color="#85994b">// Total gift aid payments made</font>
grossGiftAidPayments <font color="#85994b">// Total Gift Aid amount that extends the Basic Rate band\</font>
giftAidTaxableAmount <font color="#85994b">// Tax Relief</font>

<font color="#85994b">// Calculate giftAidPaymentMade </font>
giftAidPaymentMade = roundUp (giftAidCurrentYear + giftAidNextYearTreatedAsCurrentYear - giftAidCurrentYearTreatedAsPreviousYear, 2) <font color="#85994b">// Round up to 2 decimal places </font>

<font color="#85994b">// Calculate grossGiftAidPayments </font>
grossGiftAidPayments = (giftAidPaymentMade * 100 / (100 - ukbasicRate)) <font color="#85994b">// Gross up factor</font>
grossGiftAidPayments = roundUp(grossGiftAidPayments, 0) <font color="#85994b">// Round up to nearest whole pound  </font>

<font color="#85994b">// Calculate giftAidTaxableAmount </font>
giftAidTaxableAmount = grossGiftAidPayments * roundUp(ukbasicRate / 100), 2) <font color="#85994b">// Round up to 2 decimal places</font>
giftAidTaxableAmount = roundDown(giftAidTaxableAmount, 0) <font color="#85994b">// Round down to nearest whole pound </font>
   </code>
</pre>

## Pension contributions

HMRC provides tax relief on private pension contributions. For information about tax relief for pension contributions, refer to [Tax on your private pension contributions - Tax relief (GOV.UK)](https://www.gov.uk/tax-on-your-private-pension/pension-tax-relief). All parameters used as inputs for pension contributions calculations are in the [Individuals Reliefs API](https://developer.service.hmrc.gov.uk/api-documentation/docs/api/service/individuals-reliefs-api/).

Below is the calculation pseudocode for pension contributions.

<pre>
   <code>
<font color="#85994b">// Input parameters</font>
<font color="#85994b">// Parameter names are same as API parameter names</font>
retirementAnnuityPayments <font color="#85994b">// Retirement annuity payments made by customer during tax year</font>
paymentToEmployersSchemeNoTaxRelief <font color="#85994b">// Contributions to an employer's pension scheme not eligible for tax relief</font>
overseasPensionSchemeContributions <font color="#85994b">// Contributions to approved overseas pension schemes</font>
regularPensionContributions <font color="#85994b">// Recurring contributions to private pension schemes</font>
oneOffPensionContributionsPaid <font color="#85994b">// One-time contributions to private pension schemes</font>

<font color="#85994b">// Other parameters used for calculations</font>
totalPensionContributions <font color="#85994b">// Total contributions that have not had tax relief at source (these will contribute to Total allowances)</font>
totalPensionContributionsRelief <font color="#85994b">// Total contributions that have had basic rate tax relief at source</font>

<font color="#85994b">// Other parameters used for calculations</font>
totalPensionContributions <font color="#85994b">// Total contributions that have not had tax relief at source (these will contribute to Total allowances)</font>
totalPensionContributionsRelief <font color="#85994b">// Total contributions that have had basic rate tax relief at source

<font color="#85994b">// Calculate totalPensionContributions</font>
totalPensionContributions = retirementAnnuityPayments + paymentToEmployersSchemeNoTaxRelief + overseasPensionSchemeContributions

<font color="#85994b">// Calculate totalPensionContributionsRelief</font>
totalPensionContributionsRelief = regularPensionContributions + oneOffPensionContributionsPaid
   </code>
</pre>

## Basic rate extension

A customer's basic rate tax band can be extended by their Gift Aid payments and pension contributions, allowing more of their income to be taxed at 20% before reaching the 40% higher rate tax band.

Below is the calculation pseudocode for pension contributions.

<pre>
   <code>
<font color="#85994b">// Input parameters</font>
giftAidRelief <font color="#85994b">// Gift Aid relief. Refer to grossGiftAidPayments in Gift Aid payments</font>
totalPensionContributionsRelief <font color="#85994b">// Total contributions eligible for tax relief. Refer to Pensions contributions</font>

<font color="#85994b">// Other parameter used for calculations
totalBasicRateExtension <font color="#85994b">// Tracks the cumulative total of the extensions applied to the basic rate tax band (used for Income Tax Liability calculations)\</font>

<font color="#85994b">// Round down to nearest whole pound</font>
giftAidRelief = roundDown(giftAidRelief, 0)

<font color="#85994b">// Calculate totalBasicRateExtension</font>
totalBasicRateExtension = giftAidRelief + totalPensionContributionsRelief
   </code>
</pre>

## Annuity payments

Annual payments are payments made under a legal obligation. For more information, refer to [Annual payments: introduction (GOV.UK)](https://www.gov.uk/hmrc-internal-manuals/savings-and-investment-manual/saim8010).

Below is the calculation pseudocode for gross annuity payments.

<pre>
   <code>
<font color="#85994b">// Input parameters</font>
reliefClaimed <font color="#85994b">// Relief claimed for annual payments. API parameter name: annualPaymentsMade.reliefClaimed</font>
ukBasicRate <font color="#85994b">// Refer to "BRT" rate under UK incomeTaxBands in the config file</font>

<font color="#85994b">// Other parameters used for calculations</font>
grossAnnuityPayments <font color="#85994b">// Gross annuity payments</font>

<font color="#85994b">// Calculate gross annuity payments</font>
grossAnnuityPayments = roundDown(reliefClaimed / (1 -- (tapRate / 100)), 2)) <font color="#85994b">// Round down to 2 decimal places</font>
grossAnnuityPayments = roundUp(grossAnnuityPayments, 2) <font color="#85994b">// Round up to 2 decimal places</font>
   </code>
</pre>

## Trade union payments

In some cases, payments to trades unions and police organisations may qualify for relief. For more information, refer to [PAYE10035 (GOV.UK).](https://www.gov.uk/hmrc-internal-manuals/paye-manual/paye10035)

Below is the calculation pseudocode for payments to trade unions for death benefits.

<pre>
   <code>
<font color="#85994b">// Input parameters</font>
capTup <font color="#85994b">// Limit for trade union payments. Refer to the config file</font>
paymentsToTradeUnionsForDeathBenefitsAmount <font color="#85994b">// Payments made to trade unions. API parameter name: paymentsToTradeUnionsForDeathBenefits.expenseAmount</font>

<font color="#85994b">// Other parameters used for calculations</font>
paymentsToTradeUnionsForDeathBenefits <font color="#85994b">// Payments to trade unions for death benefits</font>
paymentsToTradeUnionsForDeathBenefits = roundUp(paymentsToTradeUnionsForDeathBenefitsAmount, 2) <font color="#85994b">// Round up to 2 decimal places</font>
<font color="#1d70b8">if paymentsToTradeUnionsForDeathBenefitsAmount</font> > capTup <font color="#1d70b8">then</font>
paymentsToTradeUnionsForDeathBenefits = capTup
<font color="#1d70b8">else</font>
paymentsToTradeUnionsForDeathBenefits = paymentsToTradeUnionsForDeathBenefitsAmount
end <font color="#1d70b8">if</font>

paymentsToTradeUnionsForDeathBenefits = roundUp(paymentsToTradeUnionsForDeathBenefits, 2) <font color="#85994b">// Round up to 2 decimal places</font>
   </code>
</pre>

## Gifts to charity

A customer does not need to pay tax on land, property or shares they donate to charity. For more information, refer to [Giving land, buildings, shares and securities to charity (GOV.UK).](https://www.gov.uk/government/publications/charities-detailed-guidance-notes/chapter-5-giving-land-buildings-shares-and-securities-to-charity)

Below is the calculation pseudocode for gifts of investments and property to charity.

<pre>
   <code>
<font color="#85994b">// Input parameters</font>
<font color="#85994b">// Parameter names are same as API parameter names</font>
landAndBuildings <font color="#85994b">// Value of land and buildings gifted to charity</font>
sharesOrSecurities <font color="#85994b">// Value of shares and securities gifted to charity</font>

<font color="#85994b">// Other parameters used for calculations</font>
giftOfInvestmentsAndPropertyToCharity <font color="#85994b">// Gifts of investments and property to charity. These will contribute to Total allowances</font>

<font color="#85994b">// Calculate gift of investments and property to charity</font>
giftOfInvestmentsAndPropertyToCharity = roundUp(sharesOrSecurities + landAndBuildings, 2) <font color="#85994b">// Round up to 2 decimal places</font>
   </code>
</pre>

## Total allowances

Total allowances are used to reduce the amount of taxable income before tax is calculated.

Below is the calculation pseudocode for total allowances and deductions.

<pre>
   <code>
<font color="#85994b">// Input parameters</font>
personalAllowance <font color="#85994b">// Refer to Personal Allowance</font>
marriageAllowanceTransferOut <font color="#85994b">// Refer to marriageAllowanceTransferOutAmount in Marriage Allowance</font>
capitalGainsSetAgainstInYearGeneralIncome <font color="#85994b">// Refer to Losses and loss claims</font>
lossesAppliedToGeneralIncome <font color="#85994b">// Refer to Losses and loss claims</font>
qualifyingLoanInterestFromInvestments <font color="#85994b">// Refer to Losses and loss claims</font>
postCessationTradeReliefs <font color="#85994b">// Refer to Losses and loss claims</font>
pensionContributions <font color="#85994b">// Refer to totalPensionContributions inPension contributions</font>
grossAnnuityPayments <font color="#85994b">// Refer toAnnuity payments</font>
paymentsToTradeUnionsForDeathBenefits <font color="#85994b">// Refer to Trade union payments</font>
giftOfInvestmentsAndPropertyToCharity <font color="#85994b">// Refer to Gifts to charity</font>

<font color="#85994b">// Other parameters used for calculations</font>
totalAllowancesAndDeductions <font color="#85994b">// Total allowances and deductions</font>

<font color="#85994b">// Calculate totalAllowancesAndDeductions</font>
totalAllowancesAndDeductions = roundUp(personalAllowance -- marriageAllowanceTransferOut + capitalGainsSetAgainstInYearGeneralIncome + lossesAppliedToGeneralIncome + qualifyingLoanInterestFromInvestments + postCessationTradeReliefs + pensionContributions + grossAnnuityPayments + paymentsToTradeUnionsForDeathBenefits + giftOfInvestmentsAndPropertyToCharity, 0) <font color="#85994b">// Round up to nearest whole pound</font>
   </code>
</pre>

## Deficiency relief

Deficiency relief may be available if the individual's income is liable to tax at some of the tax rates. For more information, refer to [Deficiency relief: entitlement (GOV.UK)](https://www.gov.uk/hmrc-internal-manuals/insurance-policyholder-taxation-manual/iptm3860).

<pre>
   <code>
<font color="#85994b">// Input parameters</font>
capitalRedemptionDeficiencyRelief <font color="#85994b">// Capital Redemption deficiency relief</font>
lifeInsuranceDeficiencyRelief <font color="#85994b">// Life insurance deficiency relief</font>
lifeAnnuityDeficiencyRelief <font color="#85994b">// Life annuity deficiency relief</font>
dividendHigherRateAllocatedIncome <font color="#85994b">// Dividends income allocated to higher rate. Refer to Income Tax Liability</font>
dividendBasicRate <font color="#85994b">// Refer to "BRT" rate under dividendBands in the config file</font>
dividendHigherRate <font color="#85994b">// Refer to "HRT" rate under dividendBands in the config file</font>
savingsBasicRate <font color="#85994b">// Refer to "BRT" rate under dividendBands in the config file</font>
savingsHigherRate <font color="#85994b">// Refer to "HRT" rate under savingsBands in the config file</font>
savingsHigherRateAllocatedIncome <font color="#85994b">// Savings income allocated to HRT band. Refer to Income Tax Liability</font>
pppHigherRateAllocatedIncome <font color="#85994b">// PPP income allocated to HRT band. Refer to Income Tax Liability</font>
pppScottishHigherRate <font color="#85994b">// Refer to "HRT" rate under Scotland incomeTaxBands in the config file</font>
pppScottishHigherRateAllocatedIncome <font color="#85994b">// Refer to Income Tax Liability Scotland</font>
nationalRegime <font color="#85994b">// National Regime</font>

<font color="#85994b">// Other parameters for calculations</font>
totalDeficiencyReliefs <font color="#85994b">// Total deficiency relief</font>
dividendsReliefAmount <font color="#85994b">// Deficiency relief on dividend income</font>
dividendRateDifference <font color="#85994b">// Dividend rate difference</font>
dividendReliefApplied <font color="#85994b">// Dividend relief applied</font>
remainingDeficiencyRelief <font color="#85994b">// Remaining deficiency relief after applying dividend relief</font>
totalSavingsAndPPPHigherIncome <font color="#85994b">// Total of savings and PPP income allocated to the HRT band</font>
savingsReliefAmountUK <font color="#85994b">// Relief applied to HRT income after dividend relief</font>
savingsRateDifference <font color="#85994b">// Rate difference for savings</font>
savingsReliefApplied <font color="#85994b">// Savings relief applied</font>
pppAmountScottish <font color="#85994b">// Relief applied to PPP income after considering Scottish higher rate</font>
pppRateDifference <font color="#85994b">// Rate difference for Scottish Higher Rate tax on PPP income</font>
pppReliefApplied <font color="#85994b">// Relief on PPP income</font>
deficiencyReliefApplied <font color="#85994b">// Deficiency relief applied</font>
deficiencyReliefsAllowable <font color="#85994b">// Deficiency reliefs allowable</font>

<font color="#85994b">// Calculate total deficiency relief</font>
totalDeficiencyReliefs = capitalRedemptiondeficiencyRelief + lifeInsuranceDeficiencyRelief + lifeAnnuityDeficiencyRelief

<font color="#85994b">// Calculate deficiency relief on dividend income</font>
dividendsReliefAmount = min(dividendHigherRateAllocatedIncome, totalDeficiencyReliefs) <font color="#85994b">// Ensure DF applied does not exceed available income in HRT

<font color="#85994b">// Calculate rate difference for dividends</font>
dividendRateDifference = dividendHigherRate - dividendBasicRate

<font color="#85994b">// Calculate dividend relief amount</font>
dividendReliefApplied = roundUp(dividendsReliefAmount * dividendRateDifference / 100, 2) <font color="#85994b">// Round up to 2 decimal places</font>

<font color="#85994b">// Calculate remaining deficiency relief after applying dividend relief</font>
remainingDeficiencyRelief = max(totalDeficiencyReliefs - dividendHigherRateAllocatedIncome, 0) <font color="#85994b">// Ensure non-negative value</font>

<font color="#85994b">// Calculate total of savings and PPP income allocated to the HRT band</font>
totalSavingsAndPPPHigherIncome = savingsHigherRateAllocatedIncome + pppHigherRateAllocatedIncome

<font color="#85994b">// Get relief applied to HRT income after dividend relief</font>
savingsReliefAmountUK = min(remainingDeficiencyRelief, totalSavingsAndPPPHigherIncome)

<font color="#85994b">// Calculate rate difference for savings</font>
savingsRateDifference = savingsHigherRate - savingsBasicRate

<font color="#85994b">// Calculate savings relief amount</font>
savingsReliefApplied = roundUp(savingsReliefAmountUK * savingsRateDifference / 100,2) <font color="#85994b">// Round up to 2 decimal places</font>

---------------------------------- nationalRegime: Scotland ------------------------------------
<font color="#1d70b8">if</font> nationalRegime is Scotland <font color="#1d70b8">then</font>
    
<font color="#85994b">// Calculate income in HRT bands for PPP bands</font>
(pppScottishHigherRateAllocatedIncome)
    <font color="#85994b">// Get relief applied to PPP income after considering Scottish higher rate</font>
pppAmountScottish = min(savingsReliefApplied, pppScottishHigherRateAllocatedIncome)

    <font color="#85994b">// Calculate rate difference for Scottish Higher Rate tax on PPP income</font>
pppRateDifference = pppScottishHigherRate - savingsBasicRate

    <font color="#85994b">// Calculate relief on PPP income</font>
pppReliefApplied = roundUp(pppAmountScottish * pppRateDifference / 100,2) <font color="#85994b">// Round up to 2 decimal places</font>
<font color="#1d70b8">else</font>
    <font color="#85994b">// nationalRegime: UK</font>
    pppReliefApplied = 0
end <font color="#1d70b8">if</font>

<font color="#85994b">// Calculate deficiency relief applied</font>
deficiencyReliefApplied = dividendReliefApplied + savingsReliefApplied + pppReliefApplied
deficiencyReliefsAllowable = deficiencyReliefApplied
   </code>
</pre>

## Top Slicing Relief

Some parameters used as inputs for pension contributions calculations are in the Individuals Insurance Policies Income API.

For information about Top Slicing Relief, refer to [Insurance Policyholder Taxation Manual - IPTM3820 - Top slicing relief: general (GOV.UK)](https://www.gov.uk/hmrc-internal-manuals/insurance-policyholder-taxation-manual/iptm3820).

<pre>
   <code>
<font color="#85994b">// Input parameters</font>
gains = [
gains {
gainType, <font color="#85994b">// Type of gains (Life Insurance, Life Annuity, Capital Redemption, Voided ISA)</font>
gainAmount, <font color="#85994b">// Amount of the gain</font>
yearsheld, <font color="#85994b">// Number of years the policy has been held</font>
yearsHeldSinceLastGain <font color="#85994b">// Number of years the policy has been held since the last gain</font>
}
]
ukBasicRate <font color="#85994b">// Refer to "BRT" rate under UK incomeTaxBands in the config file</font>
totalIncomeFromPayPensionsProfit <font color="#85994b">// Refer to totalProfitFromPayPensionsProfit in Income summary totals</font>

<font color="#85994b">// Other parameters used for calculation</font>
totalGainsLiability_TSR_Calc_1 <font color="#85994b">// Calculated amount after running TSR-Calc-1</font>
totalGainsTaxableIncome_TSR_Calc_1 <font color="#85994b">// Calculated amount after running TSR-Calc-1</font>
totalGainsLiability_TSR_Calc_2 <font color="#85994b">// Calculated amount after running TSR-Calc-2</font>
totalGainsTaxableIncome_TSR_Calc_2 <font color="#85994b">// Calculated amount after running TSR-Calc-2</font>
taxOnGain_1 <font color="#85994b">// Tax on gain after running TSR-Calc-1</font>
taxOnGain_2 <font color="#85994b">// Tax on gain after running TSR-Calc-2</font>
gainsTaxableIncome_1 <font color="#85994b">// Gains taxable income after running TSR-Calc-1</font>
gainsTaxableIncome_2 <font color="#85994b">// Gains taxable income after running TSR-Calc-2</font>
gainAtBR <font color="#85994b">// Gains taxed at UK basic rate</font>
remainingTaxOnGain <font color="#85994b">// Remaining tax on gain following gain being taxed at UK basic rate</font>
totalGainsIncome <font color="#85994b">// Total gains income</font>
minYearsHeld <font color="#85994b">// Minimum years held for a given gain</font>
annualisedGainAmount <font color="#85994b">// Annualised gain amount</font>
totalAnnualisedGainAmount = 0 <font color="#85994b">// Cumulative annualised gain amount. Initialise parameter</font>
basicRateOnAnnualisedAmount <font color="#85994b">// Basic rate on annualised gain amount</font>
gainsDifference <font color="#85994b">// New difference in gains</font>
yearsAdjustment <font color="#85994b">// Years adjustment</font>
tsrReliefAmount <font color="#85994b">// Final TSR relief amount</font>

<font color="#85994b">// Note: Conditions for TSR Calculation:  </font>
<font color="#85994b">// - There are no gains (taxed or untaxed).  </font>
<font color="#85994b">// - The request is in-year.  </font>
<font color="#85994b">// - The taxpayer is not in the UK Higher Rate, Wales Higher Rate, or Scottish Higher Rate and above (i.e., ART).</font>
<font color="#85994b">// Note: TSR calculation runs in multiple iterations (TSR-Calc-n), extracting values into memory at each stage.</font>

<font color="#85994b">-------------------------------------- Calculate TSR -------------------------------------------</font>
<font color="#85994b">// Step 1: Work out the liability calculation without the excluded facts</font>
<font color="#85994b">// Run TSR-Calc-1</font>
<font color="#85994b">// - Retrieve tsrData, inputData, and calculationData</font>
<font color="#85994b">// - Apply exclusions to input data:</font>
<font color="#85994b">//     * Exclusion 1: If "UK Other" is present, exclude the value for premiumsOfGrantOfLease from the total income. If this generates a loss, cap it at 0 for this part of the calculation.</font>
<font color="#85994b">//     * Exclusion 2: If Charitable Giving is present with Gift Aid, exclude the Gift Aid (BR band extension value) from the input into TSR-Calc-1.</font>
<font color="#85994b">//     * Exclusion 3: If Charitable Giving is present with giftOfInvestmentsAndPropertyToCharity, exclude it from the input into TSR-Calc-1.</font>
<font color="#85994b">//     * Exclusion 4: Lump sums must be excluded from the income summary.</font>
<font color="#85994b">// - Prepare calculationData
</font>
<font color="#85994b">// - Run Tax Liability Calculation (Refer to Tax Liability Section)</font>
taxOnGain_1 = totalGainsLiability_TSR_Calc_1
gainsTaxableIncome_1 = totalGainsTaxableIncome_TSR_Calc_1

<font color="#85994b">// Step 2: Remaining Tax on Gain</font>
ukBasicRate = roundDown(ukBasicRate / 100, 2) <font color="#85994b">// Rounded down to 2 decimal places</font>
gainAtBR = gainsTaxableIncome_1 * ukBasicRate
remainingTaxOnGain = max(taxOnGain_1 - gainAtBR, 0) <font color="#85994b">// Ensure non-negative value</font>

<font color="#85994b">//Step 3: Calculate the annualised gain</font>
for each gain in gains
minYearsHeld = min(yearsHeld, yearsHeldSinceLastGain)
    <font color="#1d70b8">if</font> minYearsHeld > 0 <font color="#1d70b8">then</font>
    annualisedGainAmount = roundDown(max(gainAmount / min(yearsHeld, yearsHeldSinceLastGain), 0)) <font color="#85994b">// Ensure non-negative value and round down to nearest whole pound</font>
<font color="#1d70b8">else</font>
annualisedGainAmount = 0
end <font color="#1d70b8">if</font>
totalAnnualisedGainAmount = totalAnnualisedGainAmount + annualisedGainAmount
end <font color="#1d70b8">for</font>

<font color="#85994b">//Step 4: Set the annualised gain</font>
totalGainsIncome = totalAnnualisedGainAmount

<font color="#85994b">// Run TSR-Calc-2</font>
<font color="#85994b">// - Set up tsrData, inputData, and calculationData</font>
<font color="#85994b">// - Run Tax Liability Calculation (Refer to Tax Liability Section)</font>
taxOnGain_2 = totalGainsLiability_TSR_Calc_2
gainsTaxableIncome_2 = totalGainsTaxableIncome_TSR_Calc_2

<font color="#85994b">// Step 5: Basic Rate on annualised amount</font>
basicRateOnAnnualisedAmount = roundDown((ukBasicRate / 100) * totalAnnualisedGainAmount, 2) <font color="#85994b">// Round down to 2 decimal places</font>

<font color="#85994b">// Step 6: Calculate the new gains difference</font>
gainsDifference = max(taxOnGain_2 - basicRateOnAnnualisedAmount, 0) <font color="#85994b">// Ensure non-negative value</font>

// Step 7: Calculate years adjustment
yearsAdjustment = roundDown(gainsDifference * (gainsTaxableIncome_1 / totalAnnualisedGainAmount), 2) <font color="#85994b">// Round down to 2 decimal places</font>

<font color="#85994b">// Step 8: Final Relief amount
tsrReliefAmount = roundDown(remainingTaxOnGain - yearsAdjustment, 2) <font color="#85994b">// Round down to 2 decimal places</font>

<font color="#85994b">// Note: tsrReliefAmount contributes to totalReliefs, which is then factored into netIncomeTaxDue in the Tax Reduction Section</font>
   </code>
</pre>

## Other Reliefs

Some parameters used as inputs for other reliefs calculations are in the Individuals Reliefs API.

Below is the calculation pseudocode for other reliefs including investment reliefs, maintenance payments and non-deductible loan interest.

<pre>
   <code>
<font color="#85994b">// Input parameters</font>
reliefs = [
relief {
reliefType, <font color="#85994b">// Type of relief</font>
amountClaimed <font color="#85994b">// Amount claimed for the relief</font>
}
]
incomeTaxCharged <font color="#85994b">// Refer to Income tax liability</font>
qmpLimit <font color="#85994b">// Refer to the config file</font>
qmpRate <font color="#85994b">// Refer to the config file</font>
vctRate <font color="#85994b">// Refer to the config file</font>
eisRate <font color="#85994b">// Refer to the config file</font>
citrRate <font color="#85994b">// Refer to the config file</font>
seisRate <font color="#85994b">// Refer to the config file</font>
sitrRate <font color="#85994b">// Refer to the config file</font>
pppBasicRate <font color="#85994b">// Refer to "BRT" rate under UK incomeTaxBands in the config file</font>

<font color="#85994b">// Specific relief investment types</font>
reliefType = [
"vctSubscriptions",
    "eisSubscriptions",
    "communityInvestment",
    "seedEnterpriseInvestment",
    "socialEnterpriseInvestment",
    "maintenancePayments",
    "nonDeductableLoanInterest"
]

<font color="#85994b">// Other parameters for calculations</font>
remainingTaxCharged <font color="#85994b">// Income tax charged before reliefs</font>
totalClaimAmount = 0 <font color="#85994b">// Sum of the total reliefs claimed for each relief type</font>
allowableAmount <font color="#85994b">// Other relief amounts</font>
amountUsed = 0 <font color="#85994b">// Relief amount that is applied to income tax charged</font>
otherReliefs = 0 <font color="#85994b">// Other reliefs</font>

<font color="#85994b">// Calculate before relief
<font color="#1d70b8">if </font>incomeTaxCharged is null <font color="#1d70b8">then</font>
    remainingTaxCharged = 0
<font color="#1d70b8">else</font>
    remainingTaxCharged = roundDown(incomeTaxCharged, 2) <font color="#85994b">// Round down to 2 decimal places</font>
end <font color="#1d70b8">if</font>

<font color="#85994b">// Step 1: Calculate totalClaimAmount for investment relief types</font>
for each relief in reliefs
    totalClaimAmount[reliefType] = roundUp(totalClaimAmount[reliefType] + amountClaimed, 0) <font color="#85994b">// Round up to nearest whole pound</font>

<font color="#85994b">// Cap the total claim amount for maintenancePayments</font>
<font color="#1d70b8">if</font> relief.reliefType is "maintenancePayments"</font>
<font color="#1d70b8">if </font>totalClaimAmount[reliefType] + relief.amountClaimed < qmpLimit <font color="#1d70b8">then</font>
            totalClaimAmount[reliefType] = totalClaimAmount[reliefType] + relief.amountClaimed
<font color="#1d70b8">else
            totalClaimAmount[reliefType] = qmpLimit
        end <font color="#1d70b8">if</font>
    end <font color="#1d70b8">if</font>
end <font color="#1d70b8">for</font>

<font color="#85994b">// Step 2: Calculate allowableAmount, amountUsed, and update remaining tax liability</font>
for each reliefType in totalClaimAmount

<font color="#85994b">// Determine applicable relief rate for investment reliefs</font>
<font color="#1d70b8">if</font> reliefType is "vctSubscriptions" <font color="#1d70b8">then</font>
        reliefRate = vctRate
<font color="#1d70b8">else if</font> reliefType is "eisSubscriptions" <font color="#1d70b8">then</font>
        reliefRate = eisRate
    <font color="#1d70b8">else if</font> reliefType is "communityInvestment" <font color="#1d70b8">then</font>
        reliefRate = citrRate
<font color="#1d70b8">else if</font> reliefType is "seedEnterpriseInvestment" <font color="#1d70b8">then</font>
        reliefRate = seisRate
    <font color="#1d70b8">else if</font> reliefType is "socialEnterpriseInvestment" <font color="#1d70b8">then</font>
        reliefRate = sitrRate
<font color="#1d70b8">else if</font> reliefType is "maintenancePayments" <font color="#1d70b8">then</font>
        reliefRate = qmpRate
    <font color="#1d70b8">else if</font> reliefType is "nonDeductableLoanInterest" <font color="#1d70b8">then</font>
        reliefRate = pppBasicRate
    <font color="#1d70b8">else</font>
        reliefRate = 100%// default
    end <font color="#1d70b8">if</font>

<font color="#85994b">// Calculate allowable relief amount</font>
    allowableAmount = roundUp(totalClaimAmount[reliefType] * (reliefRate / 100), 2) <font color="#85994b">// Round up to 2 decimal places</font>

<font color="#85994b">// Determine amount used, ensuring it does not exceed remaining tax liability</font>
    amountUsed = min(allowableAmount, remainingTaxCharged)

<font color="#85994b">// Update remaining tax liability and other reliefs</font>
    remainingTaxCharged = remainingTaxCharged - amountUsed
    otherReliefs = otherReliefs + amountUsed
end <font color="#1d70b8">for</font>
   </code>
</pre>

## Residential finance costs

Tax relief on finance costs for landlords of residential properties is restricted to the basic rate of Income Tax. For more information, refer to [Tax relief for residential landlords: how it's worked out (GOV.UK)](https://www.gov.uk/guidance/changes-to-tax-relief-for-residential-landlords-how-its-worked-out-including-case-studies).

Most parameters used as inputs for residential finance costs calculations are in the [Property Business API](https://developer.service.hmrc.gov.uk/api-documentation/docs/api/service/property-business-api/).

### UK

Below is the calculation pseudocode for relief of UK residential finance costs.

<pre>
   <code>
<font color="#85994b">// Input parameters</font>
residentialFinanceCost <font color="#85994b">// Captures residential financial cost that can be deductible from rental income (tax relief). API parameter name: residentialFinancialCost</font>
residentialFinanceCostCarriedForward <font color="#85994b">// Amount of residential financial costs carried forward. API parameter name: residentialFinancialCostsCarriedForward</font>
taxableProfitFromUkOther <font color="#85994b">// Refer to taxableProfitFromUkPropertyOther inCalculating total taxable property profit</font>

<font color="#85994b">// Other parameters used for calculations </font>
residentialFinanceCostsAvailableForRelief <font color="#85994b">// Residential finance costs available for relief</font>
totalUKAllowableAmount <font color="#85994b">// Total UK allowable amount</font>

<font color="#85994b">// Calculate residential finance costs available for relief</font>
residentialFinanceCostsAvailableForRelief = roundUp(residentialFinanceCost +residentialFinanceCostCarriedForward, 0) <font color="#85994b">// Round up to nearest whole pound</font>

<font color="#85994b">// Limit claimed costs to total allowable amount</font>
totalUKAllowableAmount = min(residentialFinanceCostsAvailableForRelief, taxableProfitFromUkOther)
   </code>
</pre>

### Foreign

Below is the calculation pseudocode for relief of foreign residential finance costs.

<pre>
   <code>
<font color="#85994b">// Input parameters</font></font>
RfcForeignProperty = [ 
    country {
        countryCode, <font color="#85994b">// A three-letter code that represents a country name </font></font>
residentialFinancialCostAmount, <font color="#85994b">// The residential financial cost deductible from rental income (tax relief). API parameter name: residentialFinancialCost</font></font>
        broughtFwdResidentialFinancialCostAmount, <font color="#85994b">// Amount of relief brought forward for restricted residential financial costs</font></font>
taxableProfitFromForeignPropertyOther <font color="#85994b">// Refer to Calculating total taxable property profit</font></font>
    }
]

<font color="#85994b">// Other parameters used for calculations </font>
residentialFinanceCostsClaimedForRelief <font color="#85994b">// Residential finance costs claimed for relief</font>
residentialFinanceCostsAvailableForRelief <font color="#85994b">// Residential finance costs available for relief</font>
totalForeignPropertyAllowableAmount=0 <font color="#85994b">// Total foreign property allowable amount</font>

<font color="#85994b">// Calculate total allowable amount for foreign property</font>
<font color="#1d70b8">for</font> each country in RfcForeignProperty
    residentialFinanceCostsClaimedForRelief = roundUp(country.residentialFinancialCostAmount +
                                              country.broughtFwdResidentialFinancialCostAmount , 0) <font color="#85994b">// Round up to nearest whole pound</font>
residentialFinanceCostsAvailableForRelief = min(residentialFinanceCostsClaimedForRelief, taxableProfitFromForeignPropertyOther)\
totalForeignPropertyAllowableAmount = roundUp(totalForeignPropertyAllowableAmount +
residentialFinanceCostsAvailableForRelief, 2) <font color="#85994b">// Round up to 2 decimal places\</font>
end <font color="#1d70b8">for</font>

### All other income received whilst abroad

Below is the calculation pseudocode for relief of foreign residential finance costs.

<font color="#85994b">// Input parameters</font></font></font>
RfcOtherIncomeWhilstAbroadDetail = [ 
    country {
        countryCode, <font color="#85994b">// A three-letter code that represents a country name </font></font></font>
        taxableAmount, <font color="#85994b">// The amount of tax to be paid</font></font></font>
residentialFinancialCostAmount, <font color="#85994b">// The residential financial cost deductible from rental income (tax relief). API parameter name: residentialFinancialCost</font></font></font>
        broughtFwdResidentialFinancialCostAmount <font color="#85994b">// Amount of relief brought forward for restricted residential financial costs</font></font></font>
    }
]

<font color="#85994b">// Other parameters used for calculations </font></font></font>
residentialFinanceCostsClaimedForRelief <font color="#85994b">// Residential finance costs claimed for relief</font></font></font>
residentialFinanceCostsAvailableForRelief <font color="#85994b">// Residential finance costs available for relief</font></font></font>
totalOtherIncomeAllowableAmount =0 <font color="#85994b">// Total other income allowable amount</font></font></font>

<font color="#85994b">// Calculate total allowable amount for Other property</font></font>
<font color="#1d70b8">for</font></font> each country in RfcOtherIncomeWhilstAbroadDetail
residentialFinanceCostsClaimedForRelief = country.residentialFinancialCostAmount +
                                              country.broughtFwdResidentialFinancialCostAmount
residentialFinanceCostsAvailableForRelief = min(residentialFinanceCostsClaimedForRelief, taxableAmount)
    totalOtherIncomeAllowableAmount = roundUp(totalOtherIncomeAllowableAmount +
residentialFinanceCostsAvailableForRelief, 2) <font color="#85994b">// Round up to 2 decimal places</font></font>
end <font color="#1d70b8">for</font></font>
   </code>
</pre>

### Total

Below is the calculation pseudocode for relief of total residential finance costs.

<pre>
   <code>
<font color="#85994b">// Input parameters</font>
totalIncomeFromAllSources <font color="#85994b">// Total income from all sources. Refer to Income summary totals</font>
totalAllowances <font color="#85994b">// Total allowances. Refer to totalAllowancesAndDeductions in Total allowances</font>
totalUKAllowableAmount <font color="#85994b">// Total UK allowable amount. Refer to Residential finance costs UK</font>
totalForeignPropertyAllowableAmount <font color="#85994b">// Total foreign property allowable amount. Refer to Residential finance costs Foreign
totalOtherIncomeAllowableAmount <font color="#85994b">// Total other income allowable amount. Refer to Residential finance costs All other income received whilst abroad</font>
ukBasicRate <font color="#85994b">// Refer to "BRT" rate under UK incomeTaxBands in the config file</font>

<font color="#85994b">// Other parameters used for calculations</font>
adjustedTotalIncome <font color="#85994b">// Adjusted total income</font>
totalAllowableAmount <font color="#85994b">// Total allowable amount</font>
relievableAmount <font color="#85994b">// Relievable amount</font>
totalResidentialFinanceCostsRelief <font color="#85994b">// Total residential finance costs relief</font>

<font color="#85994b">// Calculate adjusted total income</font></font>
adjustedTotalIncome = totalIncomeFromAllSources -- totalAllowances

<font color="#85994b">// Sum all allowable relief values</font></font>
totalAllowableAmount = roundUp(totalUKAllowableAmount + totalOtherIncomeAllowableAmount + totalForeignPropertyAllowableAmount, 2) <font color="#85994b">// Round up to 2 decimal places</font></font>

<font color="#85994b">// Ensure total relief does not exceed adjusted net income</font></font>
relievableAmount = roundUp(min(adjustedTotalIncome, totalAllowableAmount), 2)<font color="#85994b">// Round up to 2 decimal places</font></font>

<font color="#85994b">// Calculate the final residential finance cost relief
totalResidentialFinanceCostsRelief = roundUp(relievableAmount * (ukBasicRate / 100), 2) <font color="#85994b">// Round up to 2 decimal places</font></font>
   </code>
</pre>

## Foreign Tax Credit Relief

Foreign Tax Credit Relief (FTCR) provides relief for foreign tax paid on overseas income or gains that are also taxed in the UK. For information about Foreign Tax Credit Relief, refer to [Relief for Foreign Tax Paid 2024 (HS263) (GOV.UK)](https://www.gov.uk/government/publications/calculating-foreign-tax-credit-relief-on-income-hs263-self-assessment-helpsheet/relief-for-foreign-tax-paid-2024-hs263).

Some parameters used as inputs for dividends income calculations are in the [Individuals Reliefs API](https://developer.service.hmrc.gov.uk/api-documentation/docs/api/service/individuals-reliefs-api/), [Individuals Employments Income API](https://developer.service.hmrc.gov.uk/api-documentation/docs/api/service/individuals-employments-income-api/) and [Individuals Savings Income API](https://developer.service.hmrc.gov.uk/api-documentation/docs/api/service/individuals-savings-income-api/).

Below is the calculation pseudocode for Foreign Tax Credit Relief.

<pre>
   <code>
<font color="#85994b">// Input parameters 
<font color="#85994b">// Parameter names are same as API parameter names
foreignIncomeTaxCreditReliefs = [
ftcr {
    countryCode, <font color="#85994b">// A three-letter code that represents a country name </font>
    foreignTaxPaid, <font color="#85994b">// Foreign tax paid</font>
    taxableAmount, <font color="#85994b">// Net income after foreign tax deduction</font>
    employmentLumpSum <font color="#85994b">// Total foreign tax deducted from income</font>
  }  
foreignIncomes = [  
  foreignSavings {  
    countryCode, <font color="#85994b">// A three-letter code that represents a country name. Parameter name is same as API parameter name </font>
    grossIncome, <font color="#85994b">// Total income (in UK pounds) before foreign tax deduction. API parameter name: amountBeforeTax  </font>
    netIncome, <font color="#85994b">// Net income after foreign tax deduction. API parameter name: taxableAmount  </font>
    taxDeducted <font color="#85994b">// Total foreign tax deducted from income. API parameter name: taxTakenOff  </font>
  }  
  reliefsForeignIncomeImpl = {  
    employmentLumpsum, <font color="#85994b">// Indicates if employment lump sum for Foreign Tax Credit Relief has been claimed. Parameter name is same as API parameter name  </font>
    uniqueInvestmentRef, <font color="#85994b">// Unique Investment Reference (UIR) or name of authorising tax office (as shown on certificate). Parameter name is same as API parameter name </font>
    taxableAmount, <font color="#85994b">// Total taxable amount on foreign income. Parameter name is same as API parameter name  </font>
    taxDeducted, <font color="#85994b">// Total foreign tax deducted from income. API parameter name: taxTakenOff     </font>
    foreignTaxCreditRelief, <font color="#85994b">// Indicates if Foreign Tax Credit Relief (FTCR) is claimed. Parameter name is same as API parameter name  </font>
    sourceId, <font color="#85994b">// Unique identifier of foreign income source  </font>
    countryCode <font color="#85994b">// A three-letter code that represents a country name. Parameter name is same as API parameter name  </font>
  }  
permutations <font color="#85994b">// Array containing different permutations of multiple foreign incomes
incomeSourceTypeCode <font color="#85994b">// Indicates type of income source

<font color="#85994b">// Initialise variables for Foreign Tax Credit (FTC) components  </font>
<font color="#85994b">// Each component represents a specific type of income  </font>
A = 0 <font color="#85994b">// foreignTaxCreditReliefOnProperty (incomeSourceTypeCode "15")  </font>
B = 0 <font color="#85994b">// foreignTaxCreditReliefOnSavings (incomeSourceTypeCode "16")  </font>
C = 0 <font color="#85994b">// foreignTaxCreditReliefOnDividends (incomeSourceTypeCode "07")  </font>
D = 0 <font color="#85994b">// foreignTaxCreditReliefOnForeignIncome (incomeSourceTypeCode "19")  </font>
E = 0 <font color="#85994b">// foreignTaxCreditReliefOnForeignPension (incomeSourceTypeCode "20")  </font>
F = 0 <font color="#85994b">// foreignTaxCreditReliefOnEmploymentIncome (incomeSourceTypeCode "05")</font>

<font color="#85994b">// Methods </font>
calculateAdjustedNetIncome <font color="#85994b">// Calculates adjusted net income</font>
calculateUkTaxDueWithForeignIncome <font color="#85994b">// Calculates UK tax due with foreign income  </font>
calculateUkTaxDueWithoutForeignIncome <font color="#85994b">// Calculates UK tax excluding foreign income  </font>
calculateUkTaxOnIncome <font color="#85994b">// Calculates UK tax on specific foreign income</font>
getDtaAmount <font color="#85994b">// Calculates Double Tax Agreement (DTA) amount based on corresponding rate of source country</font>
assignForeignTaxCreditComponent <font color="#85994b">// Assigns Foreign Tax Credit to appropriate component based on incomeSourceTypeCode</font>

<font color="#85994b">// Other parameters used for calculations</font>
adjustedNetIncome <font color="#85994b">// Adjusted net income</font>
ukTaxDueWithForeignIncome <font color="#85994b">// UK tax due with foreign income  </font>
ukTaxDueWithoutForeignIncome <font color="#85994b">// UK tax due excluding foreign income  </font>
foreignTaxCredit = 0 <font color="#85994b">// Foreign tax credit. Initialise total</font>
ukTaxLiabilityOnForeignIncome <font color="#85994b">// Uk tax liability on foreign income</font>
numberOfForeignIncomes <font color="#85994b">// Number of foreign income sources</font>
maxForeignTaxCredit <font color="#85994b">// Maximum amount of foreign tax credit</font>
bestPermutation <font color="#85994b">// Array containing permutation of foreign income sources that gives the maximum amount of foreign tax credit</font>
bestFTCComponents <font color="#85994b">// Array storing optimal Foreign Tax Credit component values </font>
income <font color="#85994b">// Singular foreign income</font>
ukTaxOnIncome <font color="#85994b">// Uk tax liability on specific foreign income</font>
dtaAmount <font color="#85994b">// Double Tax Agreement (DTA) amount</font>
remainingUkTaxLiability <font color="#85994b">// Remaining UK tax liability</font>
ftcForIncome <font color="#85994b">// Foreign tax credit for specific income</font>
totalUkTaxLiability <font color="#85994b">// Total UK tax liability</font>

<font color="#85994b">// Assign properties and determine income type for each income source  </font>
<font color="#1d70b8">for</font> each income in foreignIncomes
    <font color="#1d70b8">if</font> income is instance of reliefsForeignIncomeImpl <font color="#1d70b8">then</font>
        <font color="#85994b">// Map relevant properties from reliefsForeignIncomeImpl  </font>
        ftcr.taxableamount = taxableAmount  
        ftcr.foreignTaxPaid = taxDeducted  
        ftcr.countryCode = countryCode  
        <font color="#85994b">// Set income source type  </font>
        <font color="#1d70b8">if</font> employmentLumpsum = true <font color="#1d70b8">then</font>
            incomeSourceTypeCode = "05" <font color="#85994b">// Employment income  </font>
        <font color="#1d70b8">else</font>
            incomeSourceTypeCode = "19" <font color="#85994b">// Other foreign income  </font>
        end <font color="#1d70b8">if</font>
    <font color="#1d70b8">else if</font> income is instance of foreignSavings then  
        <font color="#85994b">// Map relevant properties from foreignSavings  
        ftcr.taxableamount = netIncome  
        ftcr.foreignTaxPaid = taxDeducted  
        ftcr.countryCode = countryCode     
        <font color="#85994b">// Assign income source type code for savings  </font>
        incomeSourceTypeCode = "16" <font color="#85994b">// Foreign savings income  </font>
    <font color="#1d70b8">end if  </font>
<font color="#1d70b8">end for  </font>

<font color="#85994b">// Calculate tax values required for Foreign Tax Credit calculation  </font>
adjustedNetIncome = calculateAdjustedNetIncome() <font color="#85994b">// Based on HMRC rules  </font>
ukTaxDueWithForeignIncome = calculateUkTaxDueWithForeignIncome() <font color="#85994b">// UK tax with foreign income  </font>
ukTaxDueWithoutForeignIncome = calculateUkTaxDueWithoutForeignIncome() <font color="#85994b">// UK tax excluding foreign income  </font>

<font color="#85994b">// Calculate UK tax liability on foreign income  </font>
ukTaxLiabilityOnForeignIncome = ukTaxDueWithForeignIncome - ukTaxDueWithoutForeignIncome  
ukTaxLiabilityOnForeignIncome = roundDown(ukTaxLiabilityOnForeignIncome, 2) <font color="#85994b">// Round down to 2 decimal places  </font>

<font color="#85994b">// Determine number of foreign income sources (maximum number permitted = 5)  </font>
numberOfForeignIncomes = length(foreignIncomes)  

<font color="#85994b">// Prepare for Foreign Tax Credit optimisation across income sources  </font>
maxForeignTaxCredit = 0
bestPermutation = []  
bestFTCComponents = [A, B, C, D, E, F] <font color="#85994b">// Store optimal Foreign Tax Credit component values  </font>

<font color="#85994b">// Calculate Foreign Tax Credit for single foreign income source  </font>
<font color="#1d70b8">if</font> numberOfForeignIncomes = 1 <font color="#1d70b8">then </font>
    <font color="#85994b">// Process single foreign income directly  </font>
    income = foreignIncomes[0]  
    <font color="#85994b">// Calculate UK tax liability on this foreign income  </font>
    ukTaxOnIncome = calculateUkTaxOnIncome(income)  
    ukTaxOnIncome = roundDown(ukTaxOnIncome, 2) // Round down to 2 decimal places 
    <font color="#85994b">// Ensure UK tax on this income does not exceed total liability  </font>
    ukTaxOnIncome = min(ukTaxOnIncome, ukTaxLiabilityOnForeignIncome)  
    <font color="#85994b">// Get applicable DTA amount for the country  </font>
    dtaAmount = getDtaAmount(income)  
    <font color="#85994b">// Calculate Foreign Tax Credit for this income using the minimum of foreign tax paid, UK tax, and DTA limit  </font>
    foreignTaxCredit = max(min(ftcr.foreignTaxPaid, dtaAmount, ukTaxOnIncome), 0) // Ensure non-negative value
    foreignTaxCredit = roundDown(foreignTaxCredit, 2) // Round down to 2 decimal places
    <font color="#85994b">// Assign Foreign Tax Credit to appropriate component based on incomeSourceTypeCode  </font>
    assignForeignTaxCreditComponent(incomeSourceTypeCode, foreignTaxCredit)      
<font color="#1d70b8">else</font>

<font color="#85994b">// Handle multiple foreign incomes with permutations and assign them in an array "permutations" </font>
    foreach permutation in permutations

        <font color="#85994b">// Reset Foreign Tax Credit components each permutation  </font>
        A = 0
        B = 0
        C = 0
        D = 0
        E = 0
        F = 0
        foreignTaxCredit = 0// Initialise Foreign Tax Credit for this permutation  
        remainingUkTaxLiability = ukTaxLiabilityOnForeignIncome         

        <font color="#85994b">// Process foreign incomes in the current permutation order  </font>
        <font color="#1d70b8">for</font> each income in permutation

            <font color="#85994b">// Calculate UK tax liability on this foreign income  </font>
            ukTaxOnIncome = calculateUkTaxOnIncome(income)  
            ukTaxOnIncome = roundDown(ukTaxOnIncome, 2) <font color="#85994b">// Round down to 2 decimal places</font>

            <font color="#85994b">// Ensure tax does not exceed remaining liability  </font>
            ukTaxOnIncome = min(ukTaxOnIncome, remainingUkTaxLiability)  

            <font color="#85994b">// Get DTA amount for the country  </font>
            dtaAmount = getDtaAmount(income)  

            //<font color="#85994b"> Calculate Foreign Tax Credit for this income  </font>
            ftcForIncome = max(min(ftcr.foreignTaxPaid, dtaAmount, ukTaxOnIncome), 0) <font color="#85994b">// Ensure non-negative value</font>
            ftcForIncome = roundDown(ftcForIncome, 2) <font color="#85994b">// Round down to 2 decimal places  </font>

            <font color="#85994b">// Assign Foreign Tax Credit to appropriate component based on incomeSourceTypeCode  </font>
            assignForeignTaxCreditComponent(incomeSourceTypeCode, ftcForIncome)  

            <font color="#85994b">// Accumulate Foreign Tax Credit  </font>
            foreignTaxCredit = foreignTaxCredit + ftcForIncome  

            <font color="#85994b">// Reduce remaining UK tax liability  </font>
            remainingUkTaxLiability = remainingUkTaxLiability - ftcForIncome  

            <font color="#85994b">// Stop processing if total liability is covered  </font>
            <font color="#1d70b8">if</font> remainingUkTaxLiability <= 0 <font color="#1d70b8">then</font>
                break
            <font color="#1d70b8">end if  </font>
        <font color="#1d70b8">end for  </font>

        <font color="#85994b">// Keep track of best Foreign Tax Credit configuration  </font>
        <font color="#1d70b8">if</font> foreignTaxCredit > maxForeignTaxCredit <font color="#1d70b8">then </font>
            maxForeignTaxCredit = foreignTaxCredit  
            bestPermutation = permutation  
            bestFTCComponents = [A, B, C, D, E, F]  
        <font color="#1d70b8">end if  </font>
    <font color="#1d70b8">end for  </font>

    <font color="#85994b">// Apply best Foreign Tax Credit configuration  </font>
    foreignTaxCredit = maxForeignTaxCredit  
    [A, B, C, D, E, F] = bestFTCComponents  
<font color="#1d70b8">end if  </font>

<font color="#85994b">// Calculate total Foreign Tax Credit from all components  </font>
foreignTaxCredit = A + B + C + D + E + F  

<font color="#85994b">// Apply Foreign Tax Credit to reduce UK tax liability  </font>
totalUkTaxLiability = ukTaxDueWithForeignIncome - foreignTaxCredit  
totalUkTaxLiability = roundDown(totalUkTaxLiability, 2) <font color="#85994b">// Round down to 2 decimal places  </font>

<font color="#85994b">// Ensure that Foreign Tax Credit does not affect adjusted net income or other tax reliefs  </font>

<font color="#85994b">// adjustedNetIncome = adjustedNetIncome - foreignTaxCredit </font>
   </code>
</pre>

## Shares and securities

A qualifying distribution on redemption of shares and securities refers to a payment made by a company to shareholders when buying back or redeeming shares. For more information refer to [Dividends and other company distributions (GOV.UK).](https://www.gov.uk/hmrc-internal-manuals/savings-and-investment-manual/saim5050)

Some parameters used as inputs for dividends income calculations are in the [Individuals Dividends Income API](https://developer.service.hmrc.gov.uk/api-documentation/docs/api/service/individuals-dividends-income-api/).

Below is the calculation pseudocode for Qualifying distribution redemption of shares and securities.

<pre>
   <code>
<font color="#85994b">// Input parameters</font>
qualifyingDistributionRedemptionOfSharesAndSecuritiesAmountClaimed <font color="#85994b">// Qualifying distribution amount claimed for shares and securities. API parameter name: qualifyingDistributionRedemptionOfSharesAndSecurities.amount</font>
ukDividendsIncome <font color="#85994b">// UK dividends income. Refer to ukdividends in UK dividends</font>
otherUkDividendsIncome <font color="#85994b">// Other UK dividends income. Refer to otherUkdividends in UK dividends</font>
redeemableShares <font color="#85994b">// Total redeemable shares income. Refer to UK dividends</font>
bonusIssuesSecurities <font color="#85994b">// Total bonus issues of securities income. Refer to UK dividends</font>
dividendAdditionalRateAllocatedIncome <font color="#85994b">// Dividends income allocated to additional rate.Refer to Income Tax Liability</font>
dividendZeroRateAllocatedIncome <font color="#85994b">// Dividends income allocated to zero rate. Refer to Income Tax Liability</font>
dividendHigherRateAllocatedIncome <font color="#85994b">// Dividends income allocated to higher rate. Refer to Income Tax Liability</font>
dividendAdditionalRate <font color="#85994b">// Refer to "ART" rate under dividendBands in the config file</font>
dividendHigherRate <font color="#85994b">// Refer to "HRT" rate under dividendBands in the config file</font>
remainingTaxCharged <font color="#85994b">// Remaining tax charged. Refer to Other reliefs</font>

<font color="#85994b">// Other parameters used for calculations</font>
totalDividendIncome <font color="#85994b">// Total dividend income</font>
incomeInART <font color="#85994b">// Taxable dividend income in ART band</font>
incomeInHRT <font color="#85994b">// Taxable dividend income in BRT band</font>
allowableIncomeInART <font color="#85994b">// Allowable income in ART</font>
allowableIncomeInHRT <font color="#85994b">// Allowable income in HRT</font>
remainingQDROSAS <font color="#85994b">// Remaining qualifying distribution amount after ART</font>
artRedemption <font color="#85994b">// ART redemption relief</font>
hrtRedemption <font color="#85994b">// HRT redemption relief</font>
totalRedemptionRelief <font color="#85994b">// Total redemption relief</font>
allowableQDROSAS <font color="#85994b">// Allowable amount</font>
redemptionAmountUsed <font color="#85994b">// Redemption amount used</font>

<font color="#85994b">// Step 1: Calculate taxable dividend income in ART</font>
<font color="#85994b">// Note: added to CL to not include dividendZeroRateAllocatedIncome
incomeInART = dividendAdditionalRateAllocatedIncome - dividendZeroRateAllocatedIncome
</font>
<font color="#85994b">// Step 2: Calculate total dividend income</font>
<font color="#85994b">// Note: added to CL to not include otherUkDividendsIncome</font>
totalDividendIncome = ukDividendsIncome + otherUkDividendsIncome + redeemableShares + bonusIssuesSecurities

<font color="#85994b">// Step 3: Calculate allowable income in ART</font>
allowableIncomeInART = min(totalDividendIncome, incomeInART)

<font color="#85994b">// Step 4: Calculate ART redemption relief</font>
artRedemption = roundDown(allowableIncomeInART * (dividendAdditionalRate / 100), 2) <font color="#85994b">// Round down to 2 decimal places

<font color="#85994b">// Step 5: Calculate remaining qualifying distribution amount after ART</font>
<font color="#85994b">// Note: Raise CL to charge this as (totalDividendIncome - allowableIncomeInART)</font>
remainingQDROSAS = max(qualifyingDistributionRedemptionOfSharesAndSecuritiesAmountClaimed - allowableIncomeInART, 0) <font color="#85994b">// Ensure non-negative value

<font color="#85994b">// Step 6:  Calculate taxable dividend income in HRT</font>
<font color="#85994b">// Note: added to CL to not include dividendZeroRateAllocatedIncome</font>
incomeInHRT = dividendHigherRateAllocatedIncome - dividendZeroRateAllocatedIncome

<font color="#85994b">// Step 7: Calculate allowable income in HRT</font>
allowableIncomeInHRT = min(remainingQDROSAS, incomeInHRT)

<font color="#85994b">// Step 8:  Calculate HRT redemption relief</font>
hrtRedemption = roundDown(allowableIncomeInHRT * (dividendHigherRate / 100), 2) <font color="#85994b">// Round down to 2 decimal places

<font color="#85994b">// Step 9: Calculate total redemption relief</font>
totalRedemptionRelief = hrtRedemption + artRedemption

<font color="#85994b">// Step 10: Apply the reliefs to the remaining tax charged</font>
allowableQDROSAS = min(qualifyingDistributionRedemptionOfSharesAndSecuritiesAmountClaimed, totalRedemptionRelief)
redemptionAmountUsed = min(allowableQDROSAS, remainingTaxCharged)

<font color="#85994b">// Update remaining tax liability</font>
remainingTaxCharged = remainingTaxCharged - redemptionAmountUsed
   </code>
</pre>

## Total reliefs

Below is the calculation pseudocode for total allowances and reliefs.

<pre>
   <code>
<font color="#85994b">// Input parameters</font>
deficiencyReliefsAllowable <font color="#85994b">// Deficiency reliefs allowable. Refer to Deficiency relief</font>
tsrReliefAmount <font color="#85994b">// Top Slicing relief amount. Refer to Top slicing relief</font>
otherReliefs <font color="#85994b">// Total other reliefs. Refer to Other reliefs</font>
totalResidentialFinanceCostsRelief <font color="#85994b">// Total residential finance costs reliefs. Refer to Total Residential finance costs</font>
redemptionAmountUsed <font color="#85994b">// Amount of redemption of shares and securities used. Refer to Shares and securities</font>
foreignTaxCredit <font color="#85994b">// Total foreign tax credit. Refer to Foreign Tax Credit Relief</font>

<font color="#85994b">// Other parameters used for calculations</font>
totalReliefs <font color="#85994b">// Total reliefs</font>

<font color="#85994b">// Calculate total reliefs</font>
totalReliefs = deficiencyReliefsAllowable + tsrReliefAmount + otherReliefs + totalResidentialFinanceCostsRelief + redemptionAmountUsed + foreignTaxCredit
   </code>
</pre>