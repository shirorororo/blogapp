class NotificationMailer < ApplicationMailer
  def notification_mail(blog)
   @blog = blog
   current_user_email = @blog.user.email
   mail to: @blog.user.email, subject: "投稿完了メール"
  end
end
