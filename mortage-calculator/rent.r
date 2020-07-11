source('positiveNumberValidator.r')

rent = setRefClass("rent",
  contains = "positiveNumberValidator",
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
    }
  )
)