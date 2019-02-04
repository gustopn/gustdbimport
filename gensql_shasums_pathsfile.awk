BEGIN {
  if (table == "") {
    table = "$tablename";
  }
  if (granularity == "" ) {
    granularity = 100;
  }
  indexcounter = 0;
  insertinto = "INSERT INTO " table " (sum, path, file, extension) VALUES ";
}
{
  firstseparation = index($0, " ");
  shasum = substr($0, 0, firstseparation - 1);
  filepath = substr($0, firstseparation + 1);
  pathlen = split(filepath, pathlist, "/");
  filename = pathlist[pathlen];
  filenamepartlen = split(filename, filenamepartlist, ".");
  if (filenamepartlen > 1) {
    fileextension = filenamepartlist[filenamepartlen];
  } else {
    fileextension = "";
  }
  if ( indexcounter < granularity ) {
    if ( output == "" ) {
      output = insertinto;
    }
    if ( length(output) > length(insertinto) ) {
      output = output ", ";
    }
  } else {
    print output ";";
    indexcounter = 0;
    output = insertinto;
  }
  output = output "( \"" shasum "\", \"" filepath "\", \"" filename "\", \"" fileextension "\" )";
  indexcounter = indexcounter + 1;
}
END {
  print output ";";
}