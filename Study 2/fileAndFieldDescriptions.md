# Description of files and fields for Study 2

Overview of relations. Participants (participantInfo.csv) came to the site and took the demographics survey (demographics.csv) and value survey (schwartz_survey.csv). We also tied thier country to the Hofstede cultural values (hofstede-fixed.csv) through the country-matching-file.csv (since country names were encoded differently). Participants proceeded on to the instructions and answered a couple more questions in demographics.csv. 

Participants perfomed two debugging tasks (coding_problem_session.csv). In each debugging task they could execute the code and visualize the execution multiple times (code_runs.csv) which we scored for how many tests teh code passed (code_runs.csv).

After they finished hte tasks, they answered some follow-up questions (follow_up_questions.csv and follow_up_questions.txt).

We also did some other statistics comparing Hofstede's Power Distance (hofstede-fixed.csv) with GDP per capita (world-bank gdp per capita.csv) and national student-teacher ratio (world-bank pupil-teacher ratio.csv).

## code_run_scores.csv

1. codeRunId: Which code run this score is for.
2. runScore: The score for the code execution (how many tests passed)
3. nextRunScore: The score of the code execution done next (or blank if there was no next one)
4. deltaRunScore: nextRunScore - runScore

## code_runs.csv

1. codeRunId: The id for this code run
2. codeProbId: Which coding_problem_session this code run happened during 
3. codeRunNum: which code run this was (e.g., 1 -> first, 2 -> second)
4. numStepsAvailable: The number of steps executed when the code ran
5. isError: Boolean, did the code error
6. isUserStarted: Boolean, True if this code ran when the user clicked "execute code." False if this code ran when the user when to the next problem and we automatically ran the code to see if they had a better version of the code at the end.
7. backsteps: Number of backsteps taken during this code run
8. fwdSteps: Number of forward steps taken during this code run
9. stepRevisits: Number of times the participant returned to a execution step they had already seen.

## coding_problem_session.csv
1. codeProbId: The id of this coding problem session
2. participantId: Which participant was doing this coding session
3. problemNum: which problem the participant was working on
4. isTimed: Boolean: True if this is during the initial timed part of the online experiment. False if this was after they finished and were on the result page where they could continue working as long as they wanted.
5. fwdSteps: Total number of forward steps taken during all code runs in this session
6. backSteps: Total number of back steps taken during all code runs in this session
7. stepRevisits: Total number of step revisits taken during all code runs in this session
8. totalSteps: Total steps taken during this session
9. totalExecutionVizSessions: number of code executions run during this session.
10. score: The best score of any code run during this coding problem session.

## country-matching-file.csv
1. ctr: Country name
2. hofstede-country: Country name as used in Hofstede file
3. ip-Country: Country name as used for the IP address country
4. demo-country: Country name as used in the demographic questions on country
5. short-name: Shorter version of name for display purposes

## demographics.csv
1. participantId
2. current_time
3. retake
4. gender
5. education
6. multinational
7. country0
8. country1
9. country2
10. country3
11. country4
12. country5
13. age
14. programmingExperience
15. pythonBefore
16. pythonTutorBefore
17. readUnderstandInstructions

## follow_up_questions.csv
1. participantId
2. how_easy_was_pt
3. how_helpful_was_pt
4. how_important_step_backward

## follow_up_questions.txt
1. 
2. 
3. 
4. 
5.
6.

## hofstede-fixed.csv
1. ctr	
2. country
3. pdi	
4. idv
5. mas
6. uai
7. ltowvs
8. ivr

## participantInfo.csv
1. participantId
2. time
3. userAgent
4. ipCountry
5. ipCity
6. contentLanguage

## schwartz_survey.csv
1. schwartzSurveyId
2. participantId
3. power
4. achievement
5. hedonism
6. stimulation
7. selfDirection
8. universalism
9. benevolence
10. tradition
11. conformity
12. security
13. conservation
14. selfTranscendence

## world-bank gdp per capita.csv
1. Country
2. GDP per capita

## world-bank pupil-teacher ratio.csv
1. Country
2. Student-teacher ratio
