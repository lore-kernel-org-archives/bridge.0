DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=googlemail.com; s=beta;
	h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
	bh=q/eX0VDru2NZ3ZekXJYrZ4wSQQD0DPVzKv8uubOoYBo=;
	b=UGXI/oe6ODxAicIsN6KB5mGi2YwYBPK4Nv3bL9AHFMqRXggaHI6CC6SgP78asbKTzYgONa/6aX+3jP2vGxRz2J3PuDQz4fiMO/b2v62ZYhB9GGo6Cl+UckBc/B/xdmQ0LMl3t0Wfmqrsi5nJDuV4LrhlBfFSsqUYzdvMw9uy1K0=
Message-ID: <46FCB3F4.4080802@googlemail.com>
Date: Fri, 28 Sep 2007 09:57:40 +0200
From: Dennis Borgmann <dennis.borgmann@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Flushing MAC-tables(?)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Dear list-members!

I am using OpenWRT (www.openwrt.org) on two accesspoints. Within
OpenWRT, the wireless interface and the ethernet interface are bridged
to one interface (br0).

Those two accesspoints are standing quite far from one another. Their
WLAN-cells do not cross each other, meaning I have an area in between
the two accesspoints, where there is no accesspoint of the two
accessible: a dead spot.

Now I use two WLAN-telephones (Cisco 7920). I start calling one of the
phones inside the same radio cell and I answer this call. Now I start
moving away to the other accesspoint. As soon as I see myself assiciated
to the "new" accesspoint, I am able to hear my mate on the other phone
in the "old" cell, but he cannot hear me. This stays this way, until a
certain point of time is reached. In our tests, he has been able to hear
my voice recurring at :30 each minute. Take these examples:

05:40:20 I roamed to the "new" AP
05:40:30 my mate could hear me

05:43:35 I roamed to the "new" AP
05:44:30 my mate could hear me

05:47:03 I roamed to the "new" AP
05:47:30 my mate could hear me

...and so on.

So at a certain point of time, there seems to be a flushing of some
bridge-tables, but I don't know, how I could influence this behaviour.
Is this "flushing" somehow to be done manually? Or is there a timer,
which sets this behaviour?

I sniffed the WLAN a little while my tests have been done and the result
is, that the "old" accesspoint seems to still believe me in his radio
cell. So he sends out data for me all of the time, but since my
telephone has moved away, there is no more client to ACK these packages.
After the time mentioned before has passed, these packet are away and
the communication goes on the way it should. So I assume, there is a
timeout, that tells the AP to flush its old bridge-MAC tables of
clients, that he did not hear of since XX seconds...

Any help would be appreciated. Thanks a lot in advance,

Dennis
