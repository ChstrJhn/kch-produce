class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

      devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, 
         :confirmable, :omniauthable, :omniauth_providers => [:facebook]

  validates :fullname, presence: true, length: {maximum: 50}

  has_many :products
  has_many :user_photos
  has_many :orders
  has_one :profile_image


  def self.from_omniauth(auth)
  	user = User.where(:email => auth.info.email).first

  	if user
  	  return user
  	else
  	  where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
  	  user.fullname = auth.info.name
  	  user.provider = auth.provider
  	  user.uid = auth.uid
  	  user.email = auth.info.email
      user.image = auth.info.image
  	  user.password = Devise.friendly_token[0, 20]
  	 end
  	end

  end

  def update_with_password(params={})
    if params[:password].blank?
      params.delete(:current_password)
      self.update_without_password(params)
    else
      self.verify_password_and_update(params)
    end
  end

  def update_without_password(params={})

    params.delete(:password)
    params.delete(:password_confirmation)
    result = update_attributes(params)
    clean_up_passwords
    result
  end
  
  def verify_password_and_update(params)
    #devises' update_with_password 
    # https://github.com/plataformatec/devise/blob/master/lib/devise/models/database_authenticatable.rb
    current_password = params.delete(:current_password)

    if params[:password].blank?
      params.delete(:password)
      params.delete(:password_confirmation) if params[:password_confirmation].blank?
    end

    result = if valid_password?(current_password)
      update_attributes(params)
    else
      self.attributes = params
      self.valid?
      self.errors.add(:current_password, current_password.blank? ? :blank : :invalid)
      false
    end

    clean_up_passwords
    result
  end

end
