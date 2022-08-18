<script>
  export let blogs;
</script>

<style>

  li {
    text-decoration: underline;
    color: var(--primary);
  }

</style>

<section>

    <ul>
      {#each blogs as title}
        <li>{title}</li>
      {/each}
    </ul>

</section>
