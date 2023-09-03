<script lang="ts">
	import ReafyNavBar from 'app/lib/components/reafyNavBar.svelte';
	import 'app/styles/global.css';
	import { setContext } from 'svelte';
	export let data;
	setContext('user', data.session?.user);
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
