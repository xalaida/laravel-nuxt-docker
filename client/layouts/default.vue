<template>
	<header>
		<nav>
			<ul>
				<li>
					<NuxtLink to="/">Home</NuxtLink>
				</li>
				<li>
					<NuxtLink to="/about">About</NuxtLink>
				</li>
			</ul>
		</nav>
	</header>
	<main>
		<slot />
	</main>
	<footer>
		nevadskiy &copy; 2022
	</footer>
</template>
