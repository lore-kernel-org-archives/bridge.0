Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Nov 2008 17:26:08 -0000
Message-ID: <89ADFB63BC286B49BC71F1D34A7E38D612E314@EXVS01.aenigmacorp.com>
References: <20081125153116.42936yyfpzcbl8p0@w0.mail.sapo.pt><89ADFB63BC286B49BC71F1D34A7E38D612E30B@EXVS01.aenigmacorp.com>
	<20081125170931.527737w59nif8qx7@w0.mail.sapo.pt>
From: "Geoff Wiener" <gwiener@aenigmacorp.com>
Subject: Re: [Bridge] Bridging VLANs and PVST+
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Joao Pedro <countzero@sapo.pt>
Cc: bridge@lists.linux-foundation.org

Hi JP;

I understand more clearly now - thank you for the example.  In the use
case that I struggled against I needed the BPDU's to traverse the bridge
as we were counting on the Cisco switches to force a blocking state on a
redundant link.  I have seen the case you are describing and assumed
that I would have to live with it as the Linux bridge was "doing the
right thing".  PVST is a proprietary Cisco protocol.  I guess wouldn't
expect an open source project to "re-write" the VLAN header for a
proprietary protocol.

Anyone else have any thoughts on this?

G

-----Original Message-----
From: Joao Pedro [mailto:countzero@sapo.pt]=20
Sent: 25 November 2008 5:10 PM
To: Geoff Wiener
Subject: RE: [Bridge] Bridging VLANs and PVST+


Hi Geoff, thank you for your answer.

Geoff Wiener <gwiener@aenigmacorp.com> wrote:

> I've had this very issue.  I know that 2.6.24-16 allows PVST BPDUs =20
> to cross the bridge.  Linux won't speak Cisco PVST+ but it will pass =20
> the BPDU's so that Cisco devices on both sides can communicate about =20
> the link state.
>
But isn't that part of the problem?

Imagine this situation, I have:
1 physical interface - eth0;
2 virtual lan interfaces - vlan15 and vlan16.
1 bridge - br0 - bridging vlan15 and vlan16.

The reason I have to filter the PVST+ BPDUs out (with ebtables) is =20
that, when the Cisco switch sees a BDPU on VLAN 15 that belonged =20
originally to VLAN 16, it will assume a loop was detected and shut =20
down the switch port where eth0 is connected. If Linux could convert =20
the VLAN 15 BDPU to a VLAN 16 BDPU, before sending it to VLAN 16, I =20
believe the problem would be solved.

Regards,
JP
