MIME-Version: 1.0
In-Reply-To: <4B591867.50202@pythian.com>
References: <4B5761DF.7010608@pythian.com>
	<c5b98f841001201230m39bc42e1nf2f7294004786d65@mail.gmail.com>
	<4B5775C0.3000800@pythian.com>
	<c5b98f841001201332s3d2fc90cy8c8fcc4896ee5d14@mail.gmail.com>
	<158191213-1264088664-cardhu_decombobulator_blackberry.rim.net-1129058266-@bda367.bisx.prod.on.blackberry>
	<c5b98f841001210819u4ddd9545sf08e39edcee99ad5@mail.gmail.com>
	<4B591867.50202@pythian.com>
Date: Thu, 4 Feb 2010 08:14:39 -0700
Message-ID: <c5b98f841002040714n7ce4fc7fm92af2294119b04be@mail.gmail.com>
From: Robert LeBlanc <robert@leblancnet.us>
Content-Type: multipart/alternative; boundary=00504502e31a2bd3ed047ec7cb96
Subject: Re: [Bridge] Incoming packets not always traversing the bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: hudson@pythian.com
Cc: bridge@lists.linux-foundation.org

--00504502e31a2bd3ed047ec7cb96
Content-Type: text/plain; charset=ISO-8859-1

Just for historical record and to help anyone else that comes across this
with the same problem, we solved the problem by using proxy arp and not
bridging. It made the VM more of a transparent router than a bridge. The
only downside is that I now need two VMs as I can't find a way to have one
VM act as a router for two independent networks.

Robert LeBlanc
Life Sciences & Undergraduate Education Computer Support
Brigham Young University


On Thu, Jan 21, 2010 at 8:15 PM, Brad Hudson <hudson@pythian.com> wrote:

> Robert;
>
> This is becoming off topic for the list, so we should probably keep
> responses off from this point.  Unless anyone else is still interested. :)
>
> I spoke with an implementation engineer who deals exclusively with
> vmware.  I discussed the issue with him and he agrees with the
> assessment you got from vmware.  The issues lies in incomplete network
> switching code, what they referred to as a cheat.
>
> The answer he had was to upgrade to vSphere 4.0.  He said even then it
> may take some fiddling to make it work properly.  The sure fire fix
> would be to use vSphere Enterprise Plus with a Cisco Nexus 1000, which
> is a real switch in virtual space and can replace the VMWare network
> hypervisor.  These things are wicked cool, but it's a huge cost just to
> get around this problem.
>
> I had a thought that we're going about this all wrong.  Instead of
> having the 2 NICs assigned to the virtual switch as active/passive, why
> not assign them both active as 2 different NICs and use NIC
> teaming/bonding inside the firewall VM, then use the bond as the outside
> of the bridge.  This would mean that the NIC the traffic comes in on
> does not matter, they are received by the bond.  Any failover would be
> done by the bonded NIC so the redundancy is still intact.
>
> I am afraid I do not have a test implementation of VMWare that I can try
> this theory out on.  If you are free to modify your environment freely
> can you give this a shot and let me know the results?
>
> Thanks for the list for indulging what is obviously no longer a bridging
> issue.
>
> Brad
>
>
>
> Robert LeBlanc wrote:
> > It doesn't matter if it is standby or active, the problem exists when
> > there are 2 or more physical NICs on the virtual switch. It is caused by
> > the physical NICs not dedicated to the VM's outbound traffic seeing the
> > broadcast traffic (originating from the VM, but it doesn't know it
> > because it because the VM is a bridge) and sending it to the VM. If it
> > helps, the SR from VMware is SR #1474266821.
> > Robert LeBlanc
> > Life Sciences & Undergraduate Education Computer Support
> > Brigham Young University
> >
> >
> > On Thu, Jan 21, 2010 at 8:47 AM, Brad Hudson <hudson@pythian.com
> > <mailto:hudson@pythian.com>> wrote:
> >
> >     So are you saying that it's the standby nic on the ESX layer virtual
> >     switch that is causing this issue?
> >
> >     I am actually at a vmware conference today and want to hit them up
> >     for more info.
> >
> >     Brad
> >
> >     Thumbs ... too ... big ... for ... BlackBerry
> >
> >
> ------------------------------------------------------------------------
> >     *From: * Robert LeBlanc <robert@leblancnet.us
> >     <mailto:robert@leblancnet.us>>
> >     *Date: *Wed, 20 Jan 2010 14:32:33 -0700
> >     *To: *Brad Hudson<hudson@pythian.com <mailto:hudson@pythian.com>>
> >     *Cc: *<bridge@lists.linux-foundation.org
> >     <mailto:bridge@lists.linux-foundation.org>>
> >     *Subject: *Re: [Bridge] Incoming packets not always traversing the
> >     bridge
> >
> >     It's on the front page, you need a google wave account to see the
> blog.
> >
> >     Here is the contents:
> >
> >     Interesting problem with Virtual Switches
> >
> >     So, after working with VMware yesterday, it is amazing how
> >     understanding a black box, can get you moving with a problem.
> >
> >     The Problem:
> >
> >     I was trying to create a VM that would be a transparent firewall
> >     among other things for our server VMs. The problem I was seeing was
> >     that VMs behind the firewall would lose connectivity randomly. After
> >     a lot of testing, I found that it was not random, but happened when
> >     the VM sent out broadcast traffic. The Linux bridge would see the
> >     traffic originate from both sides of the bridge with the opposite
> >     port being the most recent. With the Linux bridge thinking that the
> >     VM was on the wrong port as the actual VM, the traffic would not get
> >     to the VM until the VM sent out more traffic to tell the bridge what
> >     port it was on. This caused the interruption.
> >
> >     VMware explains:
> >
> >     After troubleshooting with creating a new virtual switch and putting
> >     one physical adapter on it, the problem disappeared. We added a
> >     second physical NIC to the switch and viola, the problem reappeared!
> >     The technician went on to explain that they 'cheat' in their virtual
> >     switch code. Usually when connecting one switch to another you will
> >     trunk the ports, but the virtual switch doesn't do this. It offers
> >     more flexibility and more throughput for a lot less complexity.
> >     VMware just promises not to create a bridge between physical NICs
> >     (each VM is kind of assigned it's own physical NIC so it's not a
> >     real bridge). I went and did what VMware promises not to do causing
> >     my problem.
> >
> >     Problem explained:
> >
> >     Since I was creating a bridge without trunking ports (not a real
> >     possibility in this situation), when the Linux bridge received a
> >     broadcast packet from the VM behind, it did the correct job of
> >     sending it out only the one port, this port is then assigned to a
> >     physical NIC, the physical switch that the NIC was connected to
> >     would then send out the broadcast packet to every other port on that
> >     physical switch. The second physical NIC on the ESX server would
> >     also receive the broadcast packet and send it to the bridge VM,
> >     hence the bridge VM saw the traffic on both ports. A classic case of
> >     reflection.
> >
> >     The solution:
> >
> >     I'm still working on this, but there are a couple of solutions that
> >     I can think of.
> >
> >     1. Make the transparent bridge a router. I'm not huge fan of this
> >     idea as I will have to have more connection with the network
> >     engineers and we deviate from the standard network config.
> >
> >     2. Use some cleaver ebtables rules to squash duplicate broadcast
> >     frames. Although I haven't really used ebtables, it's structure is
> >     much like iptables, so it can't be too hard. I might also be able to
> >     rely on some Open Source virtual appliances that already do
> >     something similar to help me out.
> >
> >     Virtualization is great, but there are times when things just don't
> >     work the same as the physical realm. It's good to know when these
> >     times are.
> >
> >
> >     Robert LeBlanc
> >     Life Sciences & Undergraduate Education Computer Support
> >     Brigham Young University
> >
> >
> >     On Wed, Jan 20, 2010 at 2:29 PM, Brad Hudson <hudson@pythian.com
> >     <mailto:hudson@pythian.com>> wrote:
> >
> >         Robert;
> >
> >         I looked over your site and could not find the document you
> >         reference in
> >         your links.  Can you provide the url to get to it?
> >
> >         I'll be happy to pass along anything I find and would appreciate
> >         it if
> >         you would do the same.  As the client having the issue is using
> >         it for
> >         production we may need to move to a non-bridged variety of
> >         transparent
> >         firewall with proxy_arp to get them back up quickly.  Ideally I
> >         would
> >         like to avoid that, but it's prod and needs to work.
> >
> >         Regards;
> >
> >         Brad
> >
> >         Robert LeBlanc wrote:
> >         > On Wed, Jan 20, 2010 at 1:04 PM, Brad Hudson
> >         <hudson@pythian.com <mailto:hudson@pythian.com>
> >         > <mailto:hudson@pythian.com <mailto:hudson@pythian.com>>>
> wrote:
> >         >
> >         >     Hi all;
> >         >
> >         >     I have an odd problem that I have been dealing with for a
> >         week.  I was
> >         >     hoping someone could help, or point me in the right
> >         direction for clues.
> >         >
> >         >     I have a standard bridge setup.  br0 is composed of eth0
> >         and eth1.
> >         >
> >         >     # brctl show bro
> >         >     bridge name     bridge id               STP enabled
> >         interfaces
> >         >     br0             8000.000c292280b9       no
>  eth0
> >         >                                                            eth1
> >         >
> >         >     Eth0 and eth1 both have 0.0.0.0 (no) address assigned and
> >         are up.  br0
> >         >     is assigned the proper IP and the routing table is
> >         correct.  STP is off.
> >         >
> >         >     I have been losing connectivity to hosts inside the local
> >         segment of the
> >         >     bridge.  Some investigation has revealed that the problem
> >         is related to
> >         >     arp not working correctly.  Arp packets going this way
> >         >
> >         >     eth1->br0->eth0->network/internet
> >         >
> >         >     have no problems at all.  The replies coming back the
> >         other way all get
> >         >     to br0, but only 33% (approx, it varies) make it to the
> >         eth1 side of the
> >         >     bridge.  I have verified this traffic pattern by tcpdump
> >         of arp packets
> >         >     through each of these devices while doing an nmap -sP of
> >         the /24 network
> >         >     to generate both arp and icmp.  We are not able to arp any
> >         host outside
> >         >     our local segment, including the default gateway (which is
> >         owned by the
> >         >     co-lo).  nmapping from the bridging server itself from
> >         interface br0
> >         >     gets the correct number of arp replies.
> >         >
> >         >     ebtables and arp_tables are not running, and adding them
> >         in has had no
> >         >     change in result.  There was a server with 2 NICs, each
> >         with an IP on
> >         >     the same subnet, that was causing some MAC flapping but
> >         that has been
> >         >     fixed and no change to the described behaviour.  All items
> in
> >         >     /proc/sys/net/bridge are set to '1', but setting them to
> >         '0' has no
> >         >     effect.  The server hosting the bridge has been rebooted
> >         several times
> >         >     with no effect.  proxy_arp does not help at all.  I also
> tried
> >         >     parprouted with no success.
> >         >
> >         >     A couple other notes.
> >         >
> >         >     - This behaviour suddenly appeared about a week ago.  I
> >         think this is
> >         >     probably related to an increase in network traffic but
> >         it's hard to say,
> >         >     the client does not buy into that statement.  If it was a
> >         matter of 0
> >         >     work or all work then there's places to look for that, but
> >         in this case
> >         >     the problem is intermittent and the lost arp replies are
> >         not the same
> >         >     every time.
> >         >     - In another test we found that if we ping the inside
> >         server from the
> >         >     firewall and also from an external machine the
> >         connectivity to the
> >         >     inside server dies.  Once the pings are stopped, the
> >         connectivity
> >         >     eventually returns.  If I ping out from the inside server
> >         while doing
> >         >     that test, the session keeps going through without hanging.
> >         >     - The firewall is a Vm running under ESX.  The vmxnet
> >         driver has been
> >         >     reinstalled and the pcnet32 driver is not loaded.  Both
> >         NICs are virtual
> >         >     so there is no chance of failed hardware, though I suppose
> >         the problem
> >         >     could be on the ESX layer.  I have made some attempt to
> >         diagnose the WSX
> >         >     layer but nothing jumps out at me.
> >         >
> >         >     I have been watching tcpdumps and do not see any sign of
> >         frags, dupes,
> >         >     or anything that would cause lost packets.  I have combed
> the
> >         >     newsgroups, google and even irc looking for clues or
> >         similar situations,
> >         >     but nothing I have found fits the profile.
> >         >
> >         >     The workaround we currently have in place is to make a
> >         static arp entry
> >         >     for the gateway on all servers on the inside.  This is not
> >         ideal because
> >         >     the co-lo controls the router and it could fail over to
> >         another device
> >         >     which would kill our route again.
> >         >
> >         >     Can anyone suggest anyplace I can look for clues, settings
> >         I should
> >         >     check or other?  I am out of ideas at this point.
> >         >
> >         >     Your help is very much appreciated.
> >         >
> >         >     Regards;
> >         >
> >         >     Brad
> >         >
> >         >
> >         >
> >         >     --
> >         >     Brad Hudson
> >         >     SA Team Lead
> >         >     The Pythian Group - love your data
> >         >     Desk: 613-565-8696 x202
> >         >     IM: pythianhudson
> >         >
> >         >
> >         > I assume you have multiple physical NICs connected to your
> virtual
> >         > switch. If so I've posted my finding on my web page
> >         > http://robert.leblancnet.us and I've posted a message to this
> >         form two
> >         > days ago entitled "Need help writing ebtables rules". I'm not
> >         sure my
> >         > messages are getting through as I've sent a few messages with
> >         no one
> >         > responding. If we can work together to solve the problem, we
> >         can both
> >         > benefit.
> >         >
> >         > Thanks,
> >         >
> >         > Robert LeBlanc
> >         > Life Sciences & Undergraduate Education Computer Support
> >         > Brigham Young University
> >         >
> >
> >
> >
> >         --
> >         Brad Hudson
> >         SA Team Lead
> >         The Pythian Group - love your data
> >         Desk: 613-565-8696 x202
> >         IM: pythianhudson
> >
> >
> >
>
>
> --
> Brad Hudson
> SA Team Lead
> The Pythian Group - love your data
> Desk: 613-565-8696 x202
> IM: pythianhudson
>

--00504502e31a2bd3ed047ec7cb96
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Just for historical record and to help anyone else that comes across this w=
ith the same problem, we solved the problem by using proxy arp and not brid=
ging. It made the VM more of a transparent router than a bridge. The only d=
ownside is that I now need two VMs as I can&#39;t find a way to have one VM=
 act as a router for two independent networks.<br clear=3D"all">
<br>Robert LeBlanc<br>Life Sciences &amp; Undergraduate Education Computer =
Support<br>Brigham Young University<br>
<br><br><div class=3D"gmail_quote">On Thu, Jan 21, 2010 at 8:15 PM, Brad Hu=
dson <span dir=3D"ltr">&lt;<a href=3D"mailto:hudson@pythian.com">hudson@pyt=
hian.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; p=
adding-left: 1ex;">
Robert;<br>
<br>
This is becoming off topic for the list, so we should probably keep<br>
responses off from this point. =A0Unless anyone else is still interested. :=
)<br>
<br>
I spoke with an implementation engineer who deals exclusively with<br>
vmware. =A0I discussed the issue with him and he agrees with the<br>
assessment you got from vmware. =A0The issues lies in incomplete network<br=
>
switching code, what they referred to as a cheat.<br>
<br>
The answer he had was to upgrade to vSphere 4.0. =A0He said even then it<br=
>
may take some fiddling to make it work properly. =A0The sure fire fix<br>
would be to use vSphere Enterprise Plus with a Cisco Nexus 1000, which<br>
is a real switch in virtual space and can replace the VMWare network<br>
hypervisor. =A0These things are wicked cool, but it&#39;s a huge cost just =
to<br>
get around this problem.<br>
<br>
I had a thought that we&#39;re going about this all wrong. =A0Instead of<br=
>
having the 2 NICs assigned to the virtual switch as active/passive, why<br>
not assign them both active as 2 different NICs and use NIC<br>
teaming/bonding inside the firewall VM, then use the bond as the outside<br=
>
of the bridge. =A0This would mean that the NIC the traffic comes in on<br>
does not matter, they are received by the bond. =A0Any failover would be<br=
>
done by the bonded NIC so the redundancy is still intact.<br>
<br>
I am afraid I do not have a test implementation of VMWare that I can try<br=
>
this theory out on. =A0If you are free to modify your environment freely<br=
>
can you give this a shot and let me know the results?<br>
<br>
Thanks for the list for indulging what is obviously no longer a bridging<br=
>
issue.<br>
<br>
Brad<br>
<div class=3D"im"><br>
<br>
<br>
Robert LeBlanc wrote:<br>
&gt; It doesn&#39;t matter if it is standby or active, the problem exists w=
hen<br>
&gt; there are 2 or more physical NICs on the virtual switch. It is caused =
by<br>
&gt; the physical NICs not dedicated to the VM&#39;s outbound traffic seein=
g the<br>
&gt; broadcast traffic (originating from the VM, but it doesn&#39;t know it=
<br>
&gt; because it because the VM is a bridge) and sending it to the VM. If it=
<br>
&gt; helps, the SR from VMware is SR #1474266821.<br>
&gt; Robert LeBlanc<br>
&gt; Life Sciences &amp; Undergraduate Education Computer Support<br>
&gt; Brigham Young University<br>
&gt;<br>
&gt;<br>
&gt; On Thu, Jan 21, 2010 at 8:47 AM, Brad Hudson &lt;<a href=3D"mailto:hud=
son@pythian.com">hudson@pythian.com</a><br>
</div><div class=3D"im">&gt; &lt;mailto:<a href=3D"mailto:hudson@pythian.co=
m">hudson@pythian.com</a>&gt;&gt; wrote:<br>
&gt;<br>
</div><div class=3D"im">&gt; =A0 =A0 So are you saying that it&#39;s the st=
andby nic on the ESX layer virtual<br>
&gt; =A0 =A0 switch that is causing this issue?<br>
&gt;<br>
&gt; =A0 =A0 I am actually at a vmware conference today and want to hit the=
m up<br>
&gt; =A0 =A0 for more info.<br>
&gt;<br>
&gt; =A0 =A0 Brad<br>
&gt;<br>
&gt; =A0 =A0 Thumbs ... too ... big ... for ... BlackBerry<br>
&gt;<br>
&gt; =A0 =A0 --------------------------------------------------------------=
----------<br>
&gt; =A0 =A0 *From: * Robert LeBlanc &lt;<a href=3D"mailto:robert@leblancne=
t.us">robert@leblancnet.us</a><br>
</div>&gt; =A0 =A0 &lt;mailto:<a href=3D"mailto:robert@leblancnet.us">rober=
t@leblancnet.us</a>&gt;&gt;<br>
<div class=3D"im">&gt; =A0 =A0 *Date: *Wed, 20 Jan 2010 14:32:33 -0700<br>
</div>&gt; =A0 =A0 *To: *Brad Hudson&lt;<a href=3D"mailto:hudson@pythian.co=
m">hudson@pythian.com</a> &lt;mailto:<a href=3D"mailto:hudson@pythian.com">=
hudson@pythian.com</a>&gt;&gt;<br>
<div class=3D"im">&gt; =A0 =A0 *Cc: *&lt;<a href=3D"mailto:bridge@lists.lin=
ux-foundation.org">bridge@lists.linux-foundation.org</a><br>
</div>&gt; =A0 =A0 &lt;mailto:<a href=3D"mailto:bridge@lists.linux-foundati=
on.org">bridge@lists.linux-foundation.org</a>&gt;&gt;<br>
<div><div></div><div class=3D"h5">&gt; =A0 =A0 *Subject: *Re: [Bridge] Inco=
ming packets not always traversing the<br>
&gt; =A0 =A0 bridge<br>
&gt;<br>
&gt; =A0 =A0 It&#39;s on the front page, you need a google wave account to =
see the blog.<br>
&gt;<br>
&gt; =A0 =A0 Here is the contents:<br>
&gt;<br>
&gt; =A0 =A0 Interesting problem with Virtual Switches<br>
&gt;<br>
&gt; =A0 =A0 So, after working with VMware yesterday, it is amazing how<br>
&gt; =A0 =A0 understanding a black box, can get you moving with a problem.<=
br>
&gt;<br>
&gt; =A0 =A0 The Problem:<br>
&gt;<br>
&gt; =A0 =A0 I was trying to create a VM that would be a transparent firewa=
ll<br>
&gt; =A0 =A0 among other things for our server VMs. The problem I was seein=
g was<br>
&gt; =A0 =A0 that VMs behind the firewall would lose connectivity randomly.=
 After<br>
&gt; =A0 =A0 a lot of testing, I found that it was not random, but happened=
 when<br>
&gt; =A0 =A0 the VM sent out broadcast traffic. The Linux bridge would see =
the<br>
&gt; =A0 =A0 traffic originate from both sides of the bridge with the oppos=
ite<br>
&gt; =A0 =A0 port being the most recent. With the Linux bridge thinking tha=
t the<br>
&gt; =A0 =A0 VM was on the wrong port as the actual VM, the traffic would n=
ot get<br>
&gt; =A0 =A0 to the VM until the VM sent out more traffic to tell the bridg=
e what<br>
&gt; =A0 =A0 port it was on. This caused the interruption.<br>
&gt;<br>
&gt; =A0 =A0 VMware explains:<br>
&gt;<br>
&gt; =A0 =A0 After troubleshooting with creating a new virtual switch and p=
utting<br>
&gt; =A0 =A0 one physical adapter on it, the problem disappeared. We added =
a<br>
&gt; =A0 =A0 second physical NIC to the switch and viola, the problem reapp=
eared!<br>
&gt; =A0 =A0 The technician went on to explain that they &#39;cheat&#39; in=
 their virtual<br>
&gt; =A0 =A0 switch code. Usually when connecting one switch to another you=
 will<br>
&gt; =A0 =A0 trunk the ports, but the virtual switch doesn&#39;t do this. I=
t offers<br>
&gt; =A0 =A0 more flexibility and more throughput for a lot less complexity=
.<br>
&gt; =A0 =A0 VMware just promises not to create a bridge between physical N=
ICs<br>
&gt; =A0 =A0 (each VM is kind of assigned it&#39;s own physical NIC so it&#=
39;s not a<br>
&gt; =A0 =A0 real bridge). I went and did what VMware promises not to do ca=
using<br>
&gt; =A0 =A0 my problem.<br>
&gt;<br>
&gt; =A0 =A0 Problem explained:<br>
&gt;<br>
&gt; =A0 =A0 Since I was creating a bridge without trunking ports (not a re=
al<br>
&gt; =A0 =A0 possibility in this situation), when the Linux bridge received=
 a<br>
&gt; =A0 =A0 broadcast packet from the VM behind, it did the correct job of=
<br>
&gt; =A0 =A0 sending it out only the one port, this port is then assigned t=
o a<br>
&gt; =A0 =A0 physical NIC, the physical switch that the NIC was connected t=
o<br>
&gt; =A0 =A0 would then send out the broadcast packet to every other port o=
n that<br>
&gt; =A0 =A0 physical switch. The second physical NIC on the ESX server wou=
ld<br>
&gt; =A0 =A0 also receive the broadcast packet and send it to the bridge VM=
,<br>
&gt; =A0 =A0 hence the bridge VM saw the traffic on both ports. A classic c=
ase of<br>
&gt; =A0 =A0 reflection.<br>
&gt;<br>
&gt; =A0 =A0 The solution:<br>
&gt;<br>
&gt; =A0 =A0 I&#39;m still working on this, but there are a couple of solut=
ions that<br>
&gt; =A0 =A0 I can think of.<br>
&gt;<br>
&gt; =A0 =A0 1. Make the transparent bridge a router. I&#39;m not huge fan =
of this<br>
&gt; =A0 =A0 idea as I will have to have more connection with the network<b=
r>
&gt; =A0 =A0 engineers and we deviate from the standard network config.<br>
&gt;<br>
&gt; =A0 =A0 2. Use some cleaver ebtables rules to squash duplicate broadca=
st<br>
&gt; =A0 =A0 frames. Although I haven&#39;t really used ebtables, it&#39;s =
structure is<br>
&gt; =A0 =A0 much like iptables, so it can&#39;t be too hard. I might also =
be able to<br>
&gt; =A0 =A0 rely on some Open Source virtual appliances that already do<br=
>
&gt; =A0 =A0 something similar to help me out.<br>
&gt;<br>
&gt; =A0 =A0 Virtualization is great, but there are times when things just =
don&#39;t<br>
&gt; =A0 =A0 work the same as the physical realm. It&#39;s good to know whe=
n these<br>
&gt; =A0 =A0 times are.<br>
&gt;<br>
&gt;<br>
&gt; =A0 =A0 Robert LeBlanc<br>
&gt; =A0 =A0 Life Sciences &amp; Undergraduate Education Computer Support<b=
r>
&gt; =A0 =A0 Brigham Young University<br>
&gt;<br>
&gt;<br>
&gt; =A0 =A0 On Wed, Jan 20, 2010 at 2:29 PM, Brad Hudson &lt;<a href=3D"ma=
ilto:hudson@pythian.com">hudson@pythian.com</a><br>
</div></div><div class=3D"im">&gt; =A0 =A0 &lt;mailto:<a href=3D"mailto:hud=
son@pythian.com">hudson@pythian.com</a>&gt;&gt; wrote:<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 Robert;<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 I looked over your site and could not find the documen=
t you<br>
&gt; =A0 =A0 =A0 =A0 reference in<br>
&gt; =A0 =A0 =A0 =A0 your links. =A0Can you provide the url to get to it?<b=
r>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 I&#39;ll be happy to pass along anything I find and wo=
uld appreciate<br>
&gt; =A0 =A0 =A0 =A0 it if<br>
&gt; =A0 =A0 =A0 =A0 you would do the same. =A0As the client having the iss=
ue is using<br>
&gt; =A0 =A0 =A0 =A0 it for<br>
&gt; =A0 =A0 =A0 =A0 production we may need to move to a non-bridged variet=
y of<br>
&gt; =A0 =A0 =A0 =A0 transparent<br>
&gt; =A0 =A0 =A0 =A0 firewall with proxy_arp to get them back up quickly. =
=A0Ideally I<br>
&gt; =A0 =A0 =A0 =A0 would<br>
&gt; =A0 =A0 =A0 =A0 like to avoid that, but it&#39;s prod and needs to wor=
k.<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 Regards;<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 Brad<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 Robert LeBlanc wrote:<br>
&gt; =A0 =A0 =A0 =A0 &gt; On Wed, Jan 20, 2010 at 1:04 PM, Brad Hudson<br>
&gt; =A0 =A0 =A0 =A0 &lt;<a href=3D"mailto:hudson@pythian.com">hudson@pythi=
an.com</a> &lt;mailto:<a href=3D"mailto:hudson@pythian.com">hudson@pythian.=
com</a>&gt;<br>
</div><div><div></div><div class=3D"h5">&gt; =A0 =A0 =A0 =A0 &gt; &lt;mailt=
o:<a href=3D"mailto:hudson@pythian.com">hudson@pythian.com</a> &lt;mailto:<=
a href=3D"mailto:hudson@pythian.com">hudson@pythian.com</a>&gt;&gt;&gt; wro=
te:<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 Hi all;<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 I have an odd problem that I have been de=
aling with for a<br>
&gt; =A0 =A0 =A0 =A0 week. =A0I was<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 hoping someone could help, or point me in=
 the right<br>
&gt; =A0 =A0 =A0 =A0 direction for clues.<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 I have a standard bridge setup. =A0br0 is=
 composed of eth0<br>
&gt; =A0 =A0 =A0 =A0 and eth1.<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 # brctl show bro<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 bridge name =A0 =A0 bridge id =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 STP enabled<br>
&gt; =A0 =A0 =A0 =A0 interfaces<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 br0 =A0 =A0 =A0 =A0 =A0 =A0 8000.000c2922=
80b9 =A0 =A0 =A0 no =A0 =A0 =A0 =A0 =A0 =A0 =A0eth0<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0eth1=
<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 Eth0 and eth1 both have 0.0.0.0 (no) addr=
ess assigned and<br>
&gt; =A0 =A0 =A0 =A0 are up. =A0br0<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 is assigned the proper IP and the routing=
 table is<br>
&gt; =A0 =A0 =A0 =A0 correct. =A0STP is off.<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 I have been losing connectivity to hosts =
inside the local<br>
&gt; =A0 =A0 =A0 =A0 segment of the<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 bridge. =A0Some investigation has reveale=
d that the problem<br>
&gt; =A0 =A0 =A0 =A0 is related to<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 arp not working correctly. =A0Arp packets=
 going this way<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 eth1-&gt;br0-&gt;eth0-&gt;network/interne=
t<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 have no problems at all. =A0The replies c=
oming back the<br>
&gt; =A0 =A0 =A0 =A0 other way all get<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 to br0, but only 33% (approx, it varies) =
make it to the<br>
&gt; =A0 =A0 =A0 =A0 eth1 side of the<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 bridge. =A0I have verified this traffic p=
attern by tcpdump<br>
&gt; =A0 =A0 =A0 =A0 of arp packets<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 through each of these devices while doing=
 an nmap -sP of<br>
&gt; =A0 =A0 =A0 =A0 the /24 network<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 to generate both arp and icmp. =A0We are =
not able to arp any<br>
&gt; =A0 =A0 =A0 =A0 host outside<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 our local segment, including the default =
gateway (which is<br>
&gt; =A0 =A0 =A0 =A0 owned by the<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 co-lo). =A0nmapping from the bridging ser=
ver itself from<br>
&gt; =A0 =A0 =A0 =A0 interface br0<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 gets the correct number of arp replies.<b=
r>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 ebtables and arp_tables are not running, =
and adding them<br>
&gt; =A0 =A0 =A0 =A0 in has had no<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 change in result. =A0There was a server w=
ith 2 NICs, each<br>
&gt; =A0 =A0 =A0 =A0 with an IP on<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 the same subnet, that was causing some MA=
C flapping but<br>
&gt; =A0 =A0 =A0 =A0 that has been<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 fixed and no change to the described beha=
viour. =A0All items in<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 /proc/sys/net/bridge are set to &#39;1&#3=
9;, but setting them to<br>
&gt; =A0 =A0 =A0 =A0 &#39;0&#39; has no<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 effect. =A0The server hosting the bridge =
has been rebooted<br>
&gt; =A0 =A0 =A0 =A0 several times<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 with no effect. =A0proxy_arp does not hel=
p at all. =A0I also tried<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 parprouted with no success.<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 A couple other notes.<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 - This behaviour suddenly appeared about =
a week ago. =A0I<br>
&gt; =A0 =A0 =A0 =A0 think this is<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 probably related to an increase in networ=
k traffic but<br>
&gt; =A0 =A0 =A0 =A0 it&#39;s hard to say,<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 the client does not buy into that stateme=
nt. =A0If it was a<br>
&gt; =A0 =A0 =A0 =A0 matter of 0<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 work or all work then there&#39;s places =
to look for that, but<br>
&gt; =A0 =A0 =A0 =A0 in this case<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 the problem is intermittent and the lost =
arp replies are<br>
&gt; =A0 =A0 =A0 =A0 not the same<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 every time.<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 - In another test we found that if we pin=
g the inside<br>
&gt; =A0 =A0 =A0 =A0 server from the<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 firewall and also from an external machin=
e the<br>
&gt; =A0 =A0 =A0 =A0 connectivity to the<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 inside server dies. =A0Once the pings are=
 stopped, the<br>
&gt; =A0 =A0 =A0 =A0 connectivity<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 eventually returns. =A0If I ping out from=
 the inside server<br>
&gt; =A0 =A0 =A0 =A0 while doing<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 that test, the session keeps going throug=
h without hanging.<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 - The firewall is a Vm running under ESX.=
 =A0The vmxnet<br>
&gt; =A0 =A0 =A0 =A0 driver has been<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 reinstalled and the pcnet32 driver is not=
 loaded. =A0Both<br>
&gt; =A0 =A0 =A0 =A0 NICs are virtual<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 so there is no chance of failed hardware,=
 though I suppose<br>
&gt; =A0 =A0 =A0 =A0 the problem<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 could be on the ESX layer. =A0I have made=
 some attempt to<br>
&gt; =A0 =A0 =A0 =A0 diagnose the WSX<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 layer but nothing jumps out at me.<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 I have been watching tcpdumps and do not =
see any sign of<br>
&gt; =A0 =A0 =A0 =A0 frags, dupes,<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 or anything that would cause lost packets=
. =A0I have combed the<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 newsgroups, google and even irc looking f=
or clues or<br>
&gt; =A0 =A0 =A0 =A0 similar situations,<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 but nothing I have found fits the profile=
.<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 The workaround we currently have in place=
 is to make a<br>
&gt; =A0 =A0 =A0 =A0 static arp entry<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 for the gateway on all servers on the ins=
ide. =A0This is not<br>
&gt; =A0 =A0 =A0 =A0 ideal because<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 the co-lo controls the router and it coul=
d fail over to<br>
&gt; =A0 =A0 =A0 =A0 another device<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 which would kill our route again.<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 Can anyone suggest anyplace I can look fo=
r clues, settings<br>
&gt; =A0 =A0 =A0 =A0 I should<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 check or other? =A0I am out of ideas at t=
his point.<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 Your help is very much appreciated.<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 Regards;<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 Brad<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 --<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 Brad Hudson<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 SA Team Lead<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 The Pythian Group - love your data<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 Desk: 613-565-8696 x202<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 IM: pythianhudson<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; I assume you have multiple physical NICs connecte=
d to your virtual<br>
&gt; =A0 =A0 =A0 =A0 &gt; switch. If so I&#39;ve posted my finding on my we=
b page<br>
&gt; =A0 =A0 =A0 =A0 &gt; <a href=3D"http://robert.leblancnet.us" target=3D=
"_blank">http://robert.leblancnet.us</a> and I&#39;ve posted a message to t=
his<br>
&gt; =A0 =A0 =A0 =A0 form two<br>
&gt; =A0 =A0 =A0 =A0 &gt; days ago entitled &quot;Need help writing ebtable=
s rules&quot;. I&#39;m not<br>
&gt; =A0 =A0 =A0 =A0 sure my<br>
&gt; =A0 =A0 =A0 =A0 &gt; messages are getting through as I&#39;ve sent a f=
ew messages with<br>
&gt; =A0 =A0 =A0 =A0 no one<br>
&gt; =A0 =A0 =A0 =A0 &gt; responding. If we can work together to solve the =
problem, we<br>
&gt; =A0 =A0 =A0 =A0 can both<br>
&gt; =A0 =A0 =A0 =A0 &gt; benefit.<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; Thanks,<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; Robert LeBlanc<br>
&gt; =A0 =A0 =A0 =A0 &gt; Life Sciences &amp; Undergraduate Education Compu=
ter Support<br>
&gt; =A0 =A0 =A0 =A0 &gt; Brigham Young University<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 --<br>
&gt; =A0 =A0 =A0 =A0 Brad Hudson<br>
&gt; =A0 =A0 =A0 =A0 SA Team Lead<br>
&gt; =A0 =A0 =A0 =A0 The Pythian Group - love your data<br>
&gt; =A0 =A0 =A0 =A0 Desk: 613-565-8696 x202<br>
&gt; =A0 =A0 =A0 =A0 IM: pythianhudson<br>
&gt;<br>
&gt;<br>
&gt;<br>
<br>
<br>
</div></div>--<br>
<div><div></div><div class=3D"h5">Brad Hudson<br>
SA Team Lead<br>
The Pythian Group - love your data<br>
Desk: 613-565-8696 x202<br>
IM: pythianhudson<br>
</div></div></blockquote></div><br>

--00504502e31a2bd3ed047ec7cb96--
