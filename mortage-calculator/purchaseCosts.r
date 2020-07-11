purchaseCosts = setRefClass("purchaseCosts",
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