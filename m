Date: Wed, 5 May 2010 10:06:04 +0200
From: Lars =?UTF-8?B?VMOkdWJlcg==?= <taeuber@bbaw.de>
Message-Id: <20100505100604.7cd09d04.taeuber@bbaw.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] which interface for IP address?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hi there,

why do all the howtos set the ip address to the brigde? Isn't it also possible to assign the address the real interface?
What's the difference between assigning the address to the bridge and assigning the address to the real interface contained by the bridge?

The situation:

virtual machine host:
eth0
vif0 (for virtual machine)
...
vifx (for virtual machine)
br0  (contains eth0 and vif*)

Whats the difference between

eth0 192.168.1.4
br0  0.0.0.0

and

eth0 0.0.0.0
br0  192.168.1.4

??

Thanks
Lars
