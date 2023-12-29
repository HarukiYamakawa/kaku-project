'use client';
import {Product} from '../types/Product';
import {getProduct} from '../api/get-product';
import React, { useState, useEffect } from 'react';

const ProductDetail: React.FC<{id: string}> = ({id}) => {
    const [product, setProduct] = useState<Product>({id: '', name: '', price: 0, description: '', image_url: ''});
    const [error, setError] = useState<string>();

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
            {product.description}
          </li>
        </ul>
        {error && <p>{error}</p>}
      </div>
    )
}

export default ProductDetail;