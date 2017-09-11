library(shiny)
library(miniUI)
library(rstudioapi)
# HUOM! Pitää olla RStudion versio > 1.1.67 jotta rstudioapi:in showDialog -funktio toimii
# https://www.rstudio.com/products/rstudio/download/preview/ <- toimiva versio

# Yritin avata hieman koodia kommenteilla, tarkempaa tietoa yksittäisistä funktioista komennolla ?funktionNimi


# Jokainen Shiny Gadget määritellään funktioon
# Funktiolle voi antaa argumentteja, ja se voi myös palauttaa jonkin arvon myöhempää käyttöä varten
gadgetExample <- function() {

  # Gadgetin käyttöliittymä, front end
  ui <- miniPage(

    # Gadgetin yläpalkki
    # left = NULL ja right = NULL poistaa titlebarissa defaulttina olevat napit
    gadgetTitleBar(title = "TMC Gadget Example", left = NULL, right = NULL),

    # Gadgetin alapalkissa oleva tabien valinta
    # Argumentteina miniTabPanel:it jotka määrittävät yksittäisten tabien sisällön.
    miniTabstripPanel(

      # Gadgetin yksittäinen tabi
      # Argumentteinä tabin nimi ja ikoni, sekä UI elementtejä
      miniTabPanel(

        title = "Log in",
        icon = icon("user-circle-o"),


        # Gadgetin varsinainen UI sisältö
        # Argumentteina pääasiassa html ja erilaiset UI elementit
        # ?miniContentPanel
        miniContentPanel(

          h1("Log in"),

          # inputId:n avulla käyttäjän syöttämiin arvoihin päästään käsiksi serverin puolella
          textInput("username", label = "Username", value = "Username"),
          passwordInput("password", label ="Password", value = ""),

          actionButton(inputId = "login", label = "Log in")
        )


      ),

      miniTabPanel(

        title = "Exercises",
        icon = icon("folder-open"),

        miniContentPanel(

          selectInput(

            inputId = "courseSelect",
            label = "Select course",

            choices = list(

              "Introduction to Statistics and R I" = "Course 1",
              "Introduction to Statistics and R II" = "Course 2",
              "Data mining" = "Course 3"
            ),

            selected = 1
          ),


          # *Output -funktioilla saadaan näkyviin serverin puolella määriteltyä tietoa
          textOutput(outputId = "courseDisplay")
        )
      )
    )

  )


  # Gadgetin palvelinlogiikka, back end
  # input:in kautta päästään käsiksi käyttöliittymän arvoihin
  # output:in kautta annetaan käyttöliittymälle renderöitävää dynaamista sisältöä
  server <- function(input, output) {


    # Määritetään toiminnallisuus esim. nappien painalluksille
    # Argumentteina UI-elementit ja niille määritelty toiminnallisuus (funktio)
    observeEvent(input$login, {

      message <- ""
      title <- ""

      if (input$username == "user" && input$password == "1234") {

        title <- "Success!"
        message <- "Login successful!"
      } else {

        title <- "Failure"
        message <- "Login failure"
      }

      # showDialog tarvitsee RStudion version > 1.1.67 toimiakseen
      showDialog(title = title, message = message, url = "")
    }
    )

    # render* -funktioilla renderöidään käyttöliittymän puolella sisältä
    # serverin render* -funktiota vastaa *Output -funktio käyttöiittymän puolella
    #
    # esim. tässä käyttöliittymän textOutput(outputId = "courseDisplay") määritellään
    # renderöimään selectInput(inputId = "courseSelect", ...) valittu arvo
    # funktiolla renderText
    output$courseDisplay <- renderText({

      input$courseSelect
    })
  }

  # Lopuksi suoritetaan Shiny Gadget
  # Argumentteina yllä määriteltyt ui ja server, sekä lisäksi viewer
  # Viewer määrittää missä Shiny Gadget näytetään
  #   Vaihtoehtoina R-Studion viewer-pane, Rstudion päälle ilmestyvä dialogi-ikkuna sekä ulkopuolinen selain
  runGadget(ui, server, viewer = dialogViewer("TMC Gadget Example"))
}
