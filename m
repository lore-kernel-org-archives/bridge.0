Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 300FF60AF2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C23D1605B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XwmRTbb7Z1iwYqyAXL7gKB2BP7kYpxso4h/Svsr1CMI=;
 b=csA4tV2W4ZPfUGsLZe9XIg6GPvBX0o6HttxaPDBrirhtOECbekGMAlDBM9lzWqmKwc
 VvLUe4zPT5C27KQ5VReqNEn/JzcranIVRM2aqTI5a0qoBhn1lBsCvpVl6dngfsH21ug1
 /j3HZXqMMiRSLTjWU7CLja/lLWLp0YhnCddQN2LR88Gk/kqI0YxcC9SWNXE9C8wIrvOn
 dNJnFVt9Rv5S4ldgQFqBMQFkfQxXX6nGQXugGQTNJMyqZbSI4+lMgDobYZuJ8zbTf2yM
 8N2r79YY8ICkwGzHJ9ZaHoC3JkkCBZ7pT/Zz2aWFe1ojKQ2NWuXvq40+gLFhbAg+sfiJ
 PztQ==
Message-ID: <9c0eb6c4-a52c-f2a9-b9be-c4b9805ac44f@blackwall.org>
Date: Tue, 25 Oct 2022 14:00:34 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <20221025100024.1287157-1-idosch@nvidia.com>
 <20221025100024.1287157-2-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20221025100024.1287157-2-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [RFC PATCH net-next 01/16] bridge: Add MAC
 Authentication Bypass (MAB) support
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: petrm@nvidia.com, ivecera@redhat.com, netdev@kapio-technology.com, roopa@nvidia.com, vladimir.oltean@nxp.com, edumazet@google.com, mlxsw@nvidia.com, jiri@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

On 25/10/2022 13:00, Ido Schimmel wrote:
> From: "Hans J. Schultz" <netdev@kapio-technology.com>
> 
> Hosts that support 802.1X authentication are able to authenticate
> themselves by exchanging EAPOL frames with an authenticator (Ethernet
> bridge, in this case) and an authentication server. Access to the
> network is only granted by the authenticator to successfully
> authenticated hosts.
> 
> The above is implemented in the bridge using the "locked" bridge port
> option. When enabled, link-local frames (e.g., EAPOL) can be locally
> received by the bridge, but all other frames are dropped unless the host
> is authenticated. That is, unless the user space control plane installed
> an FDB entry according to which the source address of the frame is
> located behind the locked ingress port. The entry can be dynamic, in
> which case learning needs to be enabled so that the entry will be
> refreshed by incoming traffic.
> 
> There are deployments in which not all the devices connected to the
> authenticator (the bridge) support 802.1X. Such devices can include
> printers and cameras. One option to support such deployments is to
> unlock the bridge ports connecting these devices, but a slightly more
> secure option is to use MAB. When MAB is enabled, the MAC address of the
> connected device is used as the user name and password for the
> authentication.
> 
> For MAB to work, the user space control plane needs to be notified about
> MAC addresses that are trying to gain access so that they will be
> compared against an allow list. This can be implemented via the regular
> learning process with the following differences:
> 
> 1. Learned FDB entries are installed with a new "locked" flag indicating
>    that the entry cannot be used to authenticate the device. The flag
>    cannot be set by user space, but user space can clear the flag by
>    replacing the entry, thereby authenticating the device.
> 
> 2. FDB entries cannot roam to locked ports to prevent unauthenticated
>    devices from disrupting traffic destined to already authenticated
>    devices.
> 
> Enable this behavior using a new bridge port option called "mab". It can
> only be enabled on a bridge port that is both locked and has learning
> enabled. A new option is added because there are pure 802.1X deployments
> that are not interested in notifications about "locked" FDB entries.
> 
> Signed-off-by: Hans J. Schultz <netdev@kapio-technology.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
> 
> Notes:
>     Changes made by me:
>     
>      * Reword commit message.
>      * Reword comment regarding 'NTF_EXT_LOCKED'.
>      * Use extack in br_fdb_add().
>      * Forbid MAB when learning is disabled.
> 
>  include/linux/if_bridge.h      |  1 +
>  include/uapi/linux/if_link.h   |  1 +
>  include/uapi/linux/neighbour.h |  8 +++++++-
>  net/bridge/br_fdb.c            | 24 ++++++++++++++++++++++++
>  net/bridge/br_input.c          | 15 +++++++++++++--
>  net/bridge/br_netlink.c        | 13 ++++++++++++-
>  net/bridge/br_private.h        |  3 ++-
>  net/core/rtnetlink.c           |  5 +++++
>  8 files changed, 65 insertions(+), 5 deletions(-)
> 

Thanks for finalizing this, the patch looks good to me.
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

Thanks,
 Nik
