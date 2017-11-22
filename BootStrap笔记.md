# BootStrap笔记

## 1.响应式分界点

①xs：<576px，Extra small（portrait phones）

②sm：576px--768px，Small（landscape phones）

③md：768px--992px，Medium（tablets）

④lg：992px--1200px，Large（desktops）

⑤xl：>1200px，Extra large（large desktops）

实现方式为：

```
media (min-width: 576px) { ... }
```

或者

```
include media-breakpoint-up(sm) { ... }
```

即基于宽度的最小值，意味着它们应用到某一等级以及该等级之上的所有等级（比如：`.col-sm-4`应用到小、中、大、特大设备）