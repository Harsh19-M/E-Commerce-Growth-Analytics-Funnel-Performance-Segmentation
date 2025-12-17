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
### **Initial Exploration (EDA) in Python**

- Conducted a full **Experiment-level EDA**
- 
The EDA builds a **Complete Vendor Intelligence Foundation**, revealing — setting the stage for deeper testing and the final BI dashboard & reporting.

<details> <summary><b> Key EDAs Performed in Python (Click to Expand)</b></summary>

<details> <summary><b> Key EDA: Code & Output Summary  (Click to Expand)</b></summary>
 
#### **Code Used in ```Python```**
```
# Experiment-level statistical

```
#### **Output Summary**

While Version B shows a slightly higher average CTR overall, lift analysis reveals that only 3 out of 8 experiments experienced meaningful improvements. Several experiments showed neutral or negative impact, indicating that Version B’s effectiveness is context-dependent rather than universally superior.

 Top positive lift experiments
| Experiment | Lift        | Interpretation                           | 
| ---------- | ----------- | ---------------------------------------- |
| **2**      | **+26.65%** | Very strong improvement — B clearly wins |
| **5**      | **+23.52%** | Large uplift, B is much better           |
| **1**      | **+11.92%** | Solid improvement                        |  

3 out of 8 experiments show meaningful CTR improvement.         

 Neutral / negative experiments
| Experiment | Lift    | Interpretation           |
| ---------- | ------- | ------------------------ |
| 6          | −0.40%  | No meaningful difference |
| 4          | −8.47%  | B performs worse         |
| 7          | −8.99%  | B performs worse         |
| 3          | −9.00%  | B performs worse         |
| 8          | −10.15% | Worst performer          |

Half the experiments hurt CTR when switching to B.

</details> 

