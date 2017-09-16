##These exercises are taken from the course "Data-analyysi R-ohjelmistolla"
#(https://wiki.helsinki.fi/pages/viewpage.action?pageId=135074576).
##

##Exercise 1

a1 <- 4 + 10
b1 <- 5*a1
c1 <- b1^3
d1 <- exp(b1)
e1 <- d1^(1/10)
f1 <- sin(c1)
res1 <- (b1 + c1 + e1 + f1)

##Exercise 2

a2 <- 51%%7

##Excercise 3
a3 <- 51%%7 + 51%/%7

##Excercise 4
v4_1 <- c(20, 5, -2, 3, 47)
v4_2 <- seq(0, 100, 5)
v4_3 <- c(v4_1, v4_2)
v4_4 <- v4_3[(v4_3 > 3) & (v4_3 < 50)]
