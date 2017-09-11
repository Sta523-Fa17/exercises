# Exercise 1 - Part 1


typeof(c(1, NA+1L, "C")) # (Flt, Int, Chr) => Chr

typeof(c(1L / 0, NA))    # (Flt, Log) => Flt

typeof(c(1:3, 5))        # (Int, Int, Int, Flt) => Flt

typeof(c(3L, NaN+1L))    # (Int, Flt) => Flt             

typeof(c(NA, TRUE))      # (Log, Log) => Log           



# Exercise 1 - Part 2

### Logical < Integer
### Logical < Double
### Logical < Character
### Integer < Double
### Integer < Character
### Double  < Character

### Logical < Integer < Float < Character


# Exercise 2

list(
  firstName = "John",
  lastName = "Smith",
  age = 25,
  address = list(
    streetAddress = "21 2nd Street",
    city = "New York",
    state = "NY",
    postalCode = 10021
  ),
  phoneNumber = list(
    list(
      type = "home",
      number = "212 555-1239"
    ), 
    list(
      type = "fax",
      number = "646 555-4567"
    )
  )
)


json = '
{
  "firstName": "John",
  "lastName": "Smith",
  "age": 25,
  "address": 
  {
    "streetAddress": "21 2nd Street",
    "city": "New York",
    "state": "NY",
    "postalCode": 10021
  },
  "phoneNumber": 
    [
      {
        "type": "home",
        "number": "212 555-1239"
      },
      {
        "type": "fax",
        "number": "646 555-4567"
      }
      ]
}'

x = jsonlite::fromJSON(json, simplifyVector = FALSE)



# Exercise 3

# bad = factor( c("rain", "rain", "clouds", "sun", "sun", "sun", "clouds"), levels = c("rain","clouds","snow"))

data = factor( c("rain", "rain", "clouds", "sun", "sun", "sun", "clouds"), levels = c("rain","clouds","sun","snow"))


scratch = c(1L, 1L, 2L, 3L, 3L, 3L, 2L)
attr(scratch, "levels") = c("rain","clouds","sun","snow")
attr(scratch, "class") = "factor"


