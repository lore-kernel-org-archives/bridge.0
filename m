Message-ID: <3FB2C726.4000503@gmx.net>
Date: Thu, 13 Nov 2003 00:49:58 +0100
From: David GLAUDE <dglaudemailing@gmx.net>
MIME-Version: 1.0
References: <20031028112416.GA32122@prolix.local.igalia.com>
	<20031112131806.2fdfccd1.shemminger@osdl.org>
In-Reply-To: <20031112131806.2fdfccd1.shemminger@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Bridge that do MSS CLAMP
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@osdl.org

In order to transparently help packet go inside a vpn/tunnel without 
having to solve the security problem of permiting ICMP packet getting 
accross a firewal...

I would like to use "clamp-mss-to-pmtu" inside a bridge (firewall bridge).

It would bridge every traffic, but alter the Maximum Segment of TCP 
connection.

Before attempting this, could anybody give us a hint on the possibility 
for this to work... Was this attempted before (or should I ask for a 
"software patent" on this) :-)

It sound a little bit like what a "Packet Shaper"TM does by altering 
windows size computation.

David GLAUDE




