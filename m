Sender: Cyrill Gorcunov <gorcunov@gmail.com>
Message-Id: <20090511114639.440944109@openvz.org>
Date: Mon, 11 May 2009 15:46:39 +0400
From: Cyrill Gorcunov <gorcunov@openvz.org>
Subject: [Bridge] [RFC 0/5] bridge - introduce via_phys_dev feature
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, davem@davemloft.net, xemul@openvz.org

Hi,

here is RFC for new via_phys_dev bridge feature.
In short -- it allows to use some bridge port as
bridge itself with already configured routing table.

More details with example you may found in patches.

Please review. Any (including _complains_) comments are
highly appreciated!

The series is on top of current -net-next-2.6

	| commit ed9b58bc443a1210b5be1ded6421b17e015bf985
	| Author Richard Genoud <richard.genoud@gmail.com>
	| Date Sat May 9 06:59:16 2009 +0000

Cyrill
