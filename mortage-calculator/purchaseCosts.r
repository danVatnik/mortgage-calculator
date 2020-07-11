source('positiveNumberValidator.r')

purchaseCosts = setRefClass("purchaseCosts",
  contains = "positiveNumberValidator",
  fields = list(
    purchaseTax = 'numeric',
    inspection = 'numeric',
    notary = 'numeric',
    other = 'numeric',
    total = 'numeric'
  ),
  methods = list(
    initialize = function(pT, i, n, o){
      validateInputs(pT, i, n, o)
      
      purchaseTax <<- pT
      inspection <<- i
      notary <<- n
      other <<- o
      total <<- purchaseTax + inspection + notary + other
    },
    validateInputs = function(pT, i, n, o){
      validateNumber(pT)
      validateNumber(i)
      validateNumber(n)
      validateNumber(o)
    }
  )
)