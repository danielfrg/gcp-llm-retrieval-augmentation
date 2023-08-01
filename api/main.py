from fastapi import FastAPI
from fastapi.responses import HTMLResponse
from google.cloud import aiplatform
from langchain.embeddings import TensorflowHubEmbeddings
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI()

origins = ["*"]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


model_url = "https://tfhub.dev/google/universal-sentence-encoder-multilingual/3"
embeddings = TensorflowHubEmbeddings(model_url=model_url)

my_index_endpoint = aiplatform.MatchingEngineIndexEndpoint(
    index_endpoint_name='1221803709063757824'
)

@app.get("/")
async def root():
    content = 'Retreival Augmentation API.<br>See <a href="/docs">/docs</a>.'
    return HTMLResponse(content=content, status_code=200)

@app.post("/api")
async def api(query: str, n: int = 10):
    vector = embeddings.embed_documents([query])

    neighbors = my_index_endpoint.find_neighbors(
        deployed_index_id="retreivalaugindex",
        queries=vector,
        num_neighbors=n
    )

    return [[neighbor.id, neighbor.distance] for neighbor in neighbors[0]]
