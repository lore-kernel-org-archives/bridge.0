From: Arnaud Fontaine <arnau@milkypond.org>
Date: Thu, 30 Jun 2011 15:05:36 +0200
Message-ID: <878vsjqxjz.fsf@duckcorp.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bridge] Bridge interface always down since Linux >= 2.6.39
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hello,

After upgrading my  kernel to 2.6.39 (I also  tested with 3.0.0-rc4), my
bridge interface  with only TAP interfaces  is always down  (the flag is
NO_CARRIER and  operational state is  DOWN) despite it was  working well
with  previous  versions of  the  kernel  (the  state was  LOWER_UP  and
operational state  was UNKNOWN). Before, running  the following commands
was enough to activate the bridge interface:

  1. brctl addbr br0
  2. ip link set br0 up

Only by attaching a real network interface (such as eth0) to the bridge,
it finally works well  but I would like to be able  to not only use real
network interfaces.

Any idea? Many thanks in advance.

Regards,
-- 
Arnaud Fontaine
