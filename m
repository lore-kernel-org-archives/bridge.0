Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Thu, 6 Apr 2006 15:12:13 -0400
Message-ID: <F021020DA23B6641A05E616D5EAD146373A7CF@de01exm60.ds.mot.com>
From: "Miller Seth-G19426" <seth.miller@motorola.com>
Content-Transfer-Encoding: 8bit
Subject: [Bridge] RE: Rapid Spanning Tree support
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Bui Khanh-E12360C <E12360C@motorola.com>, bridge@osdl.org

Stephen,

This sounds like the right approach. I'm still not sure what you 
are proposing in terms of where the RSTP code should come from. 
would you expect we should be able to pull the code out of the 
existing bridge module?

Thanks

Seth


> -----Original Message-----
> Actually, I would like to make RSTP (and all the spanning tree
> protocols)
> a user space utility.  There are some infrastructure changes necessary
> to propagate sufficient information to do it.

I was going to leave existing STP in kernel for now, but not enable it.
For 2.6.17, I made sure that  STP packets are received so application
can receive them (via LLC).

The next part would be adding a netlink interface to bridge module
to report and modify:
	* interface added/deleted from bridge
	* interface status change (carrier up/down)
	* interface forwarding enable/disable
	* forwarding table flush by interface.


