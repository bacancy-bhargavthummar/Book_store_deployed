# frozen_string_literal: true

require 'test_helper'

class InvoiceMailerTest < ActionMailer::TestCase
  test 'bill' do
    mail = InvoiceMailer.bill
    assert_equal 'Bill', mail.subject
    assert_equal ['to@example.org'], mail.to
    assert_equal ['from@example.com'], mail.from
    assert_match 'Hi', mail.body.encoded
  end
end
