require 'rails_helper'

describe "ApplicationHelper" do
 
  describe "full_title" do
    subject{ full_title(title) }
    
    describe "fill in title" do
      let(:title) { 'foo' }
      it { is_expected.to match(/foo/) }
      it { is_expected.to match(/^Ruby on Rails Tutorial Sample App/) }
    end
 
    describe "not fill in title" do
      let(:title) { '' }
      it { is_expected.not_to match(/\|/) }
    end
  end
end
