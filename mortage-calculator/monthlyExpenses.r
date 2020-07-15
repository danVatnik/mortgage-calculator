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

renderMonthlyExpensesInput = function(title, ptId, mId, iId, fId){
  fluidRow(
    column(12,
      h4(title, style = "margin-top: 0px; border-bottom: 1px solid #e3e3e3;"),
      numericInput(ptId, "Property Tax ($)", 3000, min = 0),
      numericInput(mId, "Maintenance ($)", 0, min = 0),
      numericInput(iId, "Insurance ($)", 0, min = 0),
      numericInput(fId, "Fees ($)", 0, min = 0),
    )
  )
}