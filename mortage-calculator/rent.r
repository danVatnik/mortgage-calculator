source('positiveNumberValidator.r')

rent = setRefClass("rent",
  contains = "positiveNumberValidator",
  fields = list(
    monthlyCost = 'numeric',
    yearlyIncrease = 'numeric',
    numberYears = 'numeric',
    totalSpent = 'numeric'
  ),
  methods = list(
    initialize = function(mC, yI, nY){
      validateInputs(mC, yI, nY)
      
      monthlyCost <<- mC
      yearlyIncrease <<- yI
      numberYears <<- nY
      
      calculateTotalRentSpent(monthlyCost, yearlyIncrease, numberYears)
    },
    calculateTotalRentSpent = function(mC, yI, nY){
      total = 0
      currentMonthlyCost = mC
      for (year in 1:nY) {
         total = total + currentMonthlyCost * 12
         currentMonthlyCost = currentMonthlyCost * (1 + yI / 100)
      }
      totalSpent <<- total
    },
    validateInputs = function(mC, yI, nY){
      validateNumber(mC)
      validateNumber(yI)
      validateNumber(nY)
    }
  )
)

renderRentInput = function(title, mcId, yiId, nId){
  fluidRow(
    column(12,
      h4(title, style = "margin-top: 0px; border-bottom: 1px solid #e3e3e3;"),
      numericInput(mcId, "Monthly Costs ($)", 3000, min = 0),
      numericInput(yiId, "Yearly Increase (%)", 0, min = 0),
      sliderInput(nId, label = "Number of years", min = 1, 
        max = 50, value = 25, width = "100%")
    )
  )
}