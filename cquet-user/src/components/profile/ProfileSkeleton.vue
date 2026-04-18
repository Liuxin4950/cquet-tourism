<template>
  <div class="grid grid-cols-1 gap-6 lg:grid-cols-[320px_minmax(0,1fr)]">
    <div class="animate-pulse rounded-[24px] bg-dark p-6">
      <div class="h-[72px] w-[72px] rounded-full bg-white/20"></div>
      <div class="mt-6 h-5 w-32 rounded bg-white/20"></div>
      <div class="mt-3 h-3 w-44 rounded bg-white/10"></div>
      <div class="mt-8 space-y-3">
        <div class="h-10 rounded-full bg-white/10"></div>
        <div class="h-10 rounded-full bg-white/10"></div>
      </div>
    </div>

    <div class="animate-pulse rounded-[24px] border border-border bg-white p-6">
      <div class="flex gap-2 overflow-hidden">
        <div class="h-10 w-24 rounded-full bg-light"></div>
        <div class="h-10 w-24 rounded-full bg-light"></div>
        <div class="h-10 w-24 rounded-full bg-light"></div>
      </div>
      <div class="mt-8 grid grid-cols-1 gap-4 md:grid-cols-2">
        <div v-for="item in 6" :key="item" class="rounded-[18px] border border-border p-5">
          <div class="h-3 w-20 rounded bg-light"></div>
          <div class="mt-4 h-5 w-36 rounded bg-light"></div>
        </div>
      </div>
    </div>
  </div>
</template>
