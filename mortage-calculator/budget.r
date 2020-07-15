source('positiveNumberValidator.r')

budget = setRefClass("budget",
  contains = "positiveNumberValidator",
  fields = list(
    netMonthlyRevenue = 'numeric',
    monthlySpend = 'numeric',
    monthlySavings = 'numeric',
    availableBudget = 'numeric'
  ),
  methods = list(
    initialize = function(nMr, mSp, mSa){
      validateInputs(nMr, mSp, mSa)
      
      netMonthlyRevenue <<- nMr
      monthlySpend <<- mSp
      monthlySavings <<- mSa
      availableBudget <<- netMonthlyRevenue - monthlySpend - monthlySavings
    },
    validateInputs = function(nMr, mSp, mSa){
      validateNumber(nMr)
      validateNumber(mSp)
      validateNumber(mSa)
    }
  )
)

renderBudgetInput = function(title, nMrId, mSpId, mSaId){
  fluidRow(
    column(12,
      h4(title, style = "margin-top: 0px; border-bottom: 1px solid #e3e3e3;"),
      numericInput(nMrId, "Net Monthly Revenue ($)", 3000, min = 0),
      numericInput(mSpId, "Monthly Spend ($)", 0, min = 0),
      numericInput(mSaId, "Monthly Savings ($)", 0, min = 0),
    )
  )
}