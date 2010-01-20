MIME-Version: 1.0
In-Reply-To: <4B5761DF.7010608@pythian.com>
References: <4B5761DF.7010608@pythian.com>
Date: Wed, 20 Jan 2010 13:30:09 -0700
Message-ID: <c5b98f841001201230m39bc42e1nf2f7294004786d65@mail.gmail.com>
From: Robert LeBlanc <robert@leblancnet.us>
Content-Type: multipart/alternative; boundary=0016e64b974ade409d047d9e7388
Subject: Re: [Bridge] Incoming packets not always traversing the bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Brad Hudson <hudson@pythian.com>
Cc: bridge@lists.linux-foundation.org

--0016e64b974ade409d047d9e7388
Content-Type: text/plain; charset=ISO-8859-1

On Wed, Jan 20, 2010 at 1:04 PM, Brad Hudson <hudson@pythian.com> wrote:

> Hi all;
>
> I have an odd problem that I have been dealing with for a week.  I was
> hoping someone could help, or point me in the right direction for clues.
>
> I have a standard bridge setup.  br0 is composed of eth0 and eth1.
>
> # brctl show bro
> bridge name     bridge id               STP enabled     interfaces
> br0             8000.000c292280b9       no              eth0
>                                                        eth1
>
> Eth0 and eth1 both have 0.0.0.0 (no) address assigned and are up.  br0
> is assigned the proper IP and the routing table is correct.  STP is off.
>
> I have been losing connectivity to hosts inside the local segment of the
> bridge.  Some investigation has revealed that the problem is related to
> arp not working correctly.  Arp packets going this way
>
> eth1->br0->eth0->network/internet
>
> have no problems at all.  The replies coming back the other way all get
> to br0, but only 33% (approx, it varies) make it to the eth1 side of the
> bridge.  I have verified this traffic pattern by tcpdump of arp packets
> through each of these devices while doing an nmap -sP of the /24 network
> to generate both arp and icmp.  We are not able to arp any host outside
> our local segment, including the default gateway (which is owned by the
> co-lo).  nmapping from the bridging server itself from interface br0
> gets the correct number of arp replies.
>
> ebtables and arp_tables are not running, and adding them in has had no
> change in result.  There was a server with 2 NICs, each with an IP on
> the same subnet, that was causing some MAC flapping but that has been
> fixed and no change to the described behaviour.  All items in
> /proc/sys/net/bridge are set to '1', but setting them to '0' has no
> effect.  The server hosting the bridge has been rebooted several times
> with no effect.  proxy_arp does not help at all.  I also tried
> parprouted with no success.
>
> A couple other notes.
>
> - This behaviour suddenly appeared about a week ago.  I think this is
> probably related to an increase in network traffic but it's hard to say,
> the client does not buy into that statement.  If it was a matter of 0
> work or all work then there's places to look for that, but in this case
> the problem is intermittent and the lost arp replies are not the same
> every time.
> - In another test we found that if we ping the inside server from the
> firewall and also from an external machine the connectivity to the
> inside server dies.  Once the pings are stopped, the connectivity
> eventually returns.  If I ping out from the inside server while doing
> that test, the session keeps going through without hanging.
> - The firewall is a Vm running under ESX.  The vmxnet driver has been
> reinstalled and the pcnet32 driver is not loaded.  Both NICs are virtual
> so there is no chance of failed hardware, though I suppose the problem
> could be on the ESX layer.  I have made some attempt to diagnose the WSX
> layer but nothing jumps out at me.
>
> I have been watching tcpdumps and do not see any sign of frags, dupes,
> or anything that would cause lost packets.  I have combed the
> newsgroups, google and even irc looking for clues or similar situations,
> but nothing I have found fits the profile.
>
> The workaround we currently have in place is to make a static arp entry
> for the gateway on all servers on the inside.  This is not ideal because
> the co-lo controls the router and it could fail over to another device
> which would kill our route again.
>
> Can anyone suggest anyplace I can look for clues, settings I should
> check or other?  I am out of ideas at this point.
>
> Your help is very much appreciated.
>
> Regards;
>
> Brad
>
>
>
> --
> Brad Hudson
> SA Team Lead
> The Pythian Group - love your data
> Desk: 613-565-8696 x202
> IM: pythianhudson
>
>
I assume you have multiple physical NICs connected to your virtual switch.
If so I've posted my finding on my web page http://robert.leblancnet.us and
I've posted a message to this form two days ago entitled "Need help writing
ebtables rules". I'm not sure my messages are getting through as I've sent a
few messages with no one responding. If we can work together to solve the
problem, we can both benefit.

Thanks,

Robert LeBlanc
Life Sciences & Undergraduate Education Computer Support
Brigham Young University

--0016e64b974ade409d047d9e7388
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Wed, Jan 20, 2010 at 1:04 PM, Brad Hudson <sp=
an dir=3D"ltr">&lt;<a href=3D"mailto:hudson@pythian.com">hudson@pythian.com=
</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin=
:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;">
Hi all;<br>
<br>
I have an odd problem that I have been dealing with for a week. =A0I was<br=
>
hoping someone could help, or point me in the right direction for clues.<br=
>
<br>
I have a standard bridge setup. =A0br0 is composed of eth0 and eth1.<br>
<br>
# brctl show bro<br>
bridge name =A0 =A0 bridge id =A0 =A0 =A0 =A0 =A0 =A0 =A0 STP enabled =A0 =
=A0 interfaces<br>
br0 =A0 =A0 =A0 =A0 =A0 =A0 8000.000c292280b9 =A0 =A0 =A0 no =A0 =A0 =A0 =
=A0 =A0 =A0 =A0eth0<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0eth1<br>
<br>
Eth0 and eth1 both have 0.0.0.0 (no) address assigned and are up. =A0br0<br=
>
is assigned the proper IP and the routing table is correct. =A0STP is off.<=
br>
<br>
I have been losing connectivity to hosts inside the local segment of the<br=
>
bridge. =A0Some investigation has revealed that the problem is related to<b=
r>
arp not working correctly. =A0Arp packets going this way<br>
<br>
eth1-&gt;br0-&gt;eth0-&gt;network/internet<br>
<br>
have no problems at all. =A0The replies coming back the other way all get<b=
r>
to br0, but only 33% (approx, it varies) make it to the eth1 side of the<br=
>
bridge. =A0I have verified this traffic pattern by tcpdump of arp packets<b=
r>
through each of these devices while doing an nmap -sP of the /24 network<br=
>
to generate both arp and icmp. =A0We are not able to arp any host outside<b=
r>
our local segment, including the default gateway (which is owned by the<br>
co-lo). =A0nmapping from the bridging server itself from interface br0<br>
gets the correct number of arp replies.<br>
<br>
ebtables and arp_tables are not running, and adding them in has had no<br>
change in result. =A0There was a server with 2 NICs, each with an IP on<br>
the same subnet, that was causing some MAC flapping but that has been<br>
fixed and no change to the described behaviour. =A0All items in<br>
/proc/sys/net/bridge are set to &#39;1&#39;, but setting them to &#39;0&#39=
; has no<br>
effect. =A0The server hosting the bridge has been rebooted several times<br=
>
with no effect. =A0proxy_arp does not help at all. =A0I also tried<br>
parprouted with no success.<br>
<br>
A couple other notes.<br>
<br>
- This behaviour suddenly appeared about a week ago. =A0I think this is<br>
probably related to an increase in network traffic but it&#39;s hard to say=
,<br>
the client does not buy into that statement. =A0If it was a matter of 0<br>
work or all work then there&#39;s places to look for that, but in this case=
<br>
the problem is intermittent and the lost arp replies are not the same<br>
every time.<br>
- In another test we found that if we ping the inside server from the<br>
firewall and also from an external machine the connectivity to the<br>
inside server dies. =A0Once the pings are stopped, the connectivity<br>
eventually returns. =A0If I ping out from the inside server while doing<br>
that test, the session keeps going through without hanging.<br>
- The firewall is a Vm running under ESX. =A0The vmxnet driver has been<br>
reinstalled and the pcnet32 driver is not loaded. =A0Both NICs are virtual<=
br>
so there is no chance of failed hardware, though I suppose the problem<br>
could be on the ESX layer. =A0I have made some attempt to diagnose the WSX<=
br>
layer but nothing jumps out at me.<br>
<br>
I have been watching tcpdumps and do not see any sign of frags, dupes,<br>
or anything that would cause lost packets. =A0I have combed the<br>
newsgroups, google and even irc looking for clues or similar situations,<br=
>
but nothing I have found fits the profile.<br>
<br>
The workaround we currently have in place is to make a static arp entry<br>
for the gateway on all servers on the inside. =A0This is not ideal because<=
br>
the co-lo controls the router and it could fail over to another device<br>
which would kill our route again.<br>
<br>
Can anyone suggest anyplace I can look for clues, settings I should<br>
check or other? =A0I am out of ideas at this point.<br>
<br>
Your help is very much appreciated.<br>
<br>
Regards;<br>
<br>
Brad<br>
<br>
<br>
<br>
--<br>
Brad Hudson<br>
SA Team Lead<br>
The Pythian Group - love your data<br>
Desk: 613-565-8696 x202<br>
IM: pythianhudson<br><br></blockquote><div class=3D"gmail_quote"><br></div>=
I assume you have multiple physical NICs connected to your virtual switch. =
If so I&#39;ve posted my finding on my web page <a href=3D"http://robert.le=
blancnet.us">http://robert.leblancnet.us</a> and I&#39;ve posted a message =
to this form two days ago entitled &quot;Need help writing ebtables rules&q=
uot;. I&#39;m not sure my messages are getting through as I&#39;ve sent a f=
ew messages with no one responding. If we can work together to solve the pr=
oblem, we can both benefit.</div>
<div class=3D"gmail_quote"><br></div><div class=3D"gmail_quote">Thanks,<br =
clear=3D"all"><br>Robert LeBlanc<br>Life Sciences &amp; Undergraduate Educa=
tion Computer Support<br>Brigham Young University=A0</div><br>

--0016e64b974ade409d047d9e7388--
