class Image < ActiveRecord::Base
  belongs_to :project
  has_attached_file :image, 
                    :styles => {:original => "445x440", :small => "98x98"},
                    :url => "/images/:id/:style_:basename.:extension",
                    :path => ":rails_root/public/images/:id/:style_:basename.:extension"
                    
  validates_attachment_size :image, :less_than => 4.megabyte
  validates_attachment_content_type :image, :content_type => /image\/*/
end
