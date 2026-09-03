class WhereAreWe < Formula
  include Language::Python::Virtualenv

  desc "Index a codebase into a map an agent can read instead of grepping"
  homepage "https://github.com/ngavrish/where-are-we"
  url "https://files.pythonhosted.org/packages/c5/cf/0210f794b18dc20b5bad557c84f2ee830dc376fc89e0ba7b06ab9e981c09/where_are_we-0.12.1.tar.gz"
  sha256 "d03e4955915efa80646c79dde0ec8cbbb6500d366158de7b35f03f49b28d4a11"
  license "MIT"

  depends_on "python@3.12"

  def install
    virtualenv_install_with_resources
  end

  test do
    (testpath/"steps").mkpath
    (testpath/"steps/a.py").write <<~PY
      from behave import step

      @step("a user exists")
      def f(context):
          pass
    PY
    system bin/"where-are-we", "--repo", testpath, "--out", testpath/"map", "--quiet"
    assert_predicate testpath/"map/framework_map_brief.md", :exist?
  end
end
