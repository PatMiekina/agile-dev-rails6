class SupportMailbox < ApplicationMailbox
  def process
    recent_order = Order.where(email: mail.from).order('created_at desc').first

    request = SupportRequest.create!(
      email:    mail.from.to_s,
      subject:  mail.subject,
      body:     mail.body.to_s,
      order:    recent_order
    )
  end
end
