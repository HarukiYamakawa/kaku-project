import {Product} from '../types/Product';
import {getProductList} from '../api/get-product-list';

const ProductList = async () => {
  try {
    const productList = await getProductList();
    console.log(productList);
    return (
      <div>
        <h1>[商品一覧]</h1>
        <ul>
          {productList.map((product: Product) => (
            <li key={product.id}>
              {product.name} - {product.price}
            </li>
          ))}
        </ul>
      </div>
    )
  }catch (error) {
    console.log(error);
    return (
      <div>
        <h1>商品一覧</h1>
        <p>商品一覧の取得に失敗しました。</p>
      </div>
    )
  }
}
export default ProductList;