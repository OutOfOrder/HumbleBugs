shared_examples "can not X to any" do |*privileges|
  privileges.each do |privilege|
    it "should not be able to #{privilege} any" do
      should_not be_allowed_to privilege, true
    end
  end
end

shared_examples "can X to all" do |*privileges|
  privileges.each do |privilege|
    it "should be able to #{privilege} all" do
      should be_allowed_to privilege
    end
  end
end