<script lang="ts">
	import type { User } from '@auth/core/types';
	import { getContext } from 'svelte';
	export let onClick: () => void;
	const user: User = getContext('user');
</script>

{#if user}
	<div on:click={() => onClick()} class="profile">
		<img src={user.image} class="circle" />
		<p>{user.name}</p>
	</div>
{:else}
	<div class="profile" />
{/if}

<style>
	.profile {
		width: 140px;
		display: flex;
		flex-direction: column;
		align-items: center;
		position: relative;
	}
	p {
		padding: 0;
		margin: 0;
	}
	.circle {
		height: 30px;
		width: 30px;
		background-color: var(--border-color);
		border-radius: 100%;
		margin-bottom: var(--spacing-micro);
	}
</style>
