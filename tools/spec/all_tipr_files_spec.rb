require 'erb'
require 'nokogiri'
require 'dip'
require 'spec_helper'

share_as :AllTiprFiles do
  it "should be a mets document" do
    @doc.root.name.should == 'mets'
    @doc.root.should be_in_namespace('http://www.loc.gov/METS/')
  end
  
  it "should have an OBJID" do
    @doc.root['OBJID'].should_not be_nil
  end

  it "should have a LABEL" do
    @doc.root['LABEL'].should_not be_nil
  end

  it "should have a mets header" do
    @rchildren.first.name.should == 'metsHdr'
  end

  describe "the header" do
    
    it "should have a create date" do
      @rchildren.first['CREATEDATE'].should_not be_nil
    end
    
    it "should have an agent" do
      @rchildren.first.should have_xpath('./xmlns:agent', @xmlns)
    end

    describe "the agent" do
      it "should have a role of DISSEMINATOR" do
        @rchildren.first.xpath('./xmlns:agent', @xmlns).first['ROLE'].should ==
	  "DISSEMINATOR"
      end  
      
      it "should have a type of ORGANIZATION" do
        @rchildren.first.xpath('./xmlns:agent', @xmlns).first['TYPE'].should ==
	  "ORGANIZATION"
      end
      
      it "should have name of the contributing repository" do
        @rchildren.first.xpath('./xmlns:agent/xmlns:name',
				@xmlns).first.content.should_not be_nil
      end    
    end
  end

  # We leave amdSec & dmdSec checks to individual file types
    
  it "should have a fileSec that points to representation descriptors" do
    # Validate each file representation descriptor.
    @files.each do |f|
      f['ID'].should_not be_nil
      f['CHECKSUM'].should_not be_nil
      f['CHECKSUMTYPE'].should == 'SHA-1'
      f.xpath('./xmlns:FLocat', @xmlns).first.should reference_an_xml_file      
    end    
  end 
  
  # We leave structMap checks to individual file types 

end
