Message-ID: <4B5761DF.7010608@pythian.com>
Date: Wed, 20 Jan 2010 15:04:47 -0500
From: Brad Hudson <hudson@pythian.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [Bridge] Incoming packets not always traversing the bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hi all;

I have an odd problem that I have been dealing with for a week.  I was
hoping someone could help, or point me in the right direction for clues.

I have a standard bridge setup.  br0 is composed of eth0 and eth1.

# brctl show bro
bridge name     bridge id               STP enabled     interfaces
br0             8000.000c292280b9       no              eth0
                                                        eth1

Eth0 and eth1 both have 0.0.0.0 (no) address assigned and are up.  br0
is assigned the proper IP and the routing table is correct.  STP is off.

I have been losing connectivity to hosts inside the local segment of the
bridge.  Some investigation has revealed that the problem is related to
arp not working correctly.  Arp packets going this way

eth1->br0->eth0->network/internet

have no problems at all.  The replies coming back the other way all get
to br0, but only 33% (approx, it varies) make it to the eth1 side of the
bridge.  I have verified this traffic pattern by tcpdump of arp packets
through each of these devices while doing an nmap -sP of the /24 network
to generate both arp and icmp.  We are not able to arp any host outside
our local segment, including the default gateway (which is owned by the
co-lo).  nmapping from the bridging server itself from interface br0
gets the correct number of arp replies.

ebtables and arp_tables are not running, and adding them in has had no
change in result.  There was a server with 2 NICs, each with an IP on
the same subnet, that was causing some MAC flapping but that has been
fixed and no change to the described behaviour.  All items in
/proc/sys/net/bridge are set to '1', but setting them to '0' has no
effect.  The server hosting the bridge has been rebooted several times
with no effect.  proxy_arp does not help at all.  I also tried
parprouted with no success.

A couple other notes.

- This behaviour suddenly appeared about a week ago.  I think this is
probably related to an increase in network traffic but it's hard to say,
the client does not buy into that statement.  If it was a matter of 0
work or all work then there's places to look for that, but in this case
the problem is intermittent and the lost arp replies are not the same
every time.
- In another test we found that if we ping the inside server from the
firewall and also from an external machine the connectivity to the
inside server dies.  Once the pings are stopped, the connectivity
eventually returns.  If I ping out from the inside server while doing
that test, the session keeps going through without hanging.
- The firewall is a Vm running under ESX.  The vmxnet driver has been
reinstalled and the pcnet32 driver is not loaded.  Both NICs are virtual
so there is no chance of failed hardware, though I suppose the problem
could be on the ESX layer.  I have made some attempt to diagnose the WSX
layer but nothing jumps out at me.

I have been watching tcpdumps and do not see any sign of frags, dupes,
or anything that would cause lost packets.  I have combed the
newsgroups, google and even irc looking for clues or similar situations,
but nothing I have found fits the profile.

The workaround we currently have in place is to make a static arp entry
for the gateway on all servers on the inside.  This is not ideal because
the co-lo controls the router and it could fail over to another device
which would kill our route again.

Can anyone suggest anyplace I can look for clues, settings I should
check or other?  I am out of ideas at this point.

Your help is very much appreciated.

Regards;

Brad



-- 
Brad Hudson
SA Team Lead
The Pythian Group - love your data
Desk: 613-565-8696 x202
IM: pythianhudson

--
Client of Pythian? On twitter? Let @paulvallee know and we'll add you
to @pythian/clients!


