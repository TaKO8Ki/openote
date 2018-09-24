class DeviseCustomMailer < Devise::Mailer
  before_filter :add_inline_attachment!

  private

  def add_inline_attachment!
      pngs = []

    pngs.each do |png|
      attachments.inline[png] = File.read("#{Rails.root}/app/assets/images/mailer/" + png)
    end
  end
end
