require 'test_helper'

describe "Configus" do
  it "simple config data" do
    conf = Configus::Builder.build :production do
          env :production do
            website_url 'http://example.com'
          end
        end
    conf.website_url.must_equal 'http://example.com'
  end
end