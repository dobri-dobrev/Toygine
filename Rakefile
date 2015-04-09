require 'rake/testtask'

task default: %w[test]

Rake::TestTask.new do |t|
  t.libs << "lib"
  t.name = "testcss"
  t.test_files = FileList['test/CssParserTest.rb']
  t.verbose = true
end

Rake::TestTask.new do |t|
  t.libs << "lib"
  t.name = "test:unit"
  t.test_files = FileList['test/SpecificityTest.rb']
  t.verbose = false
end

task :test do
	ruby "lib/Toygine.rb test/test_pages/link_test.html"
	ruby "lib/Toygine.rb test/test_pages/attribute_test.html"
	ruby "lib/Toygine.rb test/test_pages/small.html"
	ruby "lib/Toygine.rb test/test_pages/img_tag.html"	
end
