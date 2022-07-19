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

<table>
  <tr>
    <th>Variable</th>
    <th>Description</th>
    <th>Response</th>
  </tr>
  <tr>
   <td>School year [ schoolYear ] 
   </td>
   <td>Year the Healthy Minds Survey was taken 
   </td>
   <td>2017-18,
<p>
2018-19, 
<p>
2019-20,
<p>
2020-21
   </td>
  </tr>
  <tr>
   <td>Class Year [ classYear ]
   </td>
   <td>What year are you in your current degree program?
   </td>
   <td>1st year - 7th year
   </td>
  </tr>
  <tr>
   <td>Age [ age ] 
   </td>
   <td>How old are you? (You must be 18 years or older to complete this survey.) 
   </td>
   <td>______ years old
   </td>
  </tr>
  <tr>
   <td>Gender [ gender ] 
   </td>
   <td>What is your gender identity?
   </td>
   <td>1=Male
<p>
2=Female
<p>
3=Trans male/Trans man
<p>
4=Trans female/Trans woman
<p>
5=Genderqueer/Gender non-conforming
<p>
6=Self-identify (please specify)
   </td>
  </tr>
  <tr>
   <td>Race [ race_]
   </td>
   <td>What is your race/ethnicity?(Select all that apply)
   </td>
   <td>Race_black =
<p>
African American/Black 
<p>
Race_asian = 
<p>
Asian American/Asian race_his = 
<p>
Hispanic/Latino/a 
<p>
Race_white = White 
<p>
Race_other = 
<p>
Self-identify (please specify)
   </td>
  </tr>
  <tr>
   <td>Positive Mental Health
<p>
[ diener ]
   </td>
   <td>
<ul>

<li>I lead a purposeful and meaningful life.

<li>My social relationships are supportive and rewarding

<li>I am engaged and interested in my daily activities.

<li>I actively contribute to the happiness and well-being of others.

<li>I am competent and capable in the activities that are important to me.

<li>I am a good person and live a good life.

<li>I am optimistic about my future.

<li>People respect me
</li>
</ul>
   </td>
   <td>1=Strongly disagree
<p>
2=Disagree
<p>
3=Slightly disagree
<p>
4=Mixed or neither agree nor disagree
<p>
5=Slightly agree
<p>
6=Agree
<p>
7=Strongly agree
   </td>
  </tr>
  <tr>
   <td>Positive Mental Health
<p>
[ diener_score ]
   </td>
   <td>Sum of all diener variables
   </td>
   <td>8 - 56
   </td>
  </tr>
  <tr>
   <td>Diagnosed Mental Illnesses [dx_…]
   </td>
   <td>Have you ever been diagnosed with any of the following conditions by a health professional (e.g., primary care doctor, psychiatrist, psychologist, etc.)? (Select all that apply)
   </td>
   <td><strong>dx_dep </strong>[ 1 = depression ] 
<p>
<strong>dx_bip</strong> [ 1 = bipolar ] 
<p>
<strong>dx_anx</strong> [ 1 = anxiety ] 
<p>
<strong>dx_ocd</strong> [ 1= Obsessive-compulsive / related disorders ]
<p>
<strong>dx_ptsd</strong> [ 1=Trauma and Stressor Related Disorders ]
<p>
<strong>dx_neurodev</strong> [ 1=Neurodevelopmental disorder or intellectual disability ]
<p>
<strong>dx_ea</strong> [ 1=Eating disorder ] 
<p>
<strong>dx_psy</strong> [ 1=Psychosis ] 
<p>
<strong>dx_pers</strong> [ 1=Personality disorder ]
<p>
<strong>dx_sa </strong>[ 1=Substance use disorder ] 
<p>
<strong>dx_none </strong>[ 1=No, none of these [mutually exclusive]
<p>
<strong>dx_dk</strong> [ 1= don't know ] 
   </td>
  </tr>
  <tr>
   <td>Academic Impairment
<p>
[ aca_impa ]
   </td>
   <td>In the past 4 weeks, how many days have you felt that emotional or mental difficulties have hurt your academic performance?
   </td>
   <td>1=None 
<p>
2=1-2 days 
<p>
3=3-5 days 
<p>
4=6 or more days
   </td>
  </tr>
  <tr>
   <td>Help-seeking intentions
<p>
[ talk1_…]
   </td>
   <td>If you were experiencing serious emotional distress, whom would you talk to about this? (Select all that apply)
   </td>
   <td>1=Professional clinician (e.g., psychologist,counselor, or psychiatrist) 
<p>
2=Roommate 
<p>
3=Friend (who is not a roommate) 
<p>
4=Significant other 
<p>
5=Family member 6=Religious counselor or other religious contact
<p>
7=Support group 
<p>
8=Other non-clinical source (please specify) 
<p>
9=No one
   </td>
  </tr>
  <tr>
   <td>Use of counseling/therapy
<p>
[ ther_ever ] 
   </td>
   <td>Have you ever received counseling or therapy for mental health concerns?
   </td>
   <td>1=No, never 
<p>
2=Yes, prior to starting college 
<p>
3=Yes, since starting college 4=Yes, both of the above (prior to college and since starting college)
   </td>
  </tr>
  <tr>
   <td>Anxiety
<p>
[gad7_…]
<p>
* Not measured in HMS 2017
   </td>
   <td>Over the last 2 weeks, how often have you been bothered by the following problems?
<p>
Feeling nervous, anxious or on edge
<p>
Not being able to stop or control worrying
<p>
Worrying too much about different things
<p>
Trouble relaxing
<p>
Being so restless that it’s hard to sit still
<p>
Becoming easily annoyed or irritable
<p>
Feeling afraid as if something awful might happen
<p>
How difficult have these problems (noted above) made it for you to do your work, take care of things at home, or get along with other people?
   </td>
   <td>1=Not at all 
<p>
2=Several days 
<p>
3=Over half the days 4=Nearly every day
   </td>
  </tr>
  <tr>
   <td>Depression
<p>
[phq9_…]
<p>
* Not measured in HMS 2017
   </td>
   <td>- Over the last 2 weeks, how often have you been
<p>
bothered by any of the following problems?:
<p>
Little interest or pleasure in doing things
<p>
Feeling down, depressed or hopeless
<p>
Trouble falling or staying asleep, or sleeping too much
<p>
Feeling tired or having little energy
<p>
Poor appetite or overeating
<p>
Feeling bad about yourself—or that you are a failure or have let yourself or your family down
<p>
Trouble concentrating on things, such as reading the newspaper or watching television 
<p>
Moving or speaking so slowly that other people could have noticed; or the opposite—being so fidgety or restless that you have been moving around a lot more than usual
<p>
Thoughts that you would be better off dead or of hurting yourself in some way
<p>
- During that period, how often were you bothered by these problems?:
<p>
Little interest or pleasure in doing things
<p>
Feeling down, depressed or hopeless
   </td>
   <td>1=Not at all 
<p>
2=Several days 
<p>
3=Over half the days 4=Nearly every day
   </td>
  </tr>
  <tr>
   <td>Depression Impact
<p>
[dep_impa]
<p>
* Not measured in HMS 2017
   </td>
   <td>How difficult have these problems (noted above) made it for you to do your work, take care of things at home, or get along with other people?
   </td>
   <td>1=Not difficult at all 2=Somewhat difficult 
<p>
3=Very difficult 
<p>
4=Extremely difficult
   </td>
  </tr>
  <tr>
   <td>Loneliness
<p>
[lone_…]
<p>
* Only measured in HMS 2020-2021
   </td>
   <td>Please answer the following:
<p>
How often do you feel that you lack companionship?
<p>
How often do you feel left out?
<p>
How often do you feel isolated from others?
   </td>
   <td>1=Hardly ever 
<p>
2=Some of the time 
<p>
3=Often
   </td>
  </tr>
  <tr>
   <td>Exercise
<p>
[Q3_27]
<p>
* Not measured in HMS 2020-2021
   </td>
   <td>In the past 30 days, about how many hours per week on average did you spend exercising?
<p>
(Include any exercise of moderate or higher intensity, where “moderate intensity” would be roughly equivalent to brisk walking or bicycling)
   </td>
   <td>1=Less than 1 hour
<p>
2=2-3 hours
<p>
3=3-4 hours
<p>
4=5 or more hours
   </td>
  </tr>
  <tr>
   <td>Sleep [sleep_ ]
   </td>
   <td>During this school year, at approximately what time have you typically gone to sleep on:
<p>
Weeknights
<p>
Weekend nights
<p>
Weekdays
<p>
Weekend days
   </td>
   <td>1=12:00pm
<p>
2=1:00pm 
<p>
3=2:00pm 
<p>
4=3:00pm 
<p>
5=4:00pm 
<p>
6=5:00pm 
<p>
7=6:00pm 
<p>
8=7:00pm 
<p>
9=8:00pm 
<p>
10=9:00pm 
<p>
11=10:00pm 
<p>
12=11:00pm 
<p>
13=12:00am 
<p>
14=1:00am 
<p>
15=2:00am 
<p>
16=3:00am 
<p>
17=4:00am 
<p>
18=5:00am 
<p>
19=6:00am 
<p>
20=7:00am 
<p>
21=8:00am 
<p>
22=9:00am 
<p>
23=10:00am 24=11:00am 
   </td>
  </tr>
  <tr>
   <td>Sleep (naps) [sleep_np#]
   </td>
   <td>During this school year, on how many days have you taken naps during a typical week? 
<p>
How long is your typical nap?
   </td>
   <td>1=I don’t take naps.
<p>
2=1 
<p>
3=2 
<p>
4=3 
<p>
5=4 
<p>
6=5 
<p>
7=6 
<p>
8=7
<p>
1=Less than 1 hour 2=Between 1 and 2 hours 3=Between 2 and 3 hours 4=More than 3 hours 
   </td>
  </tr>
  <tr>
   <td>Alcohol Use
<p>
[alc_any]
<p>
[binge_fr_f]
<p>
[binge_fr_m]
<p>
[binge_fr_o]
   </td>
   <td>Over the past 2 weeks, did you drink any alcohol?
<p>
Over the past 2 weeks, about how many times did you have 4 [female]/5 [male]/4 or 5 [not female or male] or more alcoholicdrinks in a row? (1 drink is a can of beer, a glass of wine, a wine cooler, a shot ofliquor, or a mixed drink.)
   </td>
   <td>1 = Yes
<p>
0 = No
<p>
1=0 times 
<p>
2=1 time 
<p>
3=2 times 
<p>
4=3 to 5 times 
<p>
5=6 to 9 times 
<p>
6=10 or more times 
<p>
7=Don’t know
   </td>
  </tr>
  <tr>
   <td>Drug Use
<ol>

<li>[smok_freq]

<li>[smok_vape]

<li>[smok_vape_mist]

<li>[drug_…]
</li>
</ol>
   </td>
   <td>
<ol>

<li>Over the past 30 days, about how many cigarettes did you smoke per day?

<li>Over the past 30 days, have you used an electronic cigarette or vape pen?

<li>What did you think was in the mist you inhaled the last time youused a vaping device?

<li>Over the past 30 days, have you used any of the following drugs?(Select all that apply)
</li>
</ol>
   </td>
   <td>
<ol>

<li>D

<li>D

<li>D

<li>1=Marijuana 2=Cocaine (any form, including crack, powder, or freebase) 3=Heroin 
    4=Opioid pain relievers (such as Vicodin, OxyContin, Percocet, Demerol,Dilaudid, codeine, hydrocodone, methadone, morphine) without a prescription or more than prescribed 5=Benzodiazepines (such as Valium, Ativan, Klonopin, Xanax, Rohypnal (Roofies)) 6=Methamphetamines (also known as speed, crystal meth, Tina, T, or ice) 
<p>

    7=Other stimulants (such as Ritalin, Adderall) without a prescription or more than prescribed 8=MDMA (also known as Ecstasy or Molly) 
<p>

    9=Ketamine (also known as K, SpecialK) 
<p>

    10=LSD (also known as acid) 
<p>

    11=Psilocybin (also known as magic mushrooms, boomers, shrooms) 
<p>

    12=Kratom 13=Athletic performance enhancers (anything that violates policies set by your school or any athletic governing body) 
<p>

    14=Other drugs without a prescription (please specify) 15=No, none of these
</li>
</ol>
   </td>
  </tr>
  <tr>
   <td>Loneliness
<p>
[lone_lackcompanion]
<p>
[lone_leftout]
<p>
[lone_isolated]
   </td>
   <td>Please answer the following: 
<p>
How often do you feel that you lack companionship?
<p>
How often do you feel left out?
<p>
How often do you feel isolated from others? 
   </td>
   <td>1=Hardly ever 
<p>
2=Some of the time 
<p>
3=Often
   </td>
  </tr>
  <tr>
   <td>Belonging
<p>
[belong1]
   </td>
   <td>How much do you agree with the following statement?:
<p>
I see myself as a part of the campus community.
   </td>
   <td>1=Strongly agree 
<p>
2=Agree 
<p>
3=Somewhat agree 4=Somewhat disagree 5=Disagree
<p>
6=Strongly disagree
   </td>
  </tr>
  <tr>
   <td>Financial Stress
<p>
[fincur]
<p>
[finpast]
   </td>
   <td>How would you describe your financial situation right now?
<p>
How would you describe your financial situation while growing up?
   </td>
   <td>1=Always stressful 
<p>
2=Often stressful 3=Sometimes stressful 4=Rarely stressful 
<p>
5=Never stressful
   </td>
  </tr>
  <tr>
   <td>Knowledge and perceptions of campus services
<p>
[knowwher]
   </td>
   <td>How much do you agree with the following statement?:
<p>
If I needed to seek professional help for my mental or emotional health, I would know where to go on my campus.
   </td>
   <td>1=Strongly agree 
<p>
2=Agree 
<p>
3=Somewhat agree 4=Somewhat disagree 5=Disagree 
<p>
6=Strongly disagree
   </td>
  </tr>
  <tr>
   <td>Beliefs about treatment efficacy
<p>
[ther_help]
<p>
[ther_helped_me]
<p>
[med_help]
<p>
[meds_helped_me]
   </td>
   <td>How helpful on average do you think therapy or counseling is, when provided competently, for people your age who are clinically depressed?
<p>
How helpful on average do you think therapy or counseling would be for you if you were having mental or emotional health problems?
<p>
How helpful on average do you think medication is, when provided competently, for people your age who are clinically depressed?
<p>
How helpful on average do you think medication wouldbe for you if you were having mental or emotional health problems?
   </td>
   <td>1=Very helpful 
<p>
2=Helpful
<p>
 3=Somewhat helpful
<p>
4=Not helpful
   </td>
  </tr>
  <tr>
   <td>Stigma
<p>
[stig_pcv_1]
<p>
[stig_per_1]
   </td>
   <td>How much do you agree with the following statement?:
<p>
Most people would willingly accept someone who has received mental health treatment as a close friend. 
<p>
Most people think less of a person who has received mental health treatment.
   </td>
   <td>1=Strongly agree 
<p>
2=Agree 
<p>
3=Somewhat agree 4=Somewhat disagree 5=Disagree 
<p>
6=Strongly disagree 
   </td>
  </tr>
  <tr>
   <td>International Student Status
<p>
[international]
   </td>
   <td>Are you an international student?
   </td>
   <td>1=Yes 
<p>
0=No
   </td>
  </tr>
  <tr>
   <td>Major
<p>
[field_…]
   </td>
   <td>What is your field of study? (Select all that apply)
   </td>
   <td>1=Humanities (history, languages, philosophy,etc.) 2=Natural sciences or mathematics 
<p>
3=Social sciences (economics, psychology,etc.) 4=Architecture or urban planning
<p>
5=Art and design 
<p>
6=Business 
<p>
7=Dentistry
<p>
8=Education 
<p>
9=Engineering 
<p>
10=Law
<p>
11=Medicine
<p>
12=Music, theatre, or dance 13=Nursing 
<p>
14=Pharmacy 
<p>
15=Pre - professional
<p>
16=Public health 
<p>
17=Public policy 
<p>
18=Social work
<p>
19=Undecided
<p>
 20=Other (please specify)
   </td>
  </tr>
  <tr>
   <td>Extra Curricular Activities
<p>
[activ_…]
   </td>
   <td>What activities do you currently participate in at your school? (Select all that apply
   </td>
   <td>1=Academic or pre-professional organization
<p>
2=Athletics (club)
<p>
3=Athletics (intercollegiate
<p>
varsity)
<p>
4=Athletics (intramural) 
<p>
5=Community service
<p>
6=Cultural or racial organization
<p>
7=Dance
<p>
8=Fraternity or sorority
<p>
9=Gender or sexuality organization
<p>
10=Government or politics (including student government)
<p>
11=Health and wellness organization
<p>
12=Media or publications
<p>
13=Music or drama
<p>
14=Religious organization
   </td>
  </tr>
  <tr>
   <td>Sexual Orientation
<p>
[sexual_h]
<p>
[sexual_g]
<p>
[sexual_l]
<p>
[sexual_bi]
<p>
[sexual_queer]
<p>
[sexual_quest]
<p>
[sexual_other]
<p>
[sexual_text]
   </td>
   <td>How would you describe your sexual orientation? (Select all that apply)
   </td>
   <td>1=Heterosexual
<p>
2=Lesbian 
<p>
3=Gay 
<p>
4=Bisexual 
<p>
5=Queer 
<p>
6=Questioning 7=Self-identify (please specify) 
   </td>
  </tr>
</table>