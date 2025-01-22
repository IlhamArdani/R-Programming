library(shiny)
library(shinyvalidate)
library(shinydashboard)


server <- function(input, output, session) {
  
  bulan_indonesia <- c("Januari", "Februari", "Maret", "April", "Mei", "Juni", "Juli", "Agustus", "September", "Oktober", "November", "Desember")
  
  # Fungsi untuk mengubah nilai bulan dari angka menjadi nama bulan
  convert_month <- function(month) {
    bulan_indonesia[as.numeric(month)]
  }
  
  # Fungsi untuk mendapatkan data pendapatan dan menghitung pajak
  getMyData <- function(pendapatan,raw=FALSE) {
    data <- data.frame(no = 1:12, pendapatan = as.numeric(pendapatan))
    data$bulan <- sapply(data$no, convert_month)
    data$akumulasi <- cumsum(data$pendapatan)
    
    if(raw){
      return(data)
    } 
    
    # Menghitung pajak
    pajak_per_bulan <- numeric(nrow(data))
    akumulasi_pajak <- numeric(nrow(data))
   
    pajak_awal <- FALSE
    
    for (i in 1:nrow(data)) {
      if (data$akumulasi[i] <= 500000000) {
        pajak_per_bulan[i] <- 0
      } 
      else if (data$akumulasi[i] < 4800000000) {
        if(pajak_awal){
          pajak_per_bulan[i] <- (data$pendapatan[i]) * 0.005
          print(pajak_per_bulan[i])
        }else{
          print('akumulasi')
          pajak_per_bulan[i] <- (data$akumulasi[i] - 500000000) * 0.005
          pajak_awal <- TRUE
        }
        
      } 
      else {
        pajak_per_bulan[i] <- 0
      }



      if (i > 1) {
        akumulasi_pajak[i] <- akumulasi_pajak[i-1] + pajak_per_bulan[i]
      } else {
        akumulasi_pajak[i] <- pajak_per_bulan[i]
      }
    }
    
    

    pajak <- ifelse(data$akumulasi <= 500000000, "Tidak kena pajak",
              ifelse(data$akumulasi < 4800000000,
                      format(as.numeric(pajak_per_bulan), nsmall = 0, big.mark = ".", scientific = FALSE),
                      "Pajak Badan Usaha"))                     

    
    akumulasi_pajak <- ifelse(data$akumulasi <= 500000000, "Tidak kena pajak",
              ifelse(data$akumulasi < 4800000000,
                      format(as.numeric(akumulasi_pajak), nsmall = 0, big.mark = ".", scientific = FALSE),
                      "Pajak Badan Usaha"))   

    data$pajak <- pajak
    data$akumulasi_pajak <- akumulasi_pajak
    
    data$pendapatan <- format(data$pendapatan, nsmall = 0, big.mark = ".", scientific = FALSE)
    data$akumulasi <- format(data$akumulasi, nsmall = 0, big.mark = ".", scientific = FALSE)
    
    data <- data[, c("no", "bulan", "pendapatan", "akumulasi", "pajak", "akumulasi_pajak")]
    
    colnames(data) <- c("no", "bulan", "pendapatan", "akumulasi pendapatan", "pajak per bulan", "akumulasi pajak")
    
    return(data)
  }
  
  iv <- InputValidator$new()
  
  for (bulan in c("januari", "februari", "maret", "april", "mei", "juni", "juli", "agustus", "september", "oktober", "november", "desember")) {
    iv$add_rule(bulan, sv_required(message = "harus diisi dan berupa angka"))
    iv$add_rule(bulan, sv_integer())
  }
  
  iv$enable()


    output$tableIsEmpty <- renderUI({
      return(FALSE)
    })

  
  observeEvent(input$submit, {
    if (iv$is_valid()) {
      pendapatan <- c(input$januari, input$februari, input$maret, input$april, 
                      input$mei, input$juni, input$juli, input$agustus, 
                      input$september, input$oktober, input$november, input$desember)
      
      output$table1 <- renderTable({
        getMyData(pendapatan)
      }, include.rownames = FALSE)
      
      for (bulan in c("januari", "februari", "maret", "april", "mei", "juni", "juli", "agustus", "september", "oktober", "november", "desember")) {
        updateNumericInput(session, bulan, value = NULL)
      }
      
      

      updateTabItems(session, "sidebar", "dashboard")  
    }
  })
}


