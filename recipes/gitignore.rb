append_to_file '.gitignore' do
  "\n" << %w(
    .DS_Store
    *.pid
    .powrc
    .ruby-gemset
    .ruby-version
    *.swp
    config/aws_s3.yml
    config/sunspot.yml
    coverage
    dump.rdb
    erd.pdf
    public/assets
    solr/data
  ).join("\n")
end
