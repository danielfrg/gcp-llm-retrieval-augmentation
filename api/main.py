from fastapi import FastAPI
from google.cloud import aiplatform
from langchain.embeddings import TensorflowHubEmbeddings

app = FastAPI()

model_url = "https://tfhub.dev/google/universal-sentence-encoder-multilingual/3"
embeddings = TensorflowHubEmbeddings(model_url=model_url)

my_index_endpoint = aiplatform.MatchingEngineIndexEndpoint(
    index_endpoint_name='8727756175518466048'
)

@app.post("/")
async def root(query: str, n: int = 10):
    vector = embeddings.embed_documents([query])

    neighbors = my_index_endpoint.find_neighbors(
        deployed_index_id="mydeployedindex123",
        queries=vector,
        num_neighbors=n
    )

    return [[neighbor.id, neighbor.distance] for neighbor in neighbors[0]]
