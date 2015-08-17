require 'image_scanner_client/lib/image_scanner_client'

class ContainerImage < ActiveRecord::Base
  include ReportableMixin

  belongs_to :container_image_registry
  belongs_to :ext_management_system, :foreign_key => "ems_id"
  has_many :containers

  def scan
    kubeclient = ext_management_system.connect({service: 'kubernetes'})
    proxy = kubeclient.proxy_url_service("default", "image-scanner", "5001-tcp")
    scanner = ImageScannerClient::Client.new(proxy)
    scanner.scan("#{self.container_image_registry}/#{self.name}")
  end
end
