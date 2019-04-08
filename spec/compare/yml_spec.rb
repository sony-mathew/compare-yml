RSpec.describe Compare::YML do
  it 'has a version number' do
    expect(Compare::VERSION).not_to be nil
  end

  it 'show source file missing error message if no source file is given' do
    compare = Compare::YML.new(nil, './fixtures/a.yml')
    expect { compare.process }.to output("We need a source file to work with.\nExiting...\n").to_stdout
  end


  it 'show target file missing error message if no target file is given' do
    compare = Compare::YML.new('./fixtures/a.yml', nil)
    expect { compare.process }.to output("We need a target file to work with.\nExiting...\n").to_stdout
  end

  it 'compares two files and get the keys differences' do
    compare = Compare::YML.new('./spec/fixtures/a.yml', './spec/fixtures/b.yml')
    expect { compare.process }.to output("Missing from a.yml:\n  - india\n\nMissing from b.yml:\n  - armenia\n\n").to_stdout
  end
end
