Date: Thu, 3 Jun 2004 10:41:00 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] Little problem with 1.x versions (if_indextoname)
Message-Id: <20040603104100.2ae94cb2@dell_ss3.pdx.osdl.net>
In-Reply-To: <s0bef17a.034@post2.controlware.de>
References: <s0bef17a.034@post2.controlware.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: "Harald =?ISO-8859-1?B?S/x0aGUi?= <Harald.Kuethe@controlware.de>"@osdl.org
Cc: uclibc@uclibc.org, bridge@lists.osdl.org

On Thu, 03 Jun 2004 09:37:34 +0200
"Harald K=FCthe" <Harald.Kuethe@controlware.de> wrote:

> Hi,=20
> I have used bridge-utils 0.9.6 so far in a kernel 2.4.26, uClibc and ppc =
environment.
>=20
> When I use version 1.0.3 I have the problem that I do not see the brige w=
ith the 'brctl show' command if it is not fully set up. It was working with=
 0.9.6.
> I tracked the problem down to an 'incompatibility' in bridge/uClibc/kerne=
l.
>=20
> 0.9.6 uses its own if_indextoname function which uses the SIOCGIFNAME ioc=
tl which works with the kernel.
> Version 1.x uses the libc if_indextoname (here uClibc) which uses the SIO=
CGIFCONF ioctl and scans the if list to resolv the name for an if_index.=20
> The kernel will not send back interfaces which do not have an ip address =
(or exactly only for protocol family inet or decnet).=20
> So if the bridge does not have an ip address the name resolution fails an=
d old_foreach_bridge() fails as well.
>=20
> I'm not sure who has the problem now (kernel, uClibc, bridge) , but I thi=
nk I will insert if_indextoname() back to the bridge.
>=20
> I hope that this information is useful.
>=20
> Regards
> Harald K=FCthe

Rather than copy more code back into the bridge-utilities, how about applyi=
ng this
change to uClibc?  I hate when packages get cluttered for workarounds for o=
ther
incompatibilities.

The problem is that SIOCGIFCONF only lists interfaces that have IP addresse=
s, so it
doesn't find the other interfaces that are being used for bridging. It coul=
d be fixed
in the kernel to return all interfaces, but then something else might break=
; and still
it mean a kernel update for the 2.4 users.=20

The whole use of ifindex in the bridge API is a bad idea. But we probably h=
ave to live
with it for compatibility.

Patch against uClibc 0.9.26
------------------------------------------------------------
--- if_nametoindex.c.orig	2002-12-04 10:27:15.000000000 -0800
+++ if_nametoindex.c	2004-06-03 10:31:34.732707064 -0700
@@ -148,6 +148,27 @@
=20
 char * if_indextoname (unsigned int ifindex, char *ifname)
 {
+#ifdef SIOCGIFNAME
+  /* Use ioctl to avoid searching the list. */
+  struct ifreq ifr;
+  int fd, saved_errno;
+
+  fd =3D __opensock ();
+ =20
+  if (fd < 0)
+      return NULL;
+
+  ifr.ifr_ifindex =3D ifindex;
+  if (ioctl (fd, SIOCGIFNAME, &ifr) < 0) {
+      saved_errno =3D errno;
+      close (fd);
+      __set_errno (saved_errno);
+      return NULL;
+  }
+  close (fd);
+
+  return strncpy (ifname, ifr.ifr_name, IFNAMSIZ);
+#else
     struct if_nameindex *idx;
     struct if_nameindex *p;
     char *result =3D NULL;
@@ -163,5 +184,6 @@
 	if_freenameindex (idx);
     }
     return result;
+#endif
 }
=20

