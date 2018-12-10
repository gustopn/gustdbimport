{
  firstseparation = index($0, " ");
  shasum = substr($0, 0, firstseparation - 1);
  filepath = substr($0, firstseparation + 1);
  print "sha sum is: \"" shasum "\"\nfilepath is: \"" filepath "\"\n";
}