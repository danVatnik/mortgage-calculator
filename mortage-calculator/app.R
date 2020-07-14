source('mortgage.r')
source('monthlyExpenses.r')
source('purchaseCosts.r')
source('rent.r')
source('budget.r')
library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Application title
  titlePanel("Mortgage Calculator"),
  hr(),
  
  fluidRow(
    column(4,
      wellPanel(
        renderMortgageInput("propertyCost", "downPayment", "interestRate", "termLength"),
        renderBudgetInput("monthlyRevenue", "monthlySpend", "monthlySavings"),
        renderMonthlyExpensesInput("propertyTax", "maintenance", "insurance", "fees"),
        renderPurchaseCostsInput("purchaseTax", "inspection", "notary", 'otherPurchaseCosts'),
        renderRentInput("monthlyCost", "yearlyIncrease", "numberOfYears")
      )      
    ),
    
    column(8,
      fluidRow(
        textOutput("minimumMonthlyPayment")
      )

    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  # reactiveState <- reactiveValues()
  # reactiveState$mortage <- mortgage(input$propertyCost, input$downPayment, input$interestRate, input$termLength)

  # calculateMinimumMonthlyPayment <- function() {
  #     decimalInterest = input$interestRate / 100;
  #     monthlyInterest = decimalInterest / 12;
  #     numMonthsTermLength = input$termLength * 12;
  #     #return(3)
  #     return((monthlyInterest + monthlyInterest / ((1 + monthlyInterest) ^ numMonthsTermLength - 1)) * (input$propertyCost - input$downPayment));
  # }

  output$minimumMonthlyPayment <- renderText({
    m = mortgage(input$propertyCost, input$downPayment, input$interestRate, input$termLength)
    m$minimumMonthlyPayment
  })

  # output$distPlot <- renderPlot({
  #     # generate bins based on input$bins from ui.R
  #     x    <- faithful[, 2]
  #     bins <- seq(min(x), max(x), length.out = input$bins + 1)
  # 
  #     # draw the histogram with the specified number of bins
  #     hist(x, breaks = bins, col = 'darkgray', border = 'white')
  # })
}

# Run the application 
shinyApp(ui = ui, server = server)
