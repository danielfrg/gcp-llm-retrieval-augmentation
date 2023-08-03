<script lang="ts">
  import { TabItem, Tabs } from "flowbite-svelte";
  import Demo from "./Demo.svelte";
</script>

<div class="container mx-auto max-w-lg my-10">
  <h1 class="text-4xl font-extrabold text-center my-4">
    Knowledge Aware LLM Question / Answer System
  </h1>
  <h2 class="text-xl font-extrabold text-center my-4">
    Using a Language Models and Vector Databases to create a question answering
    system
  </h2>
  <p class="text-center">
    This demo features multiple Google Cloud products including <a
      class="underline"
      href="https://cloud.google.com/vertex-ai/docs/matching-engine/overview"
      >Matching Engine</a
    >,
    <a
      class="underline"
      href="https://cloud.google.com/vertex-ai/docs/generative-ai/start/quickstarts/api-quickstart"
      >VertexAI PaLM</a
    >
    to combine the functionality of
    <a class="underline" href="https://www.promptingguide.ai/techniques/rag"
      >retrieval augmentation</a
    > and conversational engines to create a question answering system where the
    user can ask a question and the LLM will use it's given context to answer the
    question.
  </p>

  <img src="/diagram.png" alt="Demo" class="mx-auto" />
</div>

<main class="container mx-auto max-w-4xl">
  <Tabs style="underline" contentClass="p-4" defaultClass="flex justify-center">
    <TabItem open title="Demo">
      <Demo />
    </TabItem>
    <TabItem title="Details" open>
      <p class="my-2">
        The demo uses the
        <a class="underline" href="https://huggingface.co/datasets/squad"
          >Stanford Question Answering Dataset (SQuAD)</a
        >
        Dataset, a reading comprehension dataset, consisting of questions posed by
        crowdworkers on a set of Wikipedia articles.
      </p>
      <h4 class="my-2 text-xl">Architecture</h4>
      <img src="/arch.jpg" alt="Architecture" />
      <h4 class="my-2 text-xl">Services</h4>
      <p class="my-2">
        This frontend App is hosted in <a
          class="underline"
          href="https://firebase.google.com/">Firebase</a
        >
        and it queries a backend API hosted in
        <a class="underline" href="https://cloud.google.com/run">Cloud Run</a>
        and documents stored in
        <a
          class="underline"
          href="https://firebase.google.com/docs/firestore
          ">Firestore</a
        >.
      </p>
      <p class="my-2">
        On the backend the developers indexed the Documents in
        <a
          class="underline"
          href="https://firebase.google.com/docs/firestore
          ">Firestore</a
        >
        and created embeddings that are deployed to
        <a
          class="underline"
          href="https://cloud.google.com/vertex-ai/docs/matching-engine/overview"
          >Matching Engine</a
        > Endpoint.
      </p>
      <p class="my-2">
        The API uses <a class="underline" href="https://python.langchain.com/"
          >LangChain</a
        >
        to retrieve the top 5 most similar documents to the query and then uses
        <a
          class="underline"
          href="https://cloud.google.com/vertex-ai/docs/generative-ai/start/quickstarts/api-quickstart"
          >VertexAI PaLM</a
        >
        to generate the final.
      </p>
      <h4 class="my-2 text-xl">How to build it</h4>
      <ol>
        <li>
          1. <a
            class="underline"
            href="https://github.com/danielfrg/gcp-llm-retrieval-augmentation/blob/main/docs/1_matching_engine.md"
            >Infrastructure Setup</a
          >: Setup the required infrastructure using Terraform and create the
          Matching Engine index
        </li>
        <li>
          2. <a
            class="underline"
            href="https://github.com/danielfrg/gcp-llm-retrieval-augmentation/blob/main/docs/2_create_embeddings.md"
            >Create embeddings</a
          >: Generate the embeddings for the documents and index them in
          Matching Engine
        </li>
        <li>
          3. <a
            class="underline"
            href="https://github.com/danielfrg/gcp-llm-retrieval-augmentation/blob/main/docs/3_firestore.md"
            >Firestore</a
          >: Index the documents in Firestore
        </li>
        <li>
          4. <a
            class="underline"
            href="https://github.com/danielfrg/gcp-llm-retrieval-augmentation/blob/main/docs/4_agent.md"
            >LangChain Retriever and Agent</a
          >: Create a LangChain retriever and conversational agent
        </li>
        <li>
          5. <a
            class="underline"
            href="https://github.com/danielfrg/gcp-llm-retrieval-augmentation/blob/main/docs/5_cloud_run.md"
            >Cloud Run</a
          >: Grab all the code, package it and deploy the API to Cloud Run
        </li>
      </ol>

      <h4 class="my-2 text-xl">Source</h4>
      <p class="my-2">
        All the code for this demo including instructions on how to deploy your
        own version using Terraform and example notebooks can be <a
          class="underline"
          href="https://github.com/danielfrg/gcp-llm-retrieval-augmentation"
          >found on Github
        </a>.
      </p></TabItem
    >
  </Tabs>
</main>
