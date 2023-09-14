<script lang="ts">
	import { goto } from '$app/navigation';
	import Title from 'app/lib/components/title.svelte';
	import ListTile from 'app/lib/components/tiles/listTile.svelte';
	import { enhance } from '$app/forms';
	import { navigating } from '$app/stores';
	import { SpinLine } from 'svelte-loading-spinners';
	export let data;
</script>

{#if $navigating}
	<section class="loadingWrapper">
		<SpinLine color="#cabdc9" />
	</section>
{:else}
	<Title title="Select company" />
	<section>
		<form
			method="POST"
			use:enhance={({ formData, submitter }) => {
				//@ts-ignore
				formData.append('companyId', submitter?.value);
				return () => goto('/employee');
			}}
		>
			{#each data.companies as company}
				<ListTile
					title={company.companyName}
					value={company.companyId}
					onPressed={() => {
						goto('/employee');
					}}
				/>
			{/each}
		</form>
	</section>
{/if}

<style>
	section {
		display: flex;
		flex-direction: column;
	}
	.loadingWrapper {
		height: 100vh;
		justify-content: center;
		align-content: center;
	}
</style>
