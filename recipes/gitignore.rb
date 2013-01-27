append_to_file '.gitignore' do
  %w(
    .rvmrc
    coverage
    .DS_Store
    *.swp
    erd.pdf
    .powrc
    public/assets
    config/aws_s3.yml
    config/sunspot.yml
    solr/data
    *.pid
    dump.rdb
  ).join("\n")
end