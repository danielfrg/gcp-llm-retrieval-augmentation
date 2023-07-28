# 2. Create Embeddings

In this step we will create the embeddings to be indexed by the Matching Engine,
upload them to a GCP bucket and update the index.

## Generate embeddings

There are multiple ways to create the embeddings, in this example we use
[LangChain](https://langchain.com) and the Tensorflow Hub Model [Universal Sentence Encoder v3](https://tfhub.dev/google/universal-sentence-encoder-multilingual/3).

The Python code can be found in [the embeddings notebook](/embeddings/embeddings.ipynb)
running this notebook will generate a `embeddings/data/embeddings.json` file.

## Upload embeddings to GCP bucket

```plain
gsutil cp embeddings/data/embeddings.json gs://<BUCKET_NAME>/contents/embeddings.json
```

## Trigger batch index update

First modify the `embeddings/metadata.json` file to point to the GCP bucket
where the embeddings were uploaded and then run the update command:

```plain
gcloud ai indexes update <index_id> \
  --metadata-file=medatada.json \
  --region=<region>
```

You can get `<index_id>` from the Teraform output of the [previous step](/docs/1_matching_engine.md).

## Query the embeddings

Now that the index has been updated we can query for a similarity search.
[See notebook](/embeddings/similarity_search.ipynb).

## Next step

In the next step we will deploy a Cloud Run service that will use the index to
perform similarity searches and expose it as an API.
