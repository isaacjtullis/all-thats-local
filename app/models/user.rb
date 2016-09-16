class User < ActiveRecord::Base
  has_many :reviews
  has_many :comments

  validates_presence_of :first_name
  validates_presence_of :last_name
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def admin?
   role == 'admin'
  end


end
