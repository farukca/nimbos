require "test_helper"

describe User do

	let(:user_params) { { name: "Faruk Çelik", email: "faruk@modaltrans.com" } }
  let(:user) { User.new user_params }

  it "is valid with valid params" do
    user.must_be :valid?
  end

  it "is invalid without email" do
  	user_params.delete :email

  	user.wont_be :valid?
  	user.errors[:email].must_be :present?
  end
end
