<script>
	import { goto } from '$app/navigation';
	import PrimaryButton from 'app/lib/components/buttons/primaryButton.svelte';
	import SecondaryButton from 'app/lib/components/buttons/secondaryButton.svelte';
</script>

<section>
	<SecondaryButton text="Delete" onPressed={() => {}} />
	<PrimaryButton text="Send" onPressed={() => goto('/company')} />
</section>

<style>
	section {
		margin-top: var(--spacing-xlarge);
		width: 50%;
		display: flex;
		justify-content: space-between;
	}
</style>
