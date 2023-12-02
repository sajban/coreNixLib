let
  inherit (builtins)
    catAttrs attrNames hasAttr getAttr mapAttrs listToAttrs concatStringsSep
    foldl' elem length elemAt head tail filter concatMap sort lessThan fromJSON
    toJSON readFile toFile intersectAttrs functionArgs typeOf isAttrs deepSeq
    trace getFlake isList isFunction;

in
rec {
  sortAscending = list: sort lessThan list;
  lowestOf = list: head sortAscending;
  highestOf = list: tail sortAscending;

  importJSONFile = path: fromJSON (readFile path);

  removeSelf = inputs: removeAttrs inputs [ "self" ];

  exportJSONFile = neim: datom: toFile neim (toJSON datom);

  mkStoreHashPrefix = object: builtins.substring 11 7 object.outPath;

  message = pred: msg:
    if pred then true
    else trace msg false;
  
  mkImplicitVersion = src:
    assert message
      ((hasAttr "shortRev" src) || (hasAttr "narHash" src))
      "Missing implicit version hints";
    let
      shortHash = cortHacString src.narHash;
    in
      src.shortRev or shortHash;

  hasSingleAttr = attrs: (length (attrNames attrs)) == 1;

  cortHacPath = path: builtins.hashFile "sha256" path;

  mkStringHash = String: builtins.hashString "sha256" String;

  cortHacString = string:
    builtins.substring 0 7 (mkStringHash string);

  cortHacFile = file:
    builtins.substring 0 7
      (builtins.hashFile "sha256" file);

  arkSistymMap = {
    x86-64 = "x86_64-linux";
    amd64 = "x86_64-linux";
    i686 = "i686-linux";
    x86 = "i686-linux";
    aarch64 = "aarch64-linux";
    arm64 = "aarch64-linux";
    armv8 = "aarch64-linux";
    armv7l = "armv7l-linux";
    armv = "armv7l-linux";
    avr = "avr-none";
  };

  mkSaizAtList = saiz: {
    min = saiz >= 1;
    med = saiz >= 2;
    max = saiz == 3;
  };

  matcSaiz = saiz: ifNon: ifMin: ifMed: ifMax:
    let saizAtList = mkSaizAtList saiz;
    in
    if saizAtList.max then ifMax
    else if saizAtList.med then ifMed
    else if saizAtList.min then ifMin
    else ifNon;

  mkLamdy = { klozyr, lamdy }:
    let
      rykuestydDatomz = functionArgs lamdy;
      rytyrndDatomz = intersectAttrs rykuestydDatomz klozyr;
    in
    lamdy rytyrndDatomz;

  mkLamdyz = { lamdyz, klozyr }:
    mapAttrs
      (n: v:
        mkLamdy { inherit klozyr; lamdy = v; }
      )
      lamdyz;

  rem = a: b:
    a - (b * (a / b));

  isOdd = number:
    let remainder = rem number 2; in
    remainder == 1;

}
