require 'test_helper'

describe "Configus" do
  it "must inherited" do
    conf = Configus.build :development do # set current environment
      env :environment do
        aaa 'aaa'
      end

      env :production, :parent => :environment do
        bbb 'bbb'
      end

      env :development, :parent => :production do
        ccc 'ccc'
      end
    end
    conf.aaa.must_equal 'aaa'
    conf.bbb.must_equal 'bbb'
    conf.ccc.must_equal 'ccc'
  end

  it "must fail for loop inheriting" do
    lambda do
      conf = Configus.build :development do # set current environment
        env :environment, :parent => :development do
          aaa 'aaa'
        end

        env :production, :parent => :environment do
          bbb 'bbb'
        end

        env :development, :parent => :production do
          ccc 'ccc'
        end
      end
    end.must_raise(RuntimeError)
  end

end