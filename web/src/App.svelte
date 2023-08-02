<script lang="ts">
  // Import the functions you need from the SDKs you need
  import { initializeApp } from "firebase/app";
  import { doc, getDoc, getFirestore } from "firebase/firestore";

  // TODO: Add SDKs for Firebase products that you want to use
  // https://firebase.google.com/docs/web/setup#available-libraries

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

  let question: string = "What is the capital of France?";
  let similarDocs: any[] = [];

  async function onSubmit() {
    const data = await fetch(
      "https://retrieval-augmentation-api-uowebtbapa-uc.a.run.app/api",
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

    const docs = await data.json();

    const newDocs: any[] = [];
    for (const similar of docs) {
      const docID = similar[0];
      console.log(docID);
      const docRef = doc(db, "questions", docID);
      const docSnap = await getDoc(docRef);

      if (docSnap.exists()) {
        const data = docSnap.data();
        console.log("Document data:", data);
        newDocs.push(data);
      } else {
        // docSnap.data() will be undefined in this case
        console.log("No such document!");
      }
    }

    similarDocs = newDocs;
  }
</script>

<main class="flex flex-col gap-4 mx-auto text-center w-xl my-4">
  <h1 class="text-4xl">Write a question</h1>

  <form on:submit|preventDefault={onSubmit} class="">
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
  </form>
</main>

<section>
  {#each similarDocs as { question }}
    <li>
      {question}
    </li>
  {/each}
</section>
