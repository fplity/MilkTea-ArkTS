export interface ProductInfo {
  id: number
  name: string
  category: string
  categoryCode: string
  price: number
  image: Resource
  desc: string
  tag?: string
  detail?: string
}

function createProduct(id: number, name: string, category: string, categoryCode: string, price: number, image: Resource, desc: string, tag: string, detail: string): ProductInfo {
  return { id, name, category, categoryCode, price, image, desc, tag, detail }
}

export const productList: ProductInfo[] = [
  createProduct(1, '珍珠奶茶', '奶茶', 'milkTea', 18, $r('app.media.product1'), '经典奶茶，香浓顺滑', '经典热卖', '经典珍珠奶茶，茶香与奶香融合，珍珠Q弹有嚼劲。'),
  createProduct(2, '鲜果百香绿茶', '果茶', 'fruitTea', 20, $r('app.media.product2'), '百香果香，绿茶清爽', '清爽果香', '鲜果百香绿茶酸甜清爽，搭配绿茶茶底，适合夏天饮用。'),
  createProduct(3, '草莓奶油蛋糕', '甜品', 'dessert', 22, $r('app.media.product3'), '草莓香甜，奶油细腻', '甜品推荐', '草莓奶油蛋糕口感松软，奶油细腻，草莓酸甜清新。'),
  createProduct(4, '生椰拿铁', '咖啡', 'coffee', 20, $r('app.media.product4'), '椰香浓郁，咖啡顺滑', '椰香咖啡', '生椰拿铁融合椰乳和咖啡香气，入口顺滑，椰香自然。'),
  createProduct(5, '冰美式', '咖啡', 'coffee', 16, $r('app.media.product5'), '冰爽提神，口感清爽', '清爽提神', '冰美式口感干净清爽，咖啡香明显，适合需要提神的时候。'),
  createProduct(6, '葡萄多多', '果茶', 'fruitTea', 22, $r('app.media.product6'), '葡萄香甜，酸甜清爽', '葡萄果香', '葡萄多多带有浓郁葡萄香气，酸甜平衡，口感清爽。'),
  createProduct(7, '芋泥波波奶茶', '奶茶', 'milkTea', 21, $r('app.media.product7'), '芋泥绵密，波波Q弹', '绵密芋泥', '芋泥波波奶茶口感厚实，芋泥绵密，波波软糯Q弹。'),
  createProduct(8, '茉莉奶绿', '奶茶', 'milkTea', 19, $r('app.media.product8'), '茉莉清香，奶绿顺滑', '茉莉清香', '茉莉奶绿茶香清雅，奶味柔和，喝起来清爽不腻。'),
  createProduct(9, '黑糖珍珠奶茶', '奶茶', 'milkTea', 20, $r('app.media.product9'), '黑糖香甜，奶茶顺滑', '黑糖香甜', '黑糖珍珠奶茶带有黑糖焦香，珍珠软糯，口感浓郁。'),
  createProduct(10, '奥利奥奶茶', '奶茶', 'milkTea', 19, $r('app.media.product10'), '奥利奥碎，奶香浓郁', '甜品奶茶', '奥利奥奶茶加入饼干碎，带有甜品口感，奶茶顺滑香甜。'),
  createProduct(11, '抹茶红豆奶茶', '奶茶', 'milkTea', 21, $r('app.media.product11'), '抹茶清香，红豆软糯', '抹茶红豆', '抹茶红豆奶茶抹茶清香明显，红豆软糯香甜。'),
  createProduct(12, '经典拿铁', '咖啡', 'coffee', 18, $r('app.media.product12'), '经典拿铁，奶香柔和', '经典咖啡', '经典拿铁奶香柔和，咖啡香稳定，适合日常饮用。'),
  createProduct(13, '卡布奇诺', '咖啡', 'coffee', 19, $r('app.media.product13'), '奶泡绵密，咖啡香浓', '绵密奶泡', '卡布奇诺奶泡细腻绵密，咖啡香气浓郁，层次感明显。'),
  createProduct(14, '摩卡咖啡', '咖啡', 'coffee', 21, $r('app.media.product14'), '摩卡香浓，巧克力味', '巧克力味', '摩卡咖啡融合咖啡和巧克力风味，香甜浓郁。'),
  createProduct(15, '焦糖玛奇朵', '咖啡', 'coffee', 22, $r('app.media.product15'), '焦糖香甜，咖啡顺滑', '焦糖香甜', '焦糖玛奇朵带有焦糖香气，咖啡和奶香融合顺滑。'),
  createProduct(16, '提拉米苏', '甜品', 'dessert', 28, $r('app.media.product16'), '咖啡奶香，入口绵密', '人气甜品', '提拉米苏入口绵密，咖啡香与奶香融合，甜而不腻。'),
  createProduct(17, '芒果布丁', '甜品', 'dessert', 18, $r('app.media.product17'), '芒果香甜，布丁嫩滑', '嫩滑布丁', '芒果布丁口感嫩滑，芒果香甜明显，适合饭后甜点。'),
  createProduct(18, '巧克力慕斯', '甜品', 'dessert', 24, $r('app.media.product18'), '慕斯丝滑，巧克力香', '丝滑慕斯', '巧克力慕斯细腻丝滑，巧克力香浓，口感柔软。'),
  createProduct(19, '原味芝士蛋糕', '甜品', 'dessert', 22, $r('app.media.product19'), '芝士香浓，入口细腻', '芝士香浓', '原味芝士蛋糕芝士香气浓郁，入口细腻，奶香充足。'),
  createProduct(20, '奶油泡芙', '甜品', 'dessert', 16, $r('app.media.product20'), '外皮酥香，奶油顺滑', '香甜泡芙', '奶油泡芙外皮酥香，内馅奶油顺滑甜美，口感松软。'),
  createProduct(21, '满杯百香果', '果茶', 'fruitTea', 22, $r('app.media.product21'), '百香果香，酸甜清爽', '百香果香', '满杯百香果香甜清爽，酸甜适中，适合消暑。'),
  createProduct(22, '蜜桃乌龙茶', '果茶', 'fruitTea', 20, $r('app.media.product22'), '蜜桃清甜，乌龙茶香', '蜜桃乌龙', '蜜桃乌龙茶甜中带香，乌龙茶底香气悠长。'),
  createProduct(23, '柠檬茉莉茶', '果茶', 'fruitTea', 18, $r('app.media.product23'), '柠檬清爽，茉莉清香', '柠檬茉莉', '柠檬茉莉茶酸甜适口，茉莉清香怡人。'),
  createProduct(24, '葡萄芝士茶', '果茶', 'fruitTea', 24, $r('app.media.product24'), '葡萄香甜，芝士浓郁', '葡萄芝士', '葡萄芝士茶香甜醇厚，芝士与葡萄的结合新奇美味。'),
  createProduct(25, '西瓜冰茶', '果茶', 'fruitTea', 19, $r('app.media.product25'), '西瓜清甜，冰爽解渴', '西瓜冰爽', '西瓜冰茶清凉解渴，西瓜香甜，与茶完美融合。'),
  createProduct(26, '杨枝甘露', '果茶', 'fruitTea', 20, $r('app.media.product26'), '芒果清甜，椰香浓郁', '杨枝甘露', '杨枝甘露芒果和椰香完美融合，清甜而香浓。')
]

export function getProductById(id: number): ProductInfo | undefined {
  return productList.find((item: ProductInfo) => item.id === id)
}

export function getProductByIdOrFirst(id: number): ProductInfo {
  const product: ProductInfo | undefined = getProductById(id)
  return product !== undefined ? product : productList[0]
}

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

export function getCategoryName(category: string): string {
  const product: ProductInfo | undefined = productList.find(
    (item: ProductInfo) => item.categoryCode === category
  )
  return product !== undefined ? product.category : category
}

export function getProductsByCategory(category: string): ProductInfo[] {
  return productList.filter(
    (item: ProductInfo) => item.category === category || item.categoryCode === category
  )
}
