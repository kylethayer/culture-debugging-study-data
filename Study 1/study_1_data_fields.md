# Field descriptions for study_1_data_part_[1-11].csv

Each row represents one code visualization execution. The **bold** fields are the ones used in the regression.

1. "": data point id

2. "X.1": data point id (duplicate of above)

3. "X": data point id (duplicate of above)

4. "Country": The country the code visualization is from (based on IP address)

5. "SessionId": Unique ID for a browser session

6. **"UUID"**: Unique ID for a user. This ID is stable across browser sessions when using the same browser and same machine.

7. **"stepsInViz"**: The total number of steps taken in the code visualization execution. This is used in conjuction with vizBackwardsSteps to calculate the number of forward steps.

8. "stepsAtStart": The number of consecutive steps viewed at start of the visualization (eg. if they viewed steps [1, 2, 3, 4, 5, 2, 3] that is 5 steps at start. If they viewed [2, 3, 4], that is 0 steps at start)

9. **"vizBackwardsSteps"**: The number of back-steps taken in the code visualization execution.

10. "vizStepRevisits": During a code visualization execution, the number of times a user returned to a previously seen step. We didn't end up using this because it wasn't distinct enough from vizBackwardsSteps to be interesting.

11. "sessionTime": The time between the first event in a browser session and the last.

12. **"vizTime"**: The time between the start of a code visualization execution and the last event in code visualization execution.

13. **"vizSessionNum"**: Within the session, what code visualization execution was this (e.g., 1 for first execution, 2 for second).

14. **"vizTotalSteps"**: Total number of steps in the code execution available for the user to view.

15. "vizCodeLines": The length of the code being run in number of lines.

16. "vizSeenEnd": Did the user view the last execution step?

17. "vizSteps.StepLine": I am not exactly sure what this is, but it is the number of "step_line" events in the code execution

18. **"vizSteps.Call"**: The number of function calls in the code execution

19. "vizSteps.Return": The number of returns from functions in the code execution

20. **"vizSteps.Exception"**: The number of exceptions thrown in the code execution

21. "vizSteps.UncaughtException": The number of uncaught exceptions thrown in the code execution

22. "vizSteps.InstructionLimitReached": The number of times the code reached the instruction call limit of python tutor

23. **"vizCodeWasEdited"**: Was the code edited since the last code visualization execution

24. **"vizCodeCharLength"**: The length of the code being executed in # of characters

25. **"vizCodeEditDistance"**: The edit distance from the previous code visualization execution

26. **"vizCode"**

27. **"sessionAnyEdits"**: Boolean. Was the code ever edited during the browser session?

28. "sessionNumVizSessions": How many code execution visualization sessions were there in the browser session.

29. "sessionCharLengthRangeDelta": For a browser session, the difference between the shortest and longest code (measured in characters).

30. "sessionTotalStepsInViz": How many total steps were taken in all code execution visualizations in the browser session.

31. "sessionSumCodeEditDistance": Sum of all edit distances of the code durring the browser session.

32. "duplicateCodeCount": 

33. "sessionAnyDupCode": Was any code run this browser session identical to code run by another user.

34. "Student.teacher.ratio": Student teacher ration of the IP address country. Data source: https://data.worldbank.org/indicator/SE.PRM.ENRL.TC.ZS

35. "GDP.per.capita": Gross Domestic Product per capita of the IP address. Data source https://data.worldbank.org/indicator/NY.GDP.PCAP.CD

36. "ctr": Country based on IP address. Should be equivalent to "Country", though could be different string (e.g., "United States" vs. "USA").

37. **"pdi"**: Hofstede's Power Distance Indicator for the country. Data source: https://geerthofstede.com/research-and-vsm/dimension-data-matrix/

38. "idv": Hofstede's Individualism score for the country. Data source: https://geerthofstede.com/research-and-vsm/dimension-data-matrix/

39. "mas": Hofstede's Masculinity score for the country. Data source: https://geerthofstede.com/research-and-vsm/dimension-data-matrix/

40. "uai": Hofstede's Uncertainty Avoidance score for the country. Data source: https://geerthofstede.com/research-and-vsm/dimension-data-matrix/

41. "ltowvs": Hofstede's Long-Term Orientation score for the country. Data source: https://geerthofstede.com/research-and-vsm/dimension-data-matrix/

42. "ivr": Hofstede's Indulgent vs. Restraint score for the country. Data source: https://geerthofstede.com/research-and-vsm/dimension-data-matrix/


