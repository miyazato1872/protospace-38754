class Prototype < ApplicationRecord
  belongs_to :user
  has_one_attached :image  #モデル.ファイル名で、添付されたファイルにアクセスできるようになります。また、このファイル名は、そのモデルが紐づいたフォームから送られるパラメーターのキーにもなる
  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :catch_copy, presence: true
  validates :concept, presence: true
  validates :image, presence: true
end
