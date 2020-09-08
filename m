Return-Path: <Allan.Nielsen@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1599564918; x=1631100918;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=F+j0JCQ1GOVdffMe15XLwWeslfZg0hQxxi1+nRfhBWA=;
 b=b/9r8RliauG8ySi18QSglOorfIKFf4nyk3gCRwptURrH5rNKxpjx5RAC
 iDNVjw+XRIpsRSaA/+XeWLQXNfbMnf/oi4w6EoMtsRlN8xB9eVq2Xs8J9
 de8eWv+iLmnykEW5+ZtL9vqbjSvD88b4BEmTTa0iQ/qbAbsWQ62NeIf9T
 Y+TAB39s7w05qRZ79m8EbqWTePVHBcYTYy+iLrGbzz5SFifKyxYt+G7Rz
 /jcYzTxiT5qf097tIrxaJPdAd5C+aK1786duIuliPt5S0w+i/tnvIlWkv
 PQdEPwMLNUwULR+vHNpNpIViJyuaede1YZ2QnXIMw7mXCXNyGf810t5sn Q==;
Date: Tue, 8 Sep 2020 13:35:09 +0200
From: "Allan W. Nielsen" <allan.nielsen@microchip.com>
Message-ID: <20200908113509.hvuknvmr54no2cy4@lx-anielsen.microsemi.net>
References: <20200904091527.669109-1-henrik.bjoernlund@microchip.com>
 <20200904154406.4fe55b9d@hermes.lan>
 <20200906182129.274fimjyo7l52puj@soft-dev3.localdomain>
 <b36a32dbf3b4b315fc4cbfdf06084b75a7c58729.camel@nvidia.com>
 <BY5PR11MB3928DF9AC75B8AEC2FBD2256ED290@BY5PR11MB3928.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Disposition: inline
In-Reply-To: <BY5PR11MB3928DF9AC75B8AEC2FBD2256ED290@BY5PR11MB3928.namprd11.prod.outlook.com>
Subject: Re: [Bridge] [PATCH RFC 0/7] net: bridge: cfm: Add support for
 Connectivity Fault Management(CFM)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Henrik Bjoernlund - M31679 <Henrik.Bjoernlund@microchip.com>
Cc: "idosch@mellanox.com" <idosch@mellanox.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Horatiu Vultur - M31836 <Horatiu.Vultur@microchip.com>, "jiri@mellanox.com" <jiri@mellanox.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, "kuba@kernel.org" <kuba@kernel.org>, UNGLinuxDriver <UNGLinuxDriver@microchip.com>, "davem@davemloft.net" <davem@davemloft.net>

Hi,

On 08.09.2020 11:04, Henrik Bjoernlund - M31679 wrote:
>>On Sun, 2020-09-06 at 20:21 +0200, Horatiu Vultur wrote:
>>> The 09/04/2020 15:44, Stephen Hemminger wrote:
>>> > On Fri, 4 Sep 2020 09:15:20 +0000 Henrik Bjoernlund
>>> > <henrik.bjoernlund@microchip.com> wrote:
>>Hi, I also had the same initial thought - this really doesn't seem to
>>affect the bridge in any way, it's only collecting and transmitting
>>information. I get that you'd like to use the bridge as a passthrough
>>device to switchdev to program your hw, could you share what would be
>>offloaded more specifically ?
>Yes.
>
>The HW will offload the periodic sending of CCM frames, and the
>reception.
>
>If CCM frames are not received as expected, it will raise an interrupt.
>
>This means that all the functionality provided in this series will be
>offloaded to HW.
>
>The offloading is very important on our HW where we have a small CPU,
>serving many ports, with a high frequency of CFM frames.
>
>The HW also support Link-Trace and Loop-back, which we may come back to
>later.
>
>>All you do - snooping and blocking these packets can easily be done
>>from user- space with the help of ebtables, but since we need to have
>>a software implementation/fallback of anything being offloaded via
>>switchdev we might need this after all, I'd just prefer to push as
>>much as possible to user-space.
In addition to Henriks comment, it is worth mentioning that we are
trying to push as much of the functionallity to user-space (learnings
from the MRP discussions).

This is why there are currently no in-kernel users of the CCM-lose
singnal. When a CCM-defect is happening the network typically needs to
be re-configured. This we are trying to keep in user-space.

>>I plan to review the individual patches tomorrow.
Thanks.

/Allan
