Date: Sun, 12 Mar 2006 14:10:07 +0100
Message-Id: <1029117136@web.de>
MIME-Version: 1.0
From: devzero@web.de
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Subject: [Bridge] Re: aoe/vblade on "localhost"
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@osdl.org

some more info:

> afaik, after starting, the bridge is in some "learning" state, to see wha=
t is on the "left side" and on the "right side".
> i`m somewhat unsure if AoE/vblade are sending out enough (or the right?) =
packets to make the bridge let them go through (aoe and vblade get aware of=
 each other via broadcast)=20
>=20
> can somebody give an advice on what needs to be taken into account here a=
nd what could be done to debug this?
> regards

actually, the broadcasts of AoE driver get through from dummy1 to dummy0 - =
i see 2 packets on dummy0 and those 2 being forwarded on dummy1

vserver2:~ # tcpdump -i dummy0 &
[1] 11302
vserver2:~ # tcpdump: verbose output suppressed, use -v or -vv for full pro=
tocol decode
listening on dummy0, link-type EN10MB (Ethernet), capture size 96 bytes

vserver2:~ # tcpdump -i dummy1 &
[2] 11303
vserver2:~ # tcpdump: verbose output suppressed, use -v or -vv for full pro=
tocol decode
listening on dummy1, link-type EN10MB (Ethernet), capture size 96 bytes

14:02:09.887410 6e:d9:cf:4c:9d:df > Broadcast, ethertype Unknown (0x88a2), =
length 60:
        0x0000:  1000 ffff ff01 0000 0000 0000 0000 0000  ................
        0x0010:  0000 0000 0000 0000 0000 0000 0000 0000  ................
        0x0020:  0000 0000 0000 0000 0000 0000 0000       ..............
14:02:09.888004 ca:90:06:04:f6:ec > Broadcast, ethertype Unknown (0x88a2), =
length 60:
        0x0000:  1000 ffff ff01 0000 0000 0000 0000 0000  ................
        0x0010:  0000 0000 0000 0000 0000 0000 0000 0000  ................
        0x0020:  0000 0000 0000 0000 0000 0000 0000       ..............
14:02:09.886699 6e:d9:cf:4c:9d:df > Broadcast, ethertype Unknown (0x88a2), =
length 60:
        0x0000:  1000 ffff ff01 0000 0000 0000 0000 0000  ................
        0x0010:  0000 0000 0000 0000 0000 0000 0000 0000  ................
        0x0020:  0000 0000 0000 0000 0000 0000 0000       ..............
14:02:09.888278 6e:d9:cf:4c:9d:df > Broadcast, ethertype Unknown (0x88a2), =
length 60:
        0x0000:  1000 ffff ff01 0000 0000 0000 0000 0000  ................
        0x0010:  0000 0000 0000 0000 0000 0000 0000 0000  ................
        0x0020:  0000 0000 0000 0000 0000 0000 0000       ..............


but - the broadcasts from vblade (connected to dummy0) can only be seen on =
dummy0, but not on dummy1:


vserver2:~ # tcpdump -i dummy0
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on dummy0, link-type EN10MB (Ethernet), capture size 96 bytes

14:04:33.825077 ca:90:06:04:f6:ec > Broadcast, ethertype Unknown (0x88a2), =
length 32:
        0x0000:  0800 0000 0001 0000 0000 0020 400a 0010  ............@...
        0x0010:  0000                                     ..

it seems the bridge isn`t forwarding them from dummy0 to dummy1

i have setup the bridge 2 or 3 times - but it doesn`t seem to work as expec=
ted.

i`m on  SuSE 9.2 with kernel 2.6.8-24.19-default=20

regards
roland



> -----Urspr=FCngliche Nachricht-----
> Von: devzero@web.de
> Gesendet: 12.03.06 12:38:49
> An: bridge@osdl.org
> Betreff: aoe/vblade on "localhost"


> hello !
>=20
> i try to use a network technology on one single host, which wasn`t design=
ed for that.=20
>=20
> to give a short overview of what i`m talking about:
>=20
> AoE is just like a "networked blockdevice" (just like nbd/enbd) - but wit=
hout tcp/ip.=20
> AoE kernel driver is the "client end" (see this like an iSCSI initiator) =
- and an etherblade storage appliance is the "server end" (see this like an=
 iSCSI target)
> there is a software equivalent to etherblade storage which is called vbla=
de (part of the aoetools project) - or vblade-kernel (another implementatio=
n, but done as a kernel module)
>=20
> a very nice article about what AoE is can be found at http://www.linuxjou=
rnal.com/comment/reply/8149
>=20
> what i want to do is nicely described in this bugreport by some other per=
son:
>=20
> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D336772
>=20
> i want to connect a AoE driver to vblade on _one_ host and i have tried t=
hat mentioned "clever juggling of network devices" on my system, but i didn=
`t succedd.
>=20
> some coraid employee recommended trying linux-bridging - so i created two=
 dummy interfaces (module dummy.ko), created a bridge "aoe-bridge" and adde=
d dummy0 and dummy1 to that bridge.
>=20
> then i "connected" AoE-driver to dummy0 and vblade server process to dumm=
y1 and would have expected that this should work.
>=20
> unfortunately, it failed to work and from what it seems it wasn`t a probl=
em with AoE or vblade but with the bridge, because i couldn`t see (tcpdump)=
 packets going through into both directions.=20
>=20
> afaik, after starting, the bridge is in some "learning" state, to see wha=
t is on the "left side" and on the "right side".
> i`m somewhat unsure if AoE/vblade are sending out enough (or the right?) =
packets to make the bridge let them go through (aoe and vblade get aware of=
 each other via broadcast)=20
>=20
> can somebody give an advice on what needs to be taken into account here a=
nd what could be done to debug this?
> regards
>=20
> roland k.=20
> systems engineer


______________________________________________________________
Verschicken Sie romantische, coole und witzige Bilder per SMS!
Jetzt bei WEB.DE FreeMail: http://f.web.de/?mc=3D021193


