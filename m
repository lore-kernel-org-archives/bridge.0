Date: Wed, 16 Mar 2005 12:38:28 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Message-ID: <20050316123828.0eb78fd3@dxpl.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] [ANNOUNCE] bridge utilities 1.0.6
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@osdl.org
Cc: linux-net@vger.kernel.org, netdev@oss.sgi.com, linux-kernel@vger.kernel.org

Minor update to bridge utilities for 2.4/2.6. The changes are:
 + Better usage of autoconf to manage detecting sysfs library
 + Support multiple interfaces for add/delete interface commands.
	Example: brctl addif br0 eth0 eth1 eth2 
 - Remove code that was dead and no longer used

http://prdownloads.sourceforge.net/bridge/bridge-utils-1.0.6.tar.gz?download
