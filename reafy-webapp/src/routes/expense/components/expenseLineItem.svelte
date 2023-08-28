<script lang="ts">
	import { convertCurrency } from 'app/lib/components/helpers/currencyConverter';
	import type { ExpenseLineItem } from 'app/types/expense';

	export let expenseLineItem: ExpenseLineItem;
</script>

<div>
	<h5>{expenseLineItem.name}</h5>
	<p>{expenseLineItem.numberPurchased} x: {convertCurrency(expenseLineItem.costPerItem)} kr</p>
</div>

<style>
	div {
		display: flex;
		flex-direction: row;
		align-items: space-between;
		justify-content: space-between;
		margin: var(--spacing-small) var(--spacing-small) var(--spacing-small) var(--spacing-large);
		padding: 0;
	}
	h5 {
		margin: 0;
		padding: 0;
		font-weight: var(--text-font-light);
		font-size: var(--text-body-large);
	}
	p {
		margin: 0;
		padding: 0;
	}
</style>
