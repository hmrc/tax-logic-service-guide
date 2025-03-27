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
<font color="#85994b">// Earnings £100,001–£125,140: Personal Allowance reduced by £1 for every £2 earned over £100,000</font>
<font color="#85994b">// Earnings >= £125,140: Personal Allowance is £0</font>

<font color="#85994b">// Input parameters</font>
adjustedNetIncome <font color="#85994b">// Total taxable income before any Personal Allowances and less certain tax reliefs</font>
personalAllowance <font color="#85994b">// £12,570 for tax year 2024-25</font>
reducedAllowanceLimit <font color="#85994b">// £100,000 for tax year 2024-25</font>

<font color="#85994b">// Other parameter used for calculations</font>
allowanceReductionAmount <font color="#85994b">// Amount to reduce Personal Allowance for incomes > £100,000</font>

<font color="#85994b">// Calculate personalAllowance</font>
<font color="#1d70b8">if</font> adjustedNetIncome <= reducedAllowanceLimit <font color="#1d70b8">then</font>
   personalAllowance = 12570
<font color="#1d70b8">else if</font> adjustedNetIncome > reducedAllowanceLimit and adjustedNetIncome < 125140 <font color="#1d70b8">then</font>
   allowanceReductionAmount = roundDown((adjustedNetIncome - reducedAllowanceLimit) / 2, 0) <font color="#85994b">// Reduce by £1 for every £2 over £100,000 and round down to nearest whole pound  </font>
   personalAllowance = roundUp(personalAllowance - allowanceReductionAmount, 0) <font color="#85994b">// Round up to nearest whole pound</font>
<font color="#1d70b8">else if</font> adjustedNetIncome >= 125140 <font color="#1d70b8">then</font>
   personalAllowance = 0  
<font color="#1d70b8">end if</font>
   </code>
</pre>