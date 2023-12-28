# Productsのシードデータ
products = [
  { name: "蜜柑", price: 500, description: "果物です", image_url: "#" },
  { name: "餅", price: 600, description: "穀物です", image_url: "#" },
  { name: "ナッツ", price: 700, description: "種実です", image_url: "#" },
  { name: "栄螺", price: 800, description: "貝類です", image_url: "#" },
]

# データベースに追加
products.each do |product|
  Product.create!(product)
end