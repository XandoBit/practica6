require 'dm-core'
require 'dm-migrations'

class Usuario
	include DataMapper::Resource
		property :id, Serial
		property :nombre, String
		property :correo, String
		property :alta, Boolean, :default => false
		
end