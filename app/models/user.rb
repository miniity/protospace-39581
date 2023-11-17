class User < ApplicationRecord
#   :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :validatable
    has_many :prototypes
    has_many :comments

#  class User < ApplicationRecord
    validates :profile, presence: true
    validates :name, presence: true
    validates :email, presence: true, uniqueness: true
    validates :password, length: { minimum: 6 }
#  end

end
