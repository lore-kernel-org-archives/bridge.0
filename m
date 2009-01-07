Message-ID: <49640E77.2090108@candelatech.com>
Date: Tue, 06 Jan 2009 18:07:51 -0800
From: Ben Greear <greearb@candelatech.com>
MIME-Version: 1.0
References: <0598BD8415F140D9BE986E3AB9FFF35F@lzheng>	<49639295.9060309@candelatech.com>
	<83475D0A79834C4C964DFE7F73FABFFD@lzheng>
In-Reply-To: <83475D0A79834C4C964DFE7F73FABFFD@lzheng>
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
> >> vconfig set_name_type DEV_PLUS_VID_NO_PAD
>  
> I made a mistake here. As we want single
> management interface per VLAN (single L3
> management address per VLAN, we will run
> single L3 authentication service instance
> -- such as DHCP -- per VLAN), we tried
> VLAN_PLUS_VID_NO_PAD.

Maybe leave the naming as DEV_PLUS_VID and then add all of those VLAN 
interfaces
to a bridge and put your mgt IP on that bridge?

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com> 
Candela Technologies Inc  http://www.candelatech.com


