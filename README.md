# LLM retrieval augmentation in Google Cloud

This demo features
[GCP Matching Engine](https://cloud.google.com/vertex-ai/docs/matching-engine/overview) and
[VertexAI PaLM](https://cloud.google.com/vertex-ai/docs/generative-ai/start/quickstarts/api-quickstart)
to combine the functionality of retrieval augmentation and conversational engines
to create a question answering system where the user can ask a question and the
LLM will use it's given context to answer the question.

The Dataset used is the
[Stanford Question Answering Dataset (SQuAD)](https://huggingface.co/datasets/squad)
, a reading comprehension dataset, consisting of questions posed by
crowdworkers on a set of Wikipedia articles.

The demo can be accessed [here](https://llmops-demos-frg.web.app).

## Services used

![Architecture](/web/public/arch.jpg)

- [VertexAI Matching Engine](https://cloud.google.com/vertex-ai/docs/matching-engine/overview): ANN Similarity Seach
- [VertexAI PaLM](https://cloud.google.com/vertex-ai/docs/generative-ai/start/quickstarts/api-quickstart): Conversational Engine
- [Cloud Run](https://cloud.google.com/run): Hosting of the API
- [Firestore](https://cloud.google.com/firestore): Document Database
- [Firebase](https://firebase.google.com): Frontend hosting
- [Cloud Build](https://cloud.google.com/build): CI/CD

Frameworks:

- [LangChain](https://python.langchain.com/): Framework for creating conversational agent and retrieval augmentation
- [Tensorflow Hub](https://www.tensorflow.org/hub):
  Embeddings

## Prerequisites

- [Terraform](https://cloud.google.com/docs/terraform)
- A GCP project created

## Docs

1. [Matching Engine Index Setup](/docs/1_matching_engine.md)
1. [Create embeddings](/docs/2_create_embeddings.md)
1. [Firestore](/docs/3_firestore.md)
1. [LangChain Retriever and Agent](/docs/4_agent.md)
1. [Cloud Run](/docs/5_cloud_run.md)
1. [Firebase WebUI](/docs/6_firebase.md)
