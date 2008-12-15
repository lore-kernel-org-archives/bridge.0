Message-ID: <fd53068c0812150229p2ac800a6j68d8be91e00d1fe1@mail.gmail.com>
Date: Mon, 15 Dec 2008 12:29:00 +0200
From: "Igor Smolyar" <xrevolver@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [Bridge] BPDU in transparent bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hi,

I have Linux bridge between two switches that run STP.

switch1-----Linux bridge-----switch2.

Linux bridge planned to inspect all traffic, being absolutely
transparent and take no part in STP.
According to my tests with latest 2.6.27.9 and from what I understand
from few threads in this list (correct me if I wrong),
Linux bridge does not forward BPDU, bridge should use them.
I refer to Stephen patch:
http://git.kernel.org/?p=linux/kernel/git/stable/linux-2.6.27.y.git;a=commitdiff;h=43aa1920117801fe9ae3d1fad886b62511e09bee

In case I need completely transparent bridge, what are my options would be?

Thanks ,Igor.
