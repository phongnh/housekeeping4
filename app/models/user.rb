# encoding: utf-8
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

  def account_summary
    accounts = self.accounts.all
    #accounts_hash = accounts.inject({}) { |h, a| h[a.id] = a; h }
    summary = Transaction.where :account_id => accounts.map(&:id)
    on_transaction = summary.group(:kind)

    # Returning data is Ordered Hash
    #on_account = summary.group([:account_id, :kind]).sum(:amount)
    account_summaries = ActiveSupport::OrderedHash.new

    accounts.each do |a|
      account_summaries[a.id] = {
        #:name => a.name, INCOME => 0, EXPENSE => 0
        :name => a.name, INCOME => a.income, EXPENSE => a.expense
      }
    end
    #on_account.each do |aid_kind, amount|
      #account_summaries[aid_kind.first][aid_kind.last] = amount
    #end

    now = DateTime.now
    default_summary = { INCOME => 0, EXPENSE => 0 }
    this_year_summary = on_transaction.where(:year => now.year)
    this_month_summary = this_year_summary.where(:month => now.month)
    today_summary = this_month_summary.where(:day => now.day)
    transaction_summaries = ActiveSupport::OrderedHash.new
    transaction_summaries[:today]      = default_summary.merge today_summary.sum(:amount)
    transaction_summaries[:this_month] = default_summary.merge this_month_summary.sum(:amount)
    transaction_summaries[:this_year]  = default_summary.merge this_year_summary.sum(:amount)

    [account_summaries, transaction_summaries]
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

