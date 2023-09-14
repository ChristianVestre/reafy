<script lang="ts">
	import Title from 'app/lib/components/title.svelte';
	import ExpenseDetail from './components/expenseDetail.svelte';
	import type { ExpenseData } from 'app/types/expense';
	import { SpinLine } from 'svelte-loading-spinners';
	import { navigating } from '$app/stores';
	export let data: ExpenseData;
</script>

<section>
	{#if $navigating}
		<div class="loadingWrapper">
			<SpinLine color="#cabdc9" />
		</div>
	{:else if data.expenseId}
		<Title title="New Expense" />
		<ExpenseDetail {data} />
	{:else}
		<Title title="No Expenses" />
	{/if}
</section>

<style>
	section {
		display: flex;
		height: 100%;
		width: 100%;
		flex-direction: column;
		align-items: center;
		justify-content: start;
	}
	.loadingWrapper {
		display: flex;
		align-items: center;
		justify-content: center;
		height: 100%;
	}
</style>
