<script lang="ts">
	export let onClick: () => void;

	const googleLogo = new URL('/google-icon.png', import.meta.url).href;
</script>

<button on:click={() => onClick()} type="submit">
	<img alt="Google logo" src={googleLogo} />
	Login with google
</button>

<style>
	img {
		height: 30px;
		width: 30px;
		margin-right: var(--spacing-small);
	}
	button {
		display: flex;
		align-items: center;
		padding: 8px;
		font-size: var(--text-body-medium);
		min-width: 100px;
		border: 1px solid var(--border-color);
		background-color: transparent;
		color: black;
		font: inherit;
		cursor: pointer;
		outline: inherit;
		border-radius: 5px;
	}
</style>
