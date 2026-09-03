class WhereAreWe < Formula
  include Language::Python::Virtualenv

  desc "Index a codebase into a map an agent can read instead of grepping"
  homepage "https://github.com/ngavrish/where-are-we"
  url "https://files.pythonhosted.org/packages/00/de/99786d07462d7ae7bb80acbf7e24f57f295e9467b8cb1e54bf3fa0422fc4/where_are_we-0.12.2.tar.gz"
  sha256 "0ffc0d65d9df8c1bcb8cd914c9d13ce9d0f2df0269194370e020c75510f0b521"
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
