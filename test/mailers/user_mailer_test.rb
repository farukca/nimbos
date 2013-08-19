require "test_helper"

describe UserMailer do
  it "reset_password_email" do
    mail = UserMailer.reset_password_email
    mail.subject.must_equal "Reset password email"
    mail.to.must_equal ["to@example.org"]
    mail.from.must_equal ["from@example.com"]
    mail.body.encoded.must_match "Hi"
  end
end
