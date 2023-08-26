<script>
	import Title from 'app/lib/components/title.svelte';
</script>

<section>
	<Title title="Expense sent" />
	<p>Waiting on employee to verify expense.</p>
</section>

<style>
	section {
		height: 100%;
		display: flex;
		flex-direction: column;
		justify-content: center;
		transform: translate(0, -10%);
	}
	p {
		margin: 0;
		padding: 0;
		font-size: var(--text-body-large);
	}
</style>
