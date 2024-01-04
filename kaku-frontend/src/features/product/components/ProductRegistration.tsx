"use client"
import React, { useState, FormEvent, ChangeEvent} from 'react';
import {useRouter} from 'next/navigation';

const ProductRegistration: React.FC = () => {
  const [name, setName] = useState<string>('');
  const [price, setPrice] = useState<string>('');
  const [description, setDescription] = useState<string>('');
  const [error, setError] = useState<string>('');

  const router = useRouter();

  const handleRegistration = async (event: FormEvent<HTMLFormElement>) => {
    event.preventDefault();
    try {
      const response = await fetch(process.env.NEXT_PUBLIC_RAILS_API_URL +"/v1/products", {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          product: {
            name,
            price,
            description
          }
        }),
      });
      if (response.ok) {
        const data = await response.json();
        router.push(`/`);
      }else{
        console.log("error");
        const errorData = await response.json();
        setError(errorData.errors || 'Registration failed');
      }
    } catch (err) {
      console.log("network error");
    }
  }

  return (
    <form onSubmit={handleRegistration} className="max-w-xl mx-auto my-8 p-4 shadow-md rounded-lg">
      <div className="mb-4">
        <label htmlFor="name" className="block text-gray-700 text-sm font-bold mb-2">Name:</label>
        <input
          type="text"
          id="name"
          className="shadow appearance-none border border-black rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
          value={name}
          onChange={(e) => setName(e.target.value)}
          required
        />
      </div>
      <div className="mb-4">
        <label htmlFor="price" className="block text-gray-700 text-sm font-bold mb-2">Price:</label>
        <input
          type="text"
          id="price"
          className="shadow appearance-none border border-black rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
          value={price}
          onChange={(e) => setPrice(e.target.value)}
          required
        />
      </div>
      <div className="mb-4">
        <label htmlFor="description" className="block text-gray-700 text-sm font-bold mb-2">Description:</label>
        <textarea
          id="description"
          className="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
          value={description}
          onChange={(e) => setDescription(e.target.value)}
          required
        />
      </div>
      <button type="submit" className="bg-blue-500 hover:bg-blue-700 text-gray-700 font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline">
        登録
      </button>
      {error && <p className="text-red-500 text-xs italic">{error}</p>}
    </form>
  );
}

export default ProductRegistration;