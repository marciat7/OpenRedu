BREADCRUMB_MAPPINGS = {
  "User" => ['wall'],
  "Space" => %w(space course environment),
  "Lecture" => %w(lecture subject space course environment)
}

shared_examples_for "having breadcrumbs" do |statusable_type|
  before  do
    get "/api/statuses/#{status.id}", get_params
  end

  let(:representation) { parse(response.body) }

  context "when statusable is a #{statusable_type}" do
    BREADCRUMB_MAPPINGS[statusable_type].each do |breadcrumb_link|
      include_examples 'breadcrumb link', breadcrumb_link
    end
  end
end

shared_examples_for 'breadcrumb link' do |breadcrumb_link|
  it "should have the breadcrumb link #{breadcrumb_link}" do
    link_to(breadcrumb_link, representation).should_not be_blank
  end

  %w(name permalink href).each do |attr|
    it "should have breadcrumb link #{breadcrumb_link} with attr #{attr}" do
      link_to(breadcrumb_link, representation)[attr].should_not be_blank
    end
  end

  def link_to(rel, representation)
    representation.fetch('links', []).detect { |l| l['rel'] == rel }
  end
end
