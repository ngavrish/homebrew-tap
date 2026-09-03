class WhereAreWe < Formula
  include Language::Python::Virtualenv

  desc "Index a codebase into a map an agent can read instead of grepping"
  homepage "https://github.com/ngavrish/where-are-we"
  url "https://files.pythonhosted.org/packages/b8/35/7e64e6d1dbb5971dd48c754fea3e01a4fa87066623c746e873a4c97eaa38/where_are_we-0.12.0.tar.gz"
  sha256 "44062aae5740783ca32e2fd3206f89dda9c71a20dcb38ed6636e5449eabc7f6f"
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
