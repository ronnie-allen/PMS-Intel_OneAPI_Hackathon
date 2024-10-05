import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
import joblib  # For saving and loading the model

# Function to load and train model on your dataset
def train_on_dataset(dataset_path):
    # Load your dataset
    data = pd.read_csv(dataset_path)

    # Using 'Glucose' as the main feature along with other relevant columns
    features = data[['Glucose', 'BMI', 'Age']]  # Input features
    target = data['Outcome']  # Target variable (0 = Non-Diabetic, 1 = Diabetic)

    # Split the dataset into training and testing sets
    X_train, X_test, y_train, y_test = train_test_split(features, target, test_size=0.2, random_state=42)

    # Initialize a model (RandomForest as an example)
    model = RandomForestClassifier()

    # Train the model
    model.fit(X_train, y_train)

    # Optionally evaluate the model on the test set
    accuracy = model.score(X_test, y_test)
    print(f"Model accuracy: {accuracy * 100:.2f}%")

    # Save the trained model to a file
    joblib.dump(model, 'trained_model.pkl')
    print("Model saved to 'trained_model.pkl'.")

if __name__ == "__main__":
    dataset_path = 'diabetes.csv'
    train_on_dataset(dataset_path)
