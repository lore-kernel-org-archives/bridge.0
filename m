Message-Id: <4D81CDF6020000780003700B@vpn.id2.novell.com>
Date: Thu, 17 Mar 2011 08:01:42 +0000
From: "Jan Beulich" <JBeulich@novell.com>
References: <4D80BC5B0200007800036D85@vpn.id2.novell.com>
	<20110316082441.45db3018@nehalam>
In-Reply-To: <20110316082441.45db3018@nehalam>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: Re: [Bridge] build breakage due to br_multicast.c referencing
	ipv6_dev_get_saddr()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: linus.luessing@web.de, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, davem@davemloft.net

>>> On 16.03.11 at 16:24, Stephen Hemminger <shemminger@linux-foundation.or=
g>
wrote:
> On Wed, 16 Mar 2011 12:34:19 +0000
> "Jan Beulich" <JBeulich@novell.com> wrote:
>=20
>> With BRIDGE=3Dy and IPV6=3Dm commit
>> fe29ec41aaa51902aebd63658dfb04fe6fea8be5 ("bridge: Use IPv6
>> link-local address for multicast listener queries") causes the build to
>> break.
>=20
> Rather than continue with the config games, lets just make the necessary
> ipv6 pieces accessible.

The below (however ugly it may look) seems to do the trick for me,
for this particular symbol. Possibly other symbols need doing the
same (didn't check which ones e.g. infiniband depends on), so
some sort of abstraction might be desirable to make the whole
thing look less ugly.

Jan

--- a/include/net/addrconf.h
+++ b/include/net/addrconf.h
@@ -78,7 +78,21 @@ extern struct inet6_ifaddr      *ipv6_ge
 						 struct net_device *dev,
 						 int strict);
=20
-extern int			ipv6_dev_get_saddr(struct net *net,
+#ifdef CONFIG_IPV6_MODULE
+static inline int ipv6_dev_get_saddr_stub(struct net *net,
+					  struct net_device *dev,
+					  const struct in6_addr *daddr,
+					  unsigned int srcprefs,
+					  struct in6_addr *saddr)
+{
+	return -EPROTONOSUPPORT;
+}
+
+extern int			(*ipv6_dev_get_saddr)
+#else
+extern int			ipv6_dev_get_saddr
+#endif
+					      (struct net *net,
 					       struct net_device *dev,
 					       const struct in6_addr =
*daddr,
 					       unsigned int srcprefs,
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -1119,9 +1119,14 @@ out:
 	return ret;
 }
=20
-int ipv6_dev_get_saddr(struct net *net, struct net_device *dst_dev,
-		       const struct in6_addr *daddr, unsigned int prefs,
-		       struct in6_addr *saddr)
+#ifdef MODULE
+static int _ipv6_dev_get_saddr
+#else
+int ipv6_dev_get_saddr
+#endif
+	(struct net *net, struct net_device *dst_dev,
+	 const struct in6_addr *daddr, unsigned int prefs,
+	 struct in6_addr *saddr)
 {
 	struct ipv6_saddr_score scores[2],
 				*score =3D &scores[0], *hiscore =3D =
&scores[1];
@@ -1244,7 +1249,6 @@ try_nextdev:
 	in6_ifa_put(hiscore->ifa);
 	return 0;
 }
-EXPORT_SYMBOL(ipv6_dev_get_saddr);
=20
 int ipv6_get_lladdr(struct net_device *dev, struct in6_addr *addr,
 		    unsigned char banned_flags)
@@ -4720,6 +4724,10 @@ int __init addrconf_init(void)
=20
 	ipv6_addr_label_rtnl_register();
=20
+#ifdef MODULE
+	ipv6_dev_get_saddr =3D _ipv6_dev_get_saddr;
+#endif
+
 	return 0;
 errout:
 	rtnl_af_unregister(&inet6_ops);
@@ -4738,6 +4746,10 @@ void addrconf_cleanup(void)
 	struct net_device *dev;
 	int i;
=20
+#ifdef MODULE
+	ipv6_dev_get_saddr =3D ipv6_dev_get_saddr_stub;
+#endif
+
 	unregister_netdevice_notifier(&ipv6_dev_notf);
 	unregister_pernet_subsys(&addrconf_ops);
 	ipv6_addr_label_cleanup();
--- a/net/ipv6/addrconf_core.c
+++ b/net/ipv6/addrconf_core.c
@@ -3,10 +3,17 @@
  * not configured or static.
  */
=20
+#include <net/addrconf.h>
 #include <net/ipv6.h>
=20
 #define IPV6_ADDR_SCOPE_TYPE(scope)	((scope) << 16)
=20
+#ifdef CONFIG_IPV6_MODULE
+typeof(ipv6_dev_get_saddr) __read_mostly ipv6_dev_get_saddr
+	=3D ipv6_dev_get_saddr_stub;
+#endif
+EXPORT_SYMBOL_GPL(ipv6_dev_get_saddr);
+
 static inline unsigned ipv6_addr_scope2type(unsigned scope)
 {
 	switch(scope) {


