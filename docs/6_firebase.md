# 6. Firebase

Firebase is used to host the frontend of the demo.

The frontend is a simple Svelte app that uses the Firebase SDK to connect to
Firestore and retrieve the documents. It also queries the Cloud Run deployed API
to retrieve the top k nearest neighbors and the LLM generated answer.

All the source can be found in [/web](/web).
