# 2. Create Embeddings

In this step we will create the embeddings to be indexed by the Matching Engine,
upload them to a GCP bucket and update the index.

## Generate embeddings

There are multiple ways to create the embeddings, in this example we use
[LangChain](https://langchain.com) and the Tensorflow Hub Model [Universal Sentence Encoder v3](https://tfhub.dev/google/universal-sentence-encoder-multilingual/3).

The Python code can be found in [the embeddings notebook](/danielfrg/gcp-langchain-retrieval-augmentation/blob/main/embeddings/embeddings.ipynb)
running this notebook will generate a `embeddings/data/embeddings.json` file.

## Upload embeddings to GCP bucket

```
gsutil cp embeddings/data/embeddings.json gs://<BUCKET_NAME>/contents/embeddings.json
```

## Trigger batch index update

First modify the `embeddings/metadata.json` file to point to the GCP bucket
where the embeddings were uploaded and then run the update command:

```
gcloud ai indexes update <index_id> \
  --metadata-file=medatada.json \
  --region=<region>
```

You can get `<index_id>` from the Teraform output of the [previous step](/danielfrg/gcp-langchain-retrieval-augmentation/blob/main/docs/1_matching_engine.md).
