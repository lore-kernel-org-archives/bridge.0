Message-Id: <200502242249.j1OMnqqh007342@smtp.osdl.org>
From: "Dan Grigsby" <dan@unpossible.com>
Subject: RE: [Bridge] Bridge not working...
Date: Thu, 24 Feb 2005 16:49:51 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
In-Reply-To: <421CEB46.5010707@abwaters.com>
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: 'Bryan Waters' <bryanw@abwaters.com>, bridge@osdl.org

Try "ifconfig br0 up"

-----Original Message-----
From: bridge-bounces@lists.osdl.org [mailto:bridge-bounces@lists.osdl.org]
On Behalf Of Bryan Waters
Sent: Wednesday, February 23, 2005 2:45 PM
To: bridge@osdl.org
Subject: [Bridge] Bridge not working...

I've got a 2.6.8 kernel with bridging enabled as a module, two nics 
(LNE100TX and RTL8139) and i've run the following commands with no errors

modprobe -v bridge
brctl addbr br0
brctl addif br0 eth0
brctl addif br0 eth1

both interfaces have 0.0.0.0 as their addresses and brctl showmacs br0 
shows the macs for both internal cards.  However, bridging doesn't seem 
to be working at all.  What am I missing or what else can I try to debug 
what might be wrong?

thanks
_______________________________________________
Bridge mailing list
Bridge@lists.osdl.org
http://lists.osdl.org/mailman/listinfo/bridge


