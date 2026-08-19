class WhereAreWe < Formula
  include Language::Python::Virtualenv

  desc "Index a codebase into a map an agent can read instead of grepping"
  homepage "https://github.com/ngavrish/where-are-we"
  url "PLACEHOLDER_URL"
  sha256 "PLACEHOLDER_SHA"
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
