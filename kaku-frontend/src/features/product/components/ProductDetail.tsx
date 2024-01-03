'use client';
import {Product} from '../types/Product';
import {getProduct} from '../api/get-product';
import React, { useState, useEffect} from 'react';
import { useRouter } from 'next/navigation';

const ProductDetail: React.FC<{id: string}> = ({id}) => {
    const [product, setProduct] = useState<Product>({id: '', name: '', price: 0, description: '', image_url: ''});
    const [error, setError] = useState<string>();
    const router = useRouter();

    useEffect(() => {
      const fetchProduct = async () => {
        try {
          const product = await getProduct(id);
          setProduct(product);
        }catch (error) {
          setError("商品情報の取得に失敗しました。");
        }
      };
      fetchProduct();
    }, []);

    return (
      <div>
        <h1>[商品詳細]</h1>
        <ul>
          <li key={product.id}>
            {product.name} - {product.price} <br />
            <img src={product.image_url} width="200" height="200" />
            {product.description}
          </li>
        </ul>
        {error && <p>{error}</p>}
        <button onClick={() => router.back()}>戻る</button>
      </div>
    )
}

export default ProductDetail;