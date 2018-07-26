library(lmerTest)
library("pscl")
library("lmtest")
library(plyr)
library(glmmADMB)

#optional set working directory
#setwd("")

codeRuns = read.csv("code_runs.csv",sep=";")
codeRunScores = read.csv("code_run_scores.csv")
codeProbSess = read.csv("coding_problem_session.csv",sep=";")
participantInfo = read.csv("participantInfo.csv",sep=";")
demographics = read.csv("demographics.csv",sep=";")
schwartz = read.csv("schwartz_survey.csv",sep=";")
follow_up_questions = read.csv("follow_up_questions.csv",sep=";")
countryMatch = read.csv("country-matching-file.csv")
hofstede = read.csv("hofstede-fixed.csv")
st_ratio = read.csv("world-bank pupil-teacher ratio.csv")
gdp_per_capita = read.csv("world-bank gdp per capita.csv")


#########################################
#         General stats
#########################################

# PDI vs. Student teacher ratio and GDP per capita

tmp <- merge(gdp_per_capita, st_ratio, by="Country")

st_ratio_hofstede <- merge(hofstede, tmp, by.x="country", by.y="Country")

cor.test(st_ratio_hofstede[, c("Student.teacher.ratio")], st_ratio_hofstede[, c("pdi")])

cor.test(st_ratio_hofstede[, c("GDP.per.capita")], st_ratio_hofstede[, c("pdi")])



#percentage with forward steps and back-steps

#join for to make sure we only count compelete data for viz sessions
# Note: not all users made viz sessions, so this is just for viz sessions
# data and user counts who made those viz sessions
tmp = codeRuns

tmp = merge(tmp, 
            codeProbSess[c("codeProbId", "participantId", "problemNum", "isTimed", "totalExecutionVizSessions", "score")]
            , by="codeProbId")

tmp = merge(tmp, 
            demographics
            , by="participantId")

tmp = merge(tmp, 
            schwartz
            , by="participantId")

tmp = merge(tmp, 
            participantInfo
            , by="participantId")

codeRunsSummary = tmp
nrow(codeRunsSummary)

#clean (don't count our automatically started code sessions for grading)
codeRunsSummaryCleaned = codeRunsSummary[codeRunsSummary["isUserStarted"] == 1, ]

nrow(codeRunsSummaryCleaned)
nrow(unique(codeRunsSummaryCleaned["participantId"]))

#how many forward step sessions?
fwdStepSessions = codeRunsSummaryCleaned[codeRunsSummaryCleaned["fwdSteps"] >= 1, ]
nrow(fwdStepSessions)
nrow(fwdStepSessions) / nrow(codeRunsSummaryCleaned)
nrow(unique(fwdStepSessions["participantId"]))

# how many backward step sessions?
backStepSessions = codeRunsSummaryCleaned[codeRunsSummaryCleaned["backsteps"] >= 1, ]
nrow(backStepSessions)
nrow(backStepSessions) / nrow(codeRunsSummaryCleaned)
nrow(unique(backStepSessions["participantId"]))



#########################################
# PDI and conservation stats and relation
#########################################

tmp = participantInfo

tmp = merge(tmp, 
            demographics
            , by="participantId")

tmp = merge(tmp, 
            schwartz
            , by="participantId")

tmp = merge(tmp, 
            countryMatch
            , by.x=c("country0"), by.y = c("demo.country"), all.x = TRUE)

tmp = merge(tmp, 
            hofstede
            , by="ctr")

participantJoined = tmp


summary(participantJoined[, c("conservation")])
summary(participantJoined[, c("age")])
sd(participantJoined[, c("age")])

length(participantJoined[, c("conservation")])
sd(participantJoined[, c("conservation")])
table(participantJoined[, c("gender")])

participantJoinedPDI = participantJoined[!is.na(participantJoined["pdi"]), ]
summary(participantJoinedPDI[, c("pdi")])
sd(participantJoinedPDI[, c("pdi")])


# test conservation and PDI correlation
cor.test(participantJoined[, c("conservation")], participantJoined[, c("pdi")])

#make sure conservation, pdi and country name are set for country averages
participantJoinedWCons = participantJoined[!is.na(participantJoined["conservation"]), ]
participantJoinedWCons = participantJoinedWCons[!is.na(participantJoinedWCons["pdi"]), ]
participantJoinedWCons = participantJoinedWCons[!is.na(participantJoinedWCons["short.name"]), ]

library(Rmisc)
countryConsAvgs <- summarySE(participantJoinedWCons, measurevar="conservation", groupvars=c("short.name"))

countryPDIAvgs <- aggregate(participantJoinedWCons[c("pdi")], participantJoinedWCons["short.name"], mean)

countrySummary <- cbind(countryConsAvgs, countryPDIAvgs)


cor.test(countrySummary[, c("conservation")], countrySummary[, c("pdi")])

countrySummaryFiltered = countrySummary[countrySummary["N"] >= 5, ]


#########################################
#         backstep regression models
#########################################

tmp = codeRuns

tmp = merge(tmp, 
            codeProbSess[c("codeProbId", "participantId", "problemNum", "isTimed", "totalExecutionVizSessions", "score")]
            , by="codeProbId")

tmp = merge(tmp, 
            demographics
            , by="participantId")

tmp = merge(tmp, 
            schwartz
            , by="participantId")

tmp = merge(tmp, 
            participantInfo
            , by="participantId")

tmp = merge(tmp, 
            countryMatch
            , by.x=c("ipCountry"), by.y = c("ip.Country"), all.x = TRUE)

tmp = merge(tmp, 
            hofstede
            , by="ctr", all.x = TRUE)

codeRunsJoined = tmp

codeRunsJoined <- transform(codeRunsJoined,
        participantId = as.factor(participantId),
        gender = as.factor(gender),
        isTimed = as.factor(isTimed),
        pythonBefore = as.factor(pythonBefore),
        problemNum = as.factor(problemNum),
        education = ordered(education, levels=c("pre-high school", "high school", "professional school", "college", "PhD", "postdoctoral")),
        programmingExperience = ordered(codeRunsJoined$programmingExperience, levels = c("none", "3m", "6m", "1yr", "more")),
        pythonTutorBefore = ordered(codeRunsJoined$pythonTutorBefore, levels = c("0", "1-2", "3-5", "6+"))
)


#(don't count our automatically started code sessions for grading)
codeRunsJoinedAndFixed = codeRunsJoined
codeRunsJoinedAndFixed = codeRunsJoined[codeRunsJoined["isUserStarted"] == 1, ]

####compare Canada and Japan

Canada = codeRunsJoinedAndFixed[codeRunsJoinedAndFixed["ipCountry"] == "Canada", ]
sd(Canada[, c("backsteps")])

Japan = codeRunsJoinedAndFixed[codeRunsJoinedAndFixed["ipCountry"] == "Japan", ]
sd(Japan[, c("backsteps")])

CanadaJapan <- codeRunsJoinedAndFixed[codeRunsJoinedAndFixed["ipCountry"] == "Canada" | codeRunsJoinedAndFixed["ipCountry"] == "Japan", ]
t.test(backsteps ~ ipCountry, CanadaJapan)


#make sure age and gender are not blank for regression model
codeRunsJoinedAndFixed = codeRunsJoinedAndFixed[!is.na(codeRunsJoinedAndFixed["gender"]), ]
codeRunsJoinedAndFixed = codeRunsJoinedAndFixed[!is.na(codeRunsJoinedAndFixed["age"]), ]

# check conservation and backsteps
model = glmmadmb(backsteps ~  
                   conservation
                 + fwdSteps
                 + programmingExperience 
                 + (1 | participantId),
         data=codeRunsJoinedAndFixed,
         zeroInflation=TRUE,
         family="nbinom")


summary(model)


# check PDI and backsteps

# make sure PDI is set
codeRunsJoinedAndFixedPDI = codeRunsJoinedAndFixed[!is.na(codeRunsJoinedAndFixed["pdi"]), ]

model = glmmadmb(backsteps ~  
                   pdi
                 + fwdSteps
                 + age + gender
                 + programmingExperience 
                 + (1 | participantId),
                 data=codeRunsJoinedAndFixedPDI,
                 zeroInflation=TRUE,
                 family="nbinom")
summary(model)



#########################################
#       Delta run score per session
#########################################

tmp = codeRuns

tmp = merge(tmp, 
            codeRunScores
            , by="codeRunId")

tmp = merge(tmp, 
            codeProbSess[c("codeProbId", "participantId", "problemNum", "isTimed", "totalExecutionVizSessions", "score")]
            , by="codeProbId")

tmp = merge(tmp, 
            demographics
            , by="participantId")

tmp = merge(tmp, 
            schwartz
            , by="participantId")

tmp = merge(tmp, 
            participantInfo
            , by="participantId")

tmp = merge(tmp, 
            countryMatch
            , by.x=c("ipCountry"), by.y = c("ip.Country"), all.x = TRUE)

tmp = merge(tmp, 
            hofstede
            , by="ctr", all.x = TRUE)

codeRunsJoined = tmp

codeRunsJoined <- transform(codeRunsJoined,
                            participantId = as.factor(participantId),
                            gender = as.factor(gender),
                            isTimed = as.factor(isTimed),
                            pythonBefore = as.factor(pythonBefore),
                            problemNum = as.factor(problemNum),
                            education = ordered(education, levels=c("pre-high school", "high school", "professional school", "college", "PhD", "postdoctoral")),
                            programmingExperience = ordered(codeRunsJoined$programmingExperience, levels = c("none", "3m", "6m", "1yr", "more")),
                            pythonTutorBefore = ordered(codeRunsJoined$pythonTutorBefore, levels = c("0", "1-2", "3-5", "6+"))
)



#(don't count our automatically started code sessions for grading)
codeRunsJoinedAndFixed = codeRunsJoined
codeRunsJoinedAndFixed = codeRunsJoined[codeRunsJoined["isUserStarted"] == 1, ]


consBackStepModel<-lmer(formula =deltaRunScore ~  
                          runScore
                        +  backsteps * conservation
                        + fwdSteps
                        + programmingExperience 
                        + (1 | participantId)
                        , data = codeRunsJoinedAndFixed
) 

consBackStepModel
summary(consBackStepModel)
anova(consBackStepModel)


#########################################
#       Final score per problem 
#  (similar results to delta score)
#########################################


tmp = codeProbSess

tmp = merge(tmp, 
            demographics
            , by="participantId")

tmp = merge(tmp, 
            schwartz
            , by="participantId")

tmp = merge(tmp, 
            participantInfo
            , by="participantId")

tmp = merge(tmp, 
            countryMatch
            , by.x=c("ipCountry"), by.y = c("ip.Country"),  all.x = TRUE)

tmp = merge(tmp, 
            hofstede
            , by="ctr", all.x = TRUE)

codeProbSessJoined = tmp


codeProbSessJoined <- transform(codeProbSessJoined,
                                participantId = as.factor(participantId),
                                gender = as.factor(gender),
                                isTimed = as.factor(isTimed),
                                pythonBefore = as.factor(pythonBefore),
                                problemNum = as.factor(problemNum),
                                education = ordered(education, levels=c("pre-high school", "high school", "professional school", "college", "PhD", "postdoctoral")),
                                programmingExperience = ordered(codeProbSessJoined$programmingExperience, levels = c("none", "3m", "6m", "1yr", "more")),
                                pythonTutorBefore = ordered(codeProbSessJoined$pythonTutorBefore, levels = c("0", "1-2", "3-5", "6+"))
)

# only for when they are working on the problems during the timed portion (not freely working on them at the end of the study)
codeProbSessJoinedAndFixed = codeProbSessJoined[codeProbSessJoined["isTimed"] == 1, ]


consScoreModel<-lmer(formula = score ~  
                       + fwdSteps + backSteps * conservation
                     + programmingExperience 
                     + (1 | participantId)
                     , data = codeProbSessJoinedAndFixed
) 

consScoreModel
summary(consScoreModel)
anova(consScoreModel)
