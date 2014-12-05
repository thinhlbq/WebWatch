use Digest::MD5  qw(md5 md5_hex md5_base64);
use File::stat;

sub takeSnapshot(){
  my @listFiles = ('/etc/passwd','/etc/xtab','/etc/ttys');
  foreach (@listFiles){
    my $hash = md5_hex($_);
    my $inf = stat($_);
    print "Snapshoting : $_ : $hash : ".$inf->ctime." : ".$inf->mtime." \n";
  }
}

print "Beginning \n";
takeSnapshot();
print "Tested";
