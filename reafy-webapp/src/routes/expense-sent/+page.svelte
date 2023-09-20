<script>
	import { goto } from '$app/navigation';
	import Title from 'app/lib/components/title.svelte';
	import { onMount } from 'svelte';
	export let data;
	onMount(() => {
		async function fetchData() {
			const response = await fetch(`api/expense-sent?id=${data.expenseId}`);
			const body = await response.json();
			console.log(body);
			if (body == true) {
				goto('/expense-verified');
			}
		}
		const interval = setInterval(fetchData, 15000);
		fetchData();
		return () => clearInterval(interval);
	});
</script>

<section>
	<Title title="Expense sent" />
	<p>Waiting on employee to verify expense.</p>
</section>

<style>
	section {
		height: 100%;
		display: flex;
		flex-direction: column;
		justify-content: center;
		transform: translate(0, -10%);
	}
	p {
		margin: 0;
		padding: 0;
		font-size: var(--text-body-large);
	}
</style>
