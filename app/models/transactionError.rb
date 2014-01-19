class TransactionError < CassandraObject::Base
  self.column_family = :transaction_errors
  string :xml
end