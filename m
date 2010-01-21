MIME-Version: 1.0
In-Reply-To: <c5b98f841001201345g16a52731y6676bb3475686661@mail.gmail.com>
References: <4B5761DF.7010608@pythian.com>
	<c5b98f841001201230m39bc42e1nf2f7294004786d65@mail.gmail.com>
	<4B5775C0.3000800@pythian.com>
	<c5b98f841001201345g16a52731y6676bb3475686661@mail.gmail.com>
Date: Wed, 20 Jan 2010 17:09:33 -0700
Message-ID: <c5b98f841001201609j64de92b3n891c58775cafd018@mail.gmail.com>
From: Robert LeBlanc <robert@leblancnet.us>
Content-Type: multipart/alternative; boundary=0016e687869483a396047da18462
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

--0016e687869483a396047da18462
Content-Type: text/plain; charset=ISO-8859-1

I think I could use the limit match and limit it to 1/sec, that should drop
the duplicate packet if it matches the source mac and destination
(broadcast).

so, I think something like:

ebtables -A FORWARD --destination Braodcast limit --limit 1/sec -j ACCEPT

should work? Any criticism?

Thanks,

Robert LeBlanc
Life Sciences & Undergraduate Education Computer Support
Brigham Young University


On Wed, Jan 20, 2010 at 2:45 PM, Robert LeBlanc <robert@leblancnet.us>wrote:

> Another quick fix is to remove all physical NICs except for one from the
> Virtual switch(s) that are being bridged. You lose redundancy, but that will
> get them up fast until a fix is found.
>
>
> Robert LeBlanc
> Life Sciences & Undergraduate Education Computer Support
> Brigham Young University
>
>
> On Wed, Jan 20, 2010 at 2:29 PM, Brad Hudson <hudson@pythian.com> wrote:
>
>> Robert;
>>
>> I looked over your site and could not find the document you reference in
>> your links.  Can you provide the url to get to it?
>>
>> I'll be happy to pass along anything I find and would appreciate it if
>> you would do the same.  As the client having the issue is using it for
>> production we may need to move to a non-bridged variety of transparent
>> firewall with proxy_arp to get them back up quickly.  Ideally I would
>> like to avoid that, but it's prod and needs to work.
>>
>> Regards;
>>
>> Brad
>>
>> Robert LeBlanc wrote:
>> > On Wed, Jan 20, 2010 at 1:04 PM, Brad Hudson <hudson@pythian.com
>> > <mailto:hudson@pythian.com>> wrote:
>> >
>> >     Hi all;
>> >
>> >     I have an odd problem that I have been dealing with for a week.  I
>> was
>> >     hoping someone could help, or point me in the right direction for
>> clues.
>> >
>> >     I have a standard bridge setup.  br0 is composed of eth0 and eth1.
>> >
>> >     # brctl show bro
>> >     bridge name     bridge id               STP enabled     interfaces
>> >     br0             8000.000c292280b9       no              eth0
>> >                                                            eth1
>> >
>> >     Eth0 and eth1 both have 0.0.0.0 (no) address assigned and are up.
>>  br0
>> >     is assigned the proper IP and the routing table is correct.  STP is
>> off.
>> >
>> >     I have been losing connectivity to hosts inside the local segment of
>> the
>> >     bridge.  Some investigation has revealed that the problem is related
>> to
>> >     arp not working correctly.  Arp packets going this way
>> >
>> >     eth1->br0->eth0->network/internet
>> >
>> >     have no problems at all.  The replies coming back the other way all
>> get
>> >     to br0, but only 33% (approx, it varies) make it to the eth1 side of
>> the
>> >     bridge.  I have verified this traffic pattern by tcpdump of arp
>> packets
>> >     through each of these devices while doing an nmap -sP of the /24
>> network
>> >     to generate both arp and icmp.  We are not able to arp any host
>> outside
>> >     our local segment, including the default gateway (which is owned by
>> the
>> >     co-lo).  nmapping from the bridging server itself from interface br0
>> >     gets the correct number of arp replies.
>> >
>> >     ebtables and arp_tables are not running, and adding them in has had
>> no
>> >     change in result.  There was a server with 2 NICs, each with an IP
>> on
>> >     the same subnet, that was causing some MAC flapping but that has
>> been
>> >     fixed and no change to the described behaviour.  All items in
>> >     /proc/sys/net/bridge are set to '1', but setting them to '0' has no
>> >     effect.  The server hosting the bridge has been rebooted several
>> times
>> >     with no effect.  proxy_arp does not help at all.  I also tried
>> >     parprouted with no success.
>> >
>> >     A couple other notes.
>> >
>> >     - This behaviour suddenly appeared about a week ago.  I think this
>> is
>> >     probably related to an increase in network traffic but it's hard to
>> say,
>> >     the client does not buy into that statement.  If it was a matter of
>> 0
>> >     work or all work then there's places to look for that, but in this
>> case
>> >     the problem is intermittent and the lost arp replies are not the
>> same
>> >     every time.
>> >     - In another test we found that if we ping the inside server from
>> the
>> >     firewall and also from an external machine the connectivity to the
>> >     inside server dies.  Once the pings are stopped, the connectivity
>> >     eventually returns.  If I ping out from the inside server while
>> doing
>> >     that test, the session keeps going through without hanging.
>> >     - The firewall is a Vm running under ESX.  The vmxnet driver has
>> been
>> >     reinstalled and the pcnet32 driver is not loaded.  Both NICs are
>> virtual
>> >     so there is no chance of failed hardware, though I suppose the
>> problem
>> >     could be on the ESX layer.  I have made some attempt to diagnose the
>> WSX
>> >     layer but nothing jumps out at me.
>> >
>> >     I have been watching tcpdumps and do not see any sign of frags,
>> dupes,
>> >     or anything that would cause lost packets.  I have combed the
>> >     newsgroups, google and even irc looking for clues or similar
>> situations,
>> >     but nothing I have found fits the profile.
>> >
>> >     The workaround we currently have in place is to make a static arp
>> entry
>> >     for the gateway on all servers on the inside.  This is not ideal
>> because
>> >     the co-lo controls the router and it could fail over to another
>> device
>> >     which would kill our route again.
>> >
>> >     Can anyone suggest anyplace I can look for clues, settings I should
>> >     check or other?  I am out of ideas at this point.
>> >
>> >     Your help is very much appreciated.
>> >
>> >     Regards;
>> >
>> >     Brad
>> >
>> >
>> >
>> >     --
>> >     Brad Hudson
>> >     SA Team Lead
>> >     The Pythian Group - love your data
>> >     Desk: 613-565-8696 x202
>> >     IM: pythianhudson
>> >
>> >
>> > I assume you have multiple physical NICs connected to your virtual
>> > switch. If so I've posted my finding on my web page
>> > http://robert.leblancnet.us and I've posted a message to this form two
>> > days ago entitled "Need help writing ebtables rules". I'm not sure my
>> > messages are getting through as I've sent a few messages with no one
>> > responding. If we can work together to solve the problem, we can both
>> > benefit.
>> >
>> > Thanks,
>> >
>> > Robert LeBlanc
>> > Life Sciences & Undergraduate Education Computer Support
>> > Brigham Young University
>> >
>>
>>
>>
>> --
>> Brad Hudson
>> SA Team Lead
>> The Pythian Group - love your data
>> Desk: 613-565-8696 x202
>> IM: pythianhudson
>>
>
>

--0016e687869483a396047da18462
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I think I could use the limit match and limit it to 1/sec, that should drop=
 the duplicate packet if it matches the source mac and destination (broadca=
st).<br><br>so, I think something like:<br><br>ebtables -A FORWARD --destin=
ation Braodcast limit --limit 1/sec -j ACCEPT<br>
<br>should work? Any criticism?<br><br>Thanks,<br clear=3D"all"><br>Robert =
LeBlanc<br>Life Sciences &amp; Undergraduate Education Computer Support<br>=
Brigham Young University<br>
<br><br><div class=3D"gmail_quote">On Wed, Jan 20, 2010 at 2:45 PM, Robert =
LeBlanc <span dir=3D"ltr">&lt;<a href=3D"mailto:robert@leblancnet.us">rober=
t@leblancnet.us</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" =
style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8=
ex; padding-left: 1ex;">
Another quick fix is to remove all physical NICs except for one from the Vi=
rtual switch(s) that are being bridged. You lose redundancy, but that will =
get them up fast until a fix is found.<div class=3D"im"><br clear=3D"all"><=
br>
Robert LeBlanc<br>
Life Sciences &amp; Undergraduate Education Computer Support<br>Brigham You=
ng University<br>
<br><br></div><div><div></div><div class=3D"h5"><div class=3D"gmail_quote">=
On Wed, Jan 20, 2010 at 2:29 PM, Brad Hudson <span dir=3D"ltr">&lt;<a href=
=3D"mailto:hudson@pythian.com" target=3D"_blank">hudson@pythian.com</a>&gt;=
</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Robert;<br>
<br>
I looked over your site and could not find the document you reference in<br=
>
your links. =A0Can you provide the url to get to it?<br>
<br>
I&#39;ll be happy to pass along anything I find and would appreciate it if<=
br>
you would do the same. =A0As the client having the issue is using it for<br=
>
production we may need to move to a non-bridged variety of transparent<br>
firewall with proxy_arp to get them back up quickly. =A0Ideally I would<br>
like to avoid that, but it&#39;s prod and needs to work.<br>
<br>
Regards;<br>
<font color=3D"#888888"><br>
Brad<br>
</font><div><br>
Robert LeBlanc wrote:<br>
&gt; On Wed, Jan 20, 2010 at 1:04 PM, Brad Hudson &lt;<a href=3D"mailto:hud=
son@pythian.com" target=3D"_blank">hudson@pythian.com</a><br>
</div><div><div></div><div>&gt; &lt;mailto:<a href=3D"mailto:hudson@pythian=
.com" target=3D"_blank">hudson@pythian.com</a>&gt;&gt; wrote:<br>
&gt;<br>
&gt; =A0 =A0 Hi all;<br>
&gt;<br>
&gt; =A0 =A0 I have an odd problem that I have been dealing with for a week=
. =A0I was<br>
&gt; =A0 =A0 hoping someone could help, or point me in the right direction =
for clues.<br>
&gt;<br>
&gt; =A0 =A0 I have a standard bridge setup. =A0br0 is composed of eth0 and=
 eth1.<br>
&gt;<br>
&gt; =A0 =A0 # brctl show bro<br>
&gt; =A0 =A0 bridge name =A0 =A0 bridge id =A0 =A0 =A0 =A0 =A0 =A0 =A0 STP =
enabled =A0 =A0 interfaces<br>
&gt; =A0 =A0 br0 =A0 =A0 =A0 =A0 =A0 =A0 8000.000c292280b9 =A0 =A0 =A0 no =
=A0 =A0 =A0 =A0 =A0 =A0 =A0eth0<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0eth1<br>
&gt;<br>
&gt; =A0 =A0 Eth0 and eth1 both have 0.0.0.0 (no) address assigned and are =
up. =A0br0<br>
&gt; =A0 =A0 is assigned the proper IP and the routing table is correct. =
=A0STP is off.<br>
&gt;<br>
&gt; =A0 =A0 I have been losing connectivity to hosts inside the local segm=
ent of the<br>
&gt; =A0 =A0 bridge. =A0Some investigation has revealed that the problem is=
 related to<br>
&gt; =A0 =A0 arp not working correctly. =A0Arp packets going this way<br>
&gt;<br>
&gt; =A0 =A0 eth1-&gt;br0-&gt;eth0-&gt;network/internet<br>
&gt;<br>
&gt; =A0 =A0 have no problems at all. =A0The replies coming back the other =
way all get<br>
&gt; =A0 =A0 to br0, but only 33% (approx, it varies) make it to the eth1 s=
ide of the<br>
&gt; =A0 =A0 bridge. =A0I have verified this traffic pattern by tcpdump of =
arp packets<br>
&gt; =A0 =A0 through each of these devices while doing an nmap -sP of the /=
24 network<br>
&gt; =A0 =A0 to generate both arp and icmp. =A0We are not able to arp any h=
ost outside<br>
&gt; =A0 =A0 our local segment, including the default gateway (which is own=
ed by the<br>
&gt; =A0 =A0 co-lo). =A0nmapping from the bridging server itself from inter=
face br0<br>
&gt; =A0 =A0 gets the correct number of arp replies.<br>
&gt;<br>
&gt; =A0 =A0 ebtables and arp_tables are not running, and adding them in ha=
s had no<br>
&gt; =A0 =A0 change in result. =A0There was a server with 2 NICs, each with=
 an IP on<br>
&gt; =A0 =A0 the same subnet, that was causing some MAC flapping but that h=
as been<br>
&gt; =A0 =A0 fixed and no change to the described behaviour. =A0All items i=
n<br>
&gt; =A0 =A0 /proc/sys/net/bridge are set to &#39;1&#39;, but setting them =
to &#39;0&#39; has no<br>
&gt; =A0 =A0 effect. =A0The server hosting the bridge has been rebooted sev=
eral times<br>
&gt; =A0 =A0 with no effect. =A0proxy_arp does not help at all. =A0I also t=
ried<br>
&gt; =A0 =A0 parprouted with no success.<br>
&gt;<br>
&gt; =A0 =A0 A couple other notes.<br>
&gt;<br>
&gt; =A0 =A0 - This behaviour suddenly appeared about a week ago. =A0I thin=
k this is<br>
&gt; =A0 =A0 probably related to an increase in network traffic but it&#39;=
s hard to say,<br>
&gt; =A0 =A0 the client does not buy into that statement. =A0If it was a ma=
tter of 0<br>
&gt; =A0 =A0 work or all work then there&#39;s places to look for that, but=
 in this case<br>
&gt; =A0 =A0 the problem is intermittent and the lost arp replies are not t=
he same<br>
&gt; =A0 =A0 every time.<br>
&gt; =A0 =A0 - In another test we found that if we ping the inside server f=
rom the<br>
&gt; =A0 =A0 firewall and also from an external machine the connectivity to=
 the<br>
&gt; =A0 =A0 inside server dies. =A0Once the pings are stopped, the connect=
ivity<br>
&gt; =A0 =A0 eventually returns. =A0If I ping out from the inside server wh=
ile doing<br>
&gt; =A0 =A0 that test, the session keeps going through without hanging.<br=
>
&gt; =A0 =A0 - The firewall is a Vm running under ESX. =A0The vmxnet driver=
 has been<br>
&gt; =A0 =A0 reinstalled and the pcnet32 driver is not loaded. =A0Both NICs=
 are virtual<br>
&gt; =A0 =A0 so there is no chance of failed hardware, though I suppose the=
 problem<br>
&gt; =A0 =A0 could be on the ESX layer. =A0I have made some attempt to diag=
nose the WSX<br>
&gt; =A0 =A0 layer but nothing jumps out at me.<br>
&gt;<br>
&gt; =A0 =A0 I have been watching tcpdumps and do not see any sign of frags=
, dupes,<br>
&gt; =A0 =A0 or anything that would cause lost packets. =A0I have combed th=
e<br>
&gt; =A0 =A0 newsgroups, google and even irc looking for clues or similar s=
ituations,<br>
&gt; =A0 =A0 but nothing I have found fits the profile.<br>
&gt;<br>
&gt; =A0 =A0 The workaround we currently have in place is to make a static =
arp entry<br>
&gt; =A0 =A0 for the gateway on all servers on the inside. =A0This is not i=
deal because<br>
&gt; =A0 =A0 the co-lo controls the router and it could fail over to anothe=
r device<br>
&gt; =A0 =A0 which would kill our route again.<br>
&gt;<br>
&gt; =A0 =A0 Can anyone suggest anyplace I can look for clues, settings I s=
hould<br>
&gt; =A0 =A0 check or other? =A0I am out of ideas at this point.<br>
&gt;<br>
&gt; =A0 =A0 Your help is very much appreciated.<br>
&gt;<br>
&gt; =A0 =A0 Regards;<br>
&gt;<br>
&gt; =A0 =A0 Brad<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; =A0 =A0 --<br>
&gt; =A0 =A0 Brad Hudson<br>
&gt; =A0 =A0 SA Team Lead<br>
&gt; =A0 =A0 The Pythian Group - love your data<br>
&gt; =A0 =A0 Desk: 613-565-8696 x202<br>
&gt; =A0 =A0 IM: pythianhudson<br>
&gt;<br>
&gt;<br>
&gt; I assume you have multiple physical NICs connected to your virtual<br>
&gt; switch. If so I&#39;ve posted my finding on my web page<br>
&gt; <a href=3D"http://robert.leblancnet.us" target=3D"_blank">http://rober=
t.leblancnet.us</a> and I&#39;ve posted a message to this form two<br>
&gt; days ago entitled &quot;Need help writing ebtables rules&quot;. I&#39;=
m not sure my<br>
&gt; messages are getting through as I&#39;ve sent a few messages with no o=
ne<br>
&gt; responding. If we can work together to solve the problem, we can both<=
br>
&gt; benefit.<br>
&gt;<br>
&gt; Thanks,<br>
&gt;<br>
&gt; Robert LeBlanc<br>
&gt; Life Sciences &amp; Undergraduate Education Computer Support<br>
&gt; Brigham Young University<br>
&gt;<br>
<br>
<br>
<br>
</div></div>--<br>
<div><div></div><div>Brad Hudson<br>
SA Team Lead<br>
The Pythian Group - love your data<br>
Desk: 613-565-8696 x202<br>
IM: pythianhudson<br>
</div></div></blockquote></div><br>
</div></div></blockquote></div><br>

--0016e687869483a396047da18462--
