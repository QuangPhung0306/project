# frozen_string_literal: true

class Ckeditor::Picture < Ckeditor::Asset
  self.inheritance_column = nil
  # for validation, see https://github.com/igorkasyanchuk/active_storage_validations

  def url_content
    rails_representation_url(storage_data.variant(resize: '800>').processed)
  end

  def url_thumb
    rails_representation_url(storage_data.variant(resize: '118x100').processed)
  end
end
