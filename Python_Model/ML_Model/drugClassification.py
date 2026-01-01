# locating dataset
import os

# munging dataset
import numpy as np
import pandas as pd

# preparing for ml
from sklearn.preprocessing import OrdinalEncoder
from sklearn.model_selection import train_test_split

# making the model
from sklearn.naive_bayes import GaussianNB
from sklearn.ensemble import RandomForestClassifier
from sklearn.pipeline import make_pipeline
from sklearn.preprocessing import StandardScaler
from sklearn.svm import SVC

# checking accuracy
from sklearn import metrics
from sklearn.metrics import confusion_matrix
from sklearn.metrics import roc_auc_score

# for ensembling the models
from sklearn.ensemble import VotingClassifier

# streamlit
import streamlit as st

# Loading Dataset
def load_data(d):
    data = pd.read_csv(d, low_memory=False, encoding='utf-8')
    lowercase = lambda x: str(x).lower()
    data.rename(lowercase, axis='columns', inplace=True)
    return data

current_dir = os.path.dirname(os.path.abspath(__file__))
st.text(file_path)
file_path = os.path.join(current_dir, '..', 'Datasets', 'drugsComTrain_raw.csv')
D = load_data(file_path)
file_path = os.path.join(current_dir, '..', 'Datasets', 'drugsComTest_raw.csv')
D = D._append(load_data("../Datasets/drugsComTest_raw.csv"))
 
# Cleaning Dataset
D.drop(['uniqueid', 'review', 'date', 'usefulcount'], axis=1, inplace=True)
D.drop(list(D.filter(regex='unnamed')), axis=1, inplace=True)
D = D.dropna()
D = D[~D.condition.str.contains(r"span", na=False)]
D = D[D.rating.str.contains(r"^\d+$", na=False)]
D["rating"] = D["rating"].astype("int64")

# Munging Dataset
D = D[D["rating"] >= 7]
AvgRating = D.groupby('drugname')['rating'].mean()
AvgRating = pd.DataFrame(AvgRating)
MungedData = pd.merge(AvgRating, D[['drugname', 'condition']], on='drugname')
MungedData = MungedData.drop_duplicates(subset="drugname")
MungedData = MungedData.sort_values(["condition", "rating"], ascending = [True, False])
Rating = MungedData['rating']
Class = []
for i in Rating:
    if i>9:
        Class.append("A")
    elif i>8:
        Class.append("B")
    else:
        Class.append("C")
MungedData['class'] = Class
file_path = os.path.join(current_dir, '..', 'Datasets', 'DrugsMungedData.csv')
MungedData.to_csv(file_path, index = False)

# Preparing Data for Recommendation Model
Data = load_data(file_path)
Data["drugname"] = Data["drugname"].astype('category')
Data["condition"] = Data["condition"].astype('category')
Data["class"] = Data["class"].astype('category')
ord_enc = OrdinalEncoder()
Data["condition"] = ord_enc.fit_transform(Data[["condition"]])
Data["drugname"] = ord_enc.fit_transform(Data[["drugname"]]) 

# Splitting the dataset into Train and Test
X = Data.drop(['class'], axis=1)
Y = Data['class']
X_train, X_test, Y_train, Y_test = train_test_split(X, Y, test_size=0.5, random_state=42)

# Naive Bayes Model
GNB = GaussianNB()
GNB.fit(X_train, Y_train)
Y_predNB = GNB.predict(X_test)

# Random Forest Model
randomForest = RandomForestClassifier(max_depth=2, random_state=0)
randomForest.fit(X_train, Y_train)
Y_predRF = randomForest.predict(X_test)

SVC = make_pipeline(StandardScaler(), SVC(gamma='auto', probability=True))
SVC.fit(X_train, Y_train)
Y_predSVC = SVC.predict(X_test)

# Ensembled Model
estimator = []
estimator.append(('GNB', GNB))
estimator.append(('RF', randomForest))
estimator.append(('SVC', SVC))
EnsembledVH = VotingClassifier(estimators = estimator, voting ='hard')
EnsembledVH.fit(X_train, Y_train)
Y_predEM = EnsembledVH.predict(X_test)
Y_changedDF = pd.DataFrame()
Y_changedDF['Y_predEM'] = Y_predEM
Y_OHENCdata = pd.get_dummies(Y_changedDF, columns = ['Y_predEM'])

# Complete Dataset sent in the model
Y = EnsembledVH.predict(X)

# Streamlit Application
st.title('Secure Pharmacist')

menu = ["Model", "Accuracy"]
choice = st.sidebar.selectbox('Sidebar',menu)
if choice == 'Model':
  st.subheader("Working Model")	
  condition = st.selectbox(
     'Enter your condition',
     (MungedData['condition'].str.upper().unique()))
  conditionsUpper = MungedData['condition'].str.upper()
  match = conditionsUpper == condition
  st.write("The Drugs for " + condition + " are: ")
  st.write("Most Recommended:")
  st.write(MungedData[match & (Y == 'A')]['drugname'])
  st.write("Second Most Recommended:")
  st.write(MungedData[match & (Y == 'B')]['drugname'])
  st.write("Third Most Recommended:")
  st.write(MungedData[match & (Y == 'C')]['drugname'])

else:
  st.subheader("Model Accuracy")
  st.write("Naive Bayes Model")
  accnb = round(metrics.accuracy_score(Y_test, Y_predNB)*100, 2)
  st.metric(label="Accuracy", value=str(accnb)+"%")
  st.write("Confusion Matrix:\n", confusion_matrix(Y_test, Y_predNB))
  st.write('ROC Accuracy Score for Random Forest Model: ', 
    roc_auc_score(Y_test, GNB.predict_proba(X_test), multi_class='ovr'))
  
  
  st.write("Random Forest Model")
  accrf = round(metrics.accuracy_score(Y_test, Y_predRF)*100, 2)
  st.metric(label="Accuracy", value=str(accrf)+"%")
  st.write("Confusion Matrix:\n", confusion_matrix(Y_test, Y_predRF))
  st.write('ROC Accuracy Score for Random Forest Model: ', 
    roc_auc_score(Y_test, randomForest.predict_proba(X_test), multi_class='ovr'))
  
  st.write("SVC Model")
  accsvc = round(metrics.accuracy_score(Y_test, Y_predSVC)*100, 2)
  st.metric(label="Accuracy", value=str(accsvc)+"%")
  st.write("Confusion Matrix:\n", confusion_matrix(Y_test, Y_predSVC))
  st.write('ROC Accuracy Score for SVC Model: ', 
    roc_auc_score(Y_test, SVC.predict_proba(X_test), multi_class='ovr'))
  
  st.write("Ensembled Model")
  accen = round(metrics.accuracy_score(Y_test, Y_predEM)*100, 2)
  st.metric(label="Accuracy", value=str(accen)+"%")
  st.write("Confusion Matrix:\n", confusion_matrix(Y_test, Y_predEM))
  st.write('ROC Accuracy Score for Ensembled Model: ', 
    roc_auc_score(Y_test, Y_OHENCdata, multi_class='ovr'))
  
  chart_data = pd.DataFrame(
    np.array([accnb, accrf, accsvc, accen])
  )

  st.bar_chart(chart_data)
  st.caption('From the above graph, we can understand that the accuracy of all the models are high and the ensembled model has the highest of them all.')
