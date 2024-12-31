---
title: 有向连通图的广度和深度优先遍历（lua）
author: epya15
tags:
  - 算法
categories:
  - 算法
date: 2024-03-19 00:00:00
excerpt: ''
---

#### 现有如下有向连通图



![screenshot-20240319-162836](https://raw.githubusercontent.com/oO0OoOo/cpblog-hexo/main/source/images/202403191630468.png)



### 广度优先遍历（BFS）



从v1结点出发，并访问v1。

依次访问v1的所有未被访问过的邻接点。

再从邻接点出发，依次访问它们的邻接点，并使先被访问的顶点的邻接点先于后被访问的顶点的邻接点。重复步骤，直至图中所有已被访问的顶点的邻接点都被访问到。



```lua
--定义方法：判断列表是否存在指定元素
local contains = function(list, element)
    for i = 1, #list do
        if list[i] == element then
            return true
        end
    end
    return false
end

--构建图
local map = {}
map["v1"] = {"v2", "v3", "v4"}
map["v2"] = {"v6", "v5"}
map["v3"] = {"v1"}
map["v4"] = {"v9"}
map["v5"] = {"v3"}
map["v6"] = {"v7"}
map["v7"] = {"v6", "v8"}
map["v8"] = {"v5", "v9"}
map["v9"] = {"v3", "v8"}

local queue = {}		--数组模拟队列
local qPtr = 1			--qPtr代表队列头
queue[qPtr] = "v1" 		--从v1开始遍历，队首放入首个结点
local visited = { queue[qPtr] }		--存储访问过的结点

repeat
    local node = queue[qPtr]
    local neighborList = map[node]	--node的邻接表
    for i = 1, #neighborList do
        if not contains(visited, neighborList[i]) then
            queue[#queue + 1] = neighborList[i]
            table.insert(visited, neighborList[i])
        end
    end
    queue[qPtr] = ""
    qPtr = qPtr + 1
until(qPtr > #queue)

--结果输出
local output = ""
for i = 1, #visited do
    output = output .. visited[i] .. ","
end
print(string.sub(output, 1, #output - 1))
```

**输出：v1,v2,v3,v4,v6,v5,v9,v7,v8**



### 深度优先遍历（DFS）



从v1结点出发，并访问v1。

访问v1的第一个未被访问的邻接点v2。再访问v2的第一个未被访问的邻接点，若结点v的所有邻接点不存在或都被访问过，则退回到上一个结点。直到所有的结点都被访问到。



```lua
--定义方法：判断列表是否存在指定元素
local contains = function(list, element)
    for i = 1, #list do
        if list[i] == element then
            return true
        end
    end
    return false
end

--构建图
local map = {}
map["v1"] = {"v2", "v3", "v4"}
map["v2"] = {"v6", "v5"}
map["v3"] = {"v1"}
map["v4"] = {"v9"}
map["v5"] = {"v3"}
map["v6"] = {"v7"}
map["v7"] = {"v6", "v8"}
map["v8"] = {"v5", "v9"}
map["v9"] = {"v3", "v8"}

local stack = {}		--数组模拟栈
stack[1] = "v1" 		--从v1开始遍历，栈底放入首个结点
local visited = { stack[1] }		--存储访问过的结点
local found = false		--用于标记当前结点的邻接结点是否已经都遍历过了

repeat
    local node = stack[#stack]		--peek操作
    local neighborList = map[node]	--node的邻接表
    found = false
    for i = 1, #neighborList do
        if found then
            break
        end
        if not contains(visited, neighborList[i]) then
            stack[#stack + 1] = neighborList[i]		--push操作
            table.insert(visited, neighborList[i])
            found = true
        end
    end
    if not found then
        stack[#stack] = nil		--pop操作
    end
until(#stack == 0)

--结果输出
local output = ""
for i = 1, #visited do
    output = output .. visited[i] .. ","
end
print(string.sub(output, 1, #output - 1))
```
**输出：v1,v2,v6,v7,v8,v5,v3,v9,v4**

