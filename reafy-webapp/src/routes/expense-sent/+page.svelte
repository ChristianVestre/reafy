<script>
	import { goto } from '$app/navigation';
	import { get } from 'app/lib/api';
	import Title from 'app/lib/components/title.svelte';
	import { onMount } from 'svelte';
	export let data;
	onMount(() => {
		async function fetchData(interval) {
			const response = await get({ path: `expense/expense-payed?id=${data.expenseId}` });
			console.log(response);
			if (response.active == false) {
				goto('/expense-verified');
			}
		}
		const interval = setInterval(fetchData, 30000);
		fetchData(interval);
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
