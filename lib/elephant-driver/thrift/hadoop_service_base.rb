#
# Autogenerated by Thrift
#
# DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING
#

require 'thrift'
require 'common_types'

        module Hadoop
          module API
            module HadoopServiceBase
              class Client
                include ::Thrift::Client

                def getVersionInfo(ctx)
                  send_getVersionInfo(ctx)
                  return recv_getVersionInfo()
                end

                def send_getVersionInfo(ctx)
                  send_message('getVersionInfo', GetVersionInfo_args, :ctx => ctx)
                end

                def recv_getVersionInfo()
                  result = receive_message(GetVersionInfo_result)
                  return result.success unless result.success.nil?
                  raise ::Thrift::ApplicationException.new(::Thrift::ApplicationException::MISSING_RESULT, 'getVersionInfo failed: unknown result')
                end

                def getRuntimeInfo(ctx)
                  send_getRuntimeInfo(ctx)
                  return recv_getRuntimeInfo()
                end

                def send_getRuntimeInfo(ctx)
                  send_message('getRuntimeInfo', GetRuntimeInfo_args, :ctx => ctx)
                end

                def recv_getRuntimeInfo()
                  result = receive_message(GetRuntimeInfo_result)
                  return result.success unless result.success.nil?
                  raise ::Thrift::ApplicationException.new(::Thrift::ApplicationException::MISSING_RESULT, 'getRuntimeInfo failed: unknown result')
                end

                def getThreadDump(ctx)
                  send_getThreadDump(ctx)
                  return recv_getThreadDump()
                end

                def send_getThreadDump(ctx)
                  send_message('getThreadDump', GetThreadDump_args, :ctx => ctx)
                end

                def recv_getThreadDump()
                  result = receive_message(GetThreadDump_result)
                  return result.success unless result.success.nil?
                  raise ::Thrift::ApplicationException.new(::Thrift::ApplicationException::MISSING_RESULT, 'getThreadDump failed: unknown result')
                end

                def getAllMetrics(ctx)
                  send_getAllMetrics(ctx)
                  return recv_getAllMetrics()
                end

                def send_getAllMetrics(ctx)
                  send_message('getAllMetrics', GetAllMetrics_args, :ctx => ctx)
                end

                def recv_getAllMetrics()
                  result = receive_message(GetAllMetrics_result)
                  return result.success unless result.success.nil?
                  raise result.err unless result.err.nil?
                  raise ::Thrift::ApplicationException.new(::Thrift::ApplicationException::MISSING_RESULT, 'getAllMetrics failed: unknown result')
                end

                def getMetricsContext(ctx, contextName)
                  send_getMetricsContext(ctx, contextName)
                  return recv_getMetricsContext()
                end

                def send_getMetricsContext(ctx, contextName)
                  send_message('getMetricsContext', GetMetricsContext_args, :ctx => ctx, :contextName => contextName)
                end

                def recv_getMetricsContext()
                  result = receive_message(GetMetricsContext_result)
                  return result.success unless result.success.nil?
                  raise result.err unless result.err.nil?
                  raise ::Thrift::ApplicationException.new(::Thrift::ApplicationException::MISSING_RESULT, 'getMetricsContext failed: unknown result')
                end

              end

              class Processor
                include ::Thrift::Processor

                def process_getVersionInfo(seqid, iprot, oprot)
                  args = read_args(iprot, GetVersionInfo_args)
                  result = GetVersionInfo_result.new()
                  result.success = @handler.getVersionInfo(args.ctx)
                  write_result(result, oprot, 'getVersionInfo', seqid)
                end

                def process_getRuntimeInfo(seqid, iprot, oprot)
                  args = read_args(iprot, GetRuntimeInfo_args)
                  result = GetRuntimeInfo_result.new()
                  result.success = @handler.getRuntimeInfo(args.ctx)
                  write_result(result, oprot, 'getRuntimeInfo', seqid)
                end

                def process_getThreadDump(seqid, iprot, oprot)
                  args = read_args(iprot, GetThreadDump_args)
                  result = GetThreadDump_result.new()
                  result.success = @handler.getThreadDump(args.ctx)
                  write_result(result, oprot, 'getThreadDump', seqid)
                end

                def process_getAllMetrics(seqid, iprot, oprot)
                  args = read_args(iprot, GetAllMetrics_args)
                  result = GetAllMetrics_result.new()
                  begin
                    result.success = @handler.getAllMetrics(args.ctx)
                  rescue Hadoop::API::IOException => err
                    result.err = err
                  end
                  write_result(result, oprot, 'getAllMetrics', seqid)
                end

                def process_getMetricsContext(seqid, iprot, oprot)
                  args = read_args(iprot, GetMetricsContext_args)
                  result = GetMetricsContext_result.new()
                  begin
                    result.success = @handler.getMetricsContext(args.ctx, args.contextName)
                  rescue Hadoop::API::IOException => err
                    result.err = err
                  end
                  write_result(result, oprot, 'getMetricsContext', seqid)
                end

              end

              # HELPER FUNCTIONS AND STRUCTURES

              class GetVersionInfo_args
                include ::Thrift::Struct, ::Thrift::Struct_Union
                CTX = 10

                FIELDS = {
                  CTX => {:type => ::Thrift::Types::STRUCT, :name => 'ctx', :class => Hadoop::API::RequestContext}
                }

                def struct_fields; FIELDS; end

                def validate
                end

                ::Thrift::Struct.generate_accessors self
              end

              class GetVersionInfo_result
                include ::Thrift::Struct, ::Thrift::Struct_Union
                SUCCESS = 0

                FIELDS = {
                  SUCCESS => {:type => ::Thrift::Types::STRUCT, :name => 'success', :class => Hadoop::API::VersionInfo}
                }

                def struct_fields; FIELDS; end

                def validate
                end

                ::Thrift::Struct.generate_accessors self
              end

              class GetRuntimeInfo_args
                include ::Thrift::Struct, ::Thrift::Struct_Union
                CTX = 10

                FIELDS = {
                  CTX => {:type => ::Thrift::Types::STRUCT, :name => 'ctx', :class => Hadoop::API::RequestContext}
                }

                def struct_fields; FIELDS; end

                def validate
                end

                ::Thrift::Struct.generate_accessors self
              end

              class GetRuntimeInfo_result
                include ::Thrift::Struct, ::Thrift::Struct_Union
                SUCCESS = 0

                FIELDS = {
                  SUCCESS => {:type => ::Thrift::Types::STRUCT, :name => 'success', :class => Hadoop::API::RuntimeInfo}
                }

                def struct_fields; FIELDS; end

                def validate
                end

                ::Thrift::Struct.generate_accessors self
              end

              class GetThreadDump_args
                include ::Thrift::Struct, ::Thrift::Struct_Union
                CTX = 10

                FIELDS = {
                  CTX => {:type => ::Thrift::Types::STRUCT, :name => 'ctx', :class => Hadoop::API::RequestContext}
                }

                def struct_fields; FIELDS; end

                def validate
                end

                ::Thrift::Struct.generate_accessors self
              end

              class GetThreadDump_result
                include ::Thrift::Struct, ::Thrift::Struct_Union
                SUCCESS = 0

                FIELDS = {
                  SUCCESS => {:type => ::Thrift::Types::LIST, :name => 'success', :element => {:type => ::Thrift::Types::STRUCT, :class => Hadoop::API::ThreadStackTrace}}
                }

                def struct_fields; FIELDS; end

                def validate
                end

                ::Thrift::Struct.generate_accessors self
              end

              class GetAllMetrics_args
                include ::Thrift::Struct, ::Thrift::Struct_Union
                CTX = 10

                FIELDS = {
                  CTX => {:type => ::Thrift::Types::STRUCT, :name => 'ctx', :class => Hadoop::API::RequestContext}
                }

                def struct_fields; FIELDS; end

                def validate
                end

                ::Thrift::Struct.generate_accessors self
              end

              class GetAllMetrics_result
                include ::Thrift::Struct, ::Thrift::Struct_Union
                SUCCESS = 0
                ERR = 1

                FIELDS = {
                  SUCCESS => {:type => ::Thrift::Types::LIST, :name => 'success', :element => {:type => ::Thrift::Types::STRUCT, :class => Hadoop::API::MetricsContext}},
                  ERR => {:type => ::Thrift::Types::STRUCT, :name => 'err', :class => Hadoop::API::IOException}
                }

                def struct_fields; FIELDS; end

                def validate
                end

                ::Thrift::Struct.generate_accessors self
              end

              class GetMetricsContext_args
                include ::Thrift::Struct, ::Thrift::Struct_Union
                CTX = 10
                CONTEXTNAME = 1

                FIELDS = {
                  CTX => {:type => ::Thrift::Types::STRUCT, :name => 'ctx', :class => Hadoop::API::RequestContext},
                  CONTEXTNAME => {:type => ::Thrift::Types::STRING, :name => 'contextName'}
                }

                def struct_fields; FIELDS; end

                def validate
                end

                ::Thrift::Struct.generate_accessors self
              end

              class GetMetricsContext_result
                include ::Thrift::Struct, ::Thrift::Struct_Union
                SUCCESS = 0
                ERR = 1

                FIELDS = {
                  SUCCESS => {:type => ::Thrift::Types::STRUCT, :name => 'success', :class => Hadoop::API::MetricsContext},
                  ERR => {:type => ::Thrift::Types::STRUCT, :name => 'err', :class => Hadoop::API::IOException}
                }

                def struct_fields; FIELDS; end

                def validate
                end

                ::Thrift::Struct.generate_accessors self
              end

            end

          end
        end
