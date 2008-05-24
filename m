Message-ID: <2115.78.42.27.128.1211616272.squirrel@postamt.eit.uni-kl.de>
Date: Sat, 24 May 2008 10:04:32 +0200 (CEST)
From: "Faruk Keskin" <faruk@eit.uni-kl.de>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: [Bridge] How to determine where bridged packets originally come
	from ?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hi all,

I ended up using raw packet sockets (ETH_P_ALL) with BPF filters attached
(binded on the bridge interface) to capture packets for the userspace
host.

Now having captured these packets from the bridge interface, how do I know
which interface (eth0, wifi0, ..) the packets were send from originally ?

Is there a handy solution to this without modifying the packet content ?

Please help me out I you got the answer down pat.

BR, Faruk

