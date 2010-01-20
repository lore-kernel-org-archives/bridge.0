MIME-Version: 1.0
In-Reply-To: <c5b98f841001201345g16a52731y6676bb3475686661@mail.gmail.com>
References: <4B5761DF.7010608@pythian.com>
	<c5b98f841001201230m39bc42e1nf2f7294004786d65@mail.gmail.com>
	<4B5775C0.3000800@pythian.com>
	<c5b98f841001201345g16a52731y6676bb3475686661@mail.gmail.com>
Date: Wed, 20 Jan 2010 16:03:29 -0600
Message-ID: <2e59e6971001201403i69137e31se7b339909bf309c4@mail.gmail.com>
From: "richardvoigt@gmail.com" <richardvoigt@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] Incoming packets not always traversing the bridge
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

On Wed, Jan 20, 2010 at 3:45 PM, Robert LeBlanc <robert@leblancnet.us> wrot=
e:
> Another quick fix is to remove all physical NICs except for one from the
> Virtual switch(s) that are being bridged. You lose redundancy, but that w=
ill
> get them up fast until a fix is found.

Wouldn't spanning tree do the same thing, but with automated recovery
in the case of a failure of the live link?

>
> Robert LeBlanc
> Life Sciences & Undergraduate Education Computer Support
> Brigham Young University
>
>
> On Wed, Jan 20, 2010 at 2:29 PM, Brad Hudson <hudson@pythian.com> wrote:
>>
>> Robert;
>>
>> I looked over your site and could not find the document you reference in
>> your links. =C2=A0Can you provide the url to get to it?
>>
>> I'll be happy to pass along anything I find and would appreciate it if
>> you would do the same. =C2=A0As the client having the issue is using it =
for
>> production we may need to move to a non-bridged variety of transparent
>> firewall with proxy_arp to get them back up quickly. =C2=A0Ideally I wou=
ld
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
>> > =C2=A0 =C2=A0 Hi all;
>> >
>> > =C2=A0 =C2=A0 I have an odd problem that I have been dealing with for =
a week. =C2=A0I
>> > was
>> > =C2=A0 =C2=A0 hoping someone could help, or point me in the right dire=
ction for
>> > clues.
>> >
>> > =C2=A0 =C2=A0 I have a standard bridge setup. =C2=A0br0 is composed of=
 eth0 and eth1.
>> >
>> > =C2=A0 =C2=A0 # brctl show bro
>> > =C2=A0 =C2=A0 bridge name =C2=A0 =C2=A0 bridge id =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 STP enabled =C2=A0 =C2=A0 interfaces
>> > =C2=A0 =C2=A0 br0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 8000.000c2=
92280b9 =C2=A0 =C2=A0 =C2=A0 no =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0eth0
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0eth1
>> >
>> > =C2=A0 =C2=A0 Eth0 and eth1 both have 0.0.0.0 (no) address assigned an=
d are up.
>> > =C2=A0br0
>> > =C2=A0 =C2=A0 is assigned the proper IP and the routing table is corre=
ct. =C2=A0STP is
>> > off.
>> >
>> > =C2=A0 =C2=A0 I have been losing connectivity to hosts inside the loca=
l segment of
>> > the
>> > =C2=A0 =C2=A0 bridge. =C2=A0Some investigation has revealed that the p=
roblem is related
>> > to
>> > =C2=A0 =C2=A0 arp not working correctly. =C2=A0Arp packets going this =
way
>> >
>> > =C2=A0 =C2=A0 eth1->br0->eth0->network/internet
>> >
>> > =C2=A0 =C2=A0 have no problems at all. =C2=A0The replies coming back t=
he other way all
>> > get
>> > =C2=A0 =C2=A0 to br0, but only 33% (approx, it varies) make it to the =
eth1 side of
>> > the
>> > =C2=A0 =C2=A0 bridge. =C2=A0I have verified this traffic pattern by tc=
pdump of arp
>> > packets
>> > =C2=A0 =C2=A0 through each of these devices while doing an nmap -sP of=
 the /24
>> > network
>> > =C2=A0 =C2=A0 to generate both arp and icmp. =C2=A0We are not able to =
arp any host
>> > outside
>> > =C2=A0 =C2=A0 our local segment, including the default gateway (which =
is owned by
>> > the
>> > =C2=A0 =C2=A0 co-lo). =C2=A0nmapping from the bridging server itself f=
rom interface br0
>> > =C2=A0 =C2=A0 gets the correct number of arp replies.
>> >
>> > =C2=A0 =C2=A0 ebtables and arp_tables are not running, and adding them=
 in has had
>> > no
>> > =C2=A0 =C2=A0 change in result. =C2=A0There was a server with 2 NICs, =
each with an IP
>> > on
>> > =C2=A0 =C2=A0 the same subnet, that was causing some MAC flapping but =
that has
>> > been
>> > =C2=A0 =C2=A0 fixed and no change to the described behaviour. =C2=A0Al=
l items in
>> > =C2=A0 =C2=A0 /proc/sys/net/bridge are set to '1', but setting them to=
 '0' has no
>> > =C2=A0 =C2=A0 effect. =C2=A0The server hosting the bridge has been reb=
ooted several
>> > times
>> > =C2=A0 =C2=A0 with no effect. =C2=A0proxy_arp does not help at all. =
=C2=A0I also tried
>> > =C2=A0 =C2=A0 parprouted with no success.
>> >
>> > =C2=A0 =C2=A0 A couple other notes.
>> >
>> > =C2=A0 =C2=A0 - This behaviour suddenly appeared about a week ago. =C2=
=A0I think this
>> > is
>> > =C2=A0 =C2=A0 probably related to an increase in network traffic but i=
t's hard to
>> > say,
>> > =C2=A0 =C2=A0 the client does not buy into that statement. =C2=A0If it=
 was a matter of
>> > 0
>> > =C2=A0 =C2=A0 work or all work then there's places to look for that, b=
ut in this
>> > case
>> > =C2=A0 =C2=A0 the problem is intermittent and the lost arp replies are=
 not the
>> > same
>> > =C2=A0 =C2=A0 every time.
>> > =C2=A0 =C2=A0 - In another test we found that if we ping the inside se=
rver from
>> > the
>> > =C2=A0 =C2=A0 firewall and also from an external machine the connectiv=
ity to the
>> > =C2=A0 =C2=A0 inside server dies. =C2=A0Once the pings are stopped, th=
e connectivity
>> > =C2=A0 =C2=A0 eventually returns. =C2=A0If I ping out from the inside =
server while
>> > doing
>> > =C2=A0 =C2=A0 that test, the session keeps going through without hangi=
ng.
>> > =C2=A0 =C2=A0 - The firewall is a Vm running under ESX. =C2=A0The vmxn=
et driver has
>> > been
>> > =C2=A0 =C2=A0 reinstalled and the pcnet32 driver is not loaded. =C2=A0=
Both NICs are
>> > virtual
>> > =C2=A0 =C2=A0 so there is no chance of failed hardware, though I suppo=
se the
>> > problem
>> > =C2=A0 =C2=A0 could be on the ESX layer. =C2=A0I have made some attemp=
t to diagnose the
>> > WSX
>> > =C2=A0 =C2=A0 layer but nothing jumps out at me.
>> >
>> > =C2=A0 =C2=A0 I have been watching tcpdumps and do not see any sign of=
 frags,
>> > dupes,
>> > =C2=A0 =C2=A0 or anything that would cause lost packets. =C2=A0I have =
combed the
>> > =C2=A0 =C2=A0 newsgroups, google and even irc looking for clues or sim=
ilar
>> > situations,
>> > =C2=A0 =C2=A0 but nothing I have found fits the profile.
>> >
>> > =C2=A0 =C2=A0 The workaround we currently have in place is to make a s=
tatic arp
>> > entry
>> > =C2=A0 =C2=A0 for the gateway on all servers on the inside. =C2=A0This=
 is not ideal
>> > because
>> > =C2=A0 =C2=A0 the co-lo controls the router and it could fail over to =
another
>> > device
>> > =C2=A0 =C2=A0 which would kill our route again.
>> >
>> > =C2=A0 =C2=A0 Can anyone suggest anyplace I can look for clues, settin=
gs I should
>> > =C2=A0 =C2=A0 check or other? =C2=A0I am out of ideas at this point.
>> >
>> > =C2=A0 =C2=A0 Your help is very much appreciated.
>> >
>> > =C2=A0 =C2=A0 Regards;
>> >
>> > =C2=A0 =C2=A0 Brad
>> >
>> >
>> >
>> > =C2=A0 =C2=A0 --
>> > =C2=A0 =C2=A0 Brad Hudson
>> > =C2=A0 =C2=A0 SA Team Lead
>> > =C2=A0 =C2=A0 The Pythian Group - love your data
>> > =C2=A0 =C2=A0 Desk: 613-565-8696 x202
>> > =C2=A0 =C2=A0 IM: pythianhudson
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
>
>
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge
>
