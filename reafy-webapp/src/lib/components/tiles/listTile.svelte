<script lang="ts">
	export let title: String;
	import ChevronRight from 'svelte-icons/fa/FaChevronRight.svelte';
	export let onPressed: () => void;
	export let value: string;
</script>

<button on:click={() => onPressed()} {value}>
	<h4>{title}</h4>
	<div class="chevron">
		<ChevronRight />
	</div>
</button>

<style>
	h4 {
		margin: 0;
		padding: 0;
		font-weight: var(--text-font-light);
		font-size: var(--text-headline-medium);
		font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;
	}

	.chevron {
		color: var(--primary-color);
		height: 20px;
	}

	button {
		padding: var(--spacing-small) var(--spacing-large);
		margin-bottom: var(--spacing-medium);
		widows: 50%;
		min-width: 500px;
		background-color: transparent;
		border: 1px solid var(--border-color);
		color: black;
		font: inherit;
		cursor: pointer;
		outline: inherit;
		border-radius: 5px;
		display: flex;
		flex-direction: row;
		align-items: center;
		justify-content: space-between;
	}
</style>
