<script lang="ts">
	import type { LabelEnum } from 'app/types/enums';
	export let text: string;
	export let labelType: LabelEnum;
</script>

<div class={labelType}>
	{text}
</div>

<style>
	.notPayed {
		background-color: #f37373;
		color: white;
	}
	.payed {
		background-color: green;
	}
	div {
		padding: var(--spacing-micro) var(--spacing-small);
		border-radius: 5px;
		font-size: var(--text-body-large);
		font-weight: var(--text-font-light);
		width: auto;
		overflow: auto;
	}
</style>
