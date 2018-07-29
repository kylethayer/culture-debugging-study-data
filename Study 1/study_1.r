library(lmerTest)
library(MuMIn)

#optional set working directory
#setwd("")

#Note: the data is stored in 11 files due to the github file size limit

study1DataPart1 = read.csv(file="study_1_data_part_01.csv")
study1DataPart2 = read.csv(file="study_1_data_part_02.csv")
study1DataPart3 = read.csv(file="study_1_data_part_03.csv")
study1DataPart4 = read.csv(file="study_1_data_part_04.csv")
study1DataPart5 = read.csv(file="study_1_data_part_05.csv")
study1DataPart6 = read.csv(file="study_1_data_part_06.csv")
study1DataPart7 = read.csv(file="study_1_data_part_07.csv")
study1DataPart8 = read.csv(file="study_1_data_part_08.csv")
study1DataPart9 = read.csv(file="study_1_data_part_09.csv")
study1DataPart10 = read.csv(file="study_1_data_part_10.csv")
study1DataPart11 = read.csv(file="study_1_data_part_11.csv")

study1Data = rbind(study1DataPart1, study1DataPart2)
study1Data = rbind(study1Data, study1DataPart3)
study1Data = rbind(study1Data, study1DataPart4)
study1Data = rbind(study1Data, study1DataPart5)
study1Data = rbind(study1Data, study1DataPart6)
study1Data = rbind(study1Data, study1DataPart7)
study1Data = rbind(study1Data, study1DataPart8)
study1Data = rbind(study1Data, study1DataPart9)
study1Data = rbind(study1Data, study1DataPart10)
study1Data = rbind(study1Data, study1DataPart11)

# calculate forwardSteps and sessionTotalForwadStepsInViz from other fields
study1Data <- transform(study1Data,
                 UUID = as.factor(UUID),
                 forwardSteps = stepsInViz - vizBackwardsSteps
)

#add session forward steps
forwardSums <-aggregate(study1Data[c("forwardSteps")], study1Data["SessionId"], sum)
forwardSums <- transform(forwardSums,
     sessionTotalForwadStepsInViz = forwardSteps
)
study1Data = merge(study1Data, forwardSums[c("SessionId", "sessionTotalForwadStepsInViz")], by="SessionId")


###############################################
# optional save together as one large csv file

#write.csv(study1Data, file="study_1_data_all.csv")

###############################################


#count final UUIDS
study1DataWithPDI = study1Data[!is.na(study1Data["pdi"]), ]
length(study1DataWithPDI[, 'UUID'])
length(unique(study1DataWithPDI[, 'UUID']))
length(unique(study1DataWithPDI[, 'Country']))

summary(study1DataWithPDI[, 'pdi'])
sd(study1DataWithPDI[, 'pdi'])


scaledstudy1Data = study1Data

scaledstudy1Data <- transform(scaledstudy1Data,
                       pdi =  scale(pdi),
                       idv =  scale(idv),
                       mas =  scale(mas),
                       ltowvs =  scale(ltowvs),
                       ivr =  scale(ivr),
                       Student.teacher.ratio =  scale(Student.teacher.ratio),
                       GDP.per.capita =  scale(GDP.per.capita),
                       vizTime =  scale(vizTime),
                       vizTotalSteps =  scale(vizTotalSteps),
                       forwardSteps = scale(forwardSteps),
                       sessionTotalStepsInViz =  scale(sessionTotalStepsInViz),
                       sessionTotalForwadStepsInViz =  scale(sessionTotalForwadStepsInViz),
                       sessionSumCodeEditDistance =  scale(sessionSumCodeEditDistance),
                       sessionNumVizSessions =  scale(sessionNumVizSessions),
                       vizCodeCharLength =  scale(vizCodeCharLength),
                       vizCodeEditDistance =  scale(vizCodeEditDistance),
                       vizSessionNum =  scale(vizSessionNum),
                       vizSteps.Call =  scale(vizSteps.Call),
                       vizSteps.Exception =  scale(vizSteps.Exception)
)



#use linear model due to magnitude of N


backStepModel<-lmer(formula =vizBackwardsSteps ~  
                 pdi # + Student.teacher.ratio + GDP.per.capita
               + vizTime +vizTotalSteps + forwardSteps + sessionTotalForwadStepsInViz +  sessionSumCodeEditDistance  
               + sessionAnyEdits + sessionNumVizSessions + vizCodeCharLength + vizCodeEditDistance  +vizCodeWasEdited
               + vizSessionNum + vizSteps.Call  + vizSteps.Exception+ sessionAnyDupCode
                #     + (1 | Country) 
                     + (1 | UUID)
                   , data = scaledstudy1Data
) 

backStepModel
summary(backStepModel)
anova(backStepModel)
r.squaredGLMM(backStepModel)



#compare 2 countries
Israel = study1Data[study1Data["Country"] == "Israel", ]
sd(Israel[, c("vizBackwardsSteps")])
India = study1Data[study1Data["Country"] == "India", ]
sd(India[, c("vizBackwardsSteps")])

IndIsrael <- study1Data[study1Data["Country"] == "Israel" | study1Data["Country"] == "India", ]
t.test(vizBackwardsSteps ~ Country, IndIsrael)



