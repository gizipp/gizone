module Searchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model

    settings index: { number_of_shards: 1 } do
      mappings dynamic: 'false' do
        indexes :title, analyzer: 'indonesian', index_options: 'offsets'
        indexes :content, analyzer: 'indonesian', index_options: 'offsets'
      end
    end

    Article.__elasticsearch__.create_index! force: true
    Article.__elasticsearch__.refresh_index!

    Article.import

    def self.search(query)
      __elasticsearch__.search({
        query: {
          multi_match: {
            query: query,
            fields: ['title^10', 'content']
          }
        },
        highlight: {
          fields: {title: {},content: {}
          }
        }
      })
    end
  end

  def as_indexed_json(options={})
    as_json()
  end
end