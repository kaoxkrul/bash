#!/usr/bin/perl -w

use strict;
use Tk;
use Tk::ROText;

my @times;
my $oldtime = "";

# Main Window
my $main = MainWindow->new();
$main->title("Elapsed Time");
$main->minsize(800, 420);
$main->maxsize(800, 420);
$main->repeat(500, \&get_time);

# Outer frame
my $out_frame = $main->Frame()->pack();

# Left frame
my $l_frame = $out_frame->Frame(-relief=>'groove',
                                -borderwidth=>5,
                                -background=>'blue'
                        )->pack(-side=>'left');

# Reft frame
my $r_frame = $out_frame->Frame(-relief=>'groove',
                                -borderwidth=>5,
                                -background=>'blue'
                        )->pack(-side=>'right');

# Real Time Clock
my $rt_frame = $l_frame->Frame(-relief=>'groove',
                            -borderwidth=>5,
                            -background=>'black'
                    )->pack(-side=>'top');

my $rt = $rt_frame -> Label(-width=>6,
                            -justify=>'right',
                            -background=>'black',
                            -foreground=>'red',
                            -font=>['lcd', 200, 'bold']
                    )->pack();

# Last Elapsed Time
my $et_frame = $l_frame->Frame(-relief=>'groove',
                               -borderwidth=>5,
                               -background=>'black'
                       )->pack(-side=>'bottom');

my $et = $et_frame -> Label(-width=>6,
                            -justify=>'right',
                            -background=>'black',
                            -foreground=>'red',
                            -font=>['lcd', 200, 'bold']
                    )->pack();

# ET History
my $eh_frame = $r_frame->Frame(-relief=>'groove',
                               -borderwidth=>5,
                               -background=>'black'
                       )->pack(-side=>'right');

my $eh = $eh_frame->ROText(-background=>'black', -foreground=>'red',
                           -width=>7,
                           -font=>['lcd', 24, 'bold']
                   )->pack();

&get_time();

MainLoop;

sub get_time {

   open(TIME,"<time.dat");
   my $time = <TIME>;
   close(TIME);
   chop($time);
   
   if ($time ne $oldtime) {
      if ($time eq "\.") {
         $rt->configure(-text=>"READY");
         $et->configure(-text=>"$oldtime");
      } else {
         $rt->configure(-text=>"$time");
         $et->configure(-text=>"$oldtime");
         $eh->insert("1.0", "$time\n");
         $oldtime = $time;
      }
   }

} 
