Message-ID: <49FF4512.7030004@gmail.com>
Date: Mon, 04 May 2009 21:42:10 +0200
From: Jochen Hebbrecht <jochenhebbrecht@gmail.com>
MIME-Version: 1.0
References: <20090428124009.GA26387@kallisti.us>	<2e59e6970904281200u44e3ebbfga0f074dfaa78c1ab@mail.gmail.com>	<49F77248.1050800@gmail.com>	<2e59e6970904281600u42142392vb8e0eb45c4ede15c@mail.gmail.com>	<49F87D4E.4060705@gmail.com>
	<20090429162651.GA9455@kallisti.us>	<49F882F9.4010100@gmail.com>
	<20090429165329.GA9893@kallisti.us>	<49F8C4C3.9020504@gmail.com>	<2e59e6970904292118u71ff441ft19448f753c1b6dd9@mail.gmail.com>
	<db99f77d0904292330n4c460ccbv45e60f06bfa49c4@mail.gmail.com>
	<49FA1E28.5020604@free.fr> <49FC4764.3030707@gmail.com>
	<49FDD890.1090302@free.fr> <49FF41C4.4090404@gmail.com>
	<49FF435A.3040806@free.fr>
In-Reply-To: <49FF435A.3040806@free.fr>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] Ubuntu: network bridging between wireless and wired
 connection fails
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: =?ISO-8859-1?Q?Nicolas_de_Peslo=FCan?= <nicolas.2p.debian@free.fr>
Cc: bridge@lists.linux-foundation.org

Nicolas de Peslo=FCan schreef:
> Jochen Hebbrecht a =E9crit :
>>
>>
>> Nicolas de Peslo=FCan schreef:
>>> Ok, now we understand what you are trying to do. In particular, I=20
>>> assume the DHCP server is on the subnet of location B (or behind a=20
>>> router connected on this subnet), so the expected DHCP offer will=20
>>> come from the wire interface (eth0) and definitely not from the=20
>>> wireless interface (eth1).
>>>
>> Maybe my picture isn't very clear, but my WAN access is on location=20
>> A. There's a router which receives an ip from the ISP. On the other=20
>> side, I'm having a 192.168.1.0/24 network
>
> I'm no more really sure I understand your configuration.
>
> The server you are curently trying to setup as a bridge is located in=20
> location B (UBUNTU SERVER) and has two interfaces : eth0 (ethernet)=20
> and eth1 (wifi).
>
> Am I right ?

Yes, that's totally correct. I want to receive an IP on my eth1 so my=20
UBUNTU server is in the same subnet as desktop A and notebook A. By=20
bridging eth0 and eth1 of UBUNTU SERVER, the IP packets on eth0 will be=20
forwarded on eth1 to the router, so my printer can ask for a DHCP OFFER=20
message, by sending a DHCP DISCOVER on the switch. That switch will send=20
the message to eth0 of UBUNTU SERVER whichs forwards (bridging!) the=20
packet on eth1 to the router. The router sends a DHCP OFFER back to eth1=20
of UBUNTU SERVER, which eventually forwards (bridging!) the message back=20
to switch (and so on to the printer :-))
