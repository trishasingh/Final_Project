MATH 216 Data Science Final Project (Fall 2016)
================

-   Name: Trisha Singh
-   Project title: Caste-Based Mate Selection in Modern India
-   RPubs link: <http://rpubs.com/tsingh/final_project>

**Abstract**: I examine how the prevalence of the caste system in India varies with socio-economic status. Specifically, I answer the question: “When seeking a marriage partner, is the importance given to the partner’s caste related to a person’s income or education?”

I find strong statistically significant relationships between socioeconomic status and attitude towards the caste system. Every $1000 increase in annual income is correlated with a 0.3 percent decrease in probability of having a preference for partner's caste. Additionally, I find that a person with a Master’s degree is 7.5 percentage points less likely and a person with a Professional degree is 15 percentage points less likely to have caste preferences than someone with a Bachelor’s degree. A person working in the public sector is 9 percentage points more likely to give importance to parnter's caste than a person working in the private sector.

Introduction and Background
---------------------------

![](Caste_system.jpg)

The caste system is a hierachical social structure that originated from Hindu scriptures in Ancient India. It classifies people into five main cateogories based on their occupations: *brahmins* (priests and teachers), *kshatriyas* (warriors and rulers), *vaishyas* (farmers, traders and merchants), *shudras* (labourers) and *dalits* (street sweepers and latrine cleaners) (BBC 2016). Despite increased social mobility , the caste system is still prevalent and a person's caste can often be inferred from their family name.

The class structure formed by the caste system has led to oppression of people belonging to lower rungs of the hierarchy (Center for Human Rights and Global Justice 2007). This oppression forms the basis of caste-based discrimination such wage and employment discrimination in modern India (Banerjee and Knight 1985). The rigidity of the caste system is further propagated through traditional rules such as living with members of the same caste, marrying within caste and so on.

Within-caste marriages are still strongly encouraged in the traditional marriage system (Banerjee et al. 2013). In the modern arranged marriage system, individuals place advertisements in local newspapers or create profiles on on-line matrimonial websites to search for marriage partners. Partner's caste is one of the major criteria for marriage and a person's caste preferences for their partner reveals their attitude towards the caste system.

I explore how the rigidity of caste preference for marriage depends on a person’s income, education or occupation. Using a unique dataset of young middle class Indian men who placed matrimonial advertisements online, I predict a person's caste preferences based on their socio-economic status.

Sample Summary
--------------

I use a dataset containing a random sample of 1,246 young middle class Indian men who placed advertisements for a marriage partner on a popular Indian matrimonial website. This dataset contains information about each person and their partner preferences such as income, education, caste, city and so on.

I consider Hindu men as the caste system only exists in Hinduism. Figure 1 shows that my dataset contains people who have above average income, the mean income of the sample being $13,010 per annum. The sample also has a younger age distribution, with the mean age being 30 years. Since these are matrimonial advertisements placed online, my sample contains people who have access to computers or other devices and are digitally literate.

![](Final_Project_files/figure-markdown_github/unnamed-chunk-2-1.png)

###### Figure 1: Histogram showing income and age distribution in the sample (Income reported in USD)

Analysis
--------

I conduct regression analysis to estimate the relationship between income, education and occupation and a person's caste preferences. I use a linear probability model, in which the outcome variable is the probability of having a caste preference for marriage and the independent variables are in each case, annual income, highest education degree and type of job.

Linear probability models do have a higher possibility for bias and inconsistency than logistic or probabilistic models, but the estimates obtained from the model are easier to interpret (Friedman 2012). The ability to intuitively interpret the estimates from the model is especially important in this case, since I am studying a problem with social implications.

Another drawback of linear probability models is that the predicted values may be less than zero or greater than one. However, I verify the range of all regressions I run and they are well within the \[0,1\] range.

### Income

In my exploratory plot for income and caste preferences, I divide income into deciles since there are a lot of outliers in the income variable. In Figure 2, the regression line shows that there is a negative linear relationship between income and caste preferences. That is, as income increases, caste preferences decrease.

I estimate the following linear probability model in Table 1 in the Appendix:

*P**r**o**b**a**b**i**l**i**t**y*(*C**a**s**t**e**P**r**e**f**e**r**e**n**c**e**s*)=*α* + *β*.*I**n**c**o**m**e* + *ϵ*

I find that **a $1000 increase in a person's income reduces the probability of having caste preferences by 0.3 percentage points**. Although this result is statistically significant, it is not a large effect. <br><br> ![](Final_Project_files/figure-markdown_github/unnamed-chunk-3-1.png)

###### Figure 2: Relationship between Income and Caste Preferences. (Income is reported in USD, aggregated by deciles).

<br><br>

### Education

I group the education variable into four main categories: Bachelor's, Masters, Professional (Engineering or Medical) and Doctorate. The exploratory analysis in Figure 3 shows that people having Bachelor's or Doctorate degrees have a higher than baseline probability of having caste preferences and people having Master's or Professional degrees have lower than baseline probabilities. <br><br> ![](Final_Project_files/figure-markdown_github/unnamed-chunk-4-1.png)

###### Figure 3: Relationship between Education and Caste Preferences

<br><br> I estimate the following linear probability model in Table 2 in the Appendix:

*P**r**o**b**a**b**i**l**i**t**y*(*C**a**s**t**e**P**r**e**f**e**r**e**n**c**e**s*)=*α* + *β*.*E**d**u**c**a**t**i**o**n* + *ϵ*

I find statistically significant estimates which indicate that:

1.  **a person with a Master’s degree is 7.5 percentage points less likely to have caste preferences than a person with a Bachelor's degree**.

2.  Also, **a person with a Professional degree is 15 percentage points less likely to have caste preferences than a person with a Bachelor’s degree**.

It seems that as education level increases, caste preferences decrease, except for the case of Doctorate degrees. However, the estimate for Doctorate degrees is not statistically significant since the sample does not contain enough people.

Figure 4 summarizes the regression estimates relative to a person with a Bachelor's degree. It shows that the confidence intervals for people with Master's and Professional degrees have a negative range and do not span zero. <br><br> ![](Final_Project_files/figure-markdown_github/unnamed-chunk-5-1.png)

###### Figure 4: Regression Estimates of Correlation between Education and Caste Preferences. Estimates relative to person with a Bachelor's Degree.

<br><br>

### Occupation

The occupation variable indicates the sector the person is employed in. It has three main categories: Private Sector, Public Sector and Other (Self-employed, Business or Other). The exploratory analysis in Figure 5 shows that people other or private sectors have a higher than baseline probability of having caste preferences and people working in the public sector have lower than baseline probabilities. <br><br> ![](Final_Project_files/figure-markdown_github/unnamed-chunk-6-1.png)

###### Figure 5: Relationship between Occupation and Caste Preferences

<br><br> I estimate the following linear probability model in Table 3 in the Appendix:

*P**r**o**b**a**b**i**l**i**t**y*(*C**a**s**t**e**P**r**e**f**e**r**e**n**c**e**s*)=*α* + *β*.*O**c**c**u**p**a**t**i**o**n* + *ϵ*

I find statistically significant estimates which indicate that **a person working in the Public Sector is 9 percentage points more likely to have caste preferences than a person working in the Public Sector**. However, this estimate is only significant at the 1% level (p-value=0.06). The estimate for the Other category is not statistically significant.

Figure 6 summarizes the regression estimates relative to a person working in the Private Sector. It shows that the confidence interval for people working in the Public Sector has a positive range and only touches zero at the lower bound. <br><br> ![](Final_Project_files/figure-markdown_github/unnamed-chunk-7-1.png)

###### Figure 6: Regression Estimates of Correlation between Occupation and Caste Preferences. Estimates relative to person working in Private Sector.

<br><br>

Discussion
----------

The significance of the relationship between income, education and caste preferences is interesting, but not too surprising. The positive relationship between caste preferences and working in the public sector is concerning, since people who work in the public sector also design and implement government welfare policies. Also, the negative (albeit not statistically significant) correlation between having a doctorate degree and stronger caste preferences requires further study.

It is important to understand whether these relationships are causal in order to think about public policy implications and ways to combat the negative effects of the caste system. For future analysis, I intend to expand the dataset and exploit a naturally ocurring regional variation or policy shock to find causal effects of socio-economic factors. I also intend to create sampling weights so that under and over-sampling of certain categories of people can be accounted for.

Appendix Tables
---------------

<table>
<caption>Fitting linear model: partner_caste ~ I(income_dollar/1000)</caption>
<colgroup>
<col width="38%" />
<col width="15%" />
<col width="18%" />
<col width="13%" />
<col width="13%" />
</colgroup>
<thead>
<tr class="header">
<th align="center"> </th>
<th align="center">Estimate</th>
<th align="center">Std. Error</th>
<th align="center">t value</th>
<th align="center">Pr(&gt;|t|)</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center"><strong>I(income_dollar/1000)</strong></td>
<td align="center">-0.0032</td>
<td align="center">0.0012</td>
<td align="center">-2.7</td>
<td align="center">0.0068</td>
</tr>
<tr class="even">
<td align="center"><strong>(Intercept)</strong></td>
<td align="center">0.55</td>
<td align="center">0.021</td>
<td align="center">26</td>
<td align="center">1.5e-120</td>
</tr>
</tbody>
</table>

###### Table 1: Regression Results of Caste Preference Probability on Income in USD

<table>
<caption>Fitting linear model: partner_caste ~ education</caption>
<colgroup>
<col width="38%" />
<col width="15%" />
<col width="18%" />
<col width="13%" />
<col width="13%" />
</colgroup>
<thead>
<tr class="header">
<th align="center"> </th>
<th align="center">Estimate</th>
<th align="center">Std. Error</th>
<th align="center">t value</th>
<th align="center">Pr(&gt;|t|)</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center"><strong>educationProfessional</strong></td>
<td align="center">-0.15</td>
<td align="center">0.069</td>
<td align="center">-2.2</td>
<td align="center">0.026</td>
</tr>
<tr class="even">
<td align="center"><strong>educationMasters</strong></td>
<td align="center">-0.075</td>
<td align="center">0.03</td>
<td align="center">-2.5</td>
<td align="center">0.013</td>
</tr>
<tr class="odd">
<td align="center"><strong>educationDoctorate</strong></td>
<td align="center">0.04</td>
<td align="center">0.083</td>
<td align="center">0.48</td>
<td align="center">0.63</td>
</tr>
<tr class="even">
<td align="center"><strong>(Intercept)</strong></td>
<td align="center">0.54</td>
<td align="center">0.019</td>
<td align="center">29</td>
<td align="center">1.3e-139</td>
</tr>
</tbody>
</table>

###### Table 2: Regression Results of Caste Preference Probability on Education Level

<table style="width:93%;">
<caption>Fitting linear model: partner_caste ~ job</caption>
<colgroup>
<col width="31%" />
<col width="15%" />
<col width="18%" />
<col width="13%" />
<col width="13%" />
</colgroup>
<thead>
<tr class="header">
<th align="center"> </th>
<th align="center">Estimate</th>
<th align="center">Std. Error</th>
<th align="center">t value</th>
<th align="center">Pr(&gt;|t|)</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center"><strong>jobOther</strong></td>
<td align="center">0.02</td>
<td align="center">0.041</td>
<td align="center">0.49</td>
<td align="center">0.63</td>
</tr>
<tr class="even">
<td align="center"><strong>jobPublic Sector</strong></td>
<td align="center">0.089</td>
<td align="center">0.046</td>
<td align="center">1.9</td>
<td align="center">0.055</td>
</tr>
<tr class="odd">
<td align="center"><strong>(Intercept)</strong></td>
<td align="center">0.49</td>
<td align="center">0.016</td>
<td align="center">30</td>
<td align="center">1.1e-150</td>
</tr>
</tbody>
</table>

###### Table 3: Regression Results of Caste Preference Probability on Occupation Sector

<br><br>

References
----------

BBC. “What is India’s Caste System?”.<http://www.bbc.com/news/world-asia-india-35650616>. 25 Feb. 2016. Web. 15 Dec. 2016.

NYU School of Law, Center for Human Rights and Global Justice. “Caste Discrimination in India.” <http://chrgj.org/clinics/international-human-rights-clinic/caste-discrimination-and-transitional-justice-in-nepal/caste-discrimination-in-india-2/>. 2007. Web. 15 Dec. 2016.

Banerjee, Biswajit, and John B. Knight. "Caste discrimination in the Indian urban labour market." *Journal of development Economics* 17.3 (1985): 277-307.

Banerjee, Abhijit, et al. "Marry for what? Caste and mate selection in modern India." *American Economic Journal*: Microeconomics 5.2 (2013): 33-72.

Friedman, Jed. “Whether to probit or to probe it: in defense of the Linear Probability Model.” <http://blogs.worldbank.org/impactevaluations/whether-to-probit-or-to-probe-it-in-defense-of-the-linear-probability-model>. 18 July 2012. Web. 15 Dec. 2016.
