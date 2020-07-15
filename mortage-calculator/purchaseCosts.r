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

renderPurchaseCostsInput = function(title, ptId, iId, nId, oId){
  fluidRow(
    column(12,
      h4(title, style = "margin-top: 0px; border-bottom: 1px solid #e3e3e3;"),
      numericInput(ptId, "Purchase Tax ($)", 3000, min = 0),
      numericInput(iId, "Inspection ($)", 0, min = 0),
      numericInput(nId, "Notary ($)", 0, min = 0),
      numericInput(oId, "Other ($)", 0, min = 0),
    )
  )
}