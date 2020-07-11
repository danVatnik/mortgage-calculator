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