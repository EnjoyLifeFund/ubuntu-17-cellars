# apr: Build a bottle for Linuxbrew
class Apr < Formula
  desc "Apache Portable Runtime library"
  homepage "https://apr.apache.org/"
  url "https://www.apache.org/dyn/closer.cgi?path=apr/apr-1.5.2.tar.bz2"
  sha256 "7d03ed29c22a7152be45b8e50431063736df9e1daa1ddf93f6a547ba7a28f67a"
  revision OS.mac? ? 3 : 5

  keg_only :provided_by_osx, "Apple's CLT package contains apr."

  option :universal

  depends_on "util-linux" => :recommended if OS.linux? # for libuuid

  def install
    ENV.universal_binary if build.universal?
    ENV["SED"] = "sed" # prevent libtool from hardcoding sed path from superenv

    # https://bz.apache.org/bugzilla/show_bug.cgi?id=57359
    # The internal libtool throws an enormous strop if we don't do...
    ENV.deparallelize

    if OS.linux? && build.bottle?
      # Prevent hardcoded /usr/bin/gcc-4.8 compiler
      ENV["CC"] = "cc"
    end

    # Stick it in libexec otherwise it pollutes lib with a .exp file.
    system "./configure", "--prefix=#{libexec}"
    system "make", "install"
    bin.install_symlink Dir["#{libexec}/bin/*"]
    lib.install_symlink Dir["#{libexec}/lib/*.so*"] unless OS.mac?

    # No need for this to point to the versioned path.
    inreplace libexec/"bin/apr-1-config", libexec, opt_libexec
  end

  test do
    assert_match opt_libexec.to_s, shell_output("#{bin}/apr-1-config --prefix")
  end
end
