<script lang="ts">
	import ReafyNavBar from 'app/lib/reafyNavBar.svelte';
	import 'app/styles/global.css';
</script>

<ReafyNavBar />
<main>
	<slot />
</main>

<style>
	main {
		display: flex;
		flex: 1;
		flex-direction: column;
		align-items: center;
	}
</style>
