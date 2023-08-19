<script lang="ts">
	import { goto } from '$app/navigation';
	import CompanyCard from 'app/lib/tiles/listTile.svelte';
	import Title from 'app/lib/title.svelte';
	const employees: string[] = ['Lars Johan Bjørkvoll', 'Fridtjof Høvik', 'Vivien Pixa'];
</script>

<Title title="Select employee" />
<section>
	{#each employees as employee}
		<CompanyCard title={employee} onPressed={() => goto('/expense-sent')} />
	{/each}
</section>

<style>
	section {
		display: flex;
		flex-direction: column;
	}
</style>
