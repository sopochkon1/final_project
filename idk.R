library(httr)
movies_df = GET("http://bechdeltest.com/api/v1/getMovieByImdbId?") %>% 
  content() %>%
  jsonlite::fromJSON() %>%
  as_tibble()

library(openssl)
cert <- download_ssl_cert("bechdeltest.com")
print(cert)
print(as.list(cert[[1]]))

cert_verify(cert, ca_bundle())

options(download.file.method = "curl", download.file.extra ="-k -L")
download.file("http://bechdeltest.com", "destfile")

x <- openssl::download_ssl_cert("bechdeltest.com")

lapply(x, `[[`, "validity")

getƒ <- function() {
  httr::GET("http://bechdeltest.com/api/v1/getMovieByImdbId?")
}

str(as.list(curl::curl_options("ssl_ver")))

httr::with_config(
  config = httr::config(ssl_verifypeer = FALSE),
  getƒ()
)