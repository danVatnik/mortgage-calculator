monthlyExpenses = setRefClass("monthlyExpenses",
  fields = list(
    propertyTax = 'numeric',
    maintenance = 'numeric',
    insurance = 'numeric',
    fees = 'numeric',
    total = 'numeric'
  ),
  methods = list(
    initialize = function(pT, m, i, f){
      validateInputs(pT, m, i, f)
      
      propertyTax <<- pT
      maintenance <<- m
      insurance <<- i
      fees <<- f
      total <<- propertyTax + maintenance + insurance + fees
    },
    validateInputs = function(pT, m, i, f){
      validateNumber(pT)
      validateNumber(m)
      validateNumber(i)
      validateNumber(f)
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