MIME-Version: 1.0
Date: Sat, 18 Jul 2009 13:51:04 +0530
Message-ID: <9a2da8520907180121o379ff3bxdd2c2651707fca03@mail.gmail.com>
From: Deepjyoti Kakati <dkakati73@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Bridge] problem with bridge and tap interfaces
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

I am facing a issue with bridge that apparently stops fwding and
hoping someone can point out what
is going wrong or give some clues.

am using linux 2.6.27 and corresponding bridgeutils pkg.

my topology inside the machine is like this

                                                   172.16.0.3
                 172.16.0.2
(Server_daemon)....udp socket......[ my_bridge
].............tap0......[Virtual machine1]
  atop kernel                                        !          !
                                                          !          !
                                                        tap1
tap2........[virtual machine3]
                                                          !
                                                [virtual machine2]


I create a few virtual machines using qemu and have their tap
interfaces hook into
the bridge.

virtual machine1 internally assigns 172.16.0.2 to its virtual nic

the bridge itself has address 172.16.0.3

my server binds a UDP socket to a {fixed port, 172.16.0.3} and takes
heartbeats and messages
from virtual machine1 who is UDP client and binds to 172.16.0.2

things work fine and packets flow both ways

STP is turned off by default as per "brctl show"

trouble starts when I shut down virtual machine2 or 3 and detach the
tap1 or tap2 from
the bridge. the detach sequence I used is:

ifconfig tap1 down
brctl delif br_internal tap1
ifconfig tap1 up

I would expect the bridge to keep on forwarding pkts to and from tap0
port which is
still attached, however i see sometimes the bridge receives frames from tap0
(heartbeats from virtual machine1) but my socket never gets it and is
blocked in recvfrom()

this condition lasts from 10-40 seconds before things get back to normal.

I think my socket is ok because I sent a message to it from another
thread while this
condition was happening and this dummy message instantly came to recvfrom().

tried turning on STP and setting fwd delay of 0 to no avail. also
tried explicitly setting the
promiscuous flag with ifconfig.

/var/log/messages does not show tap0 going out of forwarding state. it
appears normal.
the port thats detached goes into disabled state which is expected.

if there is anything wrong with my approach or there is some known
issue with bridge
forwarding during topology change, kindly let me know.

I need to be able to attach and detach taps dynamically without
affecting traffic on
other ports as the VLANs used by the virtual machines can be changed on the fly.
multiple virtual machine tap's could be hooked onto the same bridge
(vlan) hence the
issue.

thanks
Deepjyoti Kakati
