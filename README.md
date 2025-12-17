# E-Commerce Growth Analytics: A/B Testing & Customer Persona Segmentation

End-to-end Project Analyzing **Customer conversion** and **engagement across website experiments**, tracking **user behavior** to measure how different **A/B test variations** impact clicks, add-to-cart actions, and completed purchases. Using SQL, Python, and Power BI, aggregated and cleaned user sessions, orders, and experiment data into a single analysis-ready table, enabling detailed A/B test analysis and actionable insights for improving engagement, purchases, and revenue growth.

**Note:** This project uses a mock dataset designed to simulate realistic performance. Company names and figures are for demonstration purposes only. 


## Key Highlights
- **PostgreSQL Data Aggregation & Cleaning:** Consolidated ``80,000 session records``, ``8,000 user profiles``, ``30,044 orders``, and ``8 experiment definitions`` into a single ``1,563-row analysis-ready`` table. Built this using multi-step, ``industry-standard CTEs`` after running ~10 exploratory SQL queries to validate experiment exposure and event logic. Handled null values `(COALESCE)`, boolean event tracking, `window functions`, distinct counts, and filtered counts `(COUNT(*) FILTER)` to accurately capture clicks, add-to-cart actions, purchases, and orders. Ensured correct session-level aggregation to produce a clean, trustworthy dataset for A/B test analysis and downstream Python modeling.

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
### **Project-Planning (Framework Used):** SMART & CRISP-DM  

### **Initial Approach –**


### **Aggregated Table Creation –**


### **Data Cleaning & Loading – PostgreSQL → Python → PostgreSQL**
- Connected to the
- 
### **Exploration (EDA) in Python**

**EDA 1 — Experiment Exposure & Balance (Validity Check)**
- User and session exposure across Version A and B is well balanced (≈3% user difference, ≈2% session difference), indicating no allocation bias.
- All experiments have sufficient exposure with no missing or abnormal session distributions, supporting valid downstream comparison.

**EDA 2 — Funnel Metrics by Experiment (Behavioral Differences)**
- User behavior differs meaningfully between Version A and B across experiments, indicating that UI changes influence engagement and conversion rather than producing uniform effects.
- Several experiments show higher completed purchase rates in Version B despite equal or lower click-through rates, suggesting improved traffic quality rather than increased volume.

**EDA 3 — Funnel Rate Analysis (CTR → ATC → Purchase)**
- High click-through rates do not consistently translate into purchases, confirming that CTR alone is not a reliable success metric.
- Version B frequently outperforms Version A at the bottom of the funnel (completed purchases), even when early-funnel engagement is neutral or negative.
- Add-to-cart behavior serves as a useful mid-funnel diagnostic but does not always predict final conversion success.

**EDA 4 — Lift Analysis (PRIMARY DECISION TOOL)**
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

