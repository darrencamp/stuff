Then /^the loan counter should be (\d+)$/ do |arg1|
  within('.counter .loan') do
    page.should(have_content(arg1))
  end
end

Then /^the borrowing counter should be (\d+)$/ do |arg1|
  within('.counter .borrowing') do
    page.should(have_content(arg1))
  end
end