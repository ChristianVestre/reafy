<script lang="ts">
	import Title from 'app/lib/components/title.svelte';
	import GoogleButton from 'app/lib/components/buttons/googleButton.svelte';
	import { signIn } from '@auth/sveltekit/client';
</script>

<div class="spacer" />
<Title title="Login" />
<GoogleButton onClick={() => signIn('google', { callbackUrl: '/expense' })} />

<style>
	.spacer {
		height: 8vh;
	}
</style>
