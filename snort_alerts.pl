#!/usr/bin/perl -w
####################################################
#     Program:  snort_attacks.pl
#  Programmer:  Rob Krul
#        Date:  17 July, 2003
#
# Description:  Obtain number of tcp, udp, icmp,
#               portscan, and total attacks from
#               the Snort database. Output in a
#               a format acceptable for a Cacti
#               Data Input Method.
#
#       Input:  Snort MySQL Data
#      Output:  Totals from last 10 minutes:
#               
#      tcp:11 udp:0 icmp:1 portscan:3 total:15
#
#     History:
# Date      Comment
# -------   ----------------------------------------
# 17JUL03 - Rob Krul - Initial Version
####################################################

use DBI;
use strict;

my $dbname = "snort";
my $dsn    = "DBI:mysql:$dbname";
my $dbuser = "snort";
my $dbpass = "snort";

my $db = DBI->connect( $dsn, $dbuser, $dbpass );

my $interval = 10;
my $sql = "";

####################################################
# Get total attacks in last $interval minutes
####################################################
$sql = "SELECT COUNT(*) FROM event " .
       "WHERE timestamp > (DATE_SUB(NOW(), INTERVAL $interval MINUTE))";
my $sth = $db->prepare($sql);
$sth->execute();
my $total = $sth->fetchrow_array;
$sth->finish;

####################################################
# Get tcp attacks in last $interval minutes
####################################################
$sql = "SELECT count(*) FROM event " .
       "INNER JOIN iphdr ON event.cid = iphdr.cid " .
       "WHERE ip_proto=6 " .
       "AND timestamp > (DATE_SUB(NOW(), INTERVAL $interval MINUTE))";
$sth = $db->prepare($sql);
$sth->execute();
my $tcp = $sth->fetchrow_array;
$sth->finish;

####################################################
# Get udp attacks in last $interval minutes
####################################################
$sql = "SELECT count(*) FROM event " .
       "INNER JOIN iphdr ON event.cid = iphdr.cid " .
       "WHERE ip_proto=17 " .
       "AND timestamp > (DATE_SUB(NOW(), INTERVAL $interval MINUTE))";
$sth = $db->prepare($sql);
$sth->execute();
my $udp = $sth->fetchrow_array;
$sth->finish;

####################################################
# Get icmp attacks in last $interval minutes
####################################################
$sql = "SELECT count(*) FROM event " .
       "INNER JOIN iphdr ON event.cid = iphdr.cid " .
       "WHERE ip_proto=1 " .
       "AND timestamp > (DATE_SUB(NOW(), INTERVAL $interval MINUTE))";
$sth = $db->prepare($sql);
$sth->execute();
my $icmp = $sth->fetchrow_array;
$sth->finish;


####################################################
# Get portscan attacks in last $interval minutes
####################################################
$sql = "SELECT count(event.sid) FROM event " .
       "LEFT JOIN signature ON event.signature=signature.sig_id " .
       "WHERE sig_name LIKE 'spp_portscan%' " .
       "AND timestamp > (DATE_SUB(NOW(), INTERVAL $interval MINUTE))";
$sth = $db->prepare($sql);
$sth->execute();
my $portscan = $sth->fetchrow_array;
$sth->finish;

$db->disconnect;

####################################################
# Output Results
####################################################
print "tcp:$tcp udp:$udp icmp:$icmp portscan:$portscan total:$total";
