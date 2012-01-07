class User < ActiveRecord::Base
  
  #password -> encrypted one saved in DB
  #passwordNE -> not encrypted, not saved in DB
  #passwordNE_confirmation -> not encrypted and not saved.
  #salt -> saved in DB
  
  attr_accessor :passwordNE
  attr_accessible  :username, :passwordNE, :passwordNE_confirmation
  
  has_many :clients
  
  has_many :preferences, :dependent => :destroy
  has_many :categories, :through => :preferences
  
  
  validates :username, :presence => true,
                    #:format   => { :with => email_regex },
                    :uniqueness => { :case_sensitive => false }
  # Automatically create the virtual attribute 'password_confirmation'.
  validates :passwordNE, :presence     => true,
                       :confirmation => true,
                       :length       => { :within => 6..40 }
                       
  before_save :encrypt_password
  
  def has_password?(submitted_password)
    # Compare encrypted_password with the encrypted version of
    # submitted_password.
    password == encrypt(submitted_password)
  end
  
  def self.authenticate(username, submitted_password) #self. means this is a class method..
    user = find_by_username(username)
    return nil  if user.nil?
    return user if user.has_password?(submitted_password) # if not will return nil automatically
  end
  
  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end
  
  private

    def encrypt_password
      self.salt = make_salt unless has_password?(passwordNE)
      self.password = encrypt(self.passwordNE) #could ignore self in self.password
    end
    #self is optional when reading it but not optional when writing to it.

    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end
    
    def make_salt
      secure_hash("#{Time.now.utc}--#{passwordNE}")
    end
    
    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
end
