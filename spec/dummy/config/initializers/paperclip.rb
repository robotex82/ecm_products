Paperclip::Attachment.default_options.merge!(
  :path => ":rails_root/public/system/:class/:id/:attachment/:style/:basename.:extension",
  :url  =>                   "/system/:class/:id/:attachment/:style/:basename.:extension"
) 
