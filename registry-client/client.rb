# frozen_string_literal: true

# In this file you need to implement a registry client.

require_relative 'config/config'

# RegistryClient is a registry client that talks to a Redis service registry.
# It has two core functions:
#   - Register itself to the registry when the service is up.
#   - Query the registry for addresses of services that it wants to talk to.
class RegistryClient
  def initialize(config)
    @client = Redis.new(
      host: config.host,
      port: config.port,
      password: config.password
    )
  end

  # Register registers itself to the Service Registry.
  #
  # This method does 2 things:
  #
  # First, it registers itself to the corresponding service set via
  # `SADD serviceName "address"`. A service set is a set of addresses
  # of instances running the service.
  # Then, it registers itself by setting its status to "alive" that expires
  # every 30 seconds via `SET address "alive" EX 30`.
  # Note: these two steps are wrapped in a Transaction to ensure consistency.
  #
  # Second, it needs to re-register itself every 30 seconds via `SET ...`
  # (in the background) to the registry to *prove* that this service is still
  # alive.
  # If the registry does not hear back from this service within this time period
  # , it will declare this service *dead*.
  #
  # This is what happens in Redis,
  #   // An instance running Service A registers itself.
  #   SADD serviceA "10.10.10.11:4567"
  #   SET 10.10.10.11:4567 "alive" EX 30
  #   // Another instance running Service A registers itself.
  #   SADD serviceA "45.21.34.12:4567"
  #   SET 45.21.34.12:4567 "alive" EX 30
  #
  # @param name serviceName
  # @param host ip v4 address
  # @param port
  def register(name:, host:, port:)
    raise 'not implemented'
  end

  def service(name:)
    raise 'not implemented'
  end
end