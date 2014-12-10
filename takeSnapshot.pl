use Digest::MD5  qw(md5 md5_hex md5_base64);
use File::stat;
use DateTime;
#use warning;

sub takeSnapshot(){
  my $dt = DateTime->now;
  my $now = join '-', $dt->ymd, $dt->hms;
  open(my $fh, '>' ,'snapshots/'.$now);
  # It should be replaced by the output from configuration module
  my @listFiles = ('/etc/passwd','/etc/xtab','/etc/ttys','test/');
  foreach (@listFiles){
    my $hash = md5_hex($_);
    my $inf = stat($_);
    print $fh "$_:$hash:".$inf->ctime.":".$inf->mtime.":".$inf->size."\n";
    print "Snapshoting : $_\n";
  }
  close $fh;
}

print "Taking snapshot \n";
takeSnapshot();
print "[+] Done!";
