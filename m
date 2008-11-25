Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Nov 2008 15:37:22 -0000
Message-ID: <89ADFB63BC286B49BC71F1D34A7E38D612E30B@EXVS01.aenigmacorp.com>
References: <20081125153116.42936yyfpzcbl8p0@w0.mail.sapo.pt>
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
To: =?iso-8859-1?Q?Jo=E3o_Pedro?= <countzero@sapo.pt>, bridge@lists.linux-foundation.org

JP;

I've had this very issue.  I know that 2.6.24-16 allows PVST BPDUs to =
cross the bridge.  Linux won't speak Cisco PVST+ but it will pass the =
BPDU's so that Cisco devices on both sides can communicate about the =
link state.

That has been my experience anyway (long and painful I might add).

G

-----Original Message-----
From: bridge-bounces@lists.linux-foundation.org =
[mailto:bridge-bounces@lists.linux-foundation.org] On Behalf Of Jo=E3o =
Pedro
Sent: 25 November 2008 3:31 PM
To: bridge@lists.linux-foundation.org
Subject: [Bridge] Bridging VLANs and PVST+


Hello,

Two years ago there was a post regarding a patch to the Linux kernel =20
allowing it to bridge of two VLANs with Cisco's PVST+ =20
(https://lists.linux-foundation.org/pipermail/bridge/2006-May/004921.html=
). I =20
tried contacting both Gergely Madarasz (the author of the patch) and =20
Ian Schwimmer (who started the thread) without any luck.

Does anyone has this patch? Or, for that matter, a solution on how to =20
do this? I'm currently using ebtables on SLES10SP2 to DROP the =20
switch's BPDUs, avoiding it from shutting down the port; I have also =20
changed the bridge's ULA in order to use "per-vlan" STP. This =20
situation if far from ideal, of course: it would be great to have STP =20
working between the Linux box and the Cisco switch (or any other =20
switch), allowing it [the Linux Box] to "fail-to-wire" if something =20
was to go wrong.

Thank you,
JP
_______________________________________________
Bridge mailing list
Bridge@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/bridge
