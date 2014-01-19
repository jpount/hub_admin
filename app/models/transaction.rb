class Transaction < CassandraObject::Base
  self.column_family = :transactions
  string :xml
end