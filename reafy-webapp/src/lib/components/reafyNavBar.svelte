<script lang="ts">
	import { signOut } from '@auth/sveltekit/client';
	import Profile from 'app/lib/components/profile.svelte';
	import { getContext } from 'svelte';
	import type { EstablishmentUser } from 'app/types/user';
	import { goto } from '$app/navigation';
	const user: EstablishmentUser = getContext('user');
</script>

<div>
	<a href="/expense" class="reafy-logo wrapper"> reafy </a>
	{#if user}
		<h2>{user.establishmentName}</h2>
	{/if}
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
