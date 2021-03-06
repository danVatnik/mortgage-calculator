source('positiveNumberValidator.r')

mortgage = setRefClass("mortgage",
  contains = "positiveNumberValidator",
  fields = list(
    propertyCost = 'numeric',
    downPayment = 'numeric',
    principal = 'numeric',
    interestRate = 'numeric',
    termLength = 'numeric',
    minimumMonthlyPayment = 'numeric',
    numMonthsToPayoff = 'numeric',
    totalInterestPaid = 'numeric',
    totalPropertyCost = 'numeric'
  ),
  methods = list(
    initialize = function(pC, dP, iR, tL){
      validateInputs(pC, dP, iR, tL)
      
      propertyCost <<- pC
      downPayment <<- dP
      principal <<- pC - dP
      interestRate <<- iR
      termLength <<- tL

      minimumMonthlyPayment <<- calculateMinimumMonthlyPayment(principal, termLength, interestRate)
      
      simulatePayoff(minimumMonthlyPayment)
      
      totalPropertyCost <<- propertyCost + totalInterestPaid
    },
    calculateMinimumMonthlyPayment = function(pR, tL, iR) {
      decimalInterest = iR / 100;
      monthlyInterest = decimalInterest / 12;
      numMonthsTermLength = tL * 12;
      return((monthlyInterest + monthlyInterest / ((1 + monthlyInterest) ^ numMonthsTermLength - 1)) * pR);
    },
    simulatePayoff = function(mP) {
      valueToPayoff = principal;
      numMonths = 0;
      totalInterest = 0;
      while(valueToPayoff > 0){
        interestAmount = interestRate / 12 / 100 * valueToPayoff;
        if(mP <= interestAmount){
          this.numMonthsToPayoff = NULL;
          this.totalInterestPaid = NULL;
          return();
        }
        principalPayoff = mP - interestAmount;
        valueToPayoff = valueToPayoff - principalPayoff;
        numMonths  = numMonths + 1;
        totalInterest = totalInterest + interestAmount;
      }
      numMonthsToPayoff <<- numMonths;
      totalInterestPaid <<- totalInterest;
    }
    
    ,
    validateInputs = function(pC, dP, iR, tL){
      validateNumber(pC)
      validateNumber(dP)
      validateNumber(iR)
      validateNumber(tL)

      if(dP > pC){
        stop("Down payment cannot be larger than the property cost")
      }
      if(tL <= 0 ){
        stop("Term length cannot be 0")
      }
    }
  )
)

renderMortgageInput = function(title, pcId, dpId, irId, tlId){
  fluidRow(
    column(12,
      h4(title, style = "margin-top: 0px; border-bottom: 1px solid #e3e3e3;"),
      numericInput(pcId, "Property Cost ($)", 350000, min = 0),
      numericInput(dpId, "Down Payment ($)", 35000, min = 0),
      numericInput(irId, "Interest Rate (%)", 3.845, min = 0),
      sliderInput(tlId, label = "Loan Term (yr)", min = 1, 
        max = 50, value = 25, width = "100%")
    )
  )
}