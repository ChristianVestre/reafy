<script>
	import Title from 'app/lib/components/title.svelte';
	import { getContext } from 'svelte';
	import ExpenseDetail from './components/expenseDetail.svelte';

	const user = getContext('user');
	console.log(
		'test2'
		/*	user.subscribe((v) => {
			console.log(v);
		})*/
	);
</script>

<Title title="New Expense" />
<ExpenseDetail />

<style>
</style>
