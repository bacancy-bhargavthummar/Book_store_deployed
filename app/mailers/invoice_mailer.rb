# frozen_string_literal: true

class InvoiceMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.invoice_mailer.bill.subject
  #
  def bill(cart)
    # @c = User.find(cart.user_id)
    @cart = cart
    # @l = LineItem.where(cart_id: cart.id)
    if @cart.approval == 1
      mail to: @cart.user.email, subject: 'Your request for order is Approved and it will shipped soon.'
    elsif cart.approval == 2
      mail to: @cart.user.email, subject: 'Your request for order is Rejected.'
    else
      attachments['bill.pdf'] = WickedPdf.new.pdf_from_string(
        render_to_string(pdf: 'Invoice', template: 'charges/invoice.pdf.erb')
      )
      mail to: @cart.user.email, subject: 'Your books Order Is Placed.'
    end
  end
end
