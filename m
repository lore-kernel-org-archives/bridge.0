Message-ID: <4D6FB888.7020004@univ-nantes.fr>
Date: Thu, 03 Mar 2011 16:49:28 +0100
From: Jean-Philippe Menil <jean-philippe.menil@univ-nantes.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: [Bridge] 2.6.36-rc7: net/bridge causes temporary network I/O lockups
Reply-To: jean-philippe.menil@univ-nantes.fr
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hi,

i've just seen this thread:
https://lists.linux-foundation.org/pipermail/bridge/2010-October/007362.html

We are affected too by this problem.
Disable multicast_startup_query_count doesn't to do the trick.
Recompiling the kernel without CONFIG_BRIDGE_IGMP_SNOOPING is ok.

Our switch are dell powerconnect in m1000 chassis enclosure with  "ip=20
igmp snooping".
Remove the igmp snooping on the switch seems to fix the packet loss.
But we don't want to disable igmp snooping on our switch (and we prefer=20
to not disabe BRIDGE_IGMP_SNOOPING on our kernel ...).

I can provide more info if necessary.

Regards.

--=20
Jean-Philippe Menil - P=F4le r=E9seau Service IRTS
DSI Universit=E9 de Nantes
jean-philippe.menil@univ-nantes.fr
Tel : 02.53.48.49.27 - Fax : 02.53.48.49.09

