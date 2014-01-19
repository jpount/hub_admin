require 'thrift'
require 'nimbus'

class StatsController < ApplicationController

  # This is called from the stats page to get data from nimbus
  def index
    $:.push('gen-rb')
    @cassie_total = 0
    @kafka_spout_total = 0
    @kafka_out_total = 0
    @errors_total = 0
    if !params[:topology].blank?
     begin
      nimbus = get_nimbus_url
      socket    = Thrift::Socket.new(nimbus, 6627)
      transport = Thrift::FramedTransport.new(socket)
      protocol  = Thrift::BinaryProtocol.new(transport)
      client    = Nimbus::Client.new(protocol)

      transport.open

      summary = client.getClusterInfo

      topology = client.getTopologyInfo(summary.topologies.find{|t| t.name.eql? params[:topology]}.id)

      begin
        cassie_executors = topology.executors.select{|e| e.component_id.eql? "CASSANDRA_BOLT"}
        @cassie_total = cassie_executors.reduce(0) {|sum, e| sum + (e.stats.emitted[':all-time']["__ack_ack"] || 0)}
      rescue => ex
        print 'Thrift::Exception: ', ex.message, "\n"
      end
      begin
        kafka_executors = topology.executors.select{|e| e.component_id.eql? "KAFKA_SPOUT"}
        @kafka_spout_total = kafka_executors.reduce(0) {|sum, e| sum + (e.stats.emitted[':all-time']["__ack_init"] || 0)}
      rescue => ex
        print 'Thrift::Exception: ', ex.message, "\n"
      end
      begin
        errors_executors = topology.executors.select{|e| e.component_id.eql? "KAFKA_ERROR_BOLT"}
        @errors_total = errors_executors.reduce(0) {|sum, e| sum + (e.stats.emitted[':all-time']["__ack_ack"] || 0)}
      rescue => ex
        print 'Thrift::Exception: ', ex.message, "\n"
      end
      begin
        kafka_out_executors = topology.executors.select{|e| e.component_id.eql? "KAFKA_OUT_BOLT"}
        @kafka_out_total = kafka_out_executors.reduce(0) {|sum, e| sum + (e.stats.emitted[':all-time']["__ack_ack"] || 0)}
      rescue => ex
        print 'Thrift::Exception: ', ex.message, "\n"
      end

      transport.close

     rescue Thrift::Exception => tx
      print 'Thrift::Exception: ', tx.message, "\n"
     rescue NoMethodError::Exception => nme
      print 'NoMethodError::Exception: ', nme.message, "\n"
     end
    end

    respond_to do |format|
      format.html {  }
      format.json { render :json => {:kafka_spout_total => @kafka_spout_total, :kafka_out_total => @kafka_out_total, :errors_total => @errors_total, :cassie_total => @cassie_total} }
    end
  end

end

