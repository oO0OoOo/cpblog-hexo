document.addEventListener("DOMContentLoaded", function () { // 这个表示在html加载完成后执行
    bubbly({
        colorStart: '#E6F7FF',
        colorStop: '#E6EEFF',
        blur:1,
        compose: 'source-over',
		shadowColor: "#0ff"
        bubbleFunc:() => `hsla(${Math.random() * 50}, 100%, 50%, .1)`
      });
})