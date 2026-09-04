class WhereAreWe < Formula
  include Language::Python::Virtualenv

  desc "Index a codebase into a map an agent can read instead of grepping"
  homepage "https://github.com/ngavrish/where-are-we"
  url "https://files.pythonhosted.org/packages/99/55/be9d07641e907d3469bb2401a1e08f298e717745b0dfc3bfaa5eef462c69/where_are_we-0.12.3.tar.gz"
  sha256 "5e66297c85a19baeec722cde425309cbaf14cb13cdcaf50da4e52fa44127d01a"
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
