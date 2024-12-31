---
title: A*寻路算法（lua）
author: epya15
tags:
  - 算法
categories:
  - 算法
date: 2024-03-26 00:00:00
excerpt: ''
---



参考资料：

https://www.cnblogs.com/f-society/p/6818665.html

https://www.jianshu.com/p/a8950fa19b72



#### 举例：

现有如下寻路网格，求从A点（5, 1）到B点（5, 9）的A*路径

![202403262023420](A星寻路算法（lua）/202403262023420.png)

灰色代表不可到达的格子，每次行动可以从格子的周围8个方向行进，代价如下图

![202403262031588](A星寻路算法（lua）/202403262031588.png)

不可穿越斜墙，例如下图中，从P点出发的8个方向里，标记为"NO"的点是不可直接到达的

![202403262037831](A星寻路算法（lua）/202403262037831.png)



算法代码

```lua
--定义方法，从列表中移除指定元素
local removeFromList = function(nodeList, element)
    for i = 1, #nodeList do
        if nodeList[i] == element then
            table.remove(nodeList, i)
            break
        end
    end
end

--定义方法：在列表中查找指定nodeIndex的元素
local findNodeByIndex = function(nodeList, nodeIndex)
    for i = 1, #nodeList do
        if nodeList[i].index == nodeIndex then
            return nodeList[i]
        end
    end
    return nil
end

--定义方法：判断列表是否存在指定元素
local contains = function(nodeList, nodeIndex)
    return findNodeByIndex(nodeList, nodeIndex) ~= nil
end

--定义方法：查找list中F值最小的结点
local findMinFNode = function(nodeList)
    local minF = math.maxinteger
    local minFNode = nil
    for i = 1, #nodeList do
        local n = nodeList[i]
        local F = n.G + n.H
        if F < minF then
            minF = F
            minFNode = n
        end
    end
    return minFNode
end

--构造一个node数据结构
local node = function(index, preNodeIndex, G, H)
    if index == nil then index = 0 end
    if preNodeIndex == nil then preNodeIndex = 0 end
    if G == nil then G = 0 end
    if H == nil then H = 0 end
    local n =
    {
        index = index,
        preNodeIndex = preNodeIndex,
        G = G,
        H = H,
    }
    return n
end

--构建9x9地图（用一维数组描述）
local map = 
{
    1,0,1,1,1,0,1,1,1,
    1,0,1,0,1,1,1,0,1,
    1,1,1,0,1,1,0,1,1,
    1,1,0,0,0,0,0,1,1,
    1,1,1,1,1,1,0,1,1,
    1,1,0,1,0,1,0,1,1,
    1,1,0,1,0,1,1,0,1,
    1,0,0,1,1,0,0,1,1,
    1,1,1,1,1,1,1,1,1,
}

local mapH = 9				--地图的横宽（Horizontal）
local mapV = #map / mapH	--地图的纵高（Vertical）
local mapDataLength = #map

local openList = {}		--搜索域（开启列表，存放待搜索的结点）
local closeList = {}	--已搜索域（关闭列表，存放已搜索的结点）

local startNodeIndex = 37		--指定一个起点
local endNodeIndex = 45			--指定一个终点
local openObliqueCheck = true	--是否开启斜墙判断，比如结点的上结点和右节点是墙，那右上结点就算不是墙，也不可通行
local minFNode = nil			--临时变量

--定义方法：计算一个结点的H值（这里使用曼哈顿距离，H = 当前结点到结束点的水平距离 + 当前结点到结束点的垂直距离）
local calculateH = function(nodeIndex)
    local projectedXEnd = (endNodeIndex - 1) % mapH + 1		--取endNodeIndex在首行的投影，例如  44->8  45->9  46->1
    local projectedXNode = (nodeIndex - 1) % mapH + 1		--取nodeIndex在首行的投影
    local projectedYEnd = endNodeIndex - (endNodeIndex - 1) % mapH	--取endNodeIndex在所在行首列的投影，例如  44->37  45->37  46->46
    local projectedYNode = nodeIndex - (nodeIndex - 1) % mapH		--取nodeIndex在所在行首列的投影
    local xDis = math.abs(projectedXEnd - projectedXNode)				--计算两点的水平距离
    local yDis = math.abs(projectedYEnd - projectedYNode) / mapH		--计算两点垂直距离
    return xDis + yDis
end

--定义方法：判断一个点是否是可通行的
local isReachable = function(nodeIndex)
    return nodeIndex > 0 and nodeIndex <= mapDataLength and map[nodeIndex] > 0
end

--初始化数据
table.insert(openList, node(startNodeIndex, -1, 0, calculateH(startNodeIndex)))	--首先把起点放进搜索域

repeat
    --在openList中查找F（F = G + H）值最低的结点
    minFNode = findMinFNode(openList)
    --遍历这个结点周围一圈8个结点，筛选出可行进的+未在开启列表+未在关闭列表的结点，放入开启列表
    --使用便于理解的命名方式
    local upLeft = minFNode.index - mapH - 1	--左上点（值<1代表已越界）
    if upLeft % mapH == 0 then upLeft = -1 end	--minFNode位于最左边时，左上点不存在
    local up = minFNode.index - mapH			--上点（值<1代表已越界）
    local upRight = minFNode.index - mapH + 1	--右上点（值<1代表已越界）
    if upRight % mapH == 1 then upRight = -1 end--minFNode位于最右边时，右上点不存在
    local left = minFNode.index - 1				--左点（值<1代表已越界）
    if left % mapH == 0 then left = -1 end		--minFNode位于最左边时，左点不存在
    local right = minFNode.index + 1			--右点（值>mapDataLength代表已越界）
    if right % mapH == 1 then right = -1 end	--minFNode位于最右边时，右点不存在
    local bottomLeft = minFNode.index + mapH - 1--左下点（值>mapDataLength代表已越界）
    if bottomLeft % mapH == 0 then bottomLeft = -1 end	--minFNode位于最左边时，左下点不存在
    local bottom = minFNode.index + mapH		--下点（值>mapDataLength代表已越界）
    local bottomRight = minFNode.index + mapH + 1--右下点（值>mapDataLength代表已越界）
    if bottomRight % mapH == 1 then bottomRight = -1 end--minFNode位于最右边时，右下点不存在

    --放入列表
    local neighborList = {upLeft, up, upRight, left, right, bottomLeft, bottom, bottomRight}

    --斜墙判断
    local obliqueReachableList = {1,1,1,1,1,1,1,1}		--和neighborList一样按照从左至右，从上至下记录周围结点是否可达
    if openObliqueCheck then
        local isReachable_up = isReachable(up)
        local isReachable_left = isReachable(left)
        local isReachable_right = isReachable(right)
        local isReachable_bottom = isReachable(bottom)
        if (not isReachable_left) and (not isReachable_up) then obliqueReachableList[1] = 0 end		--左上角不可达
        if (not isReachable_up) and (not isReachable_right) then obliqueReachableList[3] = 0 end		--右上角不可达
        if (not isReachable_left) and (not isReachable_bottom) then obliqueReachableList[6] = 0 end	--左下角不可达
        if (not isReachable_bottom) and (not isReachable_right) then obliqueReachableList[8] = 0 end	--右下角不可达
    end

    for i = #neighborList, 1, -1 do
        --剔除越界的点，剔除不可通行的点，剔除已在开放列表的点，剔除已在关闭列表的点
        local n = neighborList[i]
        local reachable = isReachable(n)
        if (not reachable) or obliqueReachableList[i] == 0 or contains(openList, n) or contains(closeList, n) then
            table.remove(neighborList, i)
        else
            --计算好G和H值后放入openList中（上下左右步长按1计算，四个角按照1.414计算）
            local stepValue = 1
            if i == 1 or i == 3 or i == 6 or i == 8 then stepValue = 1.414 end
            local node = node(n, minFNode.index, minFNode.G + stepValue, calculateH(n))
            table.insert(openList, node)
        end
    end
    --把minFNode从openList转移到closeList中
    removeFromList(openList, minFNode)
    table.insert(closeList, minFNode)

until(minFNode.index == endNodeIndex or #openList == 0)	--当openList为空或者找到终点时，算法结束

--在closeList中取endNode进行回溯，直到找到startNode，再将这条回溯链路反转即为从startNode到endNode的A*寻路结果
local nodeIndex = endNodeIndex
local path = {}		--记录最短路径的结点
if contains(closeList, nodeIndex) then
    while true do
        node = findNodeByIndex(closeList, nodeIndex)
        table.insert(path, node)
        nodeIndex = node.preNodeIndex
        if nodeIndex == -1 then
            break
        end
    end
    --结果输出

    --定义方法：将一维数组的index转为更容易看的二维坐标
    local toVectorFormat = function(index)
        local x = index%mapH
        if x == 0 then x = mapH end
        return "("..math.ceil(index/mapH)..", "..x..")"
    end
    local output = "A* path from "..toVectorFormat(startNodeIndex).." to "..toVectorFormat(endNodeIndex)
    .. " distance is "..findNodeByIndex(closeList, endNodeIndex).G.." \n"
    for i = #path, 1, -1 do
        local str = toVectorFormat(path[i].index)
        output = output .. str .. " -> "
    end
    print(string.sub(output, 1, #output - 4))
else
    print("no path found in map.")
end
```

程序输出（不开启斜墙判断）：

```
A* path from (5, 1) to (5, 9) distance is 9.656 
(5, 1) -> (5, 2) -> (5, 3) -> (5, 4) -> (5, 5) -> (6, 6) -> (7, 7) -> (6, 8) -> (5, 9)
```

路线图：

![202403262035009](A星寻路算法（lua）/202403262035009.png)



程序输出（开启斜墙判断）：

```
A* path from (5, 1) to (5, 9) distance is 13.07 
(5, 1) -> (5, 2) -> (5, 3) -> (6, 4) -> (7, 4) -> (8, 5) -> (9, 6) -> (9, 7) -> (8, 8) -> (7, 9) -> (6, 9) -> (5, 9)
```

路线图：

![202403262039158](A星寻路算法（lua）/202403262039158.png)
