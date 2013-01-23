# encoding: utf-8

module DeviseHelper
  def devise_error_messages!
    return '' if resource.errors.empty?

    messages = resource.errors.full_messages.
                 map { |msg| content_tag(:li, msg) }.join

    html = <<-HTML
    <div class="alert alert-block alert-error">
      <button type="button" class="close" data-dismiss="alert">&times;</button>
      <p><strong>Ошибка</strong></p>
      <ul>#{messages}</ul>
    </div>
    HTML

    html.html_safe
  end
end