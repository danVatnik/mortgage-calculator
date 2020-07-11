mortgage = setRefClass("mortgage",
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
    },
    validateNumber = function(n){
      if(!is.numeric(n)){
        stop("Input must be a number")
      }
      if(is.infinite(n)){
        stop("Input cannot be infinite")
      }
      if(is.nan(n)){
        stop("Input cannot be NaN")
      }
      if(n < 0){
        stop("Input cannot be negative")
      }
    }
  )
) 