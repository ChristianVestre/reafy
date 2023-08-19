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
		background-color: transparent;
		border: 1px solid var(--primary-color);
		color: black;
		font: inherit;
		cursor: pointer;
		outline: inherit;
		border-radius: 5px;
	}
</style>
