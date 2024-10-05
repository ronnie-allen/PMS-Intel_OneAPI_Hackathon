import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
import joblib  # For saving and loading the model

# Function to load and train model on your dataset
def train_on_dataset(dataset_path):
    # Load your dataset
    data = pd.read_csv(dataset_path)

    # Using 'Glucose', 'BMI', and 'Age' as features and 'Outcome' as the target
    features = data[['Glucose', 'BMI', 'Age']]  # Input features
    target = data['Outcome']  # Target variable (0 = Non-Diabetic, 1 = Diabetic)

    # Split the dataset into training and testing sets
    X_train, X_test, y_train, y_test = train_test_split(features, target, test_size=0.2, random_state=42)

    # Initialize a model (RandomForest as an example)
    model = RandomForestClassifier()

    # Train the model
    model.fit(X_train, y_train)

    # Evaluate the model on the test set
    accuracy = model.score(X_test, y_test)
    print(f"Model accuracy: {accuracy * 100:.2f}%")

    # Save the trained model to a file
    joblib.dump(model, 'trained_model.pkl')
    print("Model saved to 'trained_model.pkl'.")

# Function to load the model and make predictions
def load_and_predict(model_path, glucose, bmi, age):
    # Load the trained model
    model = joblib.load(model_path)
    
    # Predict the condition based on input values
    prediction = model.predict([[glucose, bmi, age]])
    
    # Return the prediction result (0 = Non-Diabetic, 1 = Diabetic)
    return prediction[0]

if __name__ == "__main__":
    # Train the model using the dataset
    dataset_path = 'diabetes.csv'  # Path to your dataset
    train_on_dataset(dataset_path)

    # Load the model and make a prediction for new input
    model_path = 'trained_model.pkl'
    glucose = 120  # Example glucose level
    bmi = 30.0     # Example BMI
    age = 45       # Example age

    # Get prediction result
    result = load_and_predict(model_path, glucose, bmi, age)
    
    # Output prediction
    if result == 0:
        print("The patient is predicted to be Non-Diabetic.")
    else:
        print("The patient is predicted to be Diabetic.")
