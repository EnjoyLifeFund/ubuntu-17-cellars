class Gpatch < Formula
  desc "Apply a diff file to an original"
  homepage "https://savannah.gnu.org/projects/patch/"
  url "https://ftpmirror.gnu.org/patch/patch-2.7.5.tar.xz"
  mirror "https://ftp.gnu.org/gnu/patch/patch-2.7.5.tar.xz"
  sha256 "fd95153655d6b95567e623843a0e77b81612d502ecf78a489a4aed7867caa299"

  def install
    system "./configure", "--disable-dependency-tracking", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    testfile = testpath/"test"
    testfile.write "homebrew\n"
    patch = <<-EOS.undent
      1c1
      < homebrew
      ---
      > hello
    EOS
    pipe_output("#{bin}/patch #{testfile}", patch)
    assert_equal "hello", testfile.read.chomp
  end
end
