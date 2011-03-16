Message-Id: <4D80BC5B0200007800036D85@vpn.id2.novell.com>
Date: Wed, 16 Mar 2011 12:34:19 +0000
From: "Jan Beulich" <JBeulich@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: [Bridge] build breakage due to br_multicast.c referencing	
	ipv6_dev_get_saddr()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: linus.luessing@web.de
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, davem@davemloft.net

With BRIDGE=3Dy and IPV6=3Dm commit
fe29ec41aaa51902aebd63658dfb04fe6fea8be5 ("bridge: Use IPv6
link-local address for multicast listener queries") causes the build to
break.

Similary, even if both are =3Dm, but ipv6.ko got blacklisted (as is
happening in various SuSE distros when disabling IPv6), there's
a runtime problem since bridge.ko then won't load anymore due
to the missing symbol.

I note that infiniband appears to have had a similar problem
(didn't verify whether they have other dependencies on ipv6.ko),
resolved by an odd looking dependency of INFINIBAND_ADDR_TRANS
on !(INFINIBAND =3D y && IPV6 =3D m).

IP_VS also seems to have a similar issue.

Resolving this the infiniband way seems rather undesirable to me.
Instead I would think that this and any similar dependency should
get resolved via placing a stub pointer in net/ipv6/addrconf_core.c
(for this particular case), and having ipv6.ko set the pointer to the
actual implementation.

Otherwise, namely in distro kernels, pure IPv4 environments
pointlessly load the (huge) ipv6.ko just to satisfy symbol
references that would never get called.

One unrelated other observation with this change of yours:
daddr is an input argument to ipv6_dev_get_saddr(), yet
it gets initialized only after the function was called. Is that
really correct?

Thanks, Jan

