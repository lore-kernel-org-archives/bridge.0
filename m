Return-Path: <igor.mitsyanko.os@quantenna.com>
References: <20180310030308.12947-1-igor.mitsyanko.os@quantenna.com>
	<20180310220850.GI29174@lunn.ch>
From: Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>
Message-ID: <25985724-1f25-1c8b-46f0-19a88445f81e@quantenna.com>
Date: Mon, 12 Mar 2018 16:08:27 -0700
MIME-Version: 1.0
In-Reply-To: <20180310220850.GI29174@lunn.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 0/5] Switchdev: flooding offload option
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Andrew Lunn <andrew@lunn.ch>
Cc: ivecera@redhat.com, jiri@resnulli.us, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, sergey.matyukevich.os@quantenna.com, ashevchenko@quantenna.com, smaksimenko@quantenna.com, dlebed@quantenna.com

On 03/10/2018 02:08 PM, Andrew Lunn wrote:
> 
> Hi Igor
> 
> You don't appear to be adding any user of this. Please also make one
> of the switchdev drivers actually use this new functionality.
> 
>     Andrew
> 

Hi Andrew, a first user is supposed to be 
drivers/net/wireless/quantenna/qtnfmac wifi driver. I will merge the 
patchset with another one that modifies qtnfmac driver (so that it has 
at least one user) and resend.

However RFC portion is still under discussion, would be good to 
understand if this approach is at all acceptable.
