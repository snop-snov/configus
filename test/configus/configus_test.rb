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
        end
      end
    end.must_raise(RuntimeError)
  end

  it "check existied environment" do
    conf = Configus.build :production do
      env :production do
        website_url 'http://example.com'
      end
    end
    conf.must_equal({:website_url=>"http://example.com"})
  end

  it "nested one level" do
    conf = Configus.build :production do
      env :production do
        website_url 'http://example.com'
        email do
        end
      end
    end
    conf.must_equal({:website_url=>"http://example.com", :email=>{}})
  end

  it "nested one level with simple config" do
    conf = Configus.build :production do
      env :production do
        website_url 'http://example.com'
        email do
          address 'abc@mail.ru'
        end
      end
    end
    conf.email.address.must_equal 'abc@mail.ru'
  end

  it "second level nested" do
    conf = Configus.build :production do
      env :production do
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

      env :development do
        ttt "ttt"
      end
    end
    #raise "XXXXXXXXXXXXX" << conf.inspect
    conf.must_equal({:website_url=>"http://example.com",
                  :email=>{:pop=>{:address=>"pop.example.com", :port=>110},
                           :smtp=>{:address=>"smtp.example.com", :port=>25}}})
  end

  it "check inheriting" do
    conf = Fixtures.development_inherited_config
    conf.website_url.must_equal 'http://text.example.com'
    conf.email.pop.port.must_equal 110
  end

  it "should configus method work" do
    conf = Fixtures.development_inherited_config
    configus.website_url.must_equal "http://text.example.com"
    configus.email.pop.port.must_equal 110
  end
end