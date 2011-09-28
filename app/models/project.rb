class Project < ActiveRecord::Base
    validates_presence_of :client
    validates_presence_of :task
    validates_presence_of :objective
    validates_presence_of :link
    
    has_many :images, :dependent => :destroy,  :order => 'position ASC'
    accepts_nested_attributes_for :images, :allow_destroy => true
    
    has_attached_file :preview, 
                      :styles => { :original => "114x114" },
                      :path  => ":rails_root/public/images/:id/preview/:style_:basename.:extension",
                      :url => "/images/:id/preview/:style_:basename.:extension"
    
end
