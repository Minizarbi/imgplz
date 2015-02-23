#!/usr/bin/perl -w

if ($ARGV[0] eq "--help") {
	print "Usage: imgplz [-nNUMBER] arg1 [arg2] ...\n";
	exit 0;
}

my $page;
my $nbr;
if ($ARGV[0] =~ /-n(\d+)/) {
	$nbr = $1;
	shift (@ARGV);
} else {
	$nbr = 1;
}

print "<!DOCTYPE HTML><html><body>\n";
foreach $word (@ARGV) {
	print "<p><b>$word</b>";
	$word =~ s/ /%20/g;
	$page = `curl -A'Mozilla/5.0' 'https://www.google.fr/search?tbm=isch&q=$word&num=$nbr' 2>/dev/null`;
	while ($page =~ /(<img.*?>)/g) {
		print "$1";
	}
	print "</p>\n";
}
print "</body></html>\n";
