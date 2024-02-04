document.addEventListener("DOMContentLoaded", function () { // 这个表示在html加载完成后执行
    bubbly({
        colorStart: '#CEEEFF',
        colorStop: '#E8F7FF',
        blur:1,
        compose: 'source-over',
        bubbleFunc:() => `hsla(${Math.random() * 50}, 100%, 50%, .3)`
      });
})