source('positiveNumberValidator.r')

budget = setRefClass("budget",
  contains = "positiveNumberValidator",
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
    }
  )
)