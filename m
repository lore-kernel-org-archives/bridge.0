Return-Path: <stephen@networkplumber.org>
Date: Thu, 5 Dec 2013 08:55:14 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20131205085514.4c079747@nehalam.linuxnetplumber.net>
In-Reply-To: <1386257257-25258-1-git-send-email-jiri@resnulli.us>
References: <1386257257-25258-1-git-send-email-jiri@resnulli.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [patch net/stable v2] br: fix use of ->rx_handler_data
 in code executed on non-rx_handler path
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jiri Pirko <jiri@resnulli.us>
Cc: jtluka@redhat.com, mst@redhat.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, edumazet@google.com, laine@redhat.com, zhiguohong@tencent.com, davem@davemloft.net

On Thu,  5 Dec 2013 16:27:37 +0100
Jiri Pirko <jiri@resnulli.us> wrote:

> br_stp_rcv() is reached by non-rx_handler path. That means there is no
> guarantee that dev is bridge port and therefore simple NULL check of
> ->rx_handler_data is not enough. There is need to check if dev is really
> bridge port and since only rcu read lock is held here, do it by checking
> ->rx_handler pointer.
>=20
> Note that synchronize_net() in netdev_rx_handler_unregister() ensures
> this approach as valid.
>=20


I think this patch is simpler/better, it restores the old logic.

Ps. submitting patches to bugzilla is a good way to have them ignored.

=46rom Stephen Hemminger <stephen@networkplumber.org>

Check that incoming STP packet is received on a port assigned to bridge
before processing. It is possible to receive packet on non-bridge port
because they are multicast.

See:
 https://bugzilla.kernel.org/show_bug.cgi?id=3D64911


Regression introduced by:
commit 716ec052d2280d511e10e90ad54a86f5b5d4dcc2
Author: Hong Zhiguo <zhiguohong@tencent.com>
Date:   Sat Sep 14 22:42:28 2013 +0800

    bridge: fix NULL pointer deref of br_port_get_rcu


Reported-by: Alexander Y. Fomichev
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>


--- a/net/bridge/br_stp_bpdu.c	2013-06-11 09:50:21.522919061 -0700
+++ b/net/bridge/br_stp_bpdu.c	2013-12-05 08:46:56.090463702 -0800
@@ -153,6 +153,9 @@ void br_stp_rcv(const struct stp_proto *
 	if (buf[0] !=3D 0 || buf[1] !=3D 0 || buf[2] !=3D 0)
 		goto err;
=20
+	if (!br_port_exists(dev))
+		goto err;
+
 	p =3D br_port_get_rcu(dev);
 	if (!p)
 		goto err;
