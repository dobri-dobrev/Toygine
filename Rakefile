require 'rake/testtask'

task default: %w[test]

Rake::TestTask.new do |t|
  t.name = "testcss"
  t.test_files = FileList['test/CssParserTest.rb']
  t.verbose = true
end

Rake::TestTask.new do |t|

  t.name = "test:unit:html"
  t.test_files = FileList['test/unit/HTML/UnitTests*.rb']
  t.verbose = false
end

Rake::TestTask.new do |t|

  t.name = "test:unit:css"
  t.test_files = FileList['test/unit/CSS/UnitTests*.rb']
  t.verbose = false
end

Rake::TestTask.new do |t|

  t.name = "test:unit:util"
  t.test_files = FileList['test/unit/util/UnitTests*.rb']
  t.verbose = false
end

Rake::TestTask.new do |t|

  t.name = "test:unit:style"
  t.test_files = FileList['test/unit/style/UnitTests*.rb']
  t.verbose = false
end

Rake::TestTask.new do |t|

  t.name = "test:unit:layout"
  t.test_files = FileList['test/unit/layout/UnitTests*.rb']
  t.verbose = false
end

task 'test:unit' do
	puts "UTIL UNIT TESTS"
	Rake::Task["test:unit:util"].execute
	puts "CSS UNIT TESTS"
	Rake::Task["test:unit:css"].execute
    puts "HTML UNIT TESTS"
    Rake::Task["test:unit:html"].execute
    puts "STYLE UNIT TESTS"
	Rake::Task["test:unit:style"].execute
	puts "LAYOUT UNIT TESTS"
	Rake::Task["test:unit:layout"].execute
end

task 'test:all' do
	Rake::Task["test:unit"].execute
	Rake::Task["testcss"].execute
	Rake::Task["test:link"].execute
	Rake::Task["test"].execute
end

task :test do
	ruby "lib/Toygine.rb test/test_pages/attribute_test.html"
	ruby "lib/Toygine.rb test/test_pages/small.html"
	ruby "lib/Toygine.rb test/test_pages/img_tag.html"
end

task 'test:link' do
	ruby "lib/Toygine.rb test/test_pages/link_test.html"		
end
