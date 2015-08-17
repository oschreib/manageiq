require 'json'

module ImageScannerClient
  class Client
    NUMBER_OF_THREADS_REQUIRED =  2
    IMAGE_SCANNER_API_PATH = '/image-scanner/api/scan'

    def initialize(http_proxy)
      @http_proxy = http_proxy
    end

    def scan(image_name)
      body = {number: NUMBER_OF_THREADS_REQUIRED, scan: [image_name]}
      pp JSON.generate(body)
      @http_proxy.post(IMAGE_SCANNER_API_PATH, JSON.generate(body))
      @http_proxy
    end
  end
end
