// Footer.test.js
import React from 'react';
import { render, screen } from '@testing-library/react';
import '@testing-library/jest-dom';
import Footer from './Footer'; // Footer コンポーネントのパスを適切に設定してください

describe('Footer Component', () => {
  it('renders the footer with the correct text', () => {
    render(<Footer />);

    // フッター内のテキストが表示されているか確認
    const footerText = screen.getByText('Kaku-2023');
    expect(footerText).toBeInTheDocument();
  });
});