<script>
  import { onMount } from "svelte";

  let myId;
  let newTaskTitle = "";

  onMount(async () => {
    myId = localStorage.getItem("id") ?? crypto.randomUUID();
    localStorage.setItem("id", myId);
  });

  const fetchAll = (id) => Promise.all([fetchMe(id), fetchTasks(id)]);

  const fetchMe = (id) =>
    fetch("/me", {
      headers: {
        Authorization: `Bearer ${id}`,
      },
    }).then((res) => res.text());

  const fetchTasks = (id) =>
    fetch("/tasks", {
      headers: {
        Authorization: `Bearer ${id}`,
      },
    }).then((res) => res.json());

  const handleOnFormSubmit = async () => {
    await fetch(`/task?title=${newTaskTitle}`, {
      method: "POST",
      headers: {
        Authorization: `Bearer ${myId}`,
      },
    })
      .then((res) => res.text())
      .then(console.log);
    newTaskTitle = "";
  };
</script>

<section>
  <h1>Get Your Ducks</h1>

  {#if myId === undefined}
    <p class="loading">Getting ready...</p>
  {:else}
    {#await fetchAll(myId)}
      <p class="loading">Loading...</p>
    {:then [me, tasks]}
      <h2>Tasks for #{me}</h2>
      <ul>
        {#each tasks as task}
          <li>{task}</li>
        {/each}
      </ul>
      <form on:submit|preventDefault={handleOnFormSubmit}>
        <label for="taskTitle">Task Title:</label>
        <input type="text" id="taskTitle" bind:value={newTaskTitle} /><br />
        <input type="submit" value="Add Task" />
      </form>
    {:catch error}
      <p class="error">Error: {error.message}</p>
    {/await}
  {/if}
</section>

<style>
  :root {
    --primary: darkblue;
    --error: red;
    font-family: sans-serif;
  }

  h1 {
    color: var(--primary);
  }

  p.loading {
    color: var(--primary);
  }

  p.error {
    color: var(--error);
  }
</style>
