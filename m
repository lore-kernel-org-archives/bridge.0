Message-ID: <47ef310511170301sc3dac74x1a14bd75f8c8bdb6@mail.gmail.com>
Date: Thu, 17 Nov 2005 12:01:47 +0100
From: Sebastien Chaumontet <sebastien@chaumontet.net>
Sender: schaumon@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [Bridge] Linux bridge on linksys WRT54GS running OpenWRT
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org, shemminger@osdl.org
Cc: =?ISO-8859-1?Q?Micka=EBl_Hoerdt?= <hoerdt@clarinet.u-strasbg.fr>, Olaf Menzel <olaf.menzel@fokus.fraunhofer.de>

Hi all,

Following the this thread opened by Olaf
(http://lists.osdl.org/mailman/htdig/bridge/2005-July/001026.html)

We performed some more tests with and without wireless. Latest one was
to remove CONFIG_BRIDGE_NETFILTER from kernel option at compilation
time on a 2.6.14-rc4. This change solved the problem and the bridge
was able to forward correctly MLD packets (IPv6 multicast subscription
message).

So the problem seems to be related to etables. Something related to
IP/SABOTAGE in br_netfilter.c?

As specified on the bridge FAQ "The bridge knows nothing about
protocols, it only sees Ethernet frames." it should not look at the
content of the packet.

Most of performed tests are described on
http://dbeacon.innerghost.net/LinuxBridgingMulticast

Thanks
Regards

S=E9bastien

