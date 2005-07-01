Date: Fri, 1 Jul 2005 17:20:15 -0400 (EDT)
From: "Mark S. Mathews" <mark@linux-wlan.com>
Subject: Re: [Bridge] bridge-utils + Linksys WET11
In-Reply-To: <42C59E66.8050906@ntbox.com>
Message-ID: <Pine.LNX.4.63.0507011700480.10011@chef.linux-wlan.com>
References: <42C59E66.8050906@ntbox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: North Antara <north@ntbox.com>
Cc: bridge@lists.osdl.org


Without a good sniff, it's hard to know for sure but...

Because of the games that have to be played to build WLAN station bridge 
devices, some have a problem with what I call 'b/mcast echo'.  Basically, 
what happens is this:
   1) the WLAN bridge (call it WB) device picks up a broadcast frame (like
      the arp request from a2:a9) from it's ethernet interface,
   2) WB forwards the the bcast frame to the WLAN AP via a unicast WLAN
      frame (this is normal behavior),
   3) WLAN APs, by default, take 'unicast encapsulated' broadcast frames
      received on the WLAN interface and rebroadcast them on the air _as_
      broadcast frames (this occurs inside the WLAN mac layer so any
      bridging in the AP itself would have no effect on this problem),
   4) The WB picks up the rebroadcasted bcast frame and forwards it to the
      wire, hence the broadcast frame shows up on the wire twice.

In a bridge situation, the bridge would first see the bcast frame on port 
2 (the original transmission), then some time later it would see it again 
on port 4 (the echo).  When the bridge sees the frame arrive on port 4, it 
moves the port assignment for that macaddr thus misdirecting any 
subsequent unicast traffic sent to that macaddr.

I honestly don't know if the WET11 suffers from this particular issue, but 
it is one potential explanation for your observations.

If you ran a sniffer (tcpdump, ethereal, etc) on your br0 or on the 
individual ethX ports you should be able to confirm if this behavior is 
what you're seeing.

The other thing to look at is to check if there's a firmware upgrade for 
the WET11.  The problem may already be fixed.

Have fun,
-Mark


On Fri, 1 Jul 2005, North Antara wrote:

> So, I'm setting up my first bridge, and I'm running into an interesting
> issue.
>
> I have a 4 port NIC (formerly 4 seperate /29 and /28 LANs) and an
> onboard NIC (to my ISP).
>
> I've setup the bridge using the script included at the bottom of this
> email (modified from Gentoo for Aurora).
>
> When the WET11 (the WET11 is a simple ethernet to wireless bridge) is
> unplugged, the bridge works wonderfully.  I'm able to connect out to the
> internet, and clients are able to talk to each other.
>
> When the WET11 is plugged in is when things start acting up.  Every
> client (including those behind the WET11) are able to connect out to the
> internet, but clients cannot talk to each other.  If Client A(port 1)
> tries to connect to Client B(port 2), `brctl showmacs br100` shows that
> Client B moved to port 4(port 4 is where the WET11 is plugged in.  If I
> change the WET11 port, the port Client B moves to is also changed), and
> the router can no longer ping Client B.
>
> [root@deadbeef root]# brctl showmacs br100
> port no mac addr                is local?       ageing timer
>  2     00:02:a5:d3:a2:a9       no                19.71
>  1     00:04:5a:6f:f4:66       no                 0.01
>  4     00:12:17:47:90:43       no                 0.43
>  4     00:13:10:16:1e:19       no                 8.43
>  1     08:00:20:ad:0b:58       yes                0.00
>  2     08:00:20:ad:0b:59       yes                0.00
>  3     08:00:20:ad:0b:5a       yes                0.00
>  4     08:00:20:ad:0b:5b       yes                0.00
>
> after pinging Client B from Client A...Client B moves.
>
> [root@deadbeef root]# brctl showmacs br100
> port no mac addr                is local?       ageing timer
>  4     00:02:a5:d3:a2:a9       no                 0.10   <-- note the port change
>  1     00:04:5a:6f:f4:66       no                 0.00
>  4     00:12:17:47:90:43       no                 0.49
>  4     00:13:10:16:1e:19       no                12.76
>  1     08:00:20:ad:0b:58       yes                0.00
>  2     08:00:20:ad:0b:59       yes                0.00
>  3     08:00:20:ad:0b:5a       yes                0.00
>  4     08:00:20:ad:0b:5b       yes                0.00
>
>
> I've read in the archives that wireless NICs would cause issues, but
> that shouldn't be the case here, since the router doesn't even know it's
> wireless, should it?
>
> Is this some sort of stp issue?
>
> Any suggestions would be much appreciated.  I'm out of ideas.
>
>
> #!/bin/bash
> #
> bridge="br100"
> bridge_br100_devices="eth1 eth2 eth3 eth4"
> bridge_br100_ip="192.168.1.1"
>
> return=$rc_done
> case "$1" in
>
>    start)
>        for b in ${bridge}
>        do
>                echo "Create Bridge ${b}"
>                /usr/sbin/brctl addbr ${b} || {
>                        retval=$?
>                        echo ${retval} "Failed to create bridge ${b}"
>                        continue
>                }
>                for i in $(eval echo \$\{bridge_${b}_devices\})
>                do
>                        /usr/sbin/brctl addif ${b} ${i} || {
>                                retval=$?
>                                echo ${retval} "Failed to add interface
> ${i}"
>                                continue
>                        }
>                        ifconfig ${i} 0.0.0.0 promisc || \
>                                echo $? "Failed to set up interface ${i}"
>                done
>                ifconfig $b $(eval echo \$\{bridge_${b}_ip\})
>
>                brctl setbridgeprio ${b} 0
>
>                brctl sethello ${b} 1
>                brctl setmaxage ${b} 4
>                brctl setfd ${b} 4
>                brctl stp ${b} on
>        done
>
>        echo -e "$return"
>        ;;
>    [snip]the rest of the script isn't relevant[/snip]
> esac
>
> _______________________________________________
> Bridge mailing list
> Bridge@lists.osdl.org
> https://lists.osdl.org/mailman/listinfo/bridge
>

-- 

Mark S. Mathews

AbsoluteValue Systems      Web:    http://www.linux-wlan.com
721-D North Drive          e-mail: mark@linux-wlan.com
Melbourne, FL 32934        Phone:  321.259.0737
USA                        Fax:    321.259.0286
