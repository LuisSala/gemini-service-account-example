# from vertexai.generative_models import GenerationResponse
# from vertexai.preview import generative_models
from vertexai.preview.generative_models import GenerativeModel, Part, Image, Tool
import vertexai
import json
from google.oauth2 import service_account
import os

key_path = "../gemini-sa-key.json"
os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = key_path

with open("../project-config.json", "r") as f:
    config = json.load(f)

project_id = config["project_id"]
location = config["region"]


# ########
# This example loads credentials from the environment variable: "GOOGLE_APPLICATION_CREDENTIALS"
# ########
vertexai.init(
    project=project_id,
    location=location,
)
model = GenerativeModel(
    model_name="gemini-1.5-flash-001",
)

print("\nModel Responses:\n\n")

response = model.generate_content("What is the capital of France?")
print(response.candidates[0].content.parts[0].text)

# ########
# This example uses a custom credentials object
# ########
credentials = service_account.Credentials.from_service_account_file(
    key_path,
    scopes=["https://www.googleapis.com/auth/cloud-platform"],
    # Replace with your desired scopes
)

vertexai.init(
    project=project_id,
    location=location,
    credentials=credentials,
)

response = model.generate_content("What is the capital of Iceland?")
print(response.candidates[0].content.parts[0].text)
