<script lang="ts">
	import { enhance } from '$app/forms';
	import { goto } from '$app/navigation';
	import ListTile from 'app/lib/components/tiles/listTile.svelte';
	import Title from 'app/lib/components/title.svelte';
	export let data;
</script>

<Title title="Select employee" />
<section>
	<form
		method="POST"
		use:enhance={({ formData, submitter }) => {
			//@ts-ignore
			formData.append('userId', submitter?.value);
			return () => goto('/expense-sent');
		}}
	>
		{#each data.employees as employee}
			<ListTile
				title={employee.userName}
				value={employee.userId}
				onPressed={() => goto('/expense-sent')}
			/>
		{/each}
	</form>
</section>

<style>
	section {
		display: flex;
		flex-direction: column;
	}
</style>
