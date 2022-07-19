Here is the link to the presentation: [Here](https://www.canva.com/design/DAFEzvQ17Jw/RaoMnIYXKFWWew90za9bBw/view?utm_content=DAFEzvQ17Jw&utm_campaign=designshare&utm_medium=link2&utm_source=sharebutton)

# Data Description

## Wellbeing Dream Team: Temi, Jarely, Sam, and Michael

### June 27th, 2022

**Data Provenance:**

Healthy Minds Survey:

Is an online survey study of students, available for implementation at all types of post-secondary institutions. The survey examines the prevalence of mental health outcomes, knowledge and attitudes about mental health and service utilization. HMS emphasizes understanding help-seeking behavior, examining stigma, knowledge, and other potential barriers to mental health service utilization.

The Healthy Minds Study consists of three *core* modules:

Demographics\
Mental Health Status\
Mental Health Survey Utilization/Help-Seeking

*Elective* modules:

Substance Use, Sleep, Eating and Body Image, Sexual Assault, Overall Health, Knowledge and Attitudes about Mental Health and Mental Health Services, Upstander/Bystander Behaviors, Mental Health Climate, Climate for Diversity and Inclusion, Academic Competition, Persistence and Retention, Resilience and Coping, Financial Stress, Student Athletes, Peer Support, Public Safety and Policing\
- Elective modules are chosen by participating institution from the options listed above\
- The number of items per module is determined by 2 factors:\
(1) skip logic embedded within the survey (i.e Some measures are assessed only for students with certain responses to survey items)\
(2) which elective modules are selected by the participating institution.

Our data frames (**Data Dictionary**)

'Combined' dataset: includes all the variables from across the four years of HMS data we need to answer our analyses.

| School year \[schoolYear\]                                                                                                                                 | Year the Healthy Minds Survey was taken                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             | 2017-18,

2018-19, 

2019-20,

2020-21

<br>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| ---------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Class Year \[classYear\]                                                                                                                                   | What year are you in your current degree program?                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | 1st year - 7th year

<br><br>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| Age \[age\] 

<br>                                                                                                                                         | How old are you? (You must be 18 years or older to complete this survey.)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           | \_\_\_\_\_\_ years old                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| Gender \[gender\]                                                                                                                                          | What is your gender identity?                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | 1 = Male

2 = Female

3 = Trans male/Trans man

4 = Trans female/Trans woman

5 = Genderqueer/Gender non-conforming

6 = Self-identify (please specify)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| Race \[race\_\]                                                                                                                                            | What is your race/ethnicity?(Select all that apply)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 | race\_black = African American/Black

race\_asian = Asian American/Asian

race\_his = Hispanic/Latino/a

race\_white = White

race\_other = Self-identify (please specify)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| Positive Mental Health

\[diener\]                                                                                                                         | *   I lead a purposeful and meaningful life.
    

*   My social relationships are supportive and rewarding
    
*   I am engaged and interested in my daily activities.
    
*   I actively contribute to the happiness and well-being of others.
    
*   I am competent and capable in the activities that are important to me.
    
*   I am a good person and live a good life.
    
*   I am optimistic about my future.
    
*   People respect me                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           | 1 = Strongly disagree

2 = Disagree

3 = Slightly disagree

4 = Mixed or neither agree nor disagree

5 = Slightly agree

6 = Agree

7 = Strongly agree                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| Positive Mental Health

\[diener\_score\]                                                                                                                  | Sum of all diener variables                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         | 8 - 56                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| Diagnosed Mental Illnesses \[dx\_…\]                                                                                                                       | Have you ever been diagnosed with any of the following conditions by a health professional (e.g., primary care doctor, psychiatrist, psychologist, etc.)? (Select all that apply)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | dx\_dep \[1 = depression\] 

dx\_bip \[1 = bipolar\]

dx\_anx \[1 = anxiety\]

dx\_ocd \[1= Obsessive-compulsive / related disorders\]

dx\_ptsd \[1=Trauma and Stressor Related Disorders\]

dx\_neurodev \[1=Neurodevelopmental disorder or intellectual disability\]

dx\_ea \[1=Eating disorder\]

dx\_psy \[1=Psychosis\]

dx\_pers \[1=Personality disorder\]

dx\_sa \[1=Substance use disorder\] 

dx\_none \[1=No, none of these \[mutually exclusive\]

dx\_dk \[1= don't know\]                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| Academic Impairment

\[aca\_impa\]                                                                                                                         | In the past 4 weeks, how many days have you felt that emotional or mental difficulties have hurt your academic performance?                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         | 1 = None

2 = 1-2 days

3 = 3-5 days

4 = 6 or more days                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| Help-seeking intentions

\[talk1\_…\]                                                                                                                      | If you were experiencing serious emotional distress, whom would you talk to about this? (Select all that apply)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     | 1 = Professional clinician (e.g., psychologist,counselor, or psychiatrist)

2 = Roommate

3 = Friend (who is not a roommate)

4 = Significant other

5 = Family member

6 = Religious counselor or other religious contact

7 = Support group

8 = Other non-clinical source (please specify)

9 = No one                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| Use of counseling/therapy

\[ther\_ever\]                                                                                                                  | Have you ever received counseling or therapy for mental health concerns?                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            | 1 = No, never

2 = Yes, prior to starting college

3 = Yes, since starting college

4 = Yes, both of the above (prior to college and since starting college)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| Anxiety

\[gad7\_…\]

<br>

\* Not measured in HMS 2017                                                                                                    | Over the last 2 weeks, how often have you been bothered by the following problems?

<br>

Feeling nervous, anxious or on edge

<br>

Not being able to stop or control worrying

<br>

Worrying too much about different things

<br>

Trouble relaxing

<br>

Being so restless that it’s hard to sit still

<br>

Becoming easily annoyed or irritable

<br>

Feeling afraid as if something awful might happen

<br>

How difficult have these problems (noted above) made it for you to do your work, take care of things at home, or get along with other people?                                                                                                                                                                                                                                                                                                                                                                                                                              | 1 = Not at all

2 = Several days

3 = Over half the days

4 = Nearly every day                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| Depression

\[phq9\_…\]

<br>

\* Not measured in HMS 2017                                                                                                 | \- Over the last 2 weeks, how often have you been

bothered by any of the following problems?:

<br>

Little interest or pleasure in doing things

<br>

Feeling down, depressed or hopeless

<br>

Trouble falling or staying asleep, or sleeping too much

<br>

Feeling tired or having little energy

<br>

Poor appetite or overeating

<br>

Feeling bad about yourself—or that you are a failure or have let yourself or your family down

<br>

Trouble concentrating on things, such as reading the newspaper or watching television 

<br>

Moving or speaking so slowly that other people could have noticed; or the opposite—being so fidgety or restless that you have been moving around a lot more than usual

<br>

Thoughts that you would be better off dead or of hurting yourself in some way

<br>

\- During that period, how often were you bothered by these problems?:

<br>

Little interest or pleasure in doing things

<br>

Feeling down, depressed or hopeless

<br> | 1 = Not at all

2 = Several days

3 = Over half the days

4 = Nearly every day                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| Depression Impact

\[dep\_impa\]

\* Not measured in HMS 2017                                                                                              | How difficult have these problems (noted above) made it for you to do your work, take care of things at home, or get along with other people?                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | 1 = Not difficult at all

2 = Somewhat difficult

3 = Very difficult

4 = Extremely difficult                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| Loneliness

\[lone\_…\]

\* Only measured in HMS 2020-2021                                                                                                 | Please answer the following:

<br>

How often do you feel that you lack companionship?

<br>

How often do you feel left out?

<br>

How often do you feel isolated from others?                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    | 1 = Hardly ever

2 = Some of the time

3 = Often                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| Exercise

\[Q3\_27\]

\* Not measured in HMS 2020-2021                                                                                                     | In the past 30 days, about how many hours per week on average did you spend exercising?

(Include any exercise of moderate or higher intensity, where “moderate intensity” would be roughly equivalent to brisk walking or bicycling)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               | 1 = Less than 1 hour

2 = 2-3 hours

3 = 3-4 hours

4 = 5 or more hours                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| Sleep \[sleep\_\]                                                                                                                                          | During this school year, at approximately what time have you typically gone to sleep on:

<br>

Weeknights

<br>

Weekend nights

<br>

Weekdays

<br>

Weekend days

<br>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          | 1 = 12:00pm

2 = 1:00pm

3 = 2:00pm

4 = 3:00pm

5 = 4:00pm

6 = 5:00pm

7 = 6:00pm

8 = 7:00pm

9 = 8:00pm

10 = 9:00pm

11 = 10:00pm

12 = 11:00pm

13 = 12:00am

14 = 1:00am

15 = 2:00am

16 = 3:00am

17 = 4:00am

18 = 5:00am

19 = 6:00am

20 = 7:00am

21 = 8:00am

22 = 9:00am

23 = 10:00a

24 = 11:00am                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| Sleep (naps) \[sleep\_np#\]                                                                                                                                | During this school year, on how many days have you taken naps during a typical week? 

<br><br><br><br><br>

How long is your typical nap?                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          | 1 = I don’t take naps.

2 = 1 

3 = 2 

4 = 3 

5 = 4 

6 = 5 

7 = 6 

8 = 7

<br>

1 = Less than 1 hour

2 = Between 1 and 2 hours

3 = Between 2 and 3 hours

4 = More than 3 hours                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| Alcohol Use

\[alc\_any\]

\[binge\_fr\_f\]

\[binge\_fr\_m\]

\[binge\_fr\_o\]                                                                            | Over the past 2 weeks, did you drink any alcohol?

Over the past 2 weeks, about how many times did you have 4 \[female\]/5 \[male\]/4 or 5 \[not female or male\] or more alcoholicdrinks in a row? (1 drink is a can of beer, a glass of wine, a wine cooler, a shot ofliquor, or a mixed drink.)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  | 1 = Yes

0 = No

1 = 0 times 

2 = 1 time 

3 = 2 times 

4 = 3 to 5 times 

5 = 6 to 9 times 

6 = 10 or more times 

7 = Don’t know                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| Drug Use

1.  \[smok\_freq\]
    
2.  \[smok\_vape\]
    
3.  \[smok\_vape\_mist\]
    
4.  \[drug\_…\]                                                    | 1.  Over the past 30 days, about how many cigarettes did you smoke per day?
    
2.  Over the past 30 days, have you used an electronic cigarette or vape pen?
    
3.  What did you think was in the mist you inhaled the last time youused a vaping device?
    
4.  Over the past 30 days, have you used any of the following drugs?(Select all that apply)
    

<br><br>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | 1.  1 = 0 cigarettes
    

2 = Less than 1 cigarette

3 = 1 to 5 cigarettes

4 = About one-half pack

5 = 1 or more packs

2.  1 = Yes
    

2 = No

3.  1 = Any vaping
    

2 = Vaping nicotine

3 = Vaping Marijuana

4 = Vaping "just flavoring"

4.  1 = Marijuana
    

2 = Cocaine (any form, including crack, powder, or freebase)

3 = Heroin

4 = Opioid pain relievers (such as Vicodin, OxyContin, Percocet, Demerol,Dilaudid, codeine, hydrocodone, methadone, morphine) without a prescription or more than prescribed

5 = Benzodiazepines (such as Valium, Ativan, Klonopin, Xanax, Rohypnal (Roofies))

6 = Methamphetamines (also known as speed, crystal meth, Tina, T, or ice)

7 = Other stimulants (such as Ritalin, Adderall) without a prescription or more than prescribed

8 = MDMA (also known as Ecstasy or Molly)

9 = Ketamine (also known as K, SpecialK)

10 = LSD (also known as acid)  11 = Psilocybin (also known as magic mushrooms, boomers, shrooms)

12 = Kratom

13 = Athletic performance enhancers (anything that violates policies set by your school or any athletic governing body)

14 = Other drugs without a prescription (please specify)

15 = No, none of these |
| Loneliness

\[lone\_lackcompanion\]

\[lone\_leftout\]

\[lone\_isolated\]                                                                                 | Please answer the following: 

<br>

How often do you feel that you lack companionship?

<br>

How often do you feel left out?

<br>

How often do you feel isolated from others?                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | 1 = Hardly ever

2 = Some of the time

3 = Often                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| Belonging

\[belong1\]                                                                                                                                     | How much do you agree with the following statement?:

<br>

I see myself as a part of the campus community.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         | 1 = Strongly agree

2 = Agree

3 = Somewhat agree

4 = Somewhat disagree

5 = Disagree

6 = Strongly disagree                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| Financial Stress

\[fincur\]

\[finpast\]                                                                                                                  | How would you describe your financial situation right now?

<br>

How would you describe your financial situation while growing up?                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 | 1 = Always stressful

2 = Often stressful

3 = Sometimes stressful

4 = Rarely stressful

5 = Never stressful                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| Knowledge and perceptions of campus services

\[knowwher\]                                                                                                 | How much do you agree with the following statement?:

<br>

If I needed to seek professional help for my mental or emotional health, I would know where to go on my campus.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         | 1 = Strongly agree

2 = Agree

3 = Somewhat agree

4 = Somewhat disagree

5 = Disagree

6 = Strongly disagree                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| Beliefs about treatment efficacy

\[ther\_help\]

\[ther\_helped\_me\]

\[med\_help\]

\[meds\_helped\_me\]                                                | How helpful on average do you think therapy or counseling is, when provided competently, for people your age who are clinically depressed?

<br>

How helpful on average do you think therapy or counseling would be for you if you were having mental or emotional health problems?

<br>

How helpful on average do you think medication is, when provided competently, for people your age who are clinically depressed?

<br>

How helpful on average do you think medication wouldbe for you if you were having mental or emotional health problems?                                                                                                                                                                                                                                                                                                                                                                                                                                           | 1 = Very helpful

2 = Helpful

3 = Somewhat helpful

4 = Not helpful                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| Stigma

\[stig\_pcv\_1\]

\[stig\_per\_1\]                                                                                                                 | How much do you agree with the following statement?:

<br>

Most people would willingly accept someone who has received mental health treatment as a close friend. 

<br>

Most people think less of a person who has received mental health treatment.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             | 1 = Strongly agree

2 = Agree

3 = Somewhat agree

4 = Somewhat disagree

5 = Disagree

6 = Strongly disagree                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| International Student Status

\[international\]                                                                                                            | Are you an international student?                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | 1 = Yes

0 = No                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| Major

\[field\_…\]                                                                                                                                        | What is your field of study? (Select all that apply)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                | 1 = Humanities (history, languages, philosophy,etc.)

2 = Natural sciences or mathematics

3 = Social sciences (economics, psychology,etc.)

4 = Architecture or urban planning

5 = Art and design

6 = Business

7 = Dentistry

8 = Education

9 = Engineering

10 = Law

11 = Medicine

12 = Music, theatre, or dance

13 = Nursing

14 = Pharmacy

15 = Pre - professional

16 = Public health

17 = Public policy

18 = Social work

19 = Undecided

20 = Other (please specify)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| Extra Curricular Activities

\[activ\_…\]                                                                                                                  | What activities do you currently participate in at your school? (Select all that apply                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              | 1 = Academic or pre-professional organization

2 = Athletics (club)

3 = Athletics (intercollegiate

varsity)

4 = Athletics (intramural)

5 = Community service

6 = Cultural or racial organization

7 = Dance

8 = Fraternity or sorority

9 = Gender or sexuality organization

10 = Government or politics (including student government)

11 = Health and wellness organization

12 = Media or publications

13 = Music or drama

14 = Religious organization                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| Sexual Orientation

\[sexual\_h\]

\[sexual\_g\]

\[sexual\_l\]

\[sexual\_bi\]

\[sexual\_queer\]

\[sexual\_quest\]

\[sexual\_other\]

\[sexual\_text\] | How would you describe your sexual orientation? (Select all that apply)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             | 1 = Heterosexual

2 = Lesbian

3 = Gay

4 = Bisexual

5 = Queer

6 = Questioning

7 = Self-identify (please specify)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |