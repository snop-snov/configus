require 'test_helper'

describe "Configus" do
  it "hash_creator" do
    c = Configus::HashCreator.generate_hash do
      website_url "http://example.com"
      email do
        address "abc@mail.ru"
      end
    end
    c.must_equal({:website_url=>"http://example.com", :email=>{:address=>"abc@mail.ru"}})
  end

end