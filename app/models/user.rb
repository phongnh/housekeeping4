# == Schema Information
#
# Table name: users
#
#  id                     :integer         not null, primary key
#  email                  :string(255)     default(""), not null
#  encrypted_password     :string(128)     default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer         default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  first_name             :string(255)
#  last_name              :string(255)
#  gender                 :integer         default(0)
#  birthday               :datetime
#  created_at             :datetime
#  updated_at             :datetime
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, #:confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :email, :first_name, :last_name, :password, :password_confirmation,
            :presence => true
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :first_name, :last_name,
                  :password, :password_confirmation, :remember_me

  has_many :accounts, :foreign_key => :owner_id

  def name(locale=I18n.locale)
    full_name =
      if I18n.locale == :vi
        [last_name, first_name]
      else
        [first_name, last_name]
      end
    full_name.compact.join(" ")
  end

  def self.seed
    self.create :email                 => "nhphong1406@gmail.com",
                :first_name            => "Phong",
                :last_name             => "Nguyễn Hoài",
                :password              => "056113",
                :password_confirmation => "056113"

    self.create :email                 => "trinhtran1905@gmail.com",
                :first_name            => "Trinh",
                :last_name             => "Trần Mỹ",
                :password              => "056113",
                :password_confirmation => "056113"
  end

end

