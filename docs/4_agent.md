# 4. LangChain Agent

With the embedding in our deployed index in Matching Engine and the documents
indexed in our Firebase document DB we are able to build a simple RetreivalQA
LangChain agent.

This Agent will that a sample question, create an embedding, look for similar
embedings using Matching Engine endpoint, then look for those docs in Firestore
and finally use Vertex AI PaLM to generate an answer based on the documents.

A sample notebook of all of this can be found on [embeddings/agent.ipynb].
