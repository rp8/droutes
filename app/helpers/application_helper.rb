module ApplicationHelper
  def flash_messages
    [:notice, :warning, :error].collect do |msg|
      content_tag(:p, flash[msg], :class => "flash #{msg}") unless flash[msg].blank?
    end.join
  end

  # mark a field as required
  def mark_required(object, attribute)  
    "*" if object.class.validators_on(attribute).map(&:class).include? ActiveModel::Validations::PresenceValidator  
  end  

  # show google map
  def direction_href
    "http://maps.google.com/maps?f=d&source=s_d&saddr=#{current_user.profile.address}&daddr=".gsub(' ', '+')
  end

  def direction_for(order)
    link_to "#{capitalize(order.address)}", "http://maps.google.com/maps?f=d&source=s_d&saddr=#{current_user.profile.address}&daddr=#{order.address}&z=13&layer=c&pw=2 (#{phone(order.phone)}, #{order.instruction})&z=14&layer=c&pw=2".gsub(' ', '+'), :target => '_map'
  end

  def direction_to(customer)
    link_to "#{capitalize(customer.address)}", "http://maps.google.com/maps?f=d&source=s_d&saddr=#{current_user.profile.address}&daddr=#{customer.address} (#{phone(customer.phone)}, #{customer.note})&z=14&layer=c&pw=2".gsub(' ', '+'), :target => '_map'
  end

  # format phone to 123-456-7890
  # format phone to 123-456-7890
  def phone(no)
    if no
      number_to_phone(no, :area_code => false)
    else
      no
    end
  end

  # capitalize first letter in each word
  def capitalize(s)
    s.gsub(/\b(\w+)/) {|x| x.capitalize} if s
  end

  def date(t)
    t.strftime("%Y-%m-%d") if t
  end

  def time(t)
    t.strftime("%I:%m%p") if t
  end

  def datetime(t)
    t.strftime("%Y-%m-%d %I:%M%p") if t
  end

end
