Message-ID: <AD59566A9D83864F871AE2E52503064001663D6C@aimail.aiinet.priv>
From: "Eble, Dan" <DanE@aiinet.com>
Date: Mon, 9 Feb 2004 11:16:36 -0500 
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Bridge] Two entries in forwarding database
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: "'bridge@osdl.org'" <bridge@osdl.org>

I'm debugging a strange problem of noncommunication between two devices.
The test configuration is also strange, and involves loops.  Things
magically start working when I run tcpdump to put the bridge interface into
promiscuous mode.  I also noticed this in the output of brctl showmacs.

    port no mac addr                is local?       ageing timer

      1     00:40:72:04:2d:ea       no                27.10

      1     00:40:72:04:2d:ea       yes                0.00


Disregarding for the moment the loops in the test setup, which are probably
the root of the problem, it seems to me that since MAC address is used as
the key for entries in the FDB, there should not be two entries with the
same address.  (The address shown is one of the interfaces in the bridge.)
When a static entry is added it should overwrite a non-static entry.

I am going to try to fix this in br_fdb.c and post a patch (ppc kernel
2.4.21-pre4), but I wanted to see if anyone had any advice that would save
me some work or help me do a better job.  Thank you.

-- 
Dan Eble <dane@aiinet.com>  _____  .
                           |  _  |/|
Applied Innovation Inc.    | |_| | |    "All Protocols MUST be odd"
http://www.aiinet.com/     |__/|_|_|      -- RFC 1661 (PPP)
