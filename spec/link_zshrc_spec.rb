describe ".zshrc" do
  it "'s linked" do
    path = File.join(ENV['HOME'],".zshrc")
    expect(File.symlink?(path)).to be_truthy
    expect(File.readlink(path)).to eq("dot-files/.zshrc")
  end
end
