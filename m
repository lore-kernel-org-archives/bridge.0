Message-ID: <66223B09B0EC4F6EA1D9B74E39C0E215@lzheng>
From: "Lv Zheng" <lv.zheng@soliton.com.cn>
References: <0598BD8415F140D9BE986E3AB9FFF35F@lzheng>	<49639295.9060309@candelatech.com>
	<83475D0A79834C4C964DFE7F73FABFFD@lzheng>
	<49640E77.2090108@candelatech.com>
In-Reply-To: <49640E77.2090108@candelatech.com>
Date: Thu, 8 Jan 2009 09:47:58 +0800
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=response
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] vlan and bond integration in bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ben Greear <greearb@candelatech.com>
Cc: Bridge Linux <bridge@lists.linux-foundation.org>

> Maybe leave the naming as DEV_PLUS_VID and then add all of those VLAN 
> interfaces
> to a bridge and put your mgt IP on that bridge?

Do you mean:

+---------------------------+-----------------+
|          br0              |      br1        |
+------------------+--------------------------+
| bond0.1          | eth2.1 | eth3.2 | eth4.2 |
+------------------+--------+--------+--------+
| bond0            | eth2   | eth3   | eth4   |
+---------+--------+        |        |        |
| eth0    | eth1   |        |        |        |
+---------+--------+--------+--------+--------+

It looks good for port based VLAN. Thanks.

For tag based VLAN, the topology will looks like:

+---------------------------+--------------------------+
|          br0              |          br1             |
+------------------+--------+--------+-----------------+
| bond0.1          | eth2.1 | eth2.2 | eth3.2 | eth4.2 |
+------------------+--------+--------+--------+--------+
| bond0            | eth2            | eth3   | eth4   |
+---------+--------+                 |        |        |
| eth0    | eth1   |                 |        |        |
+---------+--------+-----------------+--------+--------+

port eth2 will get tow STP instances running on top of it,
this might confuse it's MAC partner if MSTP is not supported.
How could Linux solve this?

Best regards/Lv Zheng
