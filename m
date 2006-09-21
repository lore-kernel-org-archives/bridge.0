Message-ID: <451296BE.1060002@cambridgebroadband.com>
Date: Thu, 21 Sep 2006 14:42:22 +0100
From: Alex Zeffertt <ajz@cambridgebroadband.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] bridge_list orphans in linux-2.4
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Hi all,

We use linux-2.4.20 in one of our products and we've found what looks
to be a problem in the bridge module.  (I know this is old code but we
don't send our customers kernel upgrades unless we really have to!)

The problem is that some of our bridges have become orphaned from the
bridge module.  Specifically

	ifconfig ourbridgename

shows that the device "ourbridgename" is known to the kernel, but

	brctl show

does not list "ourbridgename".


I've looked through the bridge module and it seems that the most likely
explanation is that bridge_list in br_if.c has become corrupted, causing
the bridge called "ourbridgename" to become orphaned.

I cannot see how this would happen, however, since bridge_list is only
ever referenced under the ioctl_mutex.  I should also point out that
br_del_bridge() is not called by our application.

I noticed that in later kernels the ioctl_mutex has been replaced by
the rtnl_lock().  Why was this done?  Could this be related to our
problem?

TIA,

Alex
