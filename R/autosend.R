
# rec <- c("evelyn_sit@mas.gov.sg","chow_chong_yang@mas.gov.sg", "russell_teng@mas.gov.sg",
#           "lim_jie_rong@mas.gov.sg", "lim_yun_ching@mas.gov.sg", "willy_heng@mas.gov.sg",
#           "ethel_ngiam@mas.gov.sg", "stanley_neo@mas.gov.sg")
# here <- ".\\output\\notebooks\\trading_swot.pdf"

#' Distribute daily trading update
#'
#' @return Side effect only: sends email to distribution list
#' @export
#'
#' @examples \donttest{email_update()}
email_update <- function(){

  #get api key
  mg_api_key <- Sys.getenv("mg_api_key")

  if (mg_api_key == ""){
    stop("Mailgun API credentials are missing. Please ensure they are provided.")
  }

  body <- paste(paste0("Generated @ ", Sys.time()), "- hope you make some money today!")
  subject <- paste("Daily Trading Update", Sys.Date())

  cmd <- paste0("curl -s --user 'api:", mg_api_key, "' https://api.mailgun.net/v3/eurdiv.ourlittlefam.net/messages")
  cmd <- paste(cmd, "-F from='Eurdiv bot <donotreply@eurdiv.ourlittlefam.net>'")
  cmd <- paste(cmd, paste0("-F subject='", subject, "'"))
  # cmd <- paste(cmd, "-F text='Hope you make some money today!'")
  cmd <- paste(cmd, "-F to='trading_updates@eurdiv.ourlittlefam.net'")
  cmd <- paste(cmd, paste0("-F text='", body, "'"))
  cmd <- paste(cmd, "-F attachment=@output/notebooks/trading_swot.pdf")
  # message(cmd)
  system(cmd)
}

#' Knit trading swot document
#'
#' @return Generates trading swot pdf
#' @export
#'
#' @examples \donttest{knit_swot()}
knit_swot <- function(){
  rmarkdown::render("./output/notebooks/trading_swot.Rmd")
}
