Message-ID: <49639295.9060309@candelatech.com>
Date: Tue, 06 Jan 2009 09:19:17 -0800
From: Ben Greear <greearb@candelatech.com>
MIME-Version: 1.0
References: <0598BD8415F140D9BE986E3AB9FFF35F@lzheng>
In-Reply-To: <0598BD8415F140D9BE986E3AB9FFF35F@lzheng>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: Lv Zheng <lv.zheng@soliton.com.cn>
Cc: Bridge Linux <bridge@lists.linux-foundation.org>

Lv Zheng wrote:

> Since VLAN device in Linux cannot support VID duplication
> across multiple lowers, that is, following commands will fail:
> 
> vconfig set_name_type DEV_PLUS_VID_NO_PAD
> vconfig add eth0 1
> vconfig add eth1 1 <--- failure

This should work fine..what are the errors?

Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

