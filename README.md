# E-Commerce Growth Analytics: A/B Testing & Customer Persona Segmentation

End-to-end Project Analyzing **Customer conversion** and **engagement across website experiments**, tracking **user behavior** to measure how different **A/B test variations** impact clicks, add-to-cart actions, and completed purchases. Using SQL, Python, and Power BI, aggregated and cleaned user sessions, orders, and experiment data into a single analysis-ready table, enabling detailed A/B test analysis and actionable insights for improving engagement, purchases, and revenue growth.

**Note:** This project uses a mock dataset designed to simulate realistic performance. Company names and figures are for demonstration purposes only. 


## Key Highlights

- **PostgreSQL Data Aggregation & Cleaning:** Consolidated ``80,000 session records``, ``8,000 user profiles``, ``30,044 orders``, and ``8 experiment definitions`` into a single ``1,563-row analysis-ready`` table. Built this using multi-step, ``industry-standard CTEs`` after running ~10 exploratory SQL queries to validate experiment exposure and event logic. Handled null values `(COALESCE)`, boolean event tracking, `window functions`, distinct counts, and filtered counts `(COUNT(*) FILTER)` to accurately capture clicks, add-to-cart actions, purchases, and orders. Ensured correct session-level aggregation to produce a clean, trustworthy dataset for A/B test analysis and downstream Python modeling.
- **Python-Based Funnel Analysis, Segmentation & Feature Engineering:** Extended the SQL output in Python by constructing a behaviorally ordered full-funnel framework (Visit → View → Add-to-Cart → Purchase) and engineering 7 additional analytical columns, including stage-level conversion rates, engagement tiers, and purchase-intent segments. Built funnel drop-off tables using left-join logic to preserve user attrition, computed stage-specific conversion ratios, and applied explicit if / elif / else rules to create transparent, explainable user segmentation. Validated experiment balance, exposure integrity, and metric consistency before final analysis.
- **Experiment Insights, Business Decisions & Data Re-Loading:** Revealed that early-funnel metrics can be misleading, with several experiments showing weak CTR or add-to-cart performance but strong positive lift in completed purchases, establishing purchase completion as the primary decision metric. Identified Version B as the clear winner ``(5 of 8 experiments, up to +211% lift)``, particularly among mid-funnel users ``(Medium/Low Engagement + Low Intent)`` — the largest scalable growth segment. Mapped performance gains to ``specific UI elements (notably Trust Badges and Urgency Banners)`` and loaded the final enriched analysis table back into PostgreSQL for reuse in dashboards, reporting, and future experimentation.
- **Analytical Testing:**
- **Power BI + Reporting:**
  

## Tools & Skills
**SQL(PostgreSQL)** | **Python(Cleaning, EDA, Research & Testing/Visulizations)** | **Power BI - Dashboard Tools & DAX** | **Data Modeling** | **ETL** | **Hypothesis Testing** | **Business Analysis** 
 


**Live Dashboard:** [View Power BI Report](your-link-here)  
**Executive Deck:** [View Google Slides](https://docs.google.com/presentation/d/1h2wTZSiAYNN2xwqsaU1r2wTdwOEzAcLZYS8ufUnIp0g/present?slide=id.g3a024b19907_2_96)  
**Full Case Study Below ↓**



# E-Commerce Growth Analytics (Approach & Findings)
A comprehensive Data Analytics Project analyzing website micro-experiments and customer behavior using PostgreSQL and Python, uncovering actionable insights to optimize website conversion, customer targeting, and revenue growth.

---

## Business Context
An e-commerce company aims to increase sales and revenue by understanding how small website changes and different customer types affect purchasing behavior.
By leveraging user clickstream, purchase, and engagement data, the company seeks to uncover which micro website experiments boost conversions and which customer segments respond best to targeted offers.

---

## Business Problem
The challenge is to identify which website changes improve conversion and which customer segments should be targeted for maximum impact.
This project aims to:

- Determine the effect of small website changes (badges, discount labels, product order) on user behavior and conversion.
- Identify high-value or discount-sensitive customer segments for personalized marketing.
- Provide data-driven recommendations to increase purchases and revenue.

---

## Key Challenges

1. **Untested Micro Website Changes** – Small elements like badges, discount labels, or product sorting may affect purchase behavior, but their impact is unknown.
2. **Customers Treated the Same** – All customers currently receive the same offers, leading to wasted marketing efforts and missed revenue opportunities.
3. **Fragmented Data Sources** – Customer behavior and purchase data are spread across multiple tables, requiring cleaning, merging, and accurate aggregation.
4. **Measuring Impact Accurately** – Determining whether changes or campaigns truly improve conversion requires statistical testing.
5. **Actionable Insights** – Translating data analysis into clear, implementable recommendations for the business.

---

## Approach Overview
### **Project Planning & Funnel Analysis:**    
Define Metrics, Map Funnel Stages **(Visit → View → ATC → Purchase)**, Segment Users by Engagement & Purchase Intent.

### **Aggregated Table Creation – PostgreSQL**
- Exploration & Validation: Ran 10 queries across sessions, users, orders, experiments to check joins, session counts, variant exposure, conversions, and experiment durations.
- Decisions & Cleaning: Kept only sessions with valid experiment_id, handled nulls in orders, ensured unique users per variant, applied window functions for per-user session counts.
- Final Aggregated Table: Joined cleaned CTEs to produce ecom.Agg_Etable with session, user, order, and experiment metrics — 1,563 analysis-ready rows for A/B testing and modeling.

### **Data Cleaning & Loading – PostgreSQL → Python → PostgreSQL**
- Started with clean base tables via PostgreSQL CTEs; added new metrics (`Click-through_Behaviour`, `Add_to_cart Rate`, `Conversion_Rate(Cmpltd_Pur-Ratio)`) and user segments (`Engagement_Level`, `PagesView_Level`, `ClickProd-Level`, `Purchase_Intent_Level`) in Python, aggregated into **Analysis-LvL_table**.
- Loading & Future Use Final table (`Analysis_Ready_Agg`) optionally loaded back to PostgreSQL for Power BI dashboards, downstream analyses, or further modeling.

### **Exploration (EDA) in Python**
EDA & Testing: Python pivot tables, lift %, segment-level analysis, feature-wise comparison.

**EDA 1 - Experiment Exposure & Balance (Validity Check)**
- User and session exposure across Version A and B is well balanced (≈3% user difference, ≈2% session difference), indicating no allocation bias.
- All experiments have sufficient exposure with no missing or abnormal session distributions, supporting valid downstream comparison.

**EDA 2 - Funnel Metrics by Experiment (Behavioral Differences)**
- User behavior differs meaningfully between Version A and B across experiments, indicating that UI changes influence engagement and conversion rather than producing uniform effects.
- Several experiments show higher completed purchase rates in Version B despite equal or lower click-through rates, suggesting improved traffic quality rather than increased volume.

**EDA 3 - Funnel Rate Analysis (CTR → ATC → Purchase)**
- High click-through rates do not consistently translate into purchases, confirming that CTR alone is not a reliable success metric.
- Version B frequently outperforms Version A at the bottom of the funnel (completed purchases), even when early-funnel engagement is neutral or negative.
- Add-to-cart behavior serves as a useful mid-funnel diagnostic but does not always predict final conversion success.

**EDA 4 - Lift Analysis**
- Completed Purchase lift was used as the primary decision metric due to its direct revenue impact.
- 5 out of 8 experiments show strong positive purchase lift under Version B, indicating consistent conversion improvement.
- Some experiments show negative CTR or Add-to-Cart lift but positive purchase lift, reinforcing the importance of evaluating full-funnel outcomes.

**NOTE:** Detailed experiment-level metrics, rates, and lift analysis are shown below.

The EDA builds a **Complete Intelligence Foundation**, revealing — setting the stage for deeper testing and the final BI dashboard & reporting.

<details> <summary><b> Key EDAs Experiment-level metrics, rates, and lift analysis (Click to Expand)</b></summary>
 
### **Experiment-level Funnel Lift Analysis (A/B Testing):**
- Completed Purchase is the primary decision metric, as it directly reflects revenue impact.
- Version B shows higher completed purchase rates in the majority of experiments, though performance varies by experiment ID.
- 5 out of 8 experiments demonstrate strong positive lift in completed purchases, indicating that Version B often converts higher-quality buyers.
- Early-funnel metrics (CTR, Add-to-Cart) are not reliable decision criteria on their own — several experiments show lower or neutral engagement but higher final conversions, suggesting improved traffic quality rather than volume.
- Add-to-Cart serves as a useful mid-funnel diagnostic, helping explain conversion outcomes but should not override purchase performance.
- Overall, Version B delivers stronger bottom-line performance, even when early-funnel signals are mixed.

### **Completed Purchase Lift Analysis (Primary Metric)**

#### **Code Used in ```Python```**
```
Cmplt_Pur = agg_df.pivot_table(index="experiment_id", columns="Experiment Version", values="Conversion_Rate(Cmpltd_Pur-Ratio)")
Cmplt_Pur.describe() # THIS GAVE US QUICK DESCRITPIVE STATS OF THE TABLE

'''
Lift % FORMULA:
((New Rate - Old Rate) / Old Rate) *100
'''

Cmplt_Pur["Cmplt_Pur_Lift%"] = ((Cmplt_Pur["B"] - Cmplt_Pur["A"])/ Cmplt_Pur["A"])*100
Cmplt_Pur # GIVES US THE TABLE including the lift% for each experiement by the Versions.

```
 **Top positive lift experiments**
| experiment_id | A (Conv) | B (Conv) | Cmplt_Pur_Lift % | Interpretation                                    |
| ------------- | -------: | -------: | ---------------: | ------------------------------------------------- |
| 3             |   0.0755 |   0.2353 |     **+211.76%** | Exceptional improvement — B massively outperforms |
| 4             |   0.1491 |   0.2453 |      **+64.48%** | Very strong conversion uplift                     |
| 8             |   0.1359 |   0.2165 |      **+59.28%** | Large gain in completed purchases                 |
| 7             |   0.1720 |   0.2697 |      **+56.74%** | Consistent, strong improvement                    |
| 2             |   0.1429 |   0.2124 |      **+48.67%** | Meaningful uplift — B clearly wins                |

Quick Takeaway:
5 out of 8 experiments show strong positive conversion lift, making Version B clearly superior from a revenue perspective.

 **Neutral / negative experiments**
| experiment_id | A (Conv) | B (Conv) | Cmplt_Pur_Lift % | Interpretation                |
| ------------- | -------: | -------: | ---------------: | ----------------------------- |
| 1             |   0.1949 |   0.1778 |       **−8.79%** | Slight decline in conversions |
| 6             |   0.1852 |   0.1522 |      **−17.83%** | Moderate underperformance     |
| 5             |   0.1829 |   0.1224 |      **−33.06%** | Worst performer for purchases |

Quick Takeaway:
A minority of experiments regress, reinforcing the importance of experiment-level analysis rather than global averages.


<details> <summary><b> Key EDA: Code & Output Summary For Click Through Behaviour Lift Analysis and Add-to-Cart Lift Analysis (Click to Expand)</b></summary>
 ---
 
### **Add-to-Cart Lift Analysis**

#### **Code Used in ```Python```**
```
Add_To_C = agg_df.pivot_table(index="experiment_id", columns="Experiment Version", values="Add_to_cart Rate")
Add_To_C.describe()

'''
Lift % FORMULA:
((New Rate - Old Rate) / Old Rate) *100 '''

Add_To_C["Add_To_C_Lift%"] = ((Add_To_C["B"] - Add_To_C["A"])/Add_To_C["A"])*100
Add_To_C

```

 **Top positive lift experiments**
| experiment_id | A (ATC) | B (ATC) | Add_To_C_Lift % | Interpretation                               |
| ------------- | ------: | ------: | --------------: | -------------------------------------------- |
| 5             |  0.0244 |  0.0714 |    **+192.86%** | Massive uplift — B drives far more cart adds |
| 1             |  0.0678 |  0.1000 |     **+47.50%** | Strong improvement — B clearly better        |
| 7             |  0.0430 |  0.0562 |     **+30.62%** | Solid uplift in cart engagement              |
| 6             |  0.0556 |  0.0652 |     **+17.39%** | Moderate improvement                         |
| 2             |  0.0714 |  0.0796 |     **+11.50%** | Small but positive lift                      |

Quick Takeaway:
Most experiments show improved Add-to-Cart behavior under Version B, with a few extremely large gains driven by low A baselines.

| experiment_id | A (ATC) | B (ATC) | Add_To_C_Lift % | Interpretation                |
| ------------- | ------: | ------: | --------------: | ----------------------------- |
| 8             |  0.0971 |  0.1031 |      **+6.19%** | Marginal improvement          |
| 4             |  0.1228 |  0.1038 |     **−15.50%** | B performs worse              |
| 3             |  0.0472 |  0.0353 |     **−25.18%** | Significant drop in cart adds |

Quick Takeaway:
A few experiments show weaker cart engagement, but they are outweighed by stronger positive lifts elsewhere.

NOTE: Extremely high lift values (e.g., +192%) are influenced by low Version A baselines and should be interpreted directionally rather than absolutely.


### **Click-Through Behaviour Lift Analysis**

#### **Code Used in ```Python```**

```
click_TBeh = agg_df.pivot_table(index="experiment_id", columns="Experiment Version", values="Click-through_Behaviour")
click_TBeh.describe()
'''
Lift % FORMULA:
((New Rate - Old Rate) / Old Rate) *100
'''

click_TBeh["Click_TBeh_Lift%"] = ((click_TBeh["B"]  - click_TBeh["A"])/click_TBeh["A"])*100
click_TBeh

```

 **Top positive lift experiments**
| experiment_id | A (CTR) | B (CTR) | Click_TBeh_Lift % | Interpretation                           | 
| ------------- | ------: | ------: | ----------------: |----------------------------------------- |
| 2             |  0.3214 |  0.4071 |       **+26.65%** | Very strong improvement — B clearly wins |
| 5             |  0.2561 |  0.3163 |       **+23.52%** | Large uplift, B is much better           |
| 1             |  0.3475 |  0.3889 |       **+11.92%** | Solid improvement                        |

Quick Takeaway: 3 out of 8 experiments show meaningful CTR improvement.          

 **Neutral / negative experiments**
| experiment_id | A (CTR) | B (CTR) | Click_TBeh_Lift % | Interpretation           |
| ------------- | ------: | ------: | ----------------: |--------------------------:
| 6             |  0.3056 |  0.3043 |         **−0.40%**| No meaningful difference |
| 4             |  0.4123 |  0.3774 |         **−8.47%**| B performs worse         |
| 7             |  0.3333 |  0.3034 |         **−8.99%**| B performs worse         |
| 3             |  0.3491 |  0.3176 |         **−9.00%**| B performs worse         |
| 8             |  0.3786 |  0.3402 |        **−10.15%**| Worst performer          |

Quick Takeaway: Half the experiments hurt CTR when switching to B.

While Version B shows a slightly higher average CTR overall, experiment-level lift analysis reveals that only 3 out of 8 experiments experienced meaningful improvements. Several experiments showed neutral or negative impact, indicating that Version B’s effectiveness is experiment-specific rather than universally superior.ent rather than universally superior.

</details> 

</details> 

**EDA 5 - Funnel Drop-Off Analysis (Where do people quit?)** 
- Landing experience effectiveness differs clearly across experiment variants.
Visit → Product View rates range from roughly 25% to 42%, showing that some variants are significantly better at converting site visits into product interest.
- The biggest funnel drop-off occurs between product view and add-to-cart.
View → Add-to-Cart rates are consistently low across experiments (often 10–30%), indicating friction in translating interest into purchase intent rather than an issue with site entry.
- Purchase behavior does not follow a strict step-by-step funnel.
In multiple experiments, the Add-to-Cart → Purchase rate exceeds 100%, confirming that users can complete purchases without a recorded add-to-cart action. Funnel stages should therefore be interpreted as engagement signals, not mandatory sequential steps.
- Overall conversion performance varies meaningfully by variant.
Visit → Purchase rates span from approximately 8% to 27%, demonstrating that experimental changes materially impact end-to-end conversion effectiveness.
- Different variants perform better at different funnel stages.
Some variants excel at generating early interest (higher Visit → View), while others perform better at final conversion (higher Visit → Purchase), highlighting stage-specific optimization opportunities rather than a single universal winner.

This dataset is simulated and aggregated, so funnel steps should be viewed as engagement signals rather than fixed step-by-step actions. Some users complete purchases without a recorded add-to-cart event. This could happen due to direct ‘Buy Now’ flows, users who already knew what they wanted before visiting the site, or limitations in how add-to-cart actions are captured in the data.


**EDA 6 - Segment-Level Experiment Performance**
Users are segmented into 3 funnel stages: Engagement (Interest), Purchase Intent, and Final Conversion. The addition of element_tested lets us see which UI/UX element drives conversions within each segment.

**Engagement Level Segmentation**
- High Engagement (~21% of users) are most active and likely to convert; Medium (~51%) are exploring and can be nudged toward conversion, Low (~28%) may need re-engagement campaigns.
- Segmentation helps prioritize marketing and UX efforts, ensuring resources are focused where they have the most impact.

**Purchase Intent Segmentation**
- Most users (~93%) show low purchase intent, reflecting typical e-commerce behavior where browsing does not translate into cart actions.
- A small but meaningful segment (~4%) demonstrates high purchase intent, defined by both cart interaction and above-median add-to-cart rates, indicating users closest to conversion.

**Final Conversion (Segment-Level & Element-Level Analysis)**
Experiment B consistently outperforms Experiment A across all user segments, but the uplift varies by element:
- For Medium Engagement + Low Intent (largest segment), TrustBadge and UrgencyBanner in Experiment B drive the biggest lift.
- For High Engagement + High Intent users, TrustBadge and PriceCharm are most effective.

Purchase intent alone does not guarantee higher conversion — engagement and the tested element are multipliers.
- Medium Engagement + High Intent users convert more with UrgencyBanner (B: 22.28%) than Low Engagement + Low Intent users with any element (B: ~21–22%).

Mid-funnel users + high-performing elements = largest business impact.
- High-intent, high-engagement users convert well but are very few (<15 users).
- Mid-funnel segments (Medium/Low Engagement + Low Intent) contain hundreds of users and show strong, stable uplift under Experiment B when optimal elements are used — making them the most scalable revenue drivers.

<details> <summary><b> Final Conversion Table with Best Performing Element (Click to Expand)</b></summary>

| Engagement_Level | Purchase_Intent_Level | Experiment_Version | Best_Element      | Best_avg_Conversion | Users_in_Segment |
|-----------------|---------------------|-----------------|-----------------|------------------|----------------|
| High            | High                | A               | UrgencyBanner    | 0.149123         | 8              |
| High            | High                | B               | TrustBadge       | 0.216495         | 14             |
| High            | Low                 | A               | FreeShippingBadge| 0.177145         | 141            |
| High            | Low                 | B               | TrustBadge       | 0.223545         | 153            |
| High            | Medium              | A               | UrgencyBanner    | 0.194915         | 6              |
| High            | Medium              | B               | TrustBadge       | 0.235294         | 8              |
| Low             | Low                 | A               | FreeShippingBadge| 0.177679         | 230            |
| Low             | Low                 | B               | TrustBadge       | 0.227136         | 209            |
| Medium          | High                | A               | UrgencyBanner    | 0.149123         | 16             |
| Medium          | High                | B               | UrgencyBanner    | 0.222781         | 25             |
| Medium          | Low                 | A               | FreeShippingBadge| 0.176941         | 371            |
| Medium          | Low                 | B               | TrustBadge       | 0.225647         | 343            |
| Medium          | Medium              | A               | UrgencyBanner    | 0.194915         | 25             |
| Medium          | Medium              | B               | TrustBadge       | 0.235294         | 13             |


<details> <summary><b> Complete Final Conversion Table (with All elements tested) (Click to Expand)</b></summary>

| Engagement_Level | Purchase_Intent_Level | Experiment Version | element_tested      | avg_Converion | Users |
|-----------------|---------------------|-----------------|------------------|---------------|-------|
| High            | High                | A               | TrustBadge       | 0.135922      | 2     |
| High            | High                | A               | UrgencyBanner    | 0.149123      | 6     |
| High            | High                | B               | PriceCharm       | 0.212389      | 3     |
| High            | High                | B               | TrustBadge       | 0.216495      | 3     |
| High            | High                | B               | UrgencyBanner    | 0.203092      | 8     |
| High            | Low                 | A               | FreeShippingBadge| 0.177145      | 32    |
| High            | Low                 | A               | PriceCharm       | 0.166667      | 32    |
| High            | Low                 | A               | TrustBadge       | 0.107586      | 32    |
| High            | Low                 | A               | UrgencyBanner    | 0.172528      | 45    |
| High            | Low                 | B               | FreeShippingBadge| 0.179699      | 36    |
| High            | Low                 | B               | PriceCharm       | 0.186583      | 42    |
| High            | Low                 | B               | TrustBadge       | 0.223545      | 40    |
| High            | Low                 | B               | UrgencyBanner    | 0.210566      | 35    |
| High            | Medium              | A               | PriceCharm       | 0.156966      | 3     |
| High            | Medium              | A               | TrustBadge       | 0.075472      | 1     |
| High            | Medium              | A               | UrgencyBanner    | 0.194915      | 2     |
| High            | Medium              | B               | FreeShippingBadge| 0.181335      | 5     |
| High            | Medium              | B               | PriceCharm       | 0.152174      | 2     |
| High            | Medium              | B               | TrustBadge       | 0.235294      | 1     |
| Low             | Low                 | A               | FreeShippingBadge| 0.177679      | 56    |
| Low             | Low                 | A               | PriceCharm       | 0.166715      | 55    |
| Low             | Low                 | A               | TrustBadge       | 0.102674      | 59    |
| Low             | Low                 | A               | UrgencyBanner    | 0.170493      | 60    |
| Low             | Low                 | B               | FreeShippingBadge| 0.193330      | 54    |
| Low             | Low                 | B               | PriceCharm       | 0.182282      | 54    |
| Low             | Low                 | B               | TrustBadge       | 0.227136      | 53    |
| Low             | Low                 | B               | UrgencyBanner    | 0.212937      | 48    |
| Medium          | High                | A               | TrustBadge       | 0.135922      | 8     |
| Medium          | High                | A               | UrgencyBanner    | 0.149123      | 8     |
| Medium          | High                | B               | PriceCharm       | 0.212389      | 6     |
| Medium          | High                | B               | TrustBadge       | 0.216495      | 7     |
| Medium          | High                | B               | UrgencyBanner    | 0.222781      | 12    |
| Medium          | Low                 | A               | FreeShippingBadge| 0.176941      | 80    |
| Medium          | Low                 | A               | PriceCharm       | 0.167242      | 91    |
| Medium          | Low                 | A               | TrustBadge       | 0.104781      | 99    |
| Medium          | Low                 | A               | UrgencyBanner    | 0.174767      | 99    |
| Medium          | Low                 | B               | FreeShippingBadge| 0.198654      | 85    |
| Medium          | Low                 | B               | PriceCharm       | 0.186209      | 92    |
| Medium          | Low                 | B               | TrustBadge       | 0.225647      | 76    |
| Medium          | Low                 | B               | UrgencyBanner    | 0.216781      | 90    |
| Medium          | Medium              | A               | FreeShippingBadge| 0.175671      | 6     |
| Medium          | Medium              | A               | PriceCharm       | 0.166373      | 9     |
| Medium          | Medium              | A               | TrustBadge       | 0.075472      | 4     |
| Medium          | Medium              | A               | UrgencyBanner    | 0.194915      | 6     |
| Medium          | Medium              | B               | FreeShippingBadge| 0.185541      | 7     |
| Medium          | Medium              | B               | PriceCharm       | 0.152174      | 4     |
| Medium          | Medium              | B               | TrustBadge       | 0.235294      | 2     |


</details> 

</details>

  
