#***********************************************************************#
#Aim : To monitor traffic for Mesh topology using NS2
#***********************************************************************#

#Create a simulator object
set ns [new Simulator]

#Define different colors for data flows (for NAM)
$ns color 1 Blue
$ns color 2 Red
$ns color 3 green

#Open the NAM trace file
set nf [open out.nam w]
$ns namtrace-all $nf

#Open the Trace file
set tf [open out.tr w]
$ns trace-all $tf

#Define a 'finish' procedure
proc finish {} {
        global ns nf tf
        $ns flush-trace
        #Close the NAM trace file
        close $nf
        #Close the Trace file
        close $tf
        #Execute NAM on the trace file
        exec nam out.nam &
        exit 0
}

#Create four nodes
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]


set n4 [$ns node]
set n5 [$ns node]
set n6 [$ns node]
set n7 [$ns node]
set n8 [$ns node]
set n9 [$ns node]


set n10 [$ns node]
set n11 [$ns node]
set n12 [$ns node]
set n13 [$ns node]
set n14 [$ns node]
set n15 [$ns node]

#Create links between the nodes
$ns duplex-link $n0 $n1 1MB 10ms DropTail
$ns duplex-link $n0 $n2 1MB 10ms DropTail
$ns duplex-link $n0 $n3 1MB 10ms DropTail
$ns duplex-link $n1 $n2 1MB 10ms DropTail
$ns duplex-link $n1 $n3 1MB 10ms DropTail
$ns duplex-link $n2 $n3 1MB 10ms DropTail
$ns duplex-link $n3 $n4 1MB 10ms DropTail



$ns duplex-link $n4 $n5 1MB 10ms DropTail
$ns duplex-link $n4 $n6 1MB 10ms DropTail
$ns duplex-link $n7 $n8 1MB 10ms DropTail
$ns duplex-link $n4 $n8 1MB 10ms DropTail
$ns duplex-link $n4 $n9 1MB 10ms DropTail
$ns duplex-link $n7 $n10 1MB 10ms DropTail


$ns duplex-link $n10 $n11 1MB 10ms DropTail
$ns duplex-link $n11 $n12 1MB 10ms DropTail
$ns duplex-link $n12 $n13 1MB 10ms DropTail
$ns duplex-link $n13 $n14 1MB 10ms DropTail
$ns duplex-link $n14 $n15 1MB 10ms DropTail
$ns duplex-link $n15 $n10 1MB 10ms DropTail


#Create a TCP agent and attach it to node n0
set tcp0 [new Agent/TCP]
$tcp0 set class_ 1
$ns attach-agent $n1 $tcp0
#Create a TCP Sink agent (a traffic sink) for TCP and attach it to node n3
set sink0 [new Agent/TCPSink]
$ns attach-agent $n13 $sink0
#Connet the traffic sources with the traffic sink
$ns connect $tcp0 $sink0

#Create a TCP agent and attach it to node n0
set tcp1 [new Agent/TCP]
$tcp1 set class_ 2
$ns attach-agent $n9 $tcp1
#Create a TCP Sink agent (a traffic sink) for TCP and attach it to node n3
set sink1 [new Agent/TCPSink]
$ns attach-agent $n5 $sink1
#Connet the traffic sources with the traffic sink
$ns connect $tcp1 $sink1



#Create a TCP agent and attach it to node n0
set tcp2 [new Agent/TCP]
$tcp2 set class_ 3
$ns attach-agent $n6 $tcp2
#Create a TCP Sink agent (a traffic sink) for TCP and attach it to node n3
set sink2 [new Agent/TCPSink]
$ns attach-agent $n2 $sink2
#Connet the traffic sources with the traffic sink
$ns connect $tcp2 $sink2



# Create a FTP traffic source and attach it to tcp0
set ftp0 [new Application/FTP]
$ftp0 set packetSize_ 1500
$ftp0 set interval_ 0.07
$ftp0 attach-agent $tcp0

# Create a FTP traffic source and attach it to tcp0
set ftp1 [new Application/FTP]
$ftp1 set packetSize_ 1500
$ftp1 set interval_ 0.1
$ftp1 attach-agent $tcp1

# Create a FTP traffic source and attach it to tcp0
set ftp2 [new Application/FTP]
$ftp2 set packetSize_ 1500
$ftp2 set interval_ 0.2
$ftp2 attach-agent $tcp2





#Schedule events for the ftp agents
$ns at 0.5 "$ftp0 start"
$ns at 1.0 "$ftp1 start"
$ns at 1.0 "$ftp2 start"
$ns at 6.0 "$ftp1 stop"
$ns at 6.5 "$ftp2 stop"
$ns at 7.0 "$ftp0 stop"

#Call the finish procedure after 5 seconds of simulation time
$ns at 7.5 "finish"

#Run the simulation
$ns run


