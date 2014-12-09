use strict;
use warnings;
# file name
my $file = 'fileList.txt';
my $folder = 'folderList.txt';
#get list of file in a file
sub getFiles{
        my($row,@result);
        if(open(my $fh,$file) ){
                while($row = <$fh>){
                        chomp $row;
                        push @result, "$row\n";
                        #print "$row\n";
                        #$row="";
                }
        }else{
                warn "Could not open file ";
        }
        @result;
}

#get list of folder in a file
sub getFolders(){
        my($row,@result);
        if(open(my $fh,$folder)){
                while($row = <$fh>){
                        chomp $row;
                        push @result, "$row\n";
                }
        }else{
                warn "Could not open file ";
        }
        @result;
}

print "List file:"."\n";
my @kq = &getFiles();
foreach (@kq){
        print $_;
}
#
print "List folder:"."\n";
my @kq2 = &getFolders();
foreach (@kq2){
        print $_;
}
