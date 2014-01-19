class CassieController < ApplicationController

  before_action :check_connection, only: [:index, :transactions, :transaction_errors]

  def index
    begin
      @ep008s = Endpoints008.all
      @count008 = @ep008s.nil? ? 0 : @ep008s.size
      @ep002s = Endpoints002.all
      @count002 = @ep002s.nil? ? 0 : @ep002s.size
      @txns = Transaction.all
      @countTxn = @txns.nil? ? 0 : @txns.size
      @txn_errs = TransactionError.all
      @countTxnErrs = @txn_errs.nil? ? 0 : @txn_errs.size
    rescue => e
      @ep008s = nil
      @ep002s = nil
    end
  end

  def transactions
    begin
      @txns = Transaction.all
      @countTxn = @txns.nil? ? 0 : @txns.size
    rescue => e
      @txns = nil
    end
  end

  def transaction_errors
    begin
      @txn_errs = TransactionError.all
      @countTxnErrs = @txn_errs.nil? ? 0 : @txn_errs.size
    rescue => e
      @txn_errs = nil
    end
  end

  def search
    key = params[:key]
    @results = nil
    @connected = true
    if (!key.blank?)
      begin
        @results = Transaction.find(key)
      rescue => e
        @results = nil
        @connected = false
      end
    end
    render "transactions"
  end

  def edit_008
    @endpoint = Endpoints008.find(params[:id])
  end

  def update_008
    @endpoint = Endpoints008.find(params[:id])
    @endpoint.update_attribute(:endpoint, params[:endpoint])
    if @endpoint.save!
      format.html { redirect_to admin_cassie_path, notice: 'Endpoint was successfully updated.' }
    else
      format.html { render action: 'edit_008' }
    end
  end

  def connect
    begin
      CassandraObject::Base.config = {
          keyspace: 'payments',
          servers: get_cassandra_url + ":9160",
          thrift: {
              timeout: 20,
              retries: 2
          }
      }
    rescue => e
      @connected = false
    end
    redirect_to admin_cassie_path
  end

  private

  def check_connection
    @connected = true
    begin
      @ep008s = Endpoints008.all
    rescue => e
      @connected = false
    end
  end

end
