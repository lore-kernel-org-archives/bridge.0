Message-ID: <OFAE56C1D1.3B4E5ED6-ONC125773D.005039AB-C125773D.00511E25@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Wed, 9 Jun 2010 16:46:01 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Subject: [Bridge] Bridge responds on its IP address even when br0 is down.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org


System A:
eth0 has ip 192.168.1.16

Then do in system A
brctl addbr br0
ifconfig br0 192.168.1.18 down


From system B I ping 192.168.1.18
and system A responds!

Even though interface br0 is down I can still
access system A with 192.168.1.18, this feels
like a bridge bug?

Linux version 2.6.33

     Jocke

