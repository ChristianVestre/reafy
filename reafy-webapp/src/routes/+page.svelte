<script lang="ts">
	import Title from 'app/lib/components/title.svelte';
	import GoogleButton from 'app/lib/components/buttons/googleButton.svelte';
	import { goto, invalidateAll } from '$app/navigation';
	import type { PageData } from './$types.js';
	import { signIn, signOut } from '@auth/sveltekit/client';
	import { SignJWT } from 'jose';
	import { setContext } from 'svelte';
	import { writable } from 'svelte/store';
	import { enhance } from '$app/forms';
	export let data: PageData;

	const secret = new TextEncoder().encode('DetteErReafySecurityToken!!');
	const alg = 'HS256';
	let loading: boolean = false;
	const user = writable();
	setContext('user', user);
</script>

{#if loading}
	<h2>Loading</h2>
{:else}
	<div class="spacer" />
	<Title title="Login" />
	<GoogleButton onClick={() => signIn('google', { callbackUrl: '/expense' })} />
{/if}

<style>
	.spacer {
		height: 8vh;
	}
</style>
