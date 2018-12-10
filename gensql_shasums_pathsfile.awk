BEGIN {
  if (table == "") {
    table = "$tablename";
  }
  if (granularity == "" ) {
    granularity = 100;
  }
  indexcounter = 0;
  insertinto = "INSERT INTO " table " (sum, path) VALUES ";
}
{
  firstseparation = index($0, " ");
  shasum = substr($0, 0, firstseparation - 1);
  filepath = substr($0, firstseparation + 1);
  if ( indexcounter < granularity ) {
    if ( output == "" ) {
      output = insertinto;
    }
    if ( length(output) > length(insertinto) ) {
      output = output ", ";
    }
    output = output "( \"" shasum "\", \"" filepath "\" )";
  } else {
    print output ";";
    indexcounter = 0;
    output = insertinto "( \"" shasum "\", \"" filepath "\" )";
  }
  indexcounter = indexcounter + 1;
}
END {
  print output ";";
}