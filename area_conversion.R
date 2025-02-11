# Conversion function between acres and hectares
convert_area <- function(value, from = c("acres", "hectares")) {
  
  from <- match.arg(from)
  
  acre_to_hectare <- 0.404686
  hectare_to_acre <- 1 / acre_to_hectare
  
  if (from == "acres") {
    result <- value * acre_to_hectare
    message(sprintf("%f acres is equal to %f hectares", value, result))
  } else if (from == "hectares") {
    result <- value * hectare_to_acre
    message(sprintf("%f hectares is equal to %f acres", value, result))
  }
  
  return(result)
}

# Example usage:
# convert_area(10, "acres") # Converts 10 acres to hectares
# convert_area(4, "hectares") # Converts 4 hectares to acres


convert_area(15, from = "acres")
convert_area(15, from = "hectares")
