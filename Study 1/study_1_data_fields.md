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

17. **"vizSteps.StepLine"**

18. **"vizSteps.Call"**

19. **"vizSteps.Return"**

20. **"vizSteps.Exception"**

21. **"vizSteps.UncaughtException"**

22. **"vizSteps.InstructionLimitReached"**

23. **"vizCodeWasEdited"**

24. **"vizCodeCharLength"**

25. **"vizCodeEditDistance"**

26. **"vizCode"**

27. **"sessionAnyEdits"**

28. "sessionNumVizSessions"

29. "sessionCharLengthRangeDelta"

30. "sessionTotalStepsInViz"

31. "sessionSumCodeEditDistance"

32. "duplicateCodeCount"

33. "sessionAnyDupCode"

34. "Student.teacher.ratio"

35. "GDP.per.capita"

36. "ctr"

37. **"pdi"**

38. "idv"

39. "mas"

40. "uai"

41. "ltowvs"

42. "ivr"


