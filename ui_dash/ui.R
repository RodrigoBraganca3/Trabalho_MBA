#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

install.packages("shiny")
install.packages("shinydashboard")
library(ggplot2)
library(shiny)
library(shinydashboard)


# Definindo UI #
ui <- fluidPage(
  
  # Título do aplicativo #
  titlePanel("Meu Dashboard Shiny"),
  
  # Sidebar com controles de seleção #
  sidebarLayout(
    sidebarPanel(
      selectInput("variavel", "Selecione a variável", choices = names(Dados_semChar), selected = NULL),
      sliderInput("limite_x", "Limite X", min = 0, max = 1000, value = c(0, 1000)),
      sliderInput("limite_y", "Limite Y", min = 0, max = 1000, value = c(0, 1000))
    ),
    
    # Área principal com o gráfico #
    mainPanel(
      plotOutput("line_plot")
    )
  )
)

# Definir servidor #
server <- function(input, output) {
  
  # Função para renderizar o gráfico em linha #
  output$line_plot = renderPlot({
    # Criar o gráfico em linha com ggplot2 #
    p = ggplot(Dados_semChar, aes_string(x = "Shopping", y = input$variavel)) +
      geom_line(color = "red") + # Alterar a cor da linha para vermelho
      xlim(input$limite_x[1], input$limite_x[2]) + # Definir limites do eixo X
      ylim(input$limite_y[1], input$limite_y[2]) # Definir limites do eixo Y
    
    # Exibir o gráfico #
    print(p)
  })
}

# Executar o aplicativo Shiny #
shinyApp(ui = ui, server = server)

