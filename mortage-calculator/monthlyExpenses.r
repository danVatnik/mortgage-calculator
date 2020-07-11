source('positiveNumberValidator.r')

monthlyExpenses = setRefClass("monthlyExpenses",
  contains = "positiveNumberValidator",
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
    }
  )
)