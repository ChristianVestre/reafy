<script>
	import { signOut } from '@auth/sveltekit/client';
	import Profile from 'app/lib/components/profile.svelte';

	// your script goes here
</script>

<div>
	<a href="/" class="reafy-logo wrapper"> reafy </a>
	<h2>Mesh</h2>
	<Profile onClick={() => signOut({ callbackUrl: '/' })} />
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
