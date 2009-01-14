require 'dip'

# A model for a DAITSS AIP that provides functionality for
# constructing a TIPR package
describe DIP do
  it "should be initialized from a DAITSS DIP"
  it "should have an IEID"
  it "should have a package ID"
  it "should have a creation date"
  it "should have multiple representations"
end

describe Representation do
  it "should be a set of files"
  it "should have a sha-1 digest for each file"
end
