class Endpoints002 < CassandraObject::Base
  self.column_family = :endpoints002
  string :endpoint
end