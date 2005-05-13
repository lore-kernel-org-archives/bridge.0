Date: Fri, 13 May 2005 16:30:34 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Message-ID: <20050513163034.28e4d9be@dxpl.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] 2.6.12-rc4-bridge
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@osdl.org
Cc: Akshay Bhargava <akshaybh@gmail.com>

http://developer.osdl.org/shemminger/patches/2.6.12-rc4-bridge/

Here are some patches for requested features, given basic testing but
need more testing before they are publicly ready:

bridge-csum - turn on bridge pseudo-device flags so that smart hardware
	              does less work. Helps Xen

bridge-flush - add /sys/class/net/brX/bridge/flush write only hook to flush
	              forwarding database entries

bridge-setmac - allow setting device address to force bridge_id.
	                  setting to zero forces recalculation
