import { Product } from '../types/Product';
export const getProductList = async (): Promise<Product[]> => {
  try {
    const response = await fetch(process.env.NEXT_PRIVATE_RAILS_API_URL + '/v1/products', { cache: 'no-store' });
    if (!response.ok) {
      throw new Error('サーバーエラーが発生しました');
    }

    const data = await response.json();
    return data;
  } catch (error) {
    console.error(error);
    throw error;
  }
}