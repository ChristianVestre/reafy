<script>
	import Profile from '$lib/profile.svelte';

	// your script goes here
</script>

<div>
	<a href="/" class="reafy-logo wrapper"> reafy </a>
	<h2>Mesh</h2>
	<Profile />
</div>

<style>
	.wrapper {
		width: 140px;
	}
	h2 {
		font-size: var(--text-headline-large);
		padding: 0;
		margin: 0;
		text-align: center;
	}
	div {
		display: flex;
		align-items: center;
		justify-content: space-between;
		padding: var(--spacing-small);
	}
</style>
