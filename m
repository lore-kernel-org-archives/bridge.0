Message-ID: <f946675f05013105387a277d2d@mail.gmail.com>
Date: Mon, 31 Jan 2005 08:38:42 -0500
From: Jason Davis <jason.lee.davis@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Multi-interface bridge configuration help
Reply-To: Jason Davis <jason.lee.davis@gmail.com>
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

I want to configure a bridge that has one LAN interface (eth0) and
multiple WAN interfaces.  However this environment will have a lot of
multicast traffic so I don't want any data received on the WAN
interfaces to be forwarded to each other, only to eth0.  Traffic
originating from eth0 would be transmitted in the normal bridging
manner on the WAN interfaces.  STP is not used in this network.  Is it
possible to configure a bridge to behave like this?  Thanks.
