# This file has been generated by node2nix 1.7.0. Do not edit!

{nodeEnv, fetchurl, fetchgit, globalBuildInputs ? []}:

let
  sources = {
    "commander-2.20.0" = {
      name = "commander";
      packageName = "commander";
      version = "2.20.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/commander/-/commander-2.20.0.tgz";
        sha512 = "7j2y+40w61zy6YC2iRNpUe/NwhNyoXrYpHMrSunaMG64nRnaf96zO/KMQR4OyN/UnE5KLyEBnKHd4aG3rskjpQ==";
      };
    };
    "source-map-0.6.1" = {
      name = "source-map";
      packageName = "source-map";
      version = "0.6.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/source-map/-/source-map-0.6.1.tgz";
        sha512 = "UjgapumWlbMhkBgzT7Ykc5YXUT46F0iKu8SGXq0bcwP5dz/h0Plj6enJqjz1Zbq2l5WaqYnrVbwWOWMyF3F47g==";
      };
    };
  };
in
{
  uglify-js = nodeEnv.buildNodePackage {
    name = "uglify-js";
    packageName = "uglify-js";
    version = "3.6.0";
    src = fetchurl {
      url = "https://registry.npmjs.org/uglify-js/-/uglify-js-3.6.0.tgz";
      sha512 = "W+jrUHJr3DXKhrsS7NUVxn3zqMOFn0hL/Ei6v0anCIMoKC93TjcflTagwIHLW7SfMFfiQuktQyFVCFHGUE0+yg==";
    };
    dependencies = [
      sources."commander-2.20.0"
      sources."source-map-0.6.1"
    ];
    buildInputs = globalBuildInputs;
    meta = {
      description = "JavaScript parser, mangler/compressor and beautifier toolkit";
      homepage = "https://github.com/mishoo/UglifyJS2#readme";
      license = "BSD-2-Clause";
    };
    production = true;
    bypassCache = true;
    reconstructLock = true;
  };
}