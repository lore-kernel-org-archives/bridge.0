Message-ID: <49A8D505.3090103@candelatech.com>
Date: Fri, 27 Feb 2009 22:09:09 -0800
From: Ben Greear <greearb@candelatech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] core dump in latest brctl
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Here's a simple way to crash brctl (Fedora 8's brctl and tonight's git 
tree):

[root@grok2 brctl]# ./brctl addbr bridge
[root@grok2 brctl]# ./brctl show
bridge name     bridge id               STP enabled     interfaces
.               Segmentation fault (core dumped)

Take it easy,
Ben

-- 
Ben Greear <greearb@candelatech.com> 
Candela Technologies Inc  http://www.candelatech.com


