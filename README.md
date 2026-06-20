# MilkTea-ArkTS

基于 ArkTS / HarmonyOS / ArkUI 开发的奶茶点单应用项目。

## 项目信息

- 项目名称：MilkTea-ArkTS
- 技术栈：ArkTS、HarmonyOS、ArkUI
- Bundle Name：com.liuyuping.milktea
- Version：1.0.0
- Build ID：milktea-20260620-001

## 主要功能

- 首页商品展示
- 菜单浏览
- 商品详情
- 购物车
- 优惠券
- 订单页面
- 搜索页面
- 我的页面
- 登录页面

## 项目结构

```text
MilkTea/
├── AppScope/
│   ├── app.json5
│   └── resources/
├── entry/
│   ├── src/
│   │   └── main/
│   │       ├── ets/
│   │       │   ├── common/
│   │       │   │   └── AppInfo.ets
│   │       │   ├── entryability/
│   │       │   │   └── EntryAbility.ets
│   │       │   ├── entrybackupability/
│   │       │   │   └── EntryBackupAbility.ets
│   │       │   └── pages/
│   │       │       ├── Index.ets
│   │       │       ├── HomePage.ets
│   │       │       ├── LoginPage.ets
│   │       │       ├── MenuPage.ets
│   │       │       ├── DetailPage.ets
│   │       │       ├── CartPage.ets
│   │       │       ├── CouponPage.ets
│   │       │       ├── OrderPage.ets
│   │       │       ├── SearchPage.ets
│   │       │       └── MinePage.ets
│   │       └── resources/
│   └── module.json5
├── README.md
├── LICENSE
├── .gitignore
├── oh-package.json5
├── build-profile.json5
└── hvigorfile.ts
```

## License

Copyright (c) 2026 Liu Yuping.  
All rights reserved.