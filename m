Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Tue,  7 Apr 2015 21:57:28 +0200
Message-Id: <1428436652-4676-1-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH RFCv3 0/4] batman-adv: Unicasting multicast reports
 to querier-node only
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org

The last round of multicast patches send to the batman-adv mailinglist
to add support for the multicast optimizations in bridged scenarios, too,
unfortunately had one major conceptual flaw: It could lead to packet loss.
It's not sufficient to have the unicasting of reports implemented on
bridge-nodes only. Nodes without bridges need to treat reports the same
way.

The issue is described in detail here:

https://www.open-mesh.org/projects/batman-adv/wiki/Multicast-optimizations-listener-reports


I'd also be interested in what the netdev/bridge people think about
patches #1 and #2 in particular, therefore including the according mailinglists
now.

Cheers, Linus

-----

Changelog:
v3:
 * Adding Kconfig-depends and #if's
   (so basically adding similar dependancy constraints as the bridge code
    has, except that there are no depends if batman-adv gets compiled without
    multicast optimizations)
   -> the case of IPv6=M and batman-adv=y is still impossible if multicast
      optimizations are enabled; but I don't see the practical demand for that
      either - people who use IPv6 as a module will probably also want to
      use batman-adv as a module
v2:
 * various bugfixes (now runtime tested, too - should(tm) work)
 * added netdev+bridge mailinglists
