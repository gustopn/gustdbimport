BEGIN {
  if (table == "") {
    table = "$tablename";
  }
  if (granularity == "" ) {
    granularity = 100;
  }
  indexcounter = 0;
}
{
  firstseparation = index($0, " ");
  shasum = substr($0, 0, firstseparation - 1);
  filepath = substr($0, firstseparation + 1);
  if ( indexcounter < 100 ) {
    if ( output == "" ) {
      output = "INSERT INTO " table " (sum, path) VALUES ";
    }
    output = output "( \"" shasum "\", \"" filepath "\" )";
  } else {
    output = output ";\nINSERT INTO " table " (sum, path) VALUES ";
    output = output "( \"" shasum "\", \"" filepath "\" )";
    indexcounter = 0;
  }
  indexcounter = indexcounter + 1;
}
END {
  print output ";";
}