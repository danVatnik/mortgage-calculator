rent = setRefClass("rent",
  fields = list(
    monthlyCost = 'numeric',
    yearlyIncrease = 'numeric'
  ),
  methods = list(
    initialize = function(mC, yI){
      validateInputs(mC, yI)
      
      monthlyCost <<- mC
      yearlyIncrease <<- yI
    },
    validateInputs = function(mC, yI){
      validateNumber(mC)
      validateNumber(yI)
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