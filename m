Message-ID: <421CEB46.5010707@abwaters.com>
Date: Wed, 23 Feb 2005 13:44:54 -0700
From: Bryan Waters <bryanw@abwaters.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Bridge not working...
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@osdl.org

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
