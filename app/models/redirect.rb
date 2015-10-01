

include ActionView::Helpers::TextHelper

class UriValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless valid_uri?(value)
      record.errors[attribute] << (options[:message] || 'is not a valid URI')
    end
  end
  private
  def valid_uri?(uri)
    URI.parse(uri)
    true
  rescue URI::InvalidURIError
    false
  end
end



class Redirect < ActiveRecord::Base

	validates :target, uri: true
	validates :source, uri: true
	validates :published, inclusion: {in: [true, false]}

	def self.import(file)

	goodRedirects = []
	badRows = []
	rowNumber = 0
	badRowNumbers = ''

	require 'csv'

    		CSV.foreach(file.path) do |row|

    			rowNumber = rowNumber + 1

      			r = Redirect.new({
        		:source => row[0],
        		:target => row[1],
        		:changedby => row[2],
        		:published => false         
    		 	 })

      			if r.valid?
      				goodRedirects << r 

      			else

      				badRows << r
      				badRowNumbers = badRowNumbers + rowNumber.to_s + ""
      			
   				end

   			end

   			if badRows.empty?

   				for r in goodRedirects do

   					r.save

   				end

   				result = {  "success" => true, "message" => goodRedirects.length.to_s + " redirects successfully imported, don't forget to publish them."}
	  		
	  		else
	  		

	  			result = {  "success" => false, "message" => pluralize(badRows.length.to_s, 'row') + " with invalid entries, the row numbers to check are: " + badRowNumbers}

   			end

	   	

	   		

	   		

	   	end






end



