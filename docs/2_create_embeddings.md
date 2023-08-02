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
gsutil cp embeddings/data/embeddings.json gs://<gcs-bucket>/contents/embeddings.json
```

## Trigger batch index update

First modify the `embeddings/metadata.json` file to point to the GCP bucket
where the embeddings were uploaded and then run the update command:

```plain
gcloud ai indexes update <tf_index_id> \
  --metadata-file=embeddings/metadata.json \
  --region=<region>
```

You can get `<tf_index_id>` from the Teraform output of the [previous step](/docs/1_matching_engine.md).

The previous command will trigger a batch update of the index, this can take
while to complete. The previous command will output a command to check the
operation status.

## Query the embeddings

Now that the index has been updated we can query for a similarity search.
[See notebook](/embeddings/similarity_search.ipynb).

## Next step

In the next step we will index this same dataset into Firestore that will
act as our Document store for the agent and Frontend UI.
