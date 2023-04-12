class SupportMailbox < ApplicationMailbox
  def process
    clean_email = mail.from.to_s.match(/([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})/)

    recent_order = Order.where(email: mail.from).order('created_at desc').first

    request = SupportRequest.create!(
      email:    clean_email,
      subject:  mail.subject,
      body:     mail.body.to_s,
      order:    recent_order
    )
  end
end
