# Project 2: E-Commerce Funnel and Customer Experience Analysis

## Project Overview

This project examines the transactional customer journey of a Brazilian e-commerce marketplace using the Olist dataset. The analysis evaluates order status, payment records, delivery performance, repeat purchasing behavior, and customer satisfaction.

Because the dataset does not contain website sessions, traffic sources, or cart activity, this project uses a **transactional funnel** rather than a traditional website conversion funnel.

## Business Questions

- How are orders distributed across fulfillment statuses?
- How consistently are payment records associated with orders?
- How effectively does the marketplace meet estimated delivery dates?
- Do delivery outcomes vary by month and customer state?
- How frequently do customers make repeat purchases?
- How do payment methods and installment patterns vary?
- How are delivery delays associated with customer review scores?
- How quickly are customer reviews answered?

## Analytical Approach

SQL was used to investigate:

1. **Order and payment activity:** Order status distribution and payment record coverage.
2. **Fulfillment performance:** Delivery timestamp quality, on-time delivery, monthly trends, and state-level comparisons.
3. **Customer behavior:** Repeat customer rates and time between purchases.
4. **Payment behavior:** Payment method distribution and credit card installment patterns.
5. **Customer experience:** Review score distribution, delivery-delay relationships, payment-method reviews, and review response times.

The 16 SQL scripts are available in the [`sql`](sql/) folder.

## Key Findings

### Order and Payment Activity
- The dataset contains 99,441 orders.
- 96,478 orders were recorded as delivered.
- Payment records were associated with nearly all orders, including some canceled and unavailable orders.

### Delivery Performance
- Average delivery time was 12.56 days among delivered orders with valid delivery timestamps.
- 91.89% of eligible delivered orders arrived on or before the estimated delivery date.
- Delivery performance varied across months and states.
- March 2018 recorded a notably lower on-time delivery rate of 78.64%.

### Customer Retention
- 93,358 unique customers had delivered orders.
- 2,801 customers, approximately 3.0%, placed more than one delivered order.
- The average interval between repeat purchases was 79.15 days.

### Payment Behavior
- Credit cards represented the largest share of payment records.
- Credit card installment activity varied substantially by installment count.
- Orders could contain multiple payment methods, so payment-method shares are not mutually exclusive.

### Customer Satisfaction
- 77.14% of recorded review scores were four or five stars.
- Reviews associated with late deliveries averaged 2.57 stars, compared with 4.29 stars for on-time deliveries.
- Negative review rates increased with longer delivery delays.
- The average recorded review response time was 3.15 days.

## Business Implications

The analysis identifies delivery reliability as an important area for customer experience monitoring. The relationship between longer delivery delays and lower review scores suggests that fulfillment performance deserves attention alongside payment and order operations.

Repeat purchasing was relatively uncommon in the delivered-order population, highlighting an opportunity to investigate customer retention and post-purchase engagement further.

Geographic and monthly delivery differences also suggest value in monitoring fulfillment performance across regions and time periods.

## Methodology and Data Limitations

- The analysis uses transactional records, not website traffic or cart-conversion data.
- Payment records do not independently establish successful settlement.
- Delivery metrics exclude orders without the required delivery and estimated-date timestamps.
- Repeat purchasing is measured using the customer unique identifier and delivered orders.
- Payment-method groups may overlap when an order uses multiple payment methods.
- Relationships between delivery delays and review scores are observational and do not establish causation.
- Review response timestamps measure recorded response timing, not response quality.
- The dataset reflects a historical marketplace period and should not be interpreted as current operating performance.

## Tools

- SQL
- SQLite
- DB Browser for SQLite
- GitHub

## Project Files

- [`SQL Analysis Scripts`](sql/)


