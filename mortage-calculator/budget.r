budget = setRefClass("budget",
  fields = list(
    netMonthlyRevenu = 'numeric',
    monthySpend = 'numeric',
    monthlySavings = 'numeric',
    availableBudget = 'numeric'
  ),
  methods = list(
    initialize = function(nMr, mSp, mSa){
      validateInputs(nMr, mSp, mSa)
      
      netMonthlyRevenu <<- nMr
      monthySpend <<- mSp
      monthlySavings <<- mSa
      availableBudget <<- netMonthlyRevenu - monthySpend - monthlySavings
    },
    validateInputs = function(nMr, mSp, mSa){
      validateNumber(nMr)
      validateNumber(mSp)
      validateNumber(mSa)
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