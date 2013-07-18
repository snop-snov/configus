require 'test_helper'

describe "Configus" do
  it "true" do
    true.must_equal true
  end

  it "simple config data" do
    c = Configus::Builder.env :production do
      website_url 'http://example.com'
    end
    c.website_url.must_equal 'http://example.com'
  end

  it "nested one level" do
    c = Configus::Builder.env :production do
      website_url 'http://example.com'
      email do
      end
    end
    c.email.class.must_equal Configus::Config
  end

  it "nested one level with simple config" do
    c = Configus::Builder.env :production do
      website_url 'http://example.com'
      email do
        address 'abc@mail.ru'
      end
    end
    c.email.address.must_equal 'abc@mail.ru'
  end

end