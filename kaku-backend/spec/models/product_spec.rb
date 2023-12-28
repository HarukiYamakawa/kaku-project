require 'rails_helper'

RSpec.describe Product do
  let!(:product) { build(:product) }

  describe 'バリデーション' do
    context '有効な属性値の場合' do
      it '正常に登録できること' do
        expect(product).to be_valid
      end
    end

    context 'nameが空白の場合' do
      it '無効であること' do
        product.name = nil
        expect(product).not_to be_valid
      end
    end

    context 'priceが空白の場合' do
      it '無効であること' do
        product.price = nil
        expect(product).not_to be_valid
      end
    end

  end
end
