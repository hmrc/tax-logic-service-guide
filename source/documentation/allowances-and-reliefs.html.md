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

````
// Personal Allowances for tax year 2024-25
   // Earnings <= £100,000: Full Personal Allowance (£12,570)
   // Earnings £100,001–£125,140: Personal Allowance reduced by £1 for every £2 earned over £100,000
   // Earnings >= £125,140: Personal Allowance is £0

// Input parameters
adjustedNetIncome // Total taxable income before any Personal Allowances and less certain tax reliefs
personalAllowance // £12,570 for tax year 2024-25
reducedAllowanceLimit // £100,000 for tax year 2024-25

// Other parameter used for calculations
allowanceReductionAmount // Amount to reduce Personal Allowance for incomes > £100,000

// Calculate personalAllowance
if adjustedNetIncome <= reducedAllowanceLimit then
   personalAllowance = 12570
else if adjustedNetIncome > reducedAllowanceLimit and adjustedNetIncome < 125140 then
   allowanceReductionAmount = floor((adjustedNetIncome - reducedAllowanceLimit) / 2, 0) // Reduce by £1 for every £2 over £100,000 and round down to nearest whole pound  
   personalAllowance = ceiling(personalAllowance - allowanceReductionAmount, 0) // Round up to nearest whole pound
else if adjustedNetIncome >= 125140 then
   personalAllowance = 0  
end if
````