# frozen_string_literal: true

class LinkCrawlWorker
  include Sidekiq::Worker

  sidekiq_options queue: 'pull', retry: false

  def perform(status_id)
    FetchLinkCardService.new.call(Status.find(status_id))
  rescue ActiveRecord::RecordNotFound
    true
  end
end
