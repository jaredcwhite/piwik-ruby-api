module Piwik
  class Referers < ApiModule
    available_methods %W{
      getReferrerType
      getKeywords
      getKeywordsForPageUrl
      getKeywordsForPageTitle
      getSearchEnginesFromKeywordId
      getSearchEngines
      getKeywordsFromSearchEngineId
      getCampaigns
      getKeywordsFromCampaignId
      getWebsites
      getSocials
      getUrlsForSocial
      getUrlsFromWebsiteId
      getNumberOfDistinctSearchEngines
      getNumberOfDistinctKeywords
      getNumberOfDistinctCampaigns
      getNumberOfDistinctWebsites
      getNumberOfDistinctWebsitesUrls
    }
    
    scoped_methods do
      def websites params = {}
        getWebsites(defaults.merge(params))
      end
      
      def websites_count params = {}
        getNumberOfDistinctWebsites(defaults.merge(params)).value
      end
      
      def keywords params = {}
        getKeywords(defaults.merge(params))
      end
      
      def keywords_for_title(title, params = {})
        getKeywordsForPageTitle(defaults.merge(params).merge(:pageTitle => title))
      end
      
      def keywords_for_url(url, params = {})
        getKeywordsForPageUrl(defaults.merge(params).merge(:pageUrl => url))
      end
      
      def keywords_count params = {}
        getNumberOfDistinctKeywords(defaults.merge(params)).value
      end
      
      def search_engines params = {}
        getSearchEngines(defaults.merge(params))
      end
      
      def search_engines_count params = {}
        getNumberOfDistinctSearchEngines(defaults.merge(params)).value
      end

      def socials params = {}
        getSocials(defaults.merge(params))
      end
    end
  end
end