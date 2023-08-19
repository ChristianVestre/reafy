<script lang="ts">
	export let text: string;
	export let onPressed: () => void;
</script>

<button on:click={onPressed}>
	{text}
</button>

<style>
	button {
		padding: 8px;
		min-width: 100px;
		max-width: 140px;
		background: var(--primary-color);
		color: white;
		border: none;
		font: inherit;
		cursor: pointer;
		outline: inherit;
		border-radius: 5px;
	}
</style>
