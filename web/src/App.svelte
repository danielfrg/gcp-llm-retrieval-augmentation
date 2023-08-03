<script lang="ts">
  import { TabItem, Tabs } from "flowbite-svelte";
  import Demo from "./Demo.svelte";
</script>

<div class="container mx-auto max-w-lg my-10">
  <h1 class="text-4xl font-extrabold text-center my-4">
    Retrieval Augmentation Demo
  </h1>
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
    > to combine the functionality of retrieval augmentation and conversational engines
    to create a question answering system where the user can ask a question and the
    LLM will only answer questions from it's given context.
  </p>
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
      <p class="my-2">
        All the code for this demo including instructions on how to deploy your
        own version using Terraform and example notebooks can be <a
          class="underline"
          href="https://github.com/danielfrg/gcp-llm-retrieval-augmentation"
          >found on Github</a
        >.
      </p></TabItem
    >
  </Tabs>
</main>
