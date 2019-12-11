# frozen_string_literal: true

class NodeInfo::Serializer < ActiveModel::Serializer
  include RoutingHelper

  attributes :version, :software, :protocols, :usage, :open_registrations, :metadata, :services

  def version
    self.instance_options[:version]
  end

  def software
    sw = {
      name: 'corgidon',
      version: Mastodon::Version.to_s
    }
    sw[:repository] = Mastodon::Version.source_base_url if version == '2.1'
    sw
  end

  def protocols
    %w(activitypub)
  end

  def usage
    {
      users: {
        total: instance_presenter.user_count,
        active_month: instance_presenter.active_user_count(4),
        active_halfyear: instance_presenter.active_user_count(24),
      },

      local_posts: instance_presenter.status_count,
    }
  end

  def open_registrations
    Setting.registrations_mode != 'none' && !Rails.configuration.x.single_user_mode
  end

  def metadata
    md = {
      nodeName: instance_presenter.site_title,
      nodeDescription: instance_presenter.site_description,
      nodeTerms: instance_presenter.site_terms,
      siteContactEmail: instance_presenter.site_contact_email,
      domain_count: instance_presenter.domain_count,
      features: features,
      invitesEnabled: Setting.min_invite_role != 'admin',
    }
    md[:federation] = federation if Setting.nodeinfo_show_blocks
    md
  end

  def services
    { outbound: [], inbound: [] }
  end

  private

  def instance_presenter
    @instance_presenter ||= InstancePresenter.new
  end

  def features
    %w(mastodon_api mastodon_api_streaming)
  end

  def federation
    domains = DomainBlock.all
    feds = {
      reject_media: [],
      reject_reports: [],
    }
    domains.each do |domain|
      feds[domain.severity] = [] unless feds.keys.include?(domain.severity)
      feds[domain.severity] << domain.domain
      feds[:reject_media] << domain.domain if domain.reject_media
      feds[:reject_reports] << domain.domain if domain.reject_reports
    end
    feds
  end

end
