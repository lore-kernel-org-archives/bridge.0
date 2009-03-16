Message-ID: <49BE6B66.2070103@reachone.com>
Date: Mon, 16 Mar 2009 08:08:22 -0700
From: Christopher Hunt <chunt@reachone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] STP FD when STP is disabled
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Bridge@lists.linux-foundation.org

It appears that interfaces participate in STP's forwarding delay even when STP is disabled for a given bridge. I can remedy by setting the FD to 0 for each new bridge, but I'm wondering if this is by design or oversight. 

[root@ ~]# brctl show
bridge name     bridge id               STP enabled     interfaces

br0.690         8000.00065b8bce3e       no              eth1.690
                                                        eth0.690

[root@ ~]# brctl showstp br0.690
br0.690
 bridge id              8000.00065b8bce3e
 designated root        8000.00065b8bce3e
 root port                 0                    path cost                  0
 max age                  19.99                 bridge max age            19.99
 hello time                1.99                 bridge hello time          1.99
 forward delay            14.99                 bridge forward delay      14.99
 ageing time             299.95
 hello timer               1.09                 tcn timer                  0.00
 topology change timer     0.00                 gc timer                   0.00
 flags


eth1.690 (2)
 port id                8002                    state                forwarding
 designated root        8000.00065b8bce3e       path cost                100
 designated bridge      8000.00065b8bce3e       message age timer          0.00
 designated port        8002                    forward delay timer        0.00
 designated cost           0                    hold timer                 0.09
 flags

eth0.690 (1)
 port id                8001                    state                forwarding
 designated root        8000.00065b8bce3e       path cost                 19
 designated bridge      8000.00065b8bce3e       message age timer          0.00
 designated port        8001                    forward delay timer        0.00
 designated cost           0                    hold timer                 0.09
 flags

!! when i restart networking:
[root@vlan-fw-02 ~]# tail /var/log/messages -n50 | grep 690
Mar 16 08:01:33 vlan-fw-02 kernel: br0.690: port 2(eth1.690) entering disabled state
Mar 16 08:01:33 vlan-fw-02 kernel: br0.690: port 1(eth0.690) entering disabled state
Mar 16 08:01:33 vlan-fw-02 kernel: device eth0.690 left promiscuous mode
Mar 16 08:01:33 vlan-fw-02 kernel: br0.690: port 1(eth0.690) entering disabled state
Mar 16 08:01:34 vlan-fw-02 kernel: device eth1.690 left promiscuous mode
Mar 16 08:01:34 vlan-fw-02 kernel: br0.690: port 2(eth1.690) entering disabled state
Mar 16 08:01:35 vlan-fw-02 kernel: eth0.690: dev_set_promiscuity(master, -1)
Mar 16 08:01:36 vlan-fw-02 kernel: eth1.690: dev_set_promiscuity(master, -1)
Mar 16 08:01:36 vlan-fw-02 kernel: eth0.690: dev_set_promiscuity(master, 1)
Mar 16 08:01:36 vlan-fw-02 kernel: device eth0.690 entered promiscuous mode
Mar 16 08:01:36 vlan-fw-02 kernel: eth1.690: dev_set_promiscuity(master, 1)
Mar 16 08:01:36 vlan-fw-02 kernel: device eth1.690 entered promiscuous mode
Mar 16 08:01:37 vlan-fw-02 kernel: br0.690: port 2(eth1.690) entering learning state
Mar 16 08:01:37 vlan-fw-02 kernel: br0.690: port 1(eth0.690) entering learning state
Mar 16 08:01:52 vlan-fw-02 kernel: br0.690: topology change detected, propagating
Mar 16 08:01:52 vlan-fw-02 kernel: br0.690: port 2(eth1.690) entering forwarding state
Mar 16 08:01:52 vlan-fw-02 kernel: br0.690: topology change detected, propagating
Mar 16 08:01:52 vlan-fw-02 kernel: br0.690: port 1(eth0.690) entering forwarding state
