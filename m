Return-Path: <vigneshr@ti.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1613474577;
 bh=tQ1UDP5cdCJOnIdIDk0m4x6l7OoqNMl/eT40Lh0UPR0=;
 h=From:Subject:To:CC:References:Date:In-Reply-To;
 b=TcTmnU3UwG3wfWNIH9hQ3dCW3wwMUOxH1in80hi5Bck485afl/lScXQdPnAnCSRGB
 d8uFIqiKwV6ojpH0TeoQscv89GTYCFGCqyahiOVm7ddLJYEugZzSA5qZNtpIEyh9Jq
 EkJ72X2hu7tc8hKjQCnUA6FS5rQZyCBNu212IhJc=
From: Vignesh Raghavendra <vigneshr@ti.com>
References: <20210212010531.2722925-1-olteanv@gmail.com>
 <97ae293a-f59d-cc7c-21a6-f83880c69c71@ti.com>
 <ba7350f1-f9ff-b77e-65c9-cd5a4ae652d8@ti.com>
 <20210212144053.2pumwc6mlt4l2gcj@skbuf>
Message-ID: <adcbe8ce-60b3-551a-941b-f8de52a134d7@ti.com>
Date: Tue, 16 Feb 2021 16:52:50 +0530
MIME-Version: 1.0
In-Reply-To: <20210212144053.2pumwc6mlt4l2gcj@skbuf>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v4 net-next 0/9] Cleanup in brport flags
 switchdev offload for DSA
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Vadym Kochan <vkochan@marvell.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, Ioana Ciornei <ioana.ciornei@nxp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Vivien Didelot <vivien.didelot@gmail.com>, Taras Chornyi <tchornyi@marvell.com>, Ido Schimmel <idosch@idosch.org>, Claudiu Manoil <claudiu.manoil@nxp.com>, "Strashko,
 Grygorii" <grygorii.strashko@ti.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, "UNGLinuxDriver@microchip.com" <UNGLinuxDriver@microchip.com>, "David S. Miller" <davem@davemloft.net>

Hi,

On 2/12/21 8:10 PM, Vladimir Oltean wrote:
> On Fri, Feb 12, 2021 at 08:01:33PM +0530, Vignesh Raghavendra wrote:
>> Hi Vladimir,
>>
>> On 2/12/21 7:47 PM, Grygorii Strashko wrote:
>>>
>>>
>>> On 12/02/2021 03:05, Vladimir Oltean wrote:
>>>> From: Vladimir Oltean <vladimir.oltean@nxp.com>
>> [...]
>>>
>>> Sorry, but we seems just added more work for you.
>>> https://lore.kernel.org/patchwork/cover/1379380/
>>>
>>
>> Could you squash these when you post new version:
>> Sorry for not noticing earlier.
> 
> Hey, thanks for the fixup patch and congrats on the new driver support
> for the AM65 NUSS! What's functionally different compared to the other
> CPSW instantiations?
> 

CPSW is mostly present on older TI's 32 bit SoCs and can support upto 2
external ports.

AM65 NUSS is next generation multi port switch IP (up to 8 external
ports) present on TI's newer 64 bit platform. It also has different DMA integration and has native HW support to work as both Multi Mac and Switch mode.

> Also, do I get it right that you also tested the bridge port flags
> passed in the new format and that they still work ok? May I add your
> Tested-by tag?
> 

Sorry, I have not done extensive testing but tried couple of cmds. Those worked as expected:

root@evm:~# ip link set eth0 type bridge_slave flood off mcast_flood off learning off                                                  
Error: bridge: bridge flag offload is not supported.

root@evm:~# ip link set eth0 type bridge_slave  mcast_flood off
[ 65.025285] am65-cpsw-nuss 8000000.ethernet eth0: BR_MCAST_FLOOD: 0 port 1

Regards
Vignesh
