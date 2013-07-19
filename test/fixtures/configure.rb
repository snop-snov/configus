module Fixtures
  def self.development_inherited_config
    conf = Configus.build :development do # set current environment
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

      env :development, :parent => :production do
        website_url 'http://text.example.com'
        email do
          smtp do
            address 'smpt.text.example.com'
          end
        end
      end
    end
  end
end