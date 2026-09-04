class WhereAreWe < Formula
  include Language::Python::Virtualenv

  desc "Index a codebase into a map an agent can read instead of grepping"
  homepage "https://github.com/ngavrish/where-are-we"
  url "https://files.pythonhosted.org/packages/8c/e2/822e8d4417266843faa53d27fbf84ca9deec7f1f428d36452703c668cd77/where_are_we-1.0.0.tar.gz"
  sha256 "f36ad83dd070ac53a777d5dfa67c2c9771c45bae7b6184aaac8497bd046552c6"
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
