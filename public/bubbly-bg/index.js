document.addEventListener("DOMContentLoaded", function () { // 这个表示在html加载完成后执行
    bubbly({
        colorStart: '#CEEEFF',
        colorStop: '#ACE2FF',
        blur:1,
        compose: 'source-over',
        bubbleFunc:() => `hsla(${Math.random() * 50}, 100%, 50%, .3)`
      });
})