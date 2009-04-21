Date: Tue, 21 Apr 2009 14:19:00 +0300 (IDT)
From: Or Gerlitz <ogerlitz@voltaire.com>
Message-ID: <Pine.LNX.4.64.0904211307060.6460@zuben.voltaire.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [Bridge] NIC unicast macs table manipulation by bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: shemminger@linux-foundation.org
Cc: bridge@lists.linux-foundation.org

Using a Linux bridge I see that none of the interfaces is set to promiscuous
mode but on the other hand I don't see any dev_unicast_xxx calls in the
bridge code... for the case of one of the interfaces being a physical NIC
(e.g eth1), what's the magic that makes the NIC RX filtering be willing
to accept frames whos dest mac isn't the NIC "primary" unicast mac?

Also is there a method to display dev->uc_list (e.g similar to /proc/net/dev_mcast)?

Or.
