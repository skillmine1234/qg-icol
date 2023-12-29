class IcolCustomer < ActiveRecord::Base
  include Approval2::ModelAdditions
  TOTAL_SETTINGS_COUNT = 10
  include Setting

  belongs_to :created_user, class_name: 'User', foreign_key: 'created_by'
  belongs_to :updated_user, class_name: 'User', foreign_key: 'updated_by'
  
  validate :atleast_one_url_should_present?
  
  validates_presence_of :customer_code, :app_code, :is_enabled, :template_code, :use_proxy, :customer_name
  validates_numericality_of :retry_notify_in_mins, :max_retries_for_notify, allow_blank: true, greater_than_or_equal_to: 0
  validates :template_code, numericality: { greater_than_or_equal_to: 0 }
  validates_uniqueness_of :customer_code, scope: [:template_code, :approval_status]
  validates_length_of :http_username, maximum: 100, allow_blank: true
  validates_length_of :http_password, maximum: 100, allow_blank: true
  
  validates :customer_code, format: {with: /\A[a-z|A-Z|0-9|\.|\-]+\z/, :message => 'Invalid format, expected format is : {[a-z|A-Z|0-9|\.|\-]}' }, length: { maximum: 15 }
  validates :app_code, format: {with: /\A[a-z|A-Z|0-9|\.|\-]+\z/, :message => 'Invalid format, expected format is : {[a-z|A-Z|0-9|\.|\-]}' }, length: { maximum: 50 }
  validates :notify_url, :validate_url, format: {with: URI.regexp, :message => 'Invalid format, expected format is : https://example.com' }, length: { maximum: 100 }, allow_blank: true
  validates :customer_name, format: {with: /\A[a-z|A-Z|0-9|\s|\.|\-]+\z/, :message => 'Invalid format, expected format is : {[a-z|A-Z|0-9|\s|\.|\-]}'}, length: { maximum: 100 }
 
  validate :password_should_be_present
  
  before_save :encrypt_password
  after_save :decrypt_password
  after_find :decrypt_password

  private

  def atleast_one_url_should_present?
    if notify_url.blank? & validate_url.blank?
      errors.add :base, "Either Notify URL or Validate URL must be present"
    end
  end

  def decrypt_password
    self.http_password = DecPassGenerator.new(http_password,ENV['CONSUMER_KEY'], ENV['CONSUMER_SECRET']).generate_decrypted_data if http_password.present?
  end
  
  def encrypt_password
    self.http_password = EncPassGenerator.new(self.http_password, ENV['CONSUMER_KEY'], ENV['CONSUMER_SECRET']).generate_encrypted_password unless http_password.to_s.empty?
  end
  
  def password_should_be_present
    errors[:base] << "HTTP Password can't be blank if HTTP Username is present" if self.http_username.present? and (self.http_password.blank? or self.http_password.nil?)
  end
end
