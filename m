Return-Path: <netdev@kapio-technology.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1F48240591
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2A7374033D
MIME-Version: 1.0
Date: Sun, 06 Nov 2022 13:04:36 +0100
From: netdev@kapio-technology.com
In-Reply-To: <20221025100024.1287157-1-idosch@nvidia.com>
References: <20221025100024.1287157-1-idosch@nvidia.com>
Message-ID: <e6c4c3755e4aba80b3c7ebf31c8cdb58@kapio-technology.com>
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [RFC PATCH net-next 00/16] bridge: Add MAC
 Authentication Bypass (MAB) support with offload
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@nvidia.com>
Cc: petrm@nvidia.com, ivecera@redhat.com, netdev@vger.kernel.org, razor@blackwall.org, bridge@lists.linux-foundation.org, roopa@nvidia.com, vladimir.oltean@nxp.com, edumazet@google.com, mlxsw@nvidia.com, jiri@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

On 2022-10-25 12:00, Ido Schimmel wrote:
> Merge plan
> ==========
> 
> We need to agree on a merge plan that allows us to start submitting
> patches for inclusion and finally conclude this work. In my experience,
> it is best to work in small batches. I therefore propose the following
> plan:
> 
> * Add MAB support in the bridge driver. This corresponds to patches
>   #1-#2.
> 
> * Switchdev extensions for MAB offload together with mlxsw
>   support. This corresponds to patches #3-#16. I can reduce the number
>   of patches by splitting out the selftests to a separate submission.
> 
> * mv88e6xxx support. I believe the blackhole stuff is an optimization,
>   so I suggest getting initial MAB offload support without that. 
> Support
>   for blackhole entries together with offload can be added in a 
> separate
>   submission.

As I understand for the mv88e6xxx support, we will be sending 
SWITCHDEV_FDB_ADD_TO_BRIDGE
events from the driver to the bridge without installing entries in the 
driver.
Just to note, that will of course imply that the bridge FDB will be out 
of sync with the
FDB in the driver (ATU).

> 
> * Switchdev extensions for dynamic FDB entries together with mv88e6xxx
>   support. I can follow up with mlxsw support afterwards.
> 
> [1] 
> https://lore.kernel.org/netdev/20221018165619.134535-1-netdev@kapio-technology.com/
> [2] 
> https://lore.kernel.org/netdev/20221004152036.7848-1-netdev@kapio-technology.com/
> [3] 
> https://github.com/westermo/hostapd/blob/bridge_driver/hostapd/hostapd_auth_deauth.sh#L11
> [4] 
> https://lore.kernel.org/netdev/a11af0d07a79adbd2ac3d242b36dec7e@kapio-technology.com/
