# Introduction

This guide outlines the scope and methodology for the calculation of taxes for the 2024-25 tax year, with a specific focus on the end-of-year finalisation process.

The document is intended for business analysts, software developers, and software testers developing software compatible with [Making Tax Digital for Income Tax APIs](https://developer.service.hmrc.gov.uk/api-documentation/docs/api?docTypeFilters=API&categoryFilters=INCOME_TAX_MTD).

> **Note:** This is a draft document and includes only a subset of the sections relevant to the example scenario outlined below. The final version will incorporate all sections and current content may be subject to change.

### Example Scenario

**_Persona_**

In this scenario consider ‘Steve the Painter’, who is currently living in the UK, is self-employed and has income from UK property (non-FHL). He receives state benefits and pays Class 4 National Insurance (NI).

**_Tax calculation for 2024-25_**&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(year ended 5 April 2025)

<table>
    <tr>
        <td colspan="6"><b>Income Received (before tax taken off)</b></td>
    </tr>
    <tr>
        <td colspan="2">Profit from self-employment</td>
        <td>£30,000</td>
        <td></td>
        <td></td>
        <td></td>
    </tr>
    <tr>
        <td colspan="2">Profit from UK land and property</td>
        <td>£5,000</td>
        <td></td>
        <td></td>
        <td></td>
    </tr>
    <tr>
        <td colspan="2">UK Pensions and state benefits</td>
        <td>£10,000</td>
        <td></td>
        <td></td>
        <td></td>
    </tr>
    <tr>
        <td colspan="2"><b>Total Income Received</b></td>
        <td></td>
        <td>£45,000</td>
        <td></td>
        <td></td>
    </tr>
    <tr>
        <td>minus</td>
        <td>Personal Allowance</td>
        <td></td>
        <td>£12,570</td>
        <td></td>
        <td></td>
    </tr>
    <tr>
        <td colspan="3"><b>Total Income on which tax is due</b></td>
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
        <td colspan="6"><b>How I have worked out your income tax</b></td>
    </tr>
    <tr>
        <td></td>
        <td colspan="5">Pay, Pensions, Profit etc. (UK rate for England and Northern Ireland)</td>
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
        <td colspan="2"><b>Total income on which tax has charged</b></td>
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
        <td colspan="5"><b>Income tax charged after allowance and reliefs</b></td>
        <td>£6,486.00</td>
    </tr>
    <tr>
        <td><b>plus</b></td>
        <td><b>Class 4 National Insurance contributions</b></td>
        <td>£17,430</td>
        <td>x 6% =</td>
        <td>£1,045.80</td>
        <td></td>
    </tr>
    <tr>
        <td></td>
        <td colspan="4"><b>Total Class 4 National Insurance contributions due</b></td>
        <td>£1,045.80</td>
    </tr>
    <tr>
        <td colspan="5"><b>Income tax and Class 4 National Insurance contributions due</b></td>
        <td>£7,531.80</td>
    </tr>
</table>

## Document structure

This document is structured to align with the tax calculation process:

- defining income and benefits
- applying allowances and reliefs
- detailing the tax calculation process

Each section is further divided into relevant subsections that include:

- description along with the relevant APIs used in the calculation
- input parameters from the APIs and other related sections
- other parameters referenced in the pseudocode
- pseudocode outlining the step-by-step calculation process

## Document changelog

#### 2nd April 2025 

Initial version published

## Getting help and support

If you have specific questions about this document or would like to provide feedback, please email [SDSTeam@hmrc.gov.uk](mailto:sdsteam@hmrc.gov.uk)