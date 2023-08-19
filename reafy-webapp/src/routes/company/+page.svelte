<script lang="ts">
	import { goto } from '$app/navigation';
	import Title from 'app/lib/title.svelte';
	import ListTile from '$lib/tiles/listTile.svelte';
	const companies: string[] = ['ScaleupXQ', 'Code 11', 'Tyve'];
</script>

<Title title="Select company" />
<section>
	{#each companies as company}
		<ListTile title={company} onPressed={() => goto('/employee')} />
	{/each}
</section>

<style>
	section {
		display: flex;
		flex-direction: column;
	}
</style>
