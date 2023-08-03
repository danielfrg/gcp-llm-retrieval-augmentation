<script lang="ts">
  // Import the functions you need from the SDKs you need
  import { initializeApp } from "firebase/app";
  import { doc, getDoc, getFirestore } from "firebase/firestore";

  // Your web app's Firebase configuration
  const firebaseConfig = {
    apiKey: "AIzaSyC2VAWEf4hv85QGAZiMDxwfvokp22X86_4",
    authDomain: "llmops-demos-frg.firebaseapp.com",
    projectId: "llmops-demos-frg",
    storageBucket: "llmops-demos-frg.appspot.com",
    messagingSenderId: "222282500808",
    appId: "1:222282500808:web:824b7e9dd57b541dac33fd",
  };

  // Initialize Firebase
  const app = initializeApp(firebaseConfig);
  const db = getFirestore(app);

  let question: string = "";
  let loading: boolean | undefined;
  let answer: string | undefined;
  let similarDocs: any[] = [];

  async function onSubmit() {
    loading = true;
    answer = undefined;
    similarDocs = [];

    const answerP = fetch(
      "https://retrieval-augmentation-api-uowebtbapa-uc.a.run.app/api/full",
      {
        method: "POST",
        body: JSON.stringify({
          question: question,
        }),
        headers: {
          "content-type": "application/json",
        },
      }
    );

    const nearestDocsP = fetch(
      "https://retrieval-augmentation-api-uowebtbapa-uc.a.run.app/api/nearest_docs",
      {
        method: "POST",
        body: JSON.stringify({
          question: question,
          n: 5,
        }),
        headers: {
          "content-type": "application/json",
        },
      }
    );

    Promise.all([answerP, nearestDocsP]).then(async (values) => {
      answer = await values[0].json();
      const nearestDocs = await values[1].json();

      const newDocs: any[] = [];
      for (const similar of nearestDocs) {
        const docID = similar[0];
        const docRef = doc(db, "questions", docID);
        const docSnap = await getDoc(docRef);

        if (docSnap.exists()) {
          const data = docSnap.data();
          newDocs.push(data);
        } else {
          // docSnap.data() will be undefined in this case
          console.log("No such document!");
        }
      }

      loading = false;
      similarDocs = newDocs;
    });
  }

  // Initial load

  const sampleQs = [
    "In what year did the initial degrees get handed out at Notre Dame?",
    "How many named lakes are there in Montana?",
    "Who was the host of the gathering where Frédéric was introduced to George Sand?",
    "According to Norbu who failed to realize the significance of the religious aspect of the Ming-Tibetan relationship?",
    "What was June 1, 2008 called?",
    "What is a solar balloon?",
    "Who was the eldest son of Alfonso III and what did he become king of?",
    "What was Metacritics score for Spectre?",
  ];

  function randomQuestion() {
    const index = Math.floor(Math.random() * sampleQs.length);
    question = sampleQs[index];
  }
  randomQuestion();
</script>

<main class="flex flex-col gap-4 mx-auto text-center w-xl my-4">
  <h1 class="text-3xl">Ask a question</h1>

  <form on:submit|preventDefault={onSubmit} class="">
    <div>
      <input
        bind:value={question}
        type="text"
        class="w-[500px] rounded text-gray-800"
        placeholder="What is the capital of France?"
      />
      <button
        class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded"
      >
        Submit
      </button>
    </div>

    <button
      class="bg-blue-500 hover:bg-blue-700 text-white font-bold mt-2 px-4 rounded"
      on:click={randomQuestion}
    >
      Ask a random question
    </button>
  </form>
</main>

<section class="container flex flex-col gap-4 mx-auto w-xl my-4">
  {#if loading}
    <p class="text-center">Loading...</p>
  {:else if similarDocs.length >= 0 && answer != undefined}
    <h3 class="text-2xl text-center">Answer</h3>
    <p class="p-4 bg-gray-50 rounded-lg dark:bg-gray-800">{answer}</p>

    <h3 class="text-2xl text-center">Documents used</h3>
    <div class="overflow-auto pb-4">
      <div class="flex flex-row gap-2 flex-nowrap">
        {#each similarDocs as { question, context }}
          <div
            class="h-[400px] min-w-[400px] overflow-auto block rounded-lg bg-white p-6 mx-2 shadow-[0_2px_15px_-3px_rgba(0,0,0,0.07),0_10px_20px_-2px_rgba(0,0,0,0.04)] dark:bg-neutral-700"
          >
            <p class="mb-4 text-base text-neutral-600 dark:text-neutral-200">
              {context}
            </p>
          </div>
        {/each}
      </div>
    </div>
  {:else}
    <div />
  {/if}
</section>
