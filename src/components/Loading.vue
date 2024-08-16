<template>
  <div id="loader-wrapper" :class="store.imgLoadStatus ? 'loaded' : null">
    <div class="loader">
      <main>  
        <svg xmlns="http://www.w3.org/2000/svg" height="128px" width="256px" viewBox="0 0 256 128" class="ip">  
          <defs>  
            <linearGradient y2="0" x2="1" y1="0" x1="0" id="grad1">  
              <stop stop-color="#5ebd3e" offset="0%"></stop>  
              <stop stop-color="#ffb900" offset="33%"></stop>  
              <stop stop-color="#f78200" offset="67%"></stop>  
              <stop stop-color="#e23838" offset="100%"></stop>  
            </linearGradient>  
            <linearGradient y2="0" x2="0" y1="0" x1="1" id="grad2">  
              <stop stop-color="#e23838" offset="0%"></stop>  
              <stop stop-color="#973999" offset="33%"></stop>  
              <stop stop-color="#009cdf" offset="67%"></stop>  
              <stop stop-color="#5ebd3e" offset="100%"></stop>  
            </linearGradient>  
          </defs>  
          <g stroke-width="16" stroke-linecap="round" fill="none">  
            <g stroke="#ddd" class="ip__track">  
              <path d="M8,64s0-56,60-56,60,112,120,112,60-56,60-56"></path>  
              <path d="M248,64s0-56-60-56-60,112-120,112S8,64,8,64"></path>  
            </g>  
            <g stroke-dasharray="180 656">  
              <path d="M8,64s0-56,60-56,60,112,120,112,60-56,60-56" stroke-dashoffset="0" stroke="url(#grad1)" class="ip__worm1"></path>  
              <path d="M248,64s0-56-60-56-60,112-120,112S8,64,8,64" stroke-dashoffset="358" stroke="url(#grad2)" class="ip__worm2"></path>  
            </g>  
          </g>  
        </svg>  
      </main>  
      <div class="loader-text">
        <span class="name">
          {{ siteName }}
        </span>
        <span class="tip"> 加载中 </span>
      </div>
    </div>
    <div class="loader-section section-left" />
    <div class="loader-section section-right" />
  </div>
</template>

<script setup>
import { mainStore } from "@/store";

const store = mainStore();

// 配置
const siteName = import.meta.env.VITE_SITE_NAME;
</script>

<style lang="scss" scoped>  
#loader-wrapper {  
  position: fixed;  
  top: 0;  
  left: 0;  
  width: 100%;  
  height: 100%;  
  z-index: 999;  
  overflow: hidden;  
  background-color: var(--bg);  
  color: var(--fg);  

  .loader {  
    position: absolute;  
    top: 50%;  
    left: 50%;  
    transform: translate(-50%, -50%);  
    display: flex;  
    flex-direction: column;  
    align-items: center;  
    z-index: 2;  
    transition: opacity 0.3s ease-out;  
  }  

  main {  
    padding: 24px 0;  
  }  

  .ip {  
    width: 200px;  
    height: 100px;  
  }  

  .ip__track {  
    stroke: hsl(var(--hue),90%,90%);  
    transition: stroke var(--trans-dur);  
  }  

  .ip__worm1,  
  .ip__worm2 {  
    animation: worm1 0.6s linear infinite;  
  }  

  .ip__worm2 {  
    animation-name: worm2;  
  }  

  .loader-text {  
    display: flex;  
    flex-direction: column;  
    align-items: center;  
    color: var(--fg);  
    margin-top: 20px;  
    font-size: 24px;  
    .tip {  
      margin-top: 6px;  
      font-size: 18px;  
      opacity: 0.6;  
    }  
  }  

  .loader-section {  
    position: fixed;  
    top: 0;  
    width: 50%;  
    height: 100%;
    backdrop-filter: blur(5px);  
    background-color: rgba(255, 255, 255, 0.041);
    z-index: 1;  
    transition: transform 0.7s 0.3s cubic-bezier(0.645, 0.045, 0.355, 1);  
    &.section-left {  
      left: 0;  
    }  
    &.section-right {  
      right: 0;  
    }  
  }  

  &.loaded {  
    visibility: hidden;  
    transition: visibility 0s 1s;  

    .loader {  
      opacity: 0;  
      transition: opacity 0.3s ease-out;  
    }  

    .loader-section {  
      &.section-left {  
        transform: translateX(-100%);  
      }  
      &.section-right {  
        transform: translateX(100%);  
      }  
    }  
  }  
}  

:root {  
  --hue: 223;  
  --bg: hsl(var(--hue),90%,95%);  
  --fg: hsl(var(--hue),90%,5%);  
  --trans-dur: 0.3s;  
}  

@media (prefers-color-scheme: dark) {  
  :root {  
    --bg: hsl(var(--hue),90%,5%);  
    --fg: hsl(var(--hue),90%,95%);  
  }  

  .ip__track {  
    stroke: hsl(var(--hue),90%,15%);  
  }  
}  

@keyframes worm1 {  
  from { stroke-dashoffset: 0; }  
  50% {  
    animation-timing-function: steps(1);  
    stroke-dashoffset: -358;  
  }  
  50.01% {  
    animation-timing-function: linear;  
    stroke-dashoffset: 358;  
  }  
  to { stroke-dashoffset: 0; }  
}  

@keyframes worm2 {  
  from { stroke-dashoffset: 358; }  
  50% { stroke-dashoffset: 0; }  
  to { stroke-dashoffset: -358; }  
}  
</style> 