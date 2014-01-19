class Endpoints008 < CassandraObject::Base
  self.column_family = :endpoints008
  string :endpoint
end