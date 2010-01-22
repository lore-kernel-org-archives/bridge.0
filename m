Message-ID: <4B591867.50202@pythian.com>
Date: Thu, 21 Jan 2010 22:15:51 -0500
From: Brad Hudson <hudson@pythian.com>
MIME-Version: 1.0
References: <4B5761DF.7010608@pythian.com>	
	<c5b98f841001201230m39bc42e1nf2f7294004786d65@mail.gmail.com>	
	<4B5775C0.3000800@pythian.com>	
	<c5b98f841001201332s3d2fc90cy8c8fcc4896ee5d14@mail.gmail.com>	
	<158191213-1264088664-cardhu_decombobulator_blackberry.rim.net-1129058266-@bda367.bisx.prod.on.blackberry>
	<c5b98f841001210819u4ddd9545sf08e39edcee99ad5@mail.gmail.com>
In-Reply-To: <c5b98f841001210819u4ddd9545sf08e39edcee99ad5@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Incoming packets not always traversing the bridge
Reply-To: hudson@pythian.com
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Robert LeBlanc <robert@leblancnet.us>
Cc: bridge@lists.linux-foundation.org

Robert;

This is becoming off topic for the list, so we should probably keep
responses off from this point.  Unless anyone else is still interested. :)

I spoke with an implementation engineer who deals exclusively with
vmware.  I discussed the issue with him and he agrees with the
assessment you got from vmware.  The issues lies in incomplete network
switching code, what they referred to as a cheat.

The answer he had was to upgrade to vSphere 4.0.  He said even then it
may take some fiddling to make it work properly.  The sure fire fix
would be to use vSphere Enterprise Plus with a Cisco Nexus 1000, which
is a real switch in virtual space and can replace the VMWare network
hypervisor.  These things are wicked cool, but it's a huge cost just to
get around this problem.

I had a thought that we're going about this all wrong.  Instead of
having the 2 NICs assigned to the virtual switch as active/passive, why
not assign them both active as 2 different NICs and use NIC
teaming/bonding inside the firewall VM, then use the bond as the outside
of the bridge.  This would mean that the NIC the traffic comes in on
does not matter, they are received by the bond.  Any failover would be
done by the bonded NIC so the redundancy is still intact.

I am afraid I do not have a test implementation of VMWare that I can try
this theory out on.  If you are free to modify your environment freely
can you give this a shot and let me know the results?

Thanks for the list for indulging what is obviously no longer a bridging
issue.

Brad



Robert LeBlanc wrote:
> It doesn't matter if it is standby or active, the problem exists when
> there are 2 or more physical NICs on the virtual switch. It is caused by
> the physical NICs not dedicated to the VM's outbound traffic seeing the
> broadcast traffic (originating from the VM, but it doesn't know it
> because it because the VM is a bridge) and sending it to the VM. If it
> helps, the SR from VMware is SR #1474266821.
> Robert LeBlanc
> Life Sciences & Undergraduate Education Computer Support
> Brigham Young University
> 
> 
> On Thu, Jan 21, 2010 at 8:47 AM, Brad Hudson <hudson@pythian.com
> <mailto:hudson@pythian.com>> wrote:
> 
>     So are you saying that it's the standby nic on the ESX layer virtual
>     switch that is causing this issue?
> 
>     I am actually at a vmware conference today and want to hit them up
>     for more info.
> 
>     Brad
> 
>     Thumbs ... too ... big ... for ... BlackBerry
> 
>     ------------------------------------------------------------------------
>     *From: * Robert LeBlanc <robert@leblancnet.us
>     <mailto:robert@leblancnet.us>>
>     *Date: *Wed, 20 Jan 2010 14:32:33 -0700
>     *To: *Brad Hudson<hudson@pythian.com <mailto:hudson@pythian.com>>
>     *Cc: *<bridge@lists.linux-foundation.org
>     <mailto:bridge@lists.linux-foundation.org>>
>     *Subject: *Re: [Bridge] Incoming packets not always traversing the
>     bridge
> 
>     It's on the front page, you need a google wave account to see the blog.
> 
>     Here is the contents:
> 
>     Interesting problem with Virtual Switches
> 
>     So, after working with VMware yesterday, it is amazing how
>     understanding a black box, can get you moving with a problem.
> 
>     The Problem:
> 
>     I was trying to create a VM that would be a transparent firewall
>     among other things for our server VMs. The problem I was seeing was
>     that VMs behind the firewall would lose connectivity randomly. After
>     a lot of testing, I found that it was not random, but happened when
>     the VM sent out broadcast traffic. The Linux bridge would see the
>     traffic originate from both sides of the bridge with the opposite
>     port being the most recent. With the Linux bridge thinking that the
>     VM was on the wrong port as the actual VM, the traffic would not get
>     to the VM until the VM sent out more traffic to tell the bridge what
>     port it was on. This caused the interruption.
> 
>     VMware explains:
> 
>     After troubleshooting with creating a new virtual switch and putting
>     one physical adapter on it, the problem disappeared. We added a
>     second physical NIC to the switch and viola, the problem reappeared!
>     The technician went on to explain that they 'cheat' in their virtual
>     switch code. Usually when connecting one switch to another you will
>     trunk the ports, but the virtual switch doesn't do this. It offers
>     more flexibility and more throughput for a lot less complexity.
>     VMware just promises not to create a bridge between physical NICs
>     (each VM is kind of assigned it's own physical NIC so it's not a
>     real bridge). I went and did what VMware promises not to do causing
>     my problem.
> 
>     Problem explained:
> 
>     Since I was creating a bridge without trunking ports (not a real
>     possibility in this situation), when the Linux bridge received a
>     broadcast packet from the VM behind, it did the correct job of
>     sending it out only the one port, this port is then assigned to a
>     physical NIC, the physical switch that the NIC was connected to
>     would then send out the broadcast packet to every other port on that
>     physical switch. The second physical NIC on the ESX server would
>     also receive the broadcast packet and send it to the bridge VM,
>     hence the bridge VM saw the traffic on both ports. A classic case of
>     reflection.
> 
>     The solution:
> 
>     I'm still working on this, but there are a couple of solutions that
>     I can think of.
> 
>     1. Make the transparent bridge a router. I'm not huge fan of this
>     idea as I will have to have more connection with the network
>     engineers and we deviate from the standard network config.
> 
>     2. Use some cleaver ebtables rules to squash duplicate broadcast
>     frames. Although I haven't really used ebtables, it's structure is
>     much like iptables, so it can't be too hard. I might also be able to
>     rely on some Open Source virtual appliances that already do
>     something similar to help me out.
> 
>     Virtualization is great, but there are times when things just don't
>     work the same as the physical realm. It's good to know when these
>     times are. 
> 
> 
>     Robert LeBlanc
>     Life Sciences & Undergraduate Education Computer Support
>     Brigham Young University
> 
> 
>     On Wed, Jan 20, 2010 at 2:29 PM, Brad Hudson <hudson@pythian.com
>     <mailto:hudson@pythian.com>> wrote:
> 
>         Robert;
> 
>         I looked over your site and could not find the document you
>         reference in
>         your links.  Can you provide the url to get to it?
> 
>         I'll be happy to pass along anything I find and would appreciate
>         it if
>         you would do the same.  As the client having the issue is using
>         it for
>         production we may need to move to a non-bridged variety of
>         transparent
>         firewall with proxy_arp to get them back up quickly.  Ideally I
>         would
>         like to avoid that, but it's prod and needs to work.
> 
>         Regards;
> 
>         Brad
> 
>         Robert LeBlanc wrote:
>         > On Wed, Jan 20, 2010 at 1:04 PM, Brad Hudson
>         <hudson@pythian.com <mailto:hudson@pythian.com>
>         > <mailto:hudson@pythian.com <mailto:hudson@pythian.com>>> wrote:
>         >
>         >     Hi all;
>         >
>         >     I have an odd problem that I have been dealing with for a
>         week.  I was
>         >     hoping someone could help, or point me in the right
>         direction for clues.
>         >
>         >     I have a standard bridge setup.  br0 is composed of eth0
>         and eth1.
>         >
>         >     # brctl show bro
>         >     bridge name     bridge id               STP enabled    
>         interfaces
>         >     br0             8000.000c292280b9       no              eth0
>         >                                                            eth1
>         >
>         >     Eth0 and eth1 both have 0.0.0.0 (no) address assigned and
>         are up.  br0
>         >     is assigned the proper IP and the routing table is
>         correct.  STP is off.
>         >
>         >     I have been losing connectivity to hosts inside the local
>         segment of the
>         >     bridge.  Some investigation has revealed that the problem
>         is related to
>         >     arp not working correctly.  Arp packets going this way
>         >
>         >     eth1->br0->eth0->network/internet
>         >
>         >     have no problems at all.  The replies coming back the
>         other way all get
>         >     to br0, but only 33% (approx, it varies) make it to the
>         eth1 side of the
>         >     bridge.  I have verified this traffic pattern by tcpdump
>         of arp packets
>         >     through each of these devices while doing an nmap -sP of
>         the /24 network
>         >     to generate both arp and icmp.  We are not able to arp any
>         host outside
>         >     our local segment, including the default gateway (which is
>         owned by the
>         >     co-lo).  nmapping from the bridging server itself from
>         interface br0
>         >     gets the correct number of arp replies.
>         >
>         >     ebtables and arp_tables are not running, and adding them
>         in has had no
>         >     change in result.  There was a server with 2 NICs, each
>         with an IP on
>         >     the same subnet, that was causing some MAC flapping but
>         that has been
>         >     fixed and no change to the described behaviour.  All items in
>         >     /proc/sys/net/bridge are set to '1', but setting them to
>         '0' has no
>         >     effect.  The server hosting the bridge has been rebooted
>         several times
>         >     with no effect.  proxy_arp does not help at all.  I also tried
>         >     parprouted with no success.
>         >
>         >     A couple other notes.
>         >
>         >     - This behaviour suddenly appeared about a week ago.  I
>         think this is
>         >     probably related to an increase in network traffic but
>         it's hard to say,
>         >     the client does not buy into that statement.  If it was a
>         matter of 0
>         >     work or all work then there's places to look for that, but
>         in this case
>         >     the problem is intermittent and the lost arp replies are
>         not the same
>         >     every time.
>         >     - In another test we found that if we ping the inside
>         server from the
>         >     firewall and also from an external machine the
>         connectivity to the
>         >     inside server dies.  Once the pings are stopped, the
>         connectivity
>         >     eventually returns.  If I ping out from the inside server
>         while doing
>         >     that test, the session keeps going through without hanging.
>         >     - The firewall is a Vm running under ESX.  The vmxnet
>         driver has been
>         >     reinstalled and the pcnet32 driver is not loaded.  Both
>         NICs are virtual
>         >     so there is no chance of failed hardware, though I suppose
>         the problem
>         >     could be on the ESX layer.  I have made some attempt to
>         diagnose the WSX
>         >     layer but nothing jumps out at me.
>         >
>         >     I have been watching tcpdumps and do not see any sign of
>         frags, dupes,
>         >     or anything that would cause lost packets.  I have combed the
>         >     newsgroups, google and even irc looking for clues or
>         similar situations,
>         >     but nothing I have found fits the profile.
>         >
>         >     The workaround we currently have in place is to make a
>         static arp entry
>         >     for the gateway on all servers on the inside.  This is not
>         ideal because
>         >     the co-lo controls the router and it could fail over to
>         another device
>         >     which would kill our route again.
>         >
>         >     Can anyone suggest anyplace I can look for clues, settings
>         I should
>         >     check or other?  I am out of ideas at this point.
>         >
>         >     Your help is very much appreciated.
>         >
>         >     Regards;
>         >
>         >     Brad
>         >
>         >
>         >
>         >     --
>         >     Brad Hudson
>         >     SA Team Lead
>         >     The Pythian Group - love your data
>         >     Desk: 613-565-8696 x202
>         >     IM: pythianhudson
>         >
>         >
>         > I assume you have multiple physical NICs connected to your virtual
>         > switch. If so I've posted my finding on my web page
>         > http://robert.leblancnet.us and I've posted a message to this
>         form two
>         > days ago entitled "Need help writing ebtables rules". I'm not
>         sure my
>         > messages are getting through as I've sent a few messages with
>         no one
>         > responding. If we can work together to solve the problem, we
>         can both
>         > benefit.
>         >
>         > Thanks,
>         >
>         > Robert LeBlanc
>         > Life Sciences & Undergraduate Education Computer Support
>         > Brigham Young University
>         >
> 
> 
> 
>         --
>         Brad Hudson
>         SA Team Lead
>         The Pythian Group - love your data
>         Desk: 613-565-8696 x202
>         IM: pythianhudson
> 
> 
> 


-- 
Brad Hudson
SA Team Lead
The Pythian Group - love your data
Desk: 613-565-8696 x202
IM: pythianhudson
