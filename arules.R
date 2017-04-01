setwd('C:/Users/azmfaridee/Documents/GitHub/is471-data-analytics-for-cybersecurity')
load('titanic.raw.rdata')
summary(titanic.raw)
# if you encounter the follwing error message
# "Error in library(arules) : there is no package called ‘arules’"
# execute the folowing line
# install.packages('arules')
library(arules)
rules.all <- apriori(titanic.raw)
inspect(rules.all)
rules <- apriori(titanic.raw, 
                 control = list(verbose=F), 
                 parameter = list(minlen=2, supp=0.005, conf=0.8),
                 appearance = list(rhs = c("Survived=No","Survived=Yes"), default="lhs"))
quality(rules)
quality(rules) <- round(quality(rules), digits=3)
inspect(rules)

rules.sorted <- sort(rules, by="lift")
inspect(rules.sorted)

#
# install.packages('RWeka')
# install.packages('partykit')
library(RWeka)
titanicct=J48(Survived~.,data=titanic.raw)
titanicct
plot(titanicct)
