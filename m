Message-Id: <s0bef17a.034@post2.controlware.de>
Date: Thu, 03 Jun 2004 09:37:34 +0200
From: "=?ISO-8859-1?Q?Harald=20K=FCthe?=" <Harald.Kuethe@controlware.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [Bridge] Little problem with 1.x versions (if_indextoname)
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Hi,=20
I have used bridge-utils 0.9.6 so far in a kernel 2.4.26, uClibc and ppc en=
vironment.

When I use version 1.0.3 I have the problem that I do not see the brige wit=
h the 'brctl show' command if it is not fully set up. It was working with 0=
.9.6.
I tracked the problem down to an 'incompatibility' in bridge/uClibc/kernel.

0.9.6 uses its own if_indextoname function which uses the SIOCGIFNAME ioctl=
 which works with the kernel.
Version 1.x uses the libc if_indextoname (here uClibc) which uses the SIOCG=
IFCONF ioctl and scans the if list to resolv the name for an if_index.=20
The kernel will not send back interfaces which do not have an ip address (o=
r exactly only for protocol family inet or decnet).=20
So if the bridge does not have an ip address the name resolution fails and =
old_foreach_bridge() fails as well.

I'm not sure who has the problem now (kernel, uClibc, bridge) , but I think=
 I will insert if_indextoname() back to the bridge.

I hope that this information is useful.

Regards
Harald K=FCthe


