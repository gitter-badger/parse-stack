# encoding: UTF-8
# frozen_string_literal: true
require_relative '../object'

module Parse
  # This class represents the data and columns contained in the standard Parse
  # `_Session` collection. The Session class maintains per-device (or website) authentication
  # information for a particular user. Whenever a User object is logged in, a new Session record, with
  # a session token is generated. You may use a known active session token to find the corresponding
  # user for that session. Deleting a Session record (and session token), effectively logs out the user, when making Parse requests
  # on behalf of the user using the session token.
  class Session < Parse::Object

    parse_class Parse::Model::CLASS_SESSION

    # @!attribute created_with
    # @return [Hash] data on how this Session was created.
    property :created_with, :object

    # @!attribute expires_at
    # @return [Parse::Date] when the session token expires.
    property :expires_at, :date

    # @!attribute installation_id
    # @return [String] The installation id from the Installation table.
    # @see Installation#installation_id
    property :installation_id

    # @!attribute [r] restricted
    # @return [Boolean] whether this session token is restricted.
    property :restricted, :boolean

    # @!attribute [r] session_token
    #  @return [String] the session token for this installation and user pair.
    property :session_token
    # @!attribute [r] user
    #  This property is mapped as a `belongs_to` association with the {Parse::User}
    #  class. Every session instance is tied to a specific logged in user.
    #  @return [User] the user corresponding to this session.
    #  @see User
    belongs_to :user

    # Return the Session record for this session token.
    # @param token [String] the session token
    # @return [Session] the session for this token, otherwise nil.
    def self.session(token, **opts)
      response = client.fetch_session(token, opts)
      if response.success?
        return Parse::Session.build response.result
      end
      nil
    end

  end

end
