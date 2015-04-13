require 'rake/testtask'

task default: %w[test]

Rake::TestTask.new do |t|
  t.name = "testcss"
  t.test_files = FileList['test/CssParserTest.rb']
  t.verbose = true
end


Rake::TestTask.new do |t|

  t.name = "test:unit:css"
  t.test_files = FileList['test/unit/CSS/UnitTestsCSS*.rb']
  t.verbose = false
end

Rake::TestTask.new do |t|

  t.name = "test:unit:util"
  t.test_files = FileList['test/unit/util/UnitTests*.rb']
  t.verbose = false
end

task 'test:unit' do
	Rake::Task["test:unit:util"].execute
	Rake::Task["test:unit:css"].execute
end

task :test do
	ruby "lib/Toygine.rb test/test_pages/link_test.html"
	ruby "lib/Toygine.rb test/test_pages/attribute_test.html"
	ruby "lib/Toygine.rb test/test_pages/small.html"
	ruby "lib/Toygine.rb test/test_pages/img_tag.html"	
end
