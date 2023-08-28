<script>
	import { goto } from '$app/navigation';
	import PrimaryButton from 'app/lib/components/buttons/primaryButton.svelte';
	import Title from 'app/lib/components/title.svelte';
</script>

<section>
	<Title title="Expense payed 🎉" />
	<PrimaryButton text="Back" onPressed={() => goto('/')} />
</section>

<style>
	section {
		height: 100%;
		display: flex;
		flex-direction: column;
		justify-content: center;
		align-items: center;
		transform: translate(0, -10%);
	}
	p {
		margin: 0;
		padding: 0;
		font-size: var(--text-body-large);
	}
</style>
