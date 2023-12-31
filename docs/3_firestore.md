# 3. Firestore

Firestore is the document database used to store all the context of the questions
of the dataset with their respective IDs.

This DB is used by the web UI and API to retrieve these documents and show them to the user.

## Setup

Create the Firebase project using the UI and create the Firestore DB.

## Document structure

The document structure is pretty simple. The document ID is the question ID and the document contains the following fields from the original dataset:

- title
- context
- question
- answers: answer and answer_start

Example:

```json
{
  "title": "University_of_Notre_Dame",
  "question": "To whom did the Virgin Mary allegedly appear in 1858 in Lourdes France?",
  "context": "Architecturally, the school has a Catholic character [...]",
  "answers": {
    "text": ["Saint Bernadette Soubirous"],
    "answer_start": [515]
  }
}
```

## Indexing

We use a simple python script using the Python Firestore SDK.
See the notebook [firestore/index_docs.ipynb](/firestore/index_docs.ipynb).

## Next step

With these services in place we can proceed to [create our conversational agent](/docs/4_agent.md).
