require 'test_helper'

describe "Configus" do
  it "true" do
    true.must_equal true
  end

  it "simple config data" do
    c = Configus::Builder.new
    conf = c.env :production do
      website_url 'http://example.com'
    end
    conf.website_url.must_equal 'http://example.com'
  end

  it "check unexisted environment" do
    lambda do
      Configus.build :user_environment do
        env :production do
          website_url 'http://example.com'
          email do
          end
        end
      end
    end.must_raise(RuntimeError)
  end

=begin
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

  it "nested two level" do
    c = Configus::Builder.env :production do
      website_url 'http://example.com'
      email do
        pop do
          address 'pop.example.com'
          port    110
        end
        smtp do
          address 'smtp.example.com'
          port    25
        end
      end
    end
    #raise "XXXXXXXXXXXXX" << c.inspect
    c.must_equal({:website_url=>"http://example.com",
                  :email=>{:pop=>{:address=>"pop.example.com", :port=>110},
                           :smtp=>{:address=>"smtp.example.com", :port=>25}}})
  end
=end
end