Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 697E040C11
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 72EBD40A17
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1697533620; x=1698138420;
 darn=lists.linux-foundation.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bgo6/o6F9GJ+i/Na8KtZEjz2ourig29cQcy60o4Bri8=;
 b=U8ke447iVgWgcQz9kwhomZTMTKixXffFuXOiUcvAIIv6pxWyTa0ydVW9s9AHePSvD3
 zgCt3X5iXkmBL+dwAHx/7OR53oJHdxX8v1slSEF07KYWRUMImyo0s+WXJpurOD51VZ/s
 GwKoi270z0ULy/DYYajtXXQT/N/mPVWCVhvw/jcw/NAdR5/AgYUoHTF6vV0PqukIBocP
 KWNRXR5a5Cz5sQz4vZhD/2n1ihx0COD9rJY3/mc4/vq1meiLb1RqDGkt7f42LVLs+OQ7
 RPE+H5aIzED5DE2XybXJuMf0+rcSskssRdVF2OgBN22dD6G2xP++ln2KMs4T09KpFTVd
 C3Qg==
Message-ID: <7a6e6266-2450-4838-3629-0d3d8d43f11e@blackwall.org>
Date: Tue, 17 Oct 2023 12:06:54 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <20231016131259.3302298-1-idosch@nvidia.com>
 <20231016131259.3302298-7-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231016131259.3302298-7-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 06/13] vxlan: mdb: Factor out a helper
 for remote entry size calculation
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: mlxsw@nvidia.com, edumazet@google.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

On 10/16/23 16:12, Ido Schimmel wrote:
> Currently, netlink notifications are sent for individual remote entries
> and not for the entire MDB entry itself.
> 
> Subsequent patches are going to add MDB get support which will require
> the VXLAN driver to reply with an entire MDB entry.
> 
> Therefore, as a preparation, factor out a helper to calculate the size
> of an individual remote entry. When determining the size of the reply
> this helper will be invoked for each remote entry in the MDB entry.
> 
> No functional changes intended.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>   drivers/net/vxlan/vxlan_mdb.c | 28 +++++++++++++++++++---------
>   1 file changed, 19 insertions(+), 9 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


