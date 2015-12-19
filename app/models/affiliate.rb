require 'valid_email'

class Affiliate < ActiveRecord::Base
  has_and_belongs_to_many :categories

  ## validation ###
  validates :email, presence: true, email: true

  ## active record callbacks ###
  before_create :set_token_value, :set_is_active_value

  def activate
    self.update_attributes({ is_active: true })
  end

  def deactivate
    self.update_attributes({ is_active: false })
  end

  protected
    def set_token_value
      if self.token.nil?
        value = self.email + rand(11111..99999).to_s
        self.token = Digest::SHA1.hexdigest value
      end
    end

  def set_is_active_value
    self.is_active = 0
  end
end
