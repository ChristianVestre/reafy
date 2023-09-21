<script lang="ts">
	import PrimaryButton from 'app/lib/components/buttons/primaryButton.svelte';
	import SecondaryButton from 'app/lib/components/buttons/secondaryButton.svelte';
	export let secondaryText: string;
	export let primaryText: string;
	export let primaryOnPressed: () => void;
	export let secondaryOnPressed: () => void;
</script>

<section>
	<SecondaryButton text={secondaryText} onPressed={() => secondaryOnPressed()} />
	<PrimaryButton text={primaryText} onPressed={() => primaryOnPressed()} />
</section>

<style>
	section {
		margin-top: var(--spacing-xlarge);
		width: 70%;
		display: flex;
		justify-content: space-between;
	}
</style>
