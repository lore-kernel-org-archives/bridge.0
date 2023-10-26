Return-Path: <stephen@networkplumber.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 066DB42493
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 25C20415D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1698340891;
 x=1698945691; darn=lists.linux-foundation.org; 
 h=content-transfer-encoding:mime-version:message-id:subject:cc:to
 :from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LiGuJE8jLMnIocTKaNAa+F2ri7OFuPjhrH8s+cGGXVM=;
 b=Cmc5Gz1bSyFmisuia0vNjZoRmUAvpUgmQE1AVmOnm723BsUj4Tz+bHwT2yZbH3Zq4T
 5Elmr8WzykajtmaQB6yYAByKUn4XMek2X+Akz123PNZCLKGO+GtJgQfynxH6lyjB7mVP
 Bnk1w6Gv15R8RVUfpylsNpLOdrdJIvuTpvKUgKN+7KFRJJSMaJP77m8kM4FeHRB7W0GJ
 A2vuSAGeEHicTui6kEyyeCpmgme3K9dxw4q9s2exphjA67lFQWzG+MsE/Rh1DnW/3F0/
 nHgTUREZ4mqTBGxqk0aIrIAd++VKdLoqixVv+OPfJxESzJJ5pfIKDmGg+zGWY+6a52gZ
 l3iA==
Date: Thu, 26 Oct 2023 10:21:29 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20231026102129.2c4e1976@hermes.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Fw: [Bug 218047] New: linux network bridge kernel set
 group_fwd_mask 65535
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: razor@blackwall.org, roopa@nvidia.com
Cc: bridge@lists.linux-foundation.org

The kernel intentionally does not allow forwarding of IEEE pause frames.
These need to be handled dropped in the bridge.
Any mask without bit 1 set should work.

Originally LACP, STP and MACPAUSE frames were always blocked and could not be
changed. The restriction was relaxed for LACP and STP frames.

Begin forwarded message:

Date: Thu, 26 Oct 2023 05:16:24 +0000
From: bugzilla-daemon@kernel.org
To: stephen@networkplumber.org
Subject: [Bug 218047] New: linux network bridge kernel set group_fwd_mask 65535


https://bugzilla.kernel.org/show_bug.cgi?id=218047

            Bug ID: 218047
           Summary: linux network bridge kernel set group_fwd_mask 65535
           Product: Networking
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Other
          Assignee: stephen@networkplumber.org
          Reporter: ne-vlezay80@yandex.ru
        Regression: No

If trying set the parameter from network bridge? going error:

[root@arch user]# ip link set bridge0  type bridge group_fwd_mask 65535
RTNETLINK answers: Invalid argument

setting this parameter is desirable if the switching is routed to a separate
virtual machine on the hypervisor, and on the host it looks like this:

ip link add dev ns-switch.0 up mtu 16384 master bridge0 type veth peer name
host0 address $SWMAC  netns switch mtu 16384
ip link add dev ns-host1.0 up mtu 16384 master bridge0 type veth peer name
host0 netns host1 mtu 16384
ip link add dev ns-host2.0 up mtu 16384 master bridge0 type veth peer name
host0 netns host2 mtu 16384
ip link add dev ns-host3.0 up mtu 16384 master bridge0 type veth peer name
host0 netns host3 mtu 16384
ip link add dev ns-host4.0 up mtu 16384 master bridge0 type veth peer name
host0 netns host4 mtu 16384

tc qdisc add dev ns-switch.0 handle ffff: ingress
tc qdisc add dev ns-host1.0 handle ffff: ingress
tc qdisc add dev ns-host2.0 handle ffff: ingress
tc qdisc add dev ns-host3.0 handle ffff: ingress
tc qdisc add dev ns-host4.0 handle ffff: ingress

tc qdisc add dev gt-ll0 handle ffff: ingress
tc qdisc add dev gt-ll0 handle 1: root htb default 10

tc qdisc add dev ns-switch.0 handle 1: root htb default 10
tc qdisc add dev ns-host1.0 handle 1: root htb default 10
tc qdisc add dev ns-host2.0 handle 1: root htb default 10
tc qdisc add dev ns-host3.0 handle 1: root htb default 10
tc qdisc add dev ns-host4.0 handle 1: root htb default 10


tc filter add dev ns-host1.0 parent ffff: prio 9 protocol all flower dst_mac
01:00:00:00:00:00/8 action vlan push id 10 action mirred egress redirect dev
gt-ll0
tc filter add dev ns-host2.0 parent ffff: prio 9 protocol all flower dst_mac
01:00:00:00:00:00/8 action vlan push id 11 action mirred egress redirect dev
gt-ll0
tc filter add dev ns-host3.0 parent ffff: prio 9 protocol all flower dst_mac
01:00:00:00:00:00/8 action vlan push id 12 action mirred egress redirect dev
gt-ll0
tc filter add dev ns-host4.0 parent ffff: prio 9 protocol all flower dst_mac
01:00:00:00:00:00/8 action vlan push id 13 action mirred egress redirect dev
gt-ll0

tc filter add dev ns-host1.0 parent ffff: prio 10 protocol all matchall action
vlan push id 10 
tc filter add dev ns-host2.0 parent ffff: prio 10 protocol all matchall action
vlan push id 11
tc filter add dev ns-host3.0 parent ffff: prio 10 protocol all matchall action
vlan push id 12
tc filter add dev ns-host4.0 parent ffff: prio 10 protocol all matchall action
vlan push id 13

tc filter add dev ns-host1.0 parent 1: prio 65535 protocol all matchall action
drop
tc filter add dev ns-host1.0 parent 1: prio 1 protocol 802.1Q flower vlan_id 10
action vlan pop

tc filter add dev ns-host2.0 parent 1: prio 65535 protocol all matchall action
drop
tc filter add dev ns-host2.0 parent 1: prio 1 protocol 802.1Q flower vlan_id 11
action vlan pop

tc filter add dev ns-host3.0 parent 1: prio 65535 protocol all matchall action
drop
tc filter add dev ns-host3.0 parent 1: prio 1 protocol 802.1Q flower vlan_id 12
action vlan pop

tc filter add dev ns-host4.0 parent 1: prio 65535 protocol all matchall action
drop
tc filter add dev ns-host4.0 parent 1: prio 1 protocol 802.1Q flower vlan_id 13
action vlan pop 

the config example from be network lab.

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.
