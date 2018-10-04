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
1. participantId: The id of this participant
2. current_time: The time the participant started the experiment
3. retake: Did the participant say they'be taken this experiment before
4. gender: Reported gender of participant 0- Male, 1 - female, 2 - other
5. education: Reported education level of participant
6. multinational: Reported whether participant has lived in more than one country
7. country0: First country (or only country) participant reported living in
8. country1: Second country participant reported living in
9. country2
10. country3
11. country4
12. country5
13. age: reported age of participant
14. programmingExperience: Little to none, Three months or one course, Six months or two courses, one year or three to four courses, more
15. pythonBefore: "Have you programmed in Python before?"
16. pythonTutorBefore: "How many times have you used the Python Tutor interface previously?" - Never, 1 or 2 times, 3-5 times, 6+ times
17. readUnderstandInstructions: (I asked this becaues one of my pilot testers skipped the directions) "You will be using the Python Tutor interface to debug code for this test. 
Have you read and understood the instructions above?"- "I read and understood.", "I read and did not understand.", "I did not read, but understand PythonTutor.", "I did not read, and do not understand PythonTutor."

## follow_up_questions.csv
Truncated version of follow_up_questions.txt
1. participantId
2. how_easy_was_pt
3. how_helpful_was_pt
4. how_important_step_backward

## follow_up_questions.txt
1. participantId - Id of this participant
2. Answer to "Describe in two or more sentences how you used the code execution view
to debug your code (or why you did not use that view)?"
3. Answer to "How easy was it to use the Python Tutor Interface?"
4. Answer to "How helpful did you find the Python Tutor Interface?"
5. Answer to "Describe in two or more sentences why you stepped backward in the execution?"
6. Answer to "How important do you think the ability to step backward is in solving coding problems? "

## hofstede-fixed.csv
data from https://geerthofstede.com/research-and-vsm/dimension-data-matrix/
1. ctr - country name
2. country - country name (different encoding)
3. pdi: Hofstede's Power Distance Indicator for the country. Data source: 
4. idv: Hofstede's Individualism score for the country
5. mas: Hofstede's Masculinity score for the country
6. uai: Hofstede's Uncertainty Avoidance score for the country
7. ltowvs: Hofstede's Long-Term Orientation score for the country
8. ivr:  Hofstede's Indulgent vs. Restraint score for the country

## participantInfo.csv
1. participantId- The id of this participant
2. time - the time they started the task
3. userAgent - info on the user browser / machine
4. ipCountry - country user in (based on IP)
5. ipCity - city user in (based on IP)
6. contentLanguage - not used in this study

## schwartz_survey.csv
Formulas for conservation and selfTranscendence from original SSVS paper: Measuring values with the Short Schwartz's Value Survey.
Lindeman, Verkasalo (2005).(https://www.ncbi.nlm.nih.gov/pubmed/16171417)

Equations 3 & 4 are for the 7 point scale version of the SSVS:

* Conservation = .92 + (.15 × Power) + (.03 × Achievement) – (.17 × Hedonism) – (.25 × Stimulation) – (.31 × Self-Direction) – (.26 × Universalism) + (.04 × Benevolence) + (.30 × Tradition) + (.30 × Conformity) + (.20 × Security)

* Self-Transcendence = –.56 – (.30 × Power) – (.33 × Achievement) – (.16 × Hedonism) – (.14 × Stimulation) + (.04 × Self-Direction) + (.22 × Universalism) + (.24 × Benevolence) + (.12 × Tradition) + (.03 × Conformity) + (.03 × Security)

Word doc with updated means (http://blogs.helsinki.fi/everyday-thinking/files/2015/11/The-Short-Schwartzs-Value-Survey.docx)
* Study 2 M = .21 and SD = 1.00 for Conservation, and M = -.82 and SD = .86 for Self-Transcendence.

so final formula is:

* Conservation = -.21 + (.15 × Power) + (.03 × Achievement) – (.17 × Hedonism) – (.25 × Stimulation) – (.31 × Self-Direction) – (.26 × Universalism) + (.04 × Benevolence) + (.30 × Tradition) + (.30 × Conformity) + (.20 × Security)

* Self-Transcendence = .82 – (.30 × Power) – (.33 × Achievement) – (.16 × Hedonism) – (.14 × Stimulation) + (.04 × Self-Direction) + (.22 × Universalism) + (.24 × Benevolence) + (.12 × Tradition) + (.03 × Conformity) + (.03 × Security)

1. schwartzSurveyId: Id of this survey answer set
2. participantId: Id of this participant
3. power: "POWER (social power, authority, wealth)"
4. achievement: "ACHIEVEMENT (success, capability, ambition, influence on people and events)"
5. hedonism: "HEDONISM (gratification of desires, enjoyment in life, self-indulgence)"
6. stimulation: "STIMULATION (daring, a varied and challenging life, an exciting life)"
7. selfDirection: "SELF-DIRECTION (creativity, freedom, curiosity, independence, choosing one's own goals)"
8. universalism: "UNIVERSALISM (broad-mindedness, beauty of nature and arts, social justice, a world at peace, equality, wisdom, unity with nature, environmental protection)"
9. benevolence: "BENEVOLENCE (helpfulness, honesty, forgiveness, loyalty, responsibility)"
10. tradition: "TRADITION (respect for tradition, humbleness, accepting one's portion in life, devotion, modesty)"
11. conformity: "CONFORMITY (obedience, honoring parents and elders, self-discipline, politeness)"
12. security: "SECURITY (national security, family security, social order, cleanliness, reciprocation of favors)"
13. conservation: Aggregate measure of conservation vs. openness to change, based on the individual answers using the formula above
14. selfTranscendence: Aggregate measure of self-transcendence vs. self-enhancement, based on the individual answers using the formula above

## world-bank gdp per capita.csv
1. Country
2. GDP per capita

## world-bank pupil-teacher ratio.csv
1. Country
2. Student-teacher ratio
