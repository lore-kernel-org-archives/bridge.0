Message-ID: <2E0FC4E549A74D6A836D12FCC08A3E59@lzheng>
From: "Lv Zheng" <lv.zheng@soliton.com.cn>
References: <0598BD8415F140D9BE986E3AB9FFF35F@lzheng>
	<49639295.9060309@candelatech.com>
	<83475D0A79834C4C964DFE7F73FABFFD@lzheng>
	<49640E77.2090108@candelatech.com>
	<66223B09B0EC4F6EA1D9B74E39C0E215@lzheng>
	<20090108075852.GU10913@via.ecp.fr>
In-Reply-To: <20090108075852.GU10913@via.ecp.fr>
Date: Thu, 8 Jan 2009 18:13:07 +0800
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="utf-8"; reply-type=original
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
To: Boris Dores <babal@via.ecp.fr>
Cc: Bridge Linux <bridge@lists.linux-foundation.org>

> +---------------------------+-----------------+
> |          br0              |      br1        |
> +------------------+--------+--------+--------+
> | bond0            | eth2   | eth3   | eth4   |
> +---------+--------+        |        |        |
> | eth0    | eth1   |        |        |        |
> +---------+--------+--------+--------+--------+
> 
>  without the VLAN layer, otherwise packets will be tagged.

Do you mean BPDU will also be tagged and no longer a BPDU
on the wire?
