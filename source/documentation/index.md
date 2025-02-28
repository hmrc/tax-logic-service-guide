# Introduction

This guide outlines the scope and methodology for the calculation of taxes for the 2024-25 tax year, with a specific focus on the end-of-year finalisation process.

The document is intended for business analysts, software developers, and software testers developing software compatible with [Making Tax Digital for Income Tax APIs](https://developer.service.hmrc.gov.uk/api-documentation/docs/api?docTypeFilters=API&categoryFilters=INCOME_TAX_MTD).

> **Note:** This is a draft document and includes only a subset of the sections relevant to the example scenario outlined below. The final version will incorporate all sections and current content may be subject to change.

### Example Scenario

**_Persona_**

In this scenario, consider ‘Steve the Painter’, who is currently living in the UK, is self-employed and has income from UK property (non-FHL). He receives a State Benefit and pays Class 4 National Insurance (NI).

**_Tax calculation_**

<table>
    <tr>
        <td><b>Income Received (before tax taken off)</b></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
    </tr>
    <tr>
        <td>Profit from self-employment</td>
        <td></td>
        <td>£30,000</td>
        <td></td>
        <td></td>
        <td></td>
    </tr>
    <tr>
        <td>Profit from UK land and property</td>
        <td></td>
        <td>£5,000</td>
        <td></td>
        <td></td>
        <td></td>
    </tr>
    <tr>
        <td>UK Pensions and state benefits</td>
        <td></td>
        <td>£10,000</td>
        <td></td>
        <td></td>
        <td></td>
    </tr>
    <tr>
        <td><b>Total Income Received</b></td>
        <td></td>
        <td><b>£45,000</b></td>
        <td></td>
        <td></td>
        <td></td>
    </tr>
    <tr>
        <td>minus Personal Allowance</td>
        <td></td>
        <td></td>
        <td>£12,570</td>
        <td></td>
        <td></td>
    </tr>
    <tr>
        <td><b>Total Income on which tax is due</b></td>
        <td></td>
        <td></td>
        <td><b>£32,430</b></td>
        <td></td>
        <td></td>
    </tr>
    <tr>
        <td><b>How I have worked out your income tax</b></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
    </tr>
    <tr>
        <td></td>
        <td>Pay, Pensions, Profit (UK rate)</td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
    </tr>
    <tr>
        <td></td>
        <td></td>
        <td>Basic rate</td>
        <td>£32,430</td>
        <td>x 20% =</td>
        <td>£6,486.00</td>
    </tr>
    <tr>
        <td><b>Total income on which tax is being charged</b></td>
        <td></td>
        <td></td>
        <td>£32,430</td>
        <td></td>
        <td></td>
    </tr>
    <tr>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
    </tr>
    <tr>
        <td><b>Income tax charged after allowance &amp; relief</b></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td>£6,486.00</td>
    </tr>
    <tr>
        <td><b>plus Class 4 National Insurance</b></td>
        <td></td>
        <td></td>
        <td>£17,430</td>
        <td>x 6% =</td>
        <td>£1,045.80</td>
    </tr>
    <tr>
        <td><b>Total Class 4 National Insurance Due</b></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td>£1,045.80</td>
    </tr>
    <tr>
        <td><b>Total Income tax and NI due</b></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td>£7,531.80</td>
    </tr>
</table>

## Document structure

This document is structured to align with the tax calculation process:

- defining income and benefits
- applying allowances and reliefs
- detailing the tax calculation process

Each section is further divided into relevant subsections that cover the following:

- description along with relevant APIs used in the calculation
- input parameters from the APIs and other sections
- other parameters utilised in the tax calculation
- pseudocode outlining how the output is calculated, including rounding procedures

## Getting help and support

If you have specific questions about this document or would like to provide feedback, please email [makingtaxdigital-softwarevendors@hmrc.gov.uk](mailto:makingtaxdigital-softwarevendors@hmrc.gov.uk)