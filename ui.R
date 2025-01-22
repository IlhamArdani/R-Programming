library(shinydashboard)

ui <- dashboardPage(
  skin = "blue",
  dashboardHeader(title = "KawanPajakUMKM"),
  
  dashboardSidebar(
    sidebarMenu(id = "sidebar",
                menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
                menuItem("Input Data", tabName = "formdata", icon = icon("plus")),
                menuItem("Panduan", tabName = "panduan", icon = icon("book")),
                menuItem("Tentang Kami", tabName = "aboutus", icon = icon("users"))
    )
  ),
  
  dashboardBody(
    tabItems(
      tabItem(tabName = "dashboard",
              fluidRow(
                box(
                  width = 12,
                  title = "Halloo sobat UMKM!",
                  tags$p("Pusing ngelolah keuangan pajak? Tenang aja, ga perlu ribet! Kami hadirkan KawanPajakUMKM, solusi inovatif untuk membantu sobat UMKM menghitung pajak dengan mudah, cepat, dan akurat!"),
                  tags$br(),
                  tags$p("Kenapa sih harus pilih KawanPajakUMKM?"),
                  tags$ul(
                    tags$li("Hitung PPh Akhir lebih Cepat loh! Pake peraturan terbaru Peraturan Pemerintah RI No 55 Tahun 2022 sebagai aturan pelaksanaan UU No. 7 Tahun 2021 tentang Harmonisasi Peraturan Perpajakan, kira-kira PPh Final kamu jadi secepat kilat!"),
                    tags$li("Laporkan SPT UMKM Gampang! Buat dan laporkan SPT Tahunan UMKM dengan panduan yang jelas dan mudah dipahami."),
                    tags$li("Gak pake pusing! Kami membantu sobat UMKM memahami segala hal tentang pembayaran pajak UMKM, biar kamu ga bingung lagi!")
                  ),
                  tags$br(),
                  tags$p("KawanPajakUMKM berkomitmen membantu sobat UMKM berkembang dengan solusi perpajakan yang mudah dan terjangkau. Yuk, Bergabung bersama kami dan rasakan kemudahan dalam mengelola keuangan dan memenuhi kewajiban pajak kamu!")
                ),
                box(
                  width = 12,
                  title = "Hasil Data",
                  div(class = "table-responsive", tableOutput("table1")),
                  tags$style(HTML("
                    .box .table {
                      width: 100%;
                      white-space: nowrap;
                    }
                  "))
                )
              )
      ),
      
      tabItem(tabName = "formdata",
              fluidRow(
                box(
                  width = 12,
                  title = "Form Input Data",
                  hr(),
                  numericInput("januari", "Januari", value = NULL, min = 0, max = NA, step = 1),
                  numericInput("februari", "Februari", value = NULL, min = 0, max = NA, step = 1),
                  numericInput("maret", "Maret", value = NULL, min = 0, max = NA, step = 1),
                  numericInput("april", "April", value = NULL, min = 0, max = NA, step = 1),
                  numericInput("mei", "Mei", value = NULL, min = 0, max = NA, step = 1),
                  numericInput("juni", "Juni", value = NULL, min = 0, max = NA, step = 1),
                  numericInput("juli", "Juli", value = NULL, min = 0, max = NA, step = 1),
                  numericInput("agustus", "Agustus", value = NULL, min = 0, max = NA, step = 1),
                  numericInput("september", "September", value = NULL, min = 0, max = NA, step = 1),
                  numericInput("oktober", "Oktober", value = NULL, min = 0, max = NA, step = 1),
                  numericInput("november", "November", value = NULL, min = 0, max = NA, step = 1),
                  numericInput("desember", "Desember", value = NULL, min = 0, max = NA, step = 1),
                  
                  actionButton("submit", "Submit", class = "btn-info"),
                  
                  tags$style(HTML("
                   #shiny-tab-formdata .form-group {
                      margin: 5px;
                      width: 100%;
                      display: table;
                  }
                  #shiny-tab-formdata .control-label {
                      width: 200px;
                      display: table-cell;
                  }
                  #shiny-tab-formdata .form-control {
                      display: table-cell;
                      width: 200px;
                  }
                  "))
                )
              )
      ),
      
      tabItem(tabName = "panduan",
              fluidRow(
                tabBox(
                  title = "",
                  width = 12,
                  id = "tabset1", 
                  tabPanel("Panduan", 
                           tags$p('Berikut adalah tata cara untuk mengakses web ini'),
                           tags$img(src = "tatacara.png", style = "max-width: 100%; height: auto;"),
                           tags$br(),
                           tags$p('Berikut adalah tata cara pembayaran Pajak berdasarkan DJP'),
                           div(style = "position: relative; padding-bottom: 56.25%; height: 0; overflow: hidden; max-width: 100%;",
                               tags$iframe(style = "position: absolute; top: 0; left: 0; width: 100%; height: 100%;", 
                                           src = "https://www.youtube.com/embed/zn00tvtRRdY", 
                                           frameborder = "0", 
                                           allow = "accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture", 
                                           allowfullscreen = TRUE)
                           )
                  ),
                  
                  tabPanel("Peratuan", 
                           tags$p('Berikut adalah Peraturan Pemerintah RI No 55 Tahun 2022 sebagai aturan pelaksanaan UU No. 7 Tahun 2021 tentang Harmonisasi Peraturan Perpajakan'),
                           tags$iframe(style = "height: 600px; width: 100%;", src = "PP Nomor 55 Tahun 2022.pdf"),
                           tags$iframe(style = "height: 600px; width: 100%;", src = "Salinan UU Nomor 7 Tahun 2021.pdf")
                  )
                )
              )
      ),
      
      tabItem(tabName = "aboutus",
              fluidRow(
                box(
                  width = 12,
                  title = "Tentang Kami",
                  tags$p('KawanPajakUMKM adalah website yang dapat digunakan teman-teman UMKM sebagai tools untuk menghitung pajak UMKM terhutang yang harus dibayarkan. Dasar pengenaan pajak yang digunakan pada penghitungan ini adalah Peraturan Pemerintah RI No 55 Tahun 2022 sebagai aturan pelaksanaan UU No. 7 Tahun 2021 tentang Harmonisasi Peraturan Perpajakan. Teman-teman dapat meng-input data omzet atau penghasilan per bulan dan webiste akan menampilkan pajak terhutangnya. Selain itu, kami juga telah menyediakan link video panduan dari Direktorat Jenderal Pajak untuk proses pembayaran lebih lanjut.'),
                  tags$br(),
                  tags$p('Kami berharap website ini dapat memberikan manfaat bagi teman-teman UMKM terutama untuk keperluan penghitungan pajak UMKM.'),
                  tags$br(),
                  tags$p('Salam hangat,'),
                  tags$p('BR123456789'),
                  #tags$img(src = "1.jpeg", style = "max-width: 100%; height: auto;")
                )
              )
      )
    )
  )
)