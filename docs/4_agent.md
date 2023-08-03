# 4. LangChain Agent

Now that we have the the embedding in our deployed Matching Engine Endpoint and
the documents indexed in our Firebase document DB we are able to build a
simple
[RetrievalQA LangChain](https://python.langchain.com/docs/use_cases/question_answering/how_to/vector_db_qa) agent.

This Agent will that a sample question, create an embedding, look for similar
embedings using Matching Engine endpoint, then look for those docs in Firestore
and finally use Vertex AI PaLM API to generate an answer based on the documents.

The [embeddings/agent.ipynb](/embeddings/agent.ipynb) notebooks shows the process
of creating a custom LangChain Retriever class for Firestore and
a LangChain chain for retrieval QA.

## Next step

We can take this [source code and create a Cloud Run](/docs/5_cloud_run.md) API to expose the functionality.

## Links

- [LangChain QA using a Retriever
  ](https://python.langchain.com/docs/use_cases/question_answering/how_to/vector_db_qa)
