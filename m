MIME-Version: 1.0
Date: Sun, 10 May 2009 14:37:56 +0100
Message-ID: <a62fd16c0905100637n1107c9degd8212e9e649cba4e@mail.gmail.com>
From: Steven Williamson <steven43126@gmail.com>
Content-Type: multipart/alternative; boundary=0016364c7bc325266004698ef811
Subject: [Bridge] Linux Bridge Forward STP?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

--0016364c7bc325266004698ef811
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

If I have 2 switches already using RSTP with only a single link between
them. Then add a redundant link using a Linux bridge with STP turned off.
Will the Linux bridging code forward the RSTP BPDU's so the other switches
realize there is a new path to the root bridge, and hopefully block one of
the ports ?


The exact secnario is an ethernet segment spanning 2 datacenter's via a
fibre link. We'd like to add redundancy using a linux bridge (bridging to a
VPN tap device and routing over the net) but have since discoverd the Linux
code does not support RSTP yet.

p.s

Many thanks to the developers of the Linux briding code!

Regards
Steven Williamson.

--0016364c7bc325266004698ef811
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br><br>If I have 2 switches already using RSTP with only a single link =
between them. Then add a redundant link using a Linux bridge with STP turne=
d off. Will the Linux bridging code forward the RSTP BPDU&#39;s so the othe=
r switches realize there is a new path to the root bridge, and hopefully bl=
ock one of the ports ?<br>
<br><br>The exact secnario is an ethernet segment spanning 2 datacenter&#39=
;s via a fibre link. We&#39;d like to add redundancy using a linux bridge (=
bridging to a VPN tap device and routing over the net) but have since disco=
verd the Linux code does not support RSTP yet. <br>
<br>p.s<br><br>Many thanks to the developers of the Linux briding code!<br>=
<br>Regards<br>Steven Williamson.<br><br><br><br><br><br><br>

--0016364c7bc325266004698ef811--
