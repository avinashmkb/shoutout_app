class Notifier < ActionMailer::Base
  default from: 'SMS SYD <heartbeat@shoutout.co.in>'
  default subject: 'You have recieved a SYD feedback'
  default cc: 'avinash.mb@shoutout.co.in'
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.sms_recieved.subject
  #
  def sms_recieved(contactnumber,storecode,usermessage,category,sydreferencenume)
   @contactnumber_controller = contactnumber
    @storecode_controller = storecode
    @usermessage_controller=usermessage
    @category_controller = category
    @syd_refnum_controller = sydreferencenume
    date= Time.now()
    @date_controller = date.strftime("%d-%m-%Y")
    subject_controller = "#{@category_controller}:#{@storecode_controller}"
     mail to: 'santosh.ar@shoutout.co.in',:subject => subject_controller

  end
end
