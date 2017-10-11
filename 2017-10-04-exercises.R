library(stringr)

names = c("Haven Giron", "Newton Domingo", "Kyana Morales", "Andre Brooks", 
          "Jarvez Wilson", "Mario Kessenich", "Sahla al-Radi", "Trong Brown", 
          "Sydney Bauer", "Kaleb Bradley", "Morgan Hansen", "Abigail Cho", 
          "Destiny Stuckey", "Hafsa al-Hashmi", "Condeladio Owens", "Annnees el-Bahri", 
          "Megan La", "Naseema el-Siddiqi", "Luisa Billie", "Anthony Nguyen")

# detect if the person's first name starts with a vowel (a,e,i,o,u)

vowel = str_detect(names, "^[AEIOU]")
not_vowel = str_detect(names, "^[^AEIOU]")
xor(vowel, not_vowel)

names[vowel]

# detect if the person's last name starts with a vowel

vowel = str_detect(tolower(names), " [AEIOUaeiou]")

names[vowel]

# detect if either the person's first or last name start with a vowel

vowel = str_detect(names, "^[AEIOU]| [AEIOUaeiou]")
names[vowel]

# detect if neither the person's first nor last name start with a vowel

names[ !str_detect(names, "^[AEIOU]| [AEIOUaeiou]")]

names[ str_detect(names, "^[^AEIOU][A-Za-z]* [^AEIOUaeiou][A-Za-z]*") ]

str_detect("!Bob &smith", "^[^AEIOU][A-Za-z]* [^AEIOUaeiou][A-Za-z]*")



### Exercise 2

text = c("apple", "219 733 8965", "329-293-8753", "Work: (579) 499-7527; Home: (543) 355 3679")

str_match_all(text, "\\(?(\\d{3})\\)?[  -]\\d{3}[ -]\\d{4}")


