# Secure-Pharmacist (Version 1.0)

## Project Summary

Secure Pharmacist is a multi-tier healthcare application designed to modernize drug recommendation and pharmaceutical supply chain management. The system integrates Machine Learning for clinical decision support and Blockchain technology for the secure, immutable tracking of medication purchases and prescriptions.

## Technical Stack

* Database Management: MySQL (XAMPP Environment)

* Machine Learning & UI: Python (Scikit-learn, Streamlit)

* Web Application: Java (JSP, Servlets, Eclipse IDE)

Security Protocols: SHA-256 Hashing, Salt-based credential encryption, Blockchain-linked ledgers.

## System Architecture

### Database Schema (MySQL)

The system utilizes a relational database consisting of 10 interconnected tables:

* User / Usertype: Manages general information and authorization levels (Doctor, Patient, Pharmacy).

* Doctor / Patient: Stores specialized profiles for medical professionals and service recipients.

* Drug / Condition: Maintains a catalog of medications and associated medical conditions.

* Feedback: Stores physician reviews used to retrain the recommendation model.

* Purchase: The core ledger where drug transactions are stored as blockchain blocks.

* Patientcondition: Links patients to their specific prescribed medical histories.

### Recommendation Engine 

The recommendation system follows a structured data science pipeline:

* Preprocessing: Data cleaning and munging of drug datasets, filtering for ratings >= 7.

* Classification: Drugs are categorized into Classes A, B, and C based on performance metrics.

* Ensemble Modeling: A Hard Voting Ensemble algorithm combines Support Vector Classification (SVC), Random Forest, and Naive Bayes.

* Performance: The Ensembled model achieves a peak accuracy of 97.21%.

### Blockchain Implementation (Java)

To prevent the tampering of medical records and illegal drug procurement:

* Transaction Logic: Each purchase captures Patient ID, Drug ID, Quantity, and Timestamp.

* Chaining Mechanism: The system recreates the previous block's hash and incorporates it into the current block.

* Integrity: SHA-256 hashing is applied to the string "SecurePharmacist::<password>::<userTypeID><userID>" to ensure secure data entry and storage.

## Operational Workflow

### Doctor Interface

* Prescription Management: Doctors can only prescribe medications categorized as Class A or B for specific conditions, as determined by the ML model.

* Patient History: A "View Page" allows doctors to access chronological medical history to prevent adverse drug interactions.

### Patient Interface

* Smart Ordering: An automated cart system checks the digital prescription against previous purchases to ensure patients do not exceed the prescribed quantity.

* Tracking: Provides a transparent view of purchase history validated by the blockchain backend.

## Security and Compliance Features

* Credential Protection: Implementation of salt/sugar hashing techniques for all user passwords.

* Access Control: Strict session management to prevent unauthorized URL manipulation or vertical privilege escalation.

* Data Validation: Multi-step verification of transaction blocks before they are committed to the MySQL database.

## Development Roadmap (Version 2.0)

* Pharmacy Module: Implementation of stock management (stock-in/stock-out) with expiry date tracking.

* Geospatial Integration: Filtering medical shops based on city and inventory availability.

* Order Lifecycle: Implementation of status transitions (Pending, Shipped, Cancelled) with automatic inventory adjustment.

* Encryption: Research into end-to-end encryption for sensitive medical scan documents.
