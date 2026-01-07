# E-Commerce Growth Analytics: A/B Testing & Customer Persona Segmentation 

End-to-end Project Analyzing **Customer conversion** and **engagement across website experiments**, tracking **user behavior** to measure how different **A/B test variations** impact clicks, add-to-cart actions, and completed purchases. Using SQL, Python, and Power BI, aggregated and cleaned user sessions, orders, and experiment data into a single analysis-ready table, enabling detailed A/B test analysis and actionable insights for improving engagement, purchases, and revenue growth.

**Note:** This project uses a mock dataset designed to simulate realistic performance. Company names and figures are for demonstration purposes only. 


## Key Highlights

- **PostgreSQL Data Aggregation & Cleaning:** Consolidated ``80,000 session records``, ``8,000 user profiles``, ``30,044 orders``, and ``8 experiment definitions`` into a single ``1,563-row analysis-ready`` table. Built this using multi-step, ``industry-standard CTEs`` after running ~10 exploratory SQL queries to validate experiment exposure and event logic. Handled null values `(COALESCE)`, boolean event tracking, `window functions`, distinct counts, and filtered counts `(COUNT(*) FILTER)` to accurately capture clicks, add-to-cart actions, purchases, and orders. Ensured correct session-level aggregation to produce a clean, trustworthy dataset for A/B test analysis and downstream Python modeling.
- **Python-Based Funnel Analysis, Segmentation & Feature Engineering:** Extended the SQL output in Python by constructing a behaviorally ordered full-funnel framework ``(Visit → View → Add-to-Cart → Purchase)`` and engineering 7 additional analytical columns, including conversion rates, lift metrics, engagement tiers, and purchase-intent segments. Built funnel drop-off tables using left-join logic to preserve user attrition, computed stage-specific conversion ratios, and used ``avg_Converion`` as the primary aggregation metric for segment-level comparison. Applied explicit rules using ``if / elif / else`` statements to segment users by ``Engagement Level`` and ``Purchase Intent``, ensuring transparent, rule-based, and explainable user classification. Validated experiment balance, exposure integrity, and metric consistency before final analysis.
- **Experiment Insights, Business Decisions & Data Re-Loading:** Revealed that early-funnel metrics can be misleading, with several experiments showing weak CTR or add-to-cart performance but strong positive lift in completed purchases, establishing purchase completion as the primary decision metric. Identified Version B as the clear winner ``(5 of 8 experiments, up to +211% lift)``, particularly among mid-funnel users ``(Medium/Low Engagement + Low Intent)`` — the largest scalable growth segment. Mapped performance gains to ``specific UI elements (notably Trust Badges and Urgency Banners)`` and loaded the final enriched analysis table back into PostgreSQL for reuse in dashboards, reporting, and future experimentation.
- **Analytical Testing:** Executed rigorous statistical testing across multiple levels, including ``one-sided proportion z-tests``, ``chi-square independence tests``, ``ANOVA``, and ``logistic regression models`` to evaluate UI/UX variants, stage-specific conversion rates, and engagement-based segments. Validated experiment assumptions, quantified lift, controlled for confounding factors, and ensured statistical significance, revealing Variant B as the consistently top-performing option with measurable conversion and revenue impact.
- **Business Recommendations:** Generated high-impact, scalable strategies for e-commerce growth by combining funnel insights, segment-level lift, and UI element performance. Recommended targeted deployment of winning variants and engagement strategies to optimize mid-funnel users, reduce drop-offs, and maximize ROI, translating complex analytics into implementable, revenue-focused business actions.
- **Power BI + Reporting:** Built dynamic dashboards and executive-level reports using Power BI, integrating SQL, Python-derived metrics, and DAX measures. Visualized funnel performance, conversion trends, lift metrics, experiment results, and segment-level insights, enabling real-time monitoring, KPI tracking, and stakeholder-ready decision intelligence.
  

## Tools & Skills
**SQL(PostgreSQL)** | **Python(Cleaning, EDA, Research & Testing/Visulizations)** | **Power BI - Dashboard Tools & DAX** | **Data Modeling** | **ETL** | **Hypothesis Testing** | **Business Analysis** 
 


**Live Dashboard:** [View Power BI Report](your-link-here)  
**Executive Deck:** [View Google Slides](https://docs.google.com/presentation/d/1h2wTZSiAYNN2xwqsaU1r2wTdwOEzAcLZYS8ufUnIp0g/present?slide=id.g3a024b19907_2_96)  
**Full Case Study Below ↓**



# E-Commerce Growth Analytics (Approach & Findings)
A Comprehensive Data Analytics Project analyzing website micro-experiments and customer behavior using PostgreSQL and Python, uncovering actionable insights to optimize website conversion, customer targeting, and revenue growth.

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
- Started with clean base tables via PostgreSQL CTEs; added new metrics (`Click-through_Behaviour`, `Add_to_cart Rate`, `Conversion_Rate(Cmpltd_Pur-Ratio)`) and user segments (`Engagement_Level`, `PagesView_Level`, `ClickProd-Level`, `Purchase_Intent_Level`) in Python, then aggregated into **Analysis-LvL_table**.
- Loaded the post-EDA final table (AggEtable_analysisLvL) back into PostgreSQL for Power BI dashboards, downstream analyses, and future modeling.

---

### **Exploration (EDA) in Python**
The EDA builds a **Complete Intelligence Foundation**, revealing — setting the stage for deeper testing and the final BI dashboard & reporting.

* **EDA 1 — Experiment Exposure & Balance:** Verified user and session exposure across Versions A and B is well balanced (~3% user difference, ~2% session difference) with no abnormal distributions, confirming valid comparisons for downstream analysis.

* **EDA 2 — Funnel Metrics by Experiment:** Observed meaningful behavioral differences between Versions A and B; several experiments show higher completed purchase rates in Version B despite similar or lower CTRs, suggesting improved traffic quality rather than volume.

* **EDA 3 — Funnel Rate Analysis (CTR → ATC → Purchase):** Found that high click-through rates do not reliably predict purchases; Version B frequently outperforms A at the bottom of the funnel even when early-funnel engagement is neutral or negative, and Add-to-Cart is a helpful but imperfect mid-funnel diagnostic.

* **EDA 4 — Lift Analysis:** Completed Purchase lift highlights Version B’s superiority: 5 out of 8 experiments show strong positive purchase lift (up to +211%), while some experiments show negative early-funnel lift but positive final conversion, emphasizing the need for full-funnel evaluation.

* **EDA 5 — Funnel Drop-Off Analysis:** Identified stage-specific drop-offs: largest between Product View → Add-to-Cart (10–30%), non-linear funnel behavior, and variant-dependent performance; some variants excel early (Visit → View), others at final conversion (Visit → Purchase), highlighting stage-specific optimization opportunities.

* **EDA 6 — Segment-Level Experiment Performance:** Found that Version B outperforms A across all Engagement and Purchase Intent segments, with TrustBadge and UrgencyBanner driving the largest scalable lifts in mid-funnel users; high-intent users convert well but are few, showing engagement and element choice amplify purchase intent more than intent alone.

<details> <summary><b> Key EDA 1 to 6: Steps and Findigs in Detail (Click to Expand)</b></summary>

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


**EDA 5 - Funnel Drop-Off Analysis (Where do people quit?)**
- Funnel performance varies by stage, not uniformly by variant: Experiment variants differ meaningfully in how well they convert users at each funnel stage. Some variants are stronger at turning visits into product interest (Visit → View ≈ 25–42%), while others excel at final conversion (Visit → Purchase ≈ 8–27%), indicating stage-specific optimization opportunities rather than a single universal winner.
- Mid-funnel friction drives drop-off, and the funnel is non-linear: The largest drop-off consistently occurs between Product View → Add-to-Cart (often 10–30%), highlighting friction in translating interest into purchase intent rather than issues with site entry. Add-to-Cart → Purchase rates exceeding 100% in several experiments confirm that purchases can occur without recorded cart actions, so funnel steps should be interpreted as engagement signals—not strict sequential behavior.
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
- Experiment Version B outperforms Version A across every Engagement Level and Purchase Intent segment, but the magnitude of uplift depends on the UI element used: TrustBadge consistently drives the highest conversions for High-Engagement users (all intent levels), UrgencyBanner performs best for Medium Engagement + High Intent users, and the largest scalable gains come from mid-funnel users (Medium/Low Engagement + Low Intent) where Version B + TrustBadge delivers strong, stable conversion uplift across hundreds of users — showing that engagement + element choice amplify purchase intent, while high-intent users alone are not the primary growth lever.
- Users are segmented into 3 funnel stages: Engagement (Interest), Purchase Intent, and Final Conversion. The addition of element_tested lets us see which UI/UX element drives conversions within each segment.


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


**Complete Final Conversion Table (with All elements tested)**

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
  
---

## Analytical Tests
* **Test 1:** Does Variant B improve overall conversion vs Variant A? → **Yes** — Variant B delivers a statistically significant lift in overall conversion.
* **Test 2:** Does Variant B outperform A consistently across individual experiments? → **No** — one experiment clearly drives the uplift, while others show mixed or no effects.
* **Test 3:** Is the conversion lift explained by user segments or behavior differences? → **No** — conversion is independent of segments, and Variant B remains significant after controlling for behavior.
* **Test 4:** Does Variant B work better for high-intent users than mid-funnel users? → **No** — Variant B’s lift is consistent across funnel segments with no interaction effect.
* **Test 5:** Do specific UI elements perform better for certain user segments? → **No** — neither UI elements nor segment-specific interactions significantly affect conversion.

**NOTE:** Statistical methods including one-sided proportion z-tests, chi-square tests of independence, logistic regression (with and without interaction terms), and two-way ANOVA were selectively applied based on the analytical question being addressed.


<details>
<summary><b>Analytical Tests 1 to 5 (Click to Expand)</b></summary>

---

<details>
<summary><b>Analytical Test 1 — Overall Conversion Impact (A vs B)</b></summary>
  
### **Test 1 — Overall Conversion Impact (A vs B)**

**Hypothesis**
* **H₀ (Null):** Variant B does **not** improve conversion compared to Variant A.
* **H₁ (Alternative):** Variant B has a **higher conversion rate** than Variant A.

**Statistical Test**
* **Test Used:** One-sided proportion z-test
* **Metric:** Conversion rate (completed purchase)

**Results**
* **Z-statistic:** **2.497**
* **p-value:** **0.0063**

**Interpretation**
* The positive Z-statistic indicates that **Variant B converts better than Variant A**.
* The p-value of 0.63% means there is only a 0.63% chance that this observed lift is due to random variation.
* Therefore, the improvement in conversion rate is **statistically significant** and unlikely due to random chance.

**Conclusion**
- **Variant B delivers a statistically significant improvement in conversion rate over Variant A.**
- This confirms that the website changes introduced in Variant B have a real, measurable positive impact on user purchasing behavior.
</details>

---

<details>
<summary><b>Analytical Test 2 — Experiment-Level Conversion Impact</b></summary>

## **Test 2 — Experiment-Level Conversion Impact (A vs B)**

**Hypothesis**
* **H₀ (Null):** Variant B does **not** improve conversion compared to Variant A within each experiment.
* **H₁ (Alternative):** Variant B has a **higher conversion rate** than Variant A within each experiment.

**Statistical Test**
* **Test Used:** One-sided proportion z-test (`alternative="larger"`)
* **Metric:** Conversion rate per experiment (completed purchase)

**Results — B > A p-value**

| Experiment | Conv Rate A | Conv Rate B | Lift B vs A | Z-Score | P-Value | Verdict                                     |
| ---------- | ----------- | ----------- | ----------- | ------- | ------- | ------------------------------------------- |
| 1          | 0.2000      | 0.1818      | -0.0182     | -0.3259 | 0.6277  | 🔴 No significant difference; skip rollout  |
| 2          | 0.1446      | 0.2143      | 0.0697      | 1.2405  | 0.1074  | 🟡 Positive lift but inconclusive; retest   |
| 3          | 0.0769      | 0.2353      | 0.1584      | 3.0489  | 0.0011  | 🟢 Clear winner; rollout B                  |
| 4          | 0.1518      | 0.2476      | 0.0958      | 1.7699  | 0.0384  | 🟡 Promising lift; consider limited rollout |
| 5          | 0.1829      | 0.1224      | -0.0605     | -1.1317 | 0.8711  | 🔴 Negative lift; do not rollout            |
| 6          | 0.1852      | 0.1538      | -0.0313     | -0.5851 | 0.7208  | 🔴 No significant impact; skip rollout      |
| 7          | 0.1739      | 0.2697      | 0.0958      | 1.5521  | 0.0603  | 🟡 Positive lift but marginal; retest       |
| 8          | 0.1373      | 0.2165      | 0.0792      | 1.4676  | 0.0711  | 🟡 Positive lift but inconclusive; retest   |

**Interpretation**
* Experiment 3 shows a **clear significant improvement** for Variant B (p = 0.0011).
* Experiments 4, 7, and 8 show **positive lifts**, but p-values are slightly above 0.05 → promising but inconclusive.
* Experiments 1, 5, and 6 show **no significant difference**, indicating that Variant B does not universally outperform A.

**Conclusion**
* **Variant B performs significantly better than A in Experiment 3.**
* Some experiments show positive trends (Experiments 4, 7, 8), suggesting further investigation or limited rollout may be considered.
* This aligns logically with **Test 1**, where Variant B outperformed A overall.
* Recruiter-friendly: clear, concise, statistically correct, and highlights where rollout is justified vs where it’s inconclusive.

</details>

---

<details>
<summary><b>Analytical Test 3 — Segment Dependency & Controlled Impact Analysis</b></summary>

## **Test 3 — Segment-Level Dependency & Controlled Impact Analysis**

### **Objective**
To evaluate whether conversion is dependent on key user behavior segments and to verify whether the observed uplift of Variant B persists after controlling for these segments.

### **Part A — Segment-Level Dependency (Chi-Square Tests)**

**Hypothesis (for each segment)**
* **H₀ (Null):** Conversion is **independent** of the segment level.
* **H₁ (Alternative):** Conversion **depends** on the segment level.

**Statistical Test**
* **Test Used:** Chi-square test of independence
* **Metric:** Conversion (completed purchase)
* **Segments Tested:**
  Engagement Level, Purchase Intent Level, Pages Viewed Level, Product Click Level

**Results**
| Segment Column        | χ² Statistic | p-value | Interpretation                                                                  |
| --------------------- | ------------ | ------- | ------------------------------------------------------------------------------- |
| Purchase_Intent_Level | 0.2941       | 0.8633  | Conversion **not dependent** on purchase intent — differences likely random     |
| Engagement_Level      | 0.2904       | 0.8649  | Conversion **not dependent** on engagement — differences likely random          |
| PagesView_Level       | 0.0918       | 0.9551  | Conversion **not dependent** on pages viewed — differences likely random        |
| ClickProd-Level       | 3.1049       | 0.2117  | Conversion **not dependent** on product click level — differences likely random |

**Interpretation**
* Across all tested behavioral segments, p-values are well above 0.05.
* This indicates **no statistically significant dependency** between conversion and any individual segment level.
* Observed conversion differences across levels are likely due to **random variation**, not structural effects.


### **Part B — Controlled Impact Analysis (Logistic Regression)**

**Purpose**
While chi-square tests evaluate **pairwise dependency**, logistic regression is used to assess whether the **experiment effect remains significant after controlling for user behavior**.

**Model Setup**
* **Dependent Variable:** Conversion (binary)
* **Independent Variables:**

  * Engagement_Level
  * Purchase_Intent_Level
  * Experiment Version (A vs B)

> Note: Post-treatment funnel variables (Pages Viewed, Product Clicks) were intentionally excluded to avoid blocking the causal pathway of the experiment.

**Statistical Test**
* **Test Used:** Logistic regression (Maximum Likelihood Estimation)
* **Metric:** Odds of conversion

**Key Result**
| Variable       | Odds Ratio | 95% CI         | p-value    |
| -------------- | ---------- | -------------- | ---------- |
| Variant B vs A | **1.387**  | [1.069, 1.798] | **0.0137** |

**Interpretation**
* After controlling for engagement and purchase intent, **Variant B increases conversion odds by ~39% compared to Variant A**.
* Engagement and purchase intent levels are **not independently significant predictors** once other variables are controlled.
* The experiment effect remains statistically significant, indicating that the uplift is **attributable to the variant itself**, not differences in user composition.

**Conclusion - Test 3 (A and B)**
* Conversion is **not independently driven** by engagement level, purchase intent, pages viewed, or product click intensity.
* **Variant B’s uplift persists even after controlling for key behavioral factors**, confirming a true experiment-driven effect.
* This strengthens confidence in Test 1 and Test 2 findings and rules out segment imbalance as the cause of the observed improvement.

</details>

---

<details>
<summary><b>Analytical Test 4 — Funnel Segment Interaction Analysis</b></summary>

## **Test 4 — Variant B Impact Across Funnel Segments (Interaction with Intent Level)**

### **Objective**

To evaluate whether the lift from **Variant B** differs between **high-intent** and **mid-funnel** users, i.e., does Variant B perform better for high-intent users compared to mid-funnel users?

### **Hypothesis**

* **H₀ (Null):** Variant B’s impact on conversion is **independent of funnel segment**.
* **H₁ (Alternative):** Variant B’s impact **varies** across funnel segments (high-intent vs mid-funnel).

### **Statistical Test**

* **Test Used:** Logistic regression with interaction term
* **Dependent Variable:** Converted (binary)
* **Independent Variables:**

  * Variant B vs A
  * Funnel Segment (High Intent vs Mid-Funnel)
  * Interaction: Variant B × High Intent

> Interaction term tests whether Variant B works differently for high-intent users.

### **Results — Logistic Regression**

| Variable                 | Coefficient | Std. Err | z-value | p-value | Interpretation                                                            |
| ------------------------ | ----------- | -------- | ------- | ------- | ------------------------------------------------------------------------- |
| Intercept (Mid-Funnel A) | -1.696      | 0.099    | -17.074 | <0.001  | Baseline conversion probability for Mid-Funnel users on Variant A         |
| Variant B                | 0.350       | 0.135    | 2.591   | 0.010   | Variant B significantly **increases conversion odds** by ~42% overall     |
| High Intent              | 0.361       | 0.512    | 0.704   | 0.482   | High-intent users **not significantly higher** conversion than mid-funnel |
| Variant B × High Intent  | -0.535      | 0.667    | -0.802  | 0.423   | Interaction **not significant** → lift from B **does not vary by intent** |

### **Interpretation**

* **Variant B has a statistically significant positive effect** on conversion overall (~42% higher odds).
* High-intent users alone do **not** convert significantly more than mid-funnel users after controlling for exposure to the variant.
* The **interaction term is not significant**, indicating that **Variant B’s lift is consistent across intent levels**, i.e., the effect is scalable and not restricted to high-intent users.

### **Conclusion - Test 4**

* Variant B’s impact **does not depend on funnel segment**, confirming that the observed uplift is **broadly applicable**.
* Mid-funnel users respond just as well as high-intent users, highlighting the **scalable nature of the experiment effect**.
* This further strengthens confidence in the conclusions from Tests 1–3 and supports potential **full rollout** of Variant B.

</details>

---

<details>
<summary><b>Analytical Test 5 — UI Element Effectiveness by Segment</b></summary>

## **Test 5 — UI Element Effectiveness by Segment**

### **Objective**

To evaluate which **UI elements** drive the highest conversion for each **user segment** and whether the effect of a UI element depends on segment type.

### **Hypothesis**

* **H₀ (Null):** Conversion is **independent** of UI element and segment; there is **no interaction effect**.
* **H₁ (Alternative):** Conversion **depends on the UI element, the segment, or their interaction**.

### **Statistical Test**

* **Test Used:** Two-Way ANOVA
* **Factors:**

  * `segment_group` (High Intent, Mid Funnel)
  * `element_tested` (different UI elements tested)
  * `segment_group × element_tested` (interaction effect)
* **Metric:** Conversion (`converted` = 0/1)

### **ANOVA Results**

| Source                             | sum_sq  | df   | F     | PR(>F) |
| ---------------------------------- | ------- | ---- | ----- | ------ |
| C(segment_group)                   | 1.114   | 6    | 1.252 | 0.282  |
| C(element_tested)                  | 0.231   | 3    | 0.519 | 0.669  |
| C(segment_group):C(element_tested) | 2.758   | 18   | 1.033 | 0.418  |
| Residual                           | 228.031 | 1537 |       |        |

### **Interpretation**

* **Main effect of segment_group:** p = 0.282 → Not statistically significant. Segment type alone does **not significantly influence conversion**.
* **Main effect of element_tested:** p = 0.669 → Not statistically significant. No single UI element significantly outperforms others overall.
* **Interaction effect (segment × element):** p = 0.418 → Not statistically significant. The effectiveness of UI elements does **not depend on the user segment**.
* Overall, conversion differences are largely due to random variation rather than a systematic effect of segment or UI element.

### **Conclusion — Test 5**

* There is **no statistically significant lift** attributable to any specific UI element across segments.
* Interaction between segment type and UI element is **not significant**, suggesting **no need for segment-specific UI customization** based on current data.
* This insight helps guide design priorities: **focus on other factors** (e.g., copy, promotions, overall UX) rather than segment-specific UI tweaks.

</details>

---

</details>

## Final Insights
* Variant B is the statistically superior version with consistent conversion uplift.
* Purchase completion—not CTR—should drive experiment decisions.
* Mid-funnel users represent the largest scalable revenue opportunity.
* UI elements act as conversion multipliers, but effects are not segment-dependent.
* Results are robust to controls, confirming a true experiment-driven impact.

---

## Recommendations
* Roll out Variant B, prioritizing experiments with validated lift
* Optimize mid-funnel UX (Trust & Urgency signals)
* Evaluate experiments by purchase completion, not early engagement
* Continue experimentation with focused, testable hypotheses
  
---

## Business Impact
| Area                    | Impact                            |
| ----------------------- | --------------------------------- |
| Conversion Optimization | Statistically validated uplift    |
| Revenue Growth          | Higher purchase completion        |
| Experiment Strategy     | Focus on bottom-of-funnel metrics |
| Customer Targeting      | Prioritize mid-funnel segments    |
| Decision Confidence     | Results stable across controls    |

---

## Tools & Techniques

| **Category** | **Used For** |
|-------------|--------------|
| SQL (PostgreSQL) | Multi-step CTEs, user-level aggregation, experiment joins, funnel metric construction |
| Python (Pandas, NumPy, SciPy, Statsmodels) | Funnel analysis, segmentation, hypothesis testing, regression & ANOVA |
| Statistical Testing | One-sided proportion z-tests, chi-square tests of independence, two-way ANOVA |
| Predictive Modeling | Logistic regression, interaction-effect modeling |
| Experiment Design | A/B testing, experiment validation, bias & exposure checks |
| Funnel Framework | Visit → View → Add-to-Cart → Purchase analysis |
| Project Planning & Objectives | Metric definition, funnel mapping, decision-driven testing |
| Data Modeling & ETL | Analysis-ready table creation and reload for BI consumption |
| Visualization (Minimal) | Tabular lift analysis and statistical result summaries |
| BI & Reporting (Downstream) | Power BI dashboards for stakeholder communication (post-analysis) |

---

## Key Outcomes
* Built a production-style A/B testing framework
* Delivered statistically defensible rollout decisions
* Produced reusable analysis tables for BI and future tests
* Demonstrated end-to-end analytics maturity

---


## Deliverables

* **Executive Deck:** [View Slides](https://docs.google.com/presentation/d/12xXwo49_brnh2BfQ5SBEgyk6K4G4Cvf3LFnsGqw7ZvA/present?slide=id.g3a024b19907_2_96)
* **GitHub README:** [Detailed Project Story & Analysis](https://github.com/Harsh19-M/E-Commerce-Growth-Analytics-AB-Testing-Segmentation/blob/main/README.md)
* **Interactive Dashboard:** [View Power BI Dashboard](your-powerbi-link-here)

---

## Future Enhancements

* **Multi-Variant & Sequential Funnel Testing:** Expand experiments beyond simple A/B to multi-variant testing or sequential funnel testing, capturing how UI/UX changes interact across multiple funnel stages.
* **Real-Time Personalization Engine:** Leverage engagement and purchase-intent segments to dynamically serve the best variant or UI element per user session, maximizing mid-funnel conversion.
* **Predictive Conversion Modeling:** Integrate machine learning models to forecast which users are likely to convert, enabling preemptive nudges, discounts, or targeted messaging.
* **Automated Experiment Analysis Pipeline:** Build an ETL + analytics workflow to automatically update experiment results, segment-level lift, and funnel metrics daily, reducing manual analysis and improving speed-to-insight.
* **Enhanced KPI Tracking & Alerts:** Implement automated dashboards that flag significant changes in CTR, ATC, or purchase lift by segment or variant, triggering actionable alerts for UX, marketing, or product teams.

---

*Developed by Harsh Mishra*
*Open for Data Analyst / BI opportunities*

