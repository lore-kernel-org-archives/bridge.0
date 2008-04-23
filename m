From: Koen Vermeer <koen@vermeer.tv>
Content-Type: text/plain
Date: Wed, 23 Apr 2008 21:08:25 +0200
Message-Id: <1208977705.3575.5.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Set second IP on bridge
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

I am connected through one ethernet interface to a network on which two
subnets are available. One is in the 192.168.11.0 range, the other in
the 172.31.1.0 range. On the first one, I have a static IP, on the
second on, I obtain one by DHCP. Without bridging, I can set this up by
using eth0 and eth0:1.

Now, for virtualization, I want to set up a bridge on my one ethernet
interface. I can do this just fine, and end up with (let's say) br0.
Then, I can set an IP address to br0. But what I want to do is set two
IP addresses. I have been unable to do so thus far. Trying to use br0:1
didn't produce anything useful.

So, before trying further with br0:1 or something similar, I was
wondering whether what I like to do is actually possible. If it is, am I
on the right track? If it isn't, is there some other way to work around
this?

Best,
Koen

