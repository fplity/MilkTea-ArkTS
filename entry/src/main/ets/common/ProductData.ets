export interface ProductInfo {
  id: number
  name: string
  category: string      // 中文类别
  categoryCode: string  // 对应英文编码
  price: number
  image: Resource
  desc: string
  tag?: string
  detail?: string
}

export const productList: ProductInfo[] = [
  {
    id: 1,
    name: '珍珠奶茶',
    category: '奶茶',
    categoryCode: 'milkTea',
    price: 18,
    image: $r('app.media.product1'),
    desc: '经典奶茶，香浓顺滑',
    tag: '经典热卖',
    detail: '经典珍珠奶茶，茶香与奶香融合，珍珠Q弹有嚼劲。'
  },
  {
    id: 2,
    name: '鲜果百香绿茶',
    category: '果茶',
    categoryCode: 'fruitTea',
    price: 20,
    image: $r('app.media.product2'),
    desc: '百香果香，绿茶清爽',
    tag: '清爽果香',
    detail: '鲜果百香绿茶酸甜清爽，搭配绿茶茶底，适合夏天饮用。'
  },
  {
    id: 3,
    name: '草莓奶油蛋糕',
    category: '甜品',
    categoryCode: 'dessert',
    price: 22,
    image: $r('app.media.product3'),
    desc: '草莓香甜，奶油细腻',
    tag: '甜品推荐',
    detail: '草莓奶油蛋糕口感松软，奶油细腻，草莓酸甜清新。'
  },
  {
    id: 4,
    name: '生椰拿铁',
    category: '咖啡',
    categoryCode: 'coffee',
    price: 20,
    image: $r('app.media.product4'),
    desc: '椰香浓郁，咖啡顺滑',
    tag: '椰香咖啡',
    detail: '生椰拿铁融合椰乳和咖啡香气，入口顺滑，椰香自然。'
  },
  {
    id: 5,
    name: '冰美式',
    category: '咖啡',
    categoryCode: 'coffee',
    price: 16,
    image: $r('app.media.product5'),
    desc: '冰爽提神，口感清爽',
    tag: '清爽提神',
    detail: '冰美式口感干净清爽，咖啡香明显，适合需要提神的时候。'
  },
  {
    id: 6,
    name: '葡萄多多',
    category: '果茶',
    categoryCode: 'fruitTea',
    price: 22,
    image: $r('app.media.product6'),
    desc: '葡萄香甜，酸甜清爽',
    tag: '葡萄果香',
    detail: '葡萄多多带有浓郁葡萄香气，酸甜平衡，口感清爽。'
  },
  {
    id: 7,
    name: '芋泥波波奶茶',
    category: '奶茶',
    categoryCode: 'milkTea',
    price: 21,
    image: $r('app.media.product7'),
    desc: '芋泥绵密，波波Q弹',
    tag: '绵密芋泥',
    detail: '芋泥波波奶茶口感厚实，芋泥绵密，波波软糯Q弹。'
  },
  {
    id: 8,
    name: '茉莉奶绿',
    category: '奶茶',
    categoryCode: 'milkTea',
    price: 19,
    image: $r('app.media.product8'),
    desc: '茉莉清香，奶绿顺滑',
    tag: '茉莉清香',
    detail: '茉莉奶绿茶香清雅，奶味柔和，喝起来清爽不腻。'
  },
  {
    id: 9,
    name: '黑糖珍珠奶茶',
    category: '奶茶',
    categoryCode: 'milkTea',
    price: 20,
    image: $r('app.media.product9'),
    desc: '黑糖香甜，奶茶顺滑',
    tag: '黑糖香甜',
    detail: '黑糖珍珠奶茶带有黑糖焦香，珍珠软糯，口感浓郁。'
  },
  {
    id: 10,
    name: '奥利奥奶茶',
    category: '奶茶',
    categoryCode: 'milkTea',
    price: 19,
    image: $r('app.media.product10'),
    desc: '奥利奥碎，奶香浓郁',
    tag: '甜品奶茶',
    detail: '奥利奥奶茶加入饼干碎，带有甜品口感，奶茶顺滑香甜。'
  },
  {
    id: 11,
    name: '抹茶红豆奶茶',
    category: '奶茶',
    categoryCode: 'milkTea',
    price: 21,
    image: $r('app.media.product11'),
    desc: '抹茶清香，红豆软糯',
    tag: '抹茶红豆',
    detail: '抹茶红豆奶茶抹茶清香明显，红豆软糯香甜。'
  },
  {
    id: 12,
    name: '经典拿铁',
    category: '咖啡',
    categoryCode: 'coffee',
    price: 18,
    image: $r('app.media.product12'),
    desc: '经典拿铁，奶香柔和',
    tag: '经典咖啡',
    detail: '经典拿铁奶香柔和，咖啡香稳定，适合日常饮用。'
  },
  {
    id: 13,
    name: '卡布奇诺',
    category: '咖啡',
    categoryCode: 'coffee',
    price: 19,
    image: $r('app.media.product13'),
    desc: '奶泡绵密，咖啡香浓',
    tag: '绵密奶泡',
    detail: '卡布奇诺奶泡细腻绵密，咖啡香气浓郁，层次感明显。'
  },
  {
    id: 14,
    name: '摩卡咖啡',
    category: '咖啡',
    categoryCode: 'coffee',
    price: 21,
    image: $r('app.media.product14'),
    desc: '摩卡香浓，巧克力味',
    tag: '巧克力味',
    detail: '摩卡咖啡融合咖啡和巧克力风味，香甜浓郁。'
  },
  {
    id: 15,
    name: '焦糖玛奇朵',
    category: '咖啡',
    categoryCode: 'coffee',
    price: 22,
    image: $r('app.media.product15'),
    desc: '焦糖香甜，咖啡顺滑',
    tag: '焦糖香甜',
    detail: '焦糖玛奇朵带有焦糖香气，咖啡和奶香融合顺滑。'
  },
  {
    id: 16,
    name: '提拉米苏',
    category: '甜品',
    categoryCode: 'dessert',
    price: 28,
    image: $r('app.media.product16'),
    desc: '咖啡奶香，入口绵密',
    tag: '人气甜品',
    detail: '提拉米苏入口绵密，咖啡香与奶香融合，甜而不腻。'
  },
  {
    id: 17,
    name: '芒果布丁',
    category: '甜品',
    categoryCode: 'dessert',
    price: 18,
    image: $r('app.media.product17'),
    desc: '芒果香甜，布丁嫩滑',
    tag: '嫩滑布丁',
    detail: '芒果布丁口感嫩滑，芒果香甜明显，适合饭后甜点。'
  },
  {
    id: 18,
    name: '巧克力慕斯',
    category: '甜品',
    categoryCode: 'dessert',
    price: 24,
    image: $r('app.media.product18'),
    desc: '慕斯丝滑，巧克力香',
    tag: '丝滑慕斯',
    detail: '巧克力慕斯细腻丝滑，巧克力香浓，口感柔软。'
  },
  {
    id: 19,
    name: '原味芝士蛋糕',
    category: '甜品',
    categoryCode: 'dessert',
    price: 22,
    image: $r('app.media.product19'),
    desc: '芝士香浓，入口细腻',
    tag: '芝士香浓',
    detail: '原味芝士蛋糕芝士香气浓郁，入口细腻，奶香充足。'
  },
  {
    id: 20,
    name: '奶油泡芙',
    category: '甜品',
    categoryCode: 'dessert',
    price: 16,
    image: $r('app.media.product20'),
    desc: '外皮酥香，奶油顺滑',
    tag: '香甜泡芙',
    detail: '奶油泡芙外皮酥香，内馅奶油顺滑甜美，口感松软。'
  },
  {
    id: 21,
    name: '满杯百香果',
    category: '果茶',
    categoryCode: 'fruitTea',
    price: 22,
    image: $r('app.media.product21'),
    desc: '百香果香，酸甜清爽',
    tag: '百香果香',
    detail: '满杯百香果香甜清爽，酸甜适中，适合消暑。'
  },
  {
    id: 22,
    name: '蜜桃乌龙茶',
    category: '果茶',
    categoryCode: 'fruitTea',
    price: 20,
    image: $r('app.media.product22'),
    desc: '蜜桃清甜，乌龙茶香',
    tag: '蜜桃乌龙',
    detail: '蜜桃乌龙茶甜中带香，乌龙茶底香气悠长。'
  },
  {
    id: 23,
    name: '柠檬茉莉茶',
    category: '果茶',
    categoryCode: 'fruitTea',
    price: 18,
    image: $r('app.media.product23'),
    desc: '柠檬清爽，茉莉清香',
    tag: '柠檬茉莉',
    detail: '柠檬茉莉茶酸甜适口，茉莉清香怡人。'
  },
  {
    id: 24,
    name: '葡萄芝士茶',
    category: '果茶',
    categoryCode: 'fruitTea',
    price: 24,
    image: $r('app.media.product24'),
    desc: '葡萄香甜，芝士浓郁',
    tag: '葡萄芝士',
    detail: '葡萄芝士茶香甜醇厚，芝士与葡萄的结合新奇美味。'
  },
  {
    id: 25,
    name: '西瓜冰茶',
    category: '果茶',
    categoryCode: 'fruitTea',
    price: 19,
    image: $r('app.media.product25'),
    desc: '西瓜清甜，冰爽解渴',
    tag: '西瓜冰爽',
    detail: '西瓜冰茶清凉解渴，西瓜香甜，与茶完美融合。'
  },
  {
    id: 26,
    name: '杨枝甘露',
    category: '果茶',
    categoryCode: 'fruitTea',
    price: 20,
    image: $r('app.media.product26'),
    desc: '芒果清甜，椰香浓郁',
    tag: '杨枝甘露',
    detail: '杨枝甘露芒果和椰香完美融合，清甜而香浓。'
  }
]

// 按 id 获取单个商品
export function getProductById(id: number): ProductInfo | undefined {
  return productList.find((item) => item.id === id)
}

// 按 id 获取商品，找不到时回到首个商品，避免页面重复写兜底逻辑
export function getProductByIdOrFirst(id: number): ProductInfo {
  const product: ProductInfo | undefined = getProductById(id)
  return product !== undefined ? product : productList[0]
}

// 按 id 列表获取商品，自动跳过不存在的 id
export function getProductsByIds(ids: number[]): ProductInfo[] {
  const result: ProductInfo[] = []

  ids.forEach((id: number) => {
    const product: ProductInfo | undefined = getProductById(id)

    if (product !== undefined) {
      result.push(product)
    }
  })

  return result
}

// 将分类编码转成中文分类；如果本身就是中文分类则原样返回
export function getCategoryName(category: string): string {
  const product: ProductInfo | undefined = productList.find(
    (item: ProductInfo) => item.categoryCode === category
  )

  return product !== undefined ? product.category : category
}

// 按类别（中文或英文编码）获取商品列表
export function getProductsByCategory(category: string): ProductInfo[] {
  return productList.filter(
    (item) => item.category === category || item.categoryCode === category
  )
}
