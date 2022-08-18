<script>
  import BlogList from './components/BlogList.svelte';
  const fetchBlogs = fetch('http://localhost:8080/name').then((res) => res.json());
</script>

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

<section>

  <h1>Blog Entries</h1>

  {#await fetchBlogs}
    <p class="loading">Loading...</p>
  {:then blogs}
    <BlogList {blogs} />
  {:catch error}
    <p class="error">Error: {error.message}</p>
  {/await}

</section>
