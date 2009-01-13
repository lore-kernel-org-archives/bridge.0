References: <0598BD8415F140D9BE986E3AB9FFF35F@lzheng>
	<49639295.9060309@candelatech.com>
	<83475D0A79834C4C964DFE7F73FABFFD@lzheng>
	<49640E77.2090108@candelatech.com>
	<66223B09B0EC4F6EA1D9B74E39C0E215@lzheng>
	<20090108075852.GU10913@via.ecp.fr>
	<2E0FC4E549A74D6A836D12FCC08A3E59@lzheng>
	<20090108124525.GV10913@via.ecp.fr>
	<5B94B429B59C4ACC8A376D25A268AD95@lzheng>
From: Benny Amorsen <benny+usenet@amorsen.dk>
Date: Tue, 13 Jan 2009 15:32:53 +0100
In-Reply-To: <5B94B429B59C4ACC8A376D25A268AD95@lzheng> (Lv Zheng's message of
	"Mon\, 12 Jan 2009 12\:41\:45 +0800")
Message-ID: <m363kjtgx6.fsf@ursa.amorsen.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Re: [Bridge] vlan and bond integration in bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Lv Zheng <lv.zheng@soliton.com.cn>
Cc: Bridge Linux <bridge@lists.linux-foundation.org>

"Lv Zheng" <lv.zheng@soliton.com.cn> writes:

> Switch port do support 802.1Q parameters will
> 1. drop untagged frames if it is configured to admit
>   only VLAN tagged frames and drop frames not
>   admitted
> 2. drop any tagged frames whose tag is not in the
>   VID set if it is configured to admit only VLAN
>   tagged frames and drop frames not admitted
> 3. handle any untagged frames as PVID tagged frames
>   if it is configured to admit untagged and
>   priority-tagged frames and handle such frames as
>   if they are coming from the default vlan
> 4. handle any tagged frames whose tag is not in the
>   VID set as PVID tagged frames if it is configured
>   to admit untagged and priority-tagged frames and
>   handle such frames as if they are coming from the
>   default vlan
>
> While Linux does not support such features.

I would prefer if Linux continued to not support those features. As it
is, you can get the untagged frames at eth0, the 100 tagged ones as
eth0.100, the 100+101 tagges ones as eth0.100.101 and so on. Linux
doesn't suffer from global VLAN significance and other switch
silliness, and I really hope it stays that way.

The only challenge is spanning tree, because Cisco figured out too
late that spanning tree packets should be per-VLAN. The sane solution
is to simply tag BPDU packets like all other packets. Linux does that,
but the rest of the world is stuck with MST or PVST.


/Benny

