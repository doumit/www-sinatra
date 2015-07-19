require 'yaml'

require_relative 'deep_symbolize'

def load(name)
  hash = YAML::load_file(File.join(__dir__, "../data/#{name}.yml"))
  hash.extend DeepSymbolizable
  hash.deep_symbolize { |key| key }
end

CITIES = load(:cities)
FAQS = load(:faqs)
ALUMNI = load(:alumni)
STAFF = load(:staff)
PARTNERS = load(:partners)
SUBVENTIONS = load(:subventions)
CAMPS = load(:camps)
AUTHORS = load(:authors)
BOOSTERS = load(:boosters)
BOOSTER_CAMPS = load(:booster_camps) || {}
ARTICLES = load(:articles)
MEDIAS = load(:medias)
CONFIG = load(:config)
ONDEMAND = load(:ondemand)

CAMPS.delete(:test) if ENV['RACK_ENV'] == 'production'

ACTIVE_CITIES = CITIES.select { |slug, city| city[:active] }
ACTIVE_CAMPS = CAMPS.select {|slug, camp| ACTIVE_CITIES.keys.include? camp[:city].to_sym }
