Here is the link to the presentation: [Here](https://www.canva.com/design/DAFEzvQ17Jw/RaoMnIYXKFWWew90za9bBw/view?utm_content=DAFEzvQ17Jw&utm_campaign=designshare&utm_medium=link2&utm_source=sharebutton)

# Data Description
## Wellbeing Dream Team: Temi, Jarely, Sam, and Michael
### June 27th, 2022

**Data Provenance:**  

Healthy Minds Survey:  

Is an online survey study of students, available for implementation at all types of post-secondary institutions. The survey examines the prevalence of mental health outcomes, knowledge and attitudes about mental health and service utilization. HMS emphasizes understanding help-seeking behavior, examining stigma, knowledge, and other potential barriers to mental health service utilization.  

The Healthy Minds Study consists of three *core* modules:   

Demographics  
Mental Health Status  
Mental Health Survey Utilization/Help-Seeking  

*Elective* modules:   

Substance Use, Sleep, Eating and Body Image, Sexual Assault, Overall Health, Knowledge and Attitudes about Mental Health and Mental Health Services, Upstander/Bystander Behaviors, Mental Health Climate, Climate for Diversity and Inclusion, Academic Competition, Persistence and Retention, Resilience and Coping, Financial Stress, Student Athletes, Peer Support, Public Safety and Policing  
- Elective modules are chosen by participating institution from the options listed above  
- The number of items per module is determined by 2 factors:  
(1) skip logic embedded within the survey (i.e Some measures are assessed only for students with certain responses to survey items)  
(2) which elective modules are selected by the participating institution.  

Our data frames (**Data Dictionary**)  

‘Combined’ dataset: includes all the variables from across the four years of HMS data we need to answer our analyses.   

School year [ schoolYear ]   
Year the Healthy Minds Survey was taken  
2017-18,  
2018-19,  
2019-20,  
2020-21  

Class Year [ classYear ]  
What year are you in your current degree program?  
1st year - 7th year  

Age [ age ]  
How old are you? (You must be 18 years or older to complete this survey.)  
______ years old  

Gender [ gender ]   
What is your gender identity?  
1=Male  
2=Female  
3=Trans male/Trans man  
4=Trans female/Trans woman  
5=Genderqueer/Gender non-conforming  
6=Self-identify (please specify)  

Positive Mental Health [ diener ]  
I lead a purposeful and meaningful life.  
My social relationships are supportive and rewarding  
I am engaged and interested in my daily activities.  
I actively contribute to the happiness and well-being of others.  
I am competent and capable in the activities that are important to me.  
I am a good person and live a good life.  
I am optimistic about my future.  
People respect me.  
1=Strongly disagree  
2=Disagree  
3=Slightly disagree  
4=Mixed or neither agree nor disagree  
5=Slightly agree  
6=Agree  
7=Strongly agree  

Positive Mental Health [ diener_score ]   
Sum of all diener variables  
8 - 56  

Diagnosed Mental Illnesses [dx_…]  
Have you ever been diagnosed with any of the following conditions by a health professional (e.g., primary care doctor, psychiatrist, psychologist, etc.)? (Select all that apply)  
dx_dep [ 1 = depression ]   
dx_bip [ 1 = bipolar ]   
dx_anx [ 1 = anxiety ]   
dx_ocd [ 1= Obsessive-compulsive / related disorders ]  
dx_ptsd [ 1=Trauma and Stressor Related Disorders ]  
dx_neurodev [ 1=Neurodevelopmental disorder or intellectual disability ]  
dx_ea [ 1=Eating disorder ]  
dx_psy [ 1=Psychosis ]  
dx_pers [ 1=Personality disorder ]  
dx_sa [ 1=Substance use disorder ]  
dx_none [ 1=No, none of these [mutually exclusive]  
dx_dk [ 1= don't know ]  

Academic Impairment [ aca_impa ]  
In the past 4 weeks, how many days have you felt that emotional or mental difficulties have hurt your academic performance?  
1=None   
2=1-2 days   
3=3-5 days   
4=6 or more days    

Help-seeking intentions [ talk1_…]   
If you were experiencing serious emotional distress, whom would you talk to about this? (Select all that apply)  
1=Professional clinician (e.g., psychologist,counselor, or psychiatrist)  
2=Roommate  
3=Friend (who is not a roommate)   
4=Significant other   
5=Family member 6=Religious counselor or other religious contact  
7=Support group  
8=Other non-clinical source (please specify)   
9=No one  

Use of counseling/therapy [ ther_ever ]   
Have you ever received counseling or therapy for mental health concerns?  
1=No, never   
2=Yes, prior to starting college   
3=Yes, since starting college   
4=Yes, both of the above (prior to college and since starting college)  

Anxiety [gad7_…]  
*Not measured in HMS 2017*  

Over the last 2 weeks, how often have you been bothered by the following problems?  
Feeling nervous, anxious or on edge  
Not being able to stop or control worrying  
Worrying too much about different things  
Trouble relaxing  
Being so restless that it’s hard to sit still  
Becoming easily annoyed or irritable  
Feeling afraid as if something awful might happen  
How difficult have these problems (noted above) made it for you to do your work, take care of things at home, or get along with other people?  
1=Not at all   
2=Several days   
3=Over half the days   
4=Nearly every day  

Depression [phq9_…]  
*Not measured in HMS 2017* 

- Over the last 2 weeks, how often have you been bothered by any of the following problems?:  
Little interest or pleasure in doing things  
Feeling down, depressed or hopeless  
Trouble falling or staying asleep, or sleeping too much  
Feeling tired or having little energy  
Poor appetite or overeating  
Feeling bad about yourself—or that you are a failure or have let yourself or your family down  
Trouble concentrating on things, such as reading the newspaper or watching television   
Moving or speaking so slowly that other people could have noticed; or the opposite—being so fidgety or restless that you have been moving around a lot more than usual  
Thoughts that you would be better off dead or of hurting yourself in some way 

- During that period, how often were you bothered by these problems?:  
Little interest or pleasure in doing things  
Feeling down, depressed or hopeless  
1=Not at all   
2=Several days   
3=Over half the days  
4=Nearly every day  

Depression Impact [dep_impa]  
*Not measured in HMS 2017*  

How difficult have these problems (noted above) made it for you to do your work, take care of things at home, or get along with other people?  
1=Not difficult at all   
2=Somewhat difficult   
3=Very difficult   
4=Extremely difficult  

Loneliness  
[lone_…]  
*Only measured in HMS 2020-2021*  

Please answer the following:  
How often do you feel that you lack companionship?  
How often do you feel left out?  
How often do you feel isolated from others?  
1=Hardly ever   
2=Some of the time   
3=Often  

Exercise [Q3_27]  
*Not measured in HMS 2020-2021*  
In the past 30 days, about how many hours per week on average did you spend exercising? (Include any exercise of moderate or higher intensity, where “moderate intensity” would be roughly equivalent to brisk walking or bicycling)  
1=Less than 1 hour  
2=2-3 hours  
3=3-4 hours  
4=5 or more hours  

Graphs:  