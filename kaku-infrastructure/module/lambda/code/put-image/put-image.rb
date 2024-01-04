require 'json'
require 'aws-sdk-s3'
require 'base64'

def lambda_handler(event:, context:)
  s3 = Aws::S3::Resource.new(region: 'ap-northeast-1')
  bucket = s3.bucket('kaku-public-bucket-static-contents')

  image_data = Base64.decode64(event['image_file'])
  file_name = "#{Time.now.to_i}.png"

  obj = bucket.object(file_name)
  obj.put(body: image_data)

  image_url = obj.public_url

  { statusCode: 200, body: JSON.generate({ url: image_url }) }
end

# require 'json'

# def lambda_handler(event:, context:)
#   # レスポンスメッセージを定義
#   message = "Hello from Lambda!"

#   # JSON形式でレスポンスを返す
#   { statusCode: 200, body: JSON.generate(message: message) }
# end

# def lambda_handler(event:, context:)
#   begin
#     s3 = Aws::S3::Resource.new(region: 'ap-northeast-1')
#     bucket = s3.bucket('kaku-public-bucket-static-contents')

#     # 画像データのBase64デコード
#     image_data = Base64.decode64(event['image_file'])
#     file_name = "#{Time.now.to_i}.png"

#     # S3に画像をアップロード
#     obj = bucket.object(file_name)
#     obj.put(body: image_data, acl: 'public-read')

#     # アップロードされた画像のURLを取得
#     image_url = obj.public_url

#     # 正常なレスポンス
#     { statusCode: 200, body: JSON.generate({ url: image_url }) }
#   rescue StandardError => e
#     # エラーレスポンス
#     { statusCode: 500, body: JSON.generate({ error: e.message }) }
#   end
# end