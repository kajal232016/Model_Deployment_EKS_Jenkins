from fastapi import FastAPI
from pydantic import BaseModel
import pickle
import os

app = FastAPI()

class PredictionRequest(BaseModel):
    input_data: list

MODEL_PATH = os.path.join("models", "model-lr.model")

def load_model():
    with open(MODEL_PATH, 'rb') as model_file:
        model = pickle.load(model_file)
    return model

model = load_model()

@app.post("/predict")
async def get_prediction(request: PredictionRequest):
    input_data = [request.input_data]

    prediction = model.predict(input_data)

    return {"prediction": prediction.tolist()}
