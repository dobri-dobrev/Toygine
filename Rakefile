task default: %w[test]

task :test do
	ruby "lib/Toygine.rb test/test_pages/attribute_test.html"
	ruby "lib/Toygine.rb test/test_pages/small.html"
	ruby "lib/Toygine.rb test/test_pages/img_tag.html"	
end
task :testcss do
	ruby "test/CssParserTest.rb"
end