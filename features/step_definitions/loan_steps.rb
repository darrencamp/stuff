Then /^the loan counter should be (\d+)$/ do |arg1|
  within('#loan-counter') do
    page.should(have_content(arg1))
  end
end

Then /^the borrowing counter should be (\d+)$/ do |arg1|
  within('#borrowing-counter') do
    page.should(have_content(arg1))
  end
end