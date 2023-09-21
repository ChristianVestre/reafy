<script lang="ts">
	import { enhance } from '$app/forms';
	import { goto } from '$app/navigation';
	import { navigating } from '$app/stores';
	import PrimaryButton from 'app/lib/components/buttons/primaryButton.svelte';
	import ReafyButtonRow from 'app/lib/components/reafyButtonRow.svelte';
	import Title from 'app/lib/components/title.svelte';
	import Switch from 'app/lib/components/toggle.svelte';
	import { SpinLine } from 'svelte-loading-spinners';

	let licorValue: string = 'off';
</script>

{#if $navigating}
	<section class="loadingWrapper">
		<SpinLine color="#cabdc9" />
	</section>
{:else}
	<section>
		<div class="spacer-s" />

		<Title title="Licor" />
		<div class="spacer-s" />
		<Switch label="The tab includes licor?" bind:value={licorValue} design="slider" />

		<form
			method="POST"
			use:enhance={({ formData }) => {
				console.log(licorValue);
				//@ts-ignore
				formData.append('licor', licorValue == 'on' ? true : false);
				return () => goto('/company');
			}}
		>
			<div class="spacer" />
			<PrimaryButton text="Next" onPressed={() => {}} />
		</form>
	</section>
{/if}

<style>
	section {
		display: flex;
		flex-direction: column;
		justify-content: flex-start;
		align-items: center;
		transform: translate(0, -10%);
	}
	.spacer {
		height: 80px;
	}
	.spacer-s {
		height: 20px;
	}
	.loadingWrapper {
		height: 100vh;
		justify-content: center;
		align-content: center;
	}
	form {
		display: flex;
		flex-direction: column;
		align-items: center;
	}
</style>
