module Paperclip
  class Attachment
    def save
      @queued_for_delete = []
      @queued_for_write = {}
      true
    end
 
  private
    def post_process
      true
    end
  end
 
  # This is only necessary if you're validating the content-type
  class ContentTypeDetector
  private
    def empty?
      false
    end
  end
end

Accounts::DealerDetail.class_eval do
  def address_changed?
    false
  end
end