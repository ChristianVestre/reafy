<script lang="ts">
	import PayedLabel from 'app/lib/components/labels/payedLabel.svelte';
	import type { ExpenseData, ExpenseProcess } from 'app/types/expense';
	import { LabelEnum } from 'app/types/enums';
	import ExpenseLineItem from './expenseLineItem.svelte';
	import ExpenseButtonRow from './expenseButtonRow.svelte';
	import { convertCurrency } from 'app/lib/components/helpers/currencyConverter';
	import { goto } from '$app/navigation';
	import { enhance } from '$app/forms';
	export let data: ExpenseData;
</script>

<div class="container">
	<section class="first-section">
		<h3>{data.establishmentName}</h3>
		<h4>31.05.2023</h4>
		<h4>Time: 23:20</h4>
		<div class="spacer" />
		<PayedLabel text="Not paid" labelType={LabelEnum.NotPayed} />
	</section>
	<section class="second-section">
		<h4 class="subsection-headline">Items:</h4>
		{#each data.lineItems as item}
			<ExpenseLineItem expenseLineItem={item} />
		{/each}
		<div class="line-item">
			<h4 class="subsection-headline">Mva:</h4>
			<p>{convertCurrency(data.mva)} kr</p>
		</div>
		<div class="line-item">
			<h4 class="subsection-headline">Total cost:</h4>
			<p>{convertCurrency(data.totalExpense)} kr</p>
		</div>
	</section>
	<form
		method="POST"
		use:enhance={({ formData }) => {
			//@ts-ignore
			formData.append('expenseId', data.expenseId);
			return goto('/company');
		}}
		class="button-row"
	>
		<ExpenseButtonRow
			secondaryText="Deny"
			primaryText="Send"
			primaryOnPressed={() => {}}
			secondaryOnPressed={() => {}}
		/>
	</form>
</div>

<style>
	p {
		margin: 0;
		padding: 0;
	}
	.button-row {
		display: flex;
		justify-content: center;
		width: 100%;
	}
	.line-item {
		display: flex;
		flex-direction: row;
		justify-content: space-between;
		align-items: center;
		margin: 0 var(--spacing-small) 0 0;
		padding-top: var(--spacing-medium);
	}
	.subsection-headline {
		font-size: var(--text-headline-medium);
		font-weight: var(--text-font-light);
	}
	.first-section {
		display: flex;
		align-items: center;
		justify-content: center;
		flex-direction: column;
	}
	.second-section {
		width: 100%;
		padding: 0 var(--spacing-medium);
		margin-top: var(--spacing-large);
	}
	.spacer {
		height: var(--spacing-medium);
	}
	.container {
		border: solid 1px var(--border-color);
		border-radius: 5%;
		padding: var(--spacing-medium);
		display: flex;
		align-items: center;
		justify-content: center;
		flex-direction: column;
		width: 500px;
		max-width: 50%;
	}
	h3 {
		padding: 0;
		margin: 0;
		margin-bottom: var(--spacing-small);
		font-size: var(--text-headline-large);
	}
	h4 {
		padding: 0;
		margin: 0;
		font-weight: var(--text-font-regular);
	}
</style>
