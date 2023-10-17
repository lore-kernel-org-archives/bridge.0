Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6F4B760F40
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6379860A5E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1697534906; x=1698139706;
 darn=lists.linux-foundation.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fmR/OA6GHqXdwt3EU1KKP2U+4kY4IagR5FLSW/2Uexs=;
 b=TJ0B+gg86e6yCm9RS3xU4MfqIfd++xGFfaBZ22cwGEb9l6DQ2WGUphoH/HNGmtu98T
 7EiBFj0SouUiIyDYwCumxsB445l8Vvc/oZJauGxTiVBrYbaI+ar2vO85ZWfow+wqNh6Z
 yDUTOqFrRjn9uXlGBnF34nJ5a6Lmf2qAMWL71oAho6QD6heLfiVMrfk/WRQblgtooFeh
 DUze6KAqrBRGRinCDHlyV/090Fpn3XWvtK0V+TtmPxGMtKAOgNfPp54y8T7yseKL2uX5
 0hmUvYi7dxSBX11xNN9+kEyPnNd8uCAieV27eIp7Clw0y4XMyBpxzIvPWLv4/yF02Ru6
 ZZgg==
Message-ID: <8e25bfdc-de42-1f50-8e78-edff3d69dc49@blackwall.org>
Date: Tue, 17 Oct 2023 12:28:24 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <20231016131259.3302298-1-idosch@nvidia.com>
 <20231016131259.3302298-11-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231016131259.3302298-11-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 10/13] vxlan: mdb: Add MDB get support
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
> Implement support for MDB get operation by looking up a matching MDB
> entry, allocating the skb according to the entry's size and then filling
> in the response.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>   drivers/net/vxlan/vxlan_core.c    |   1 +
>   drivers/net/vxlan/vxlan_mdb.c     | 150 ++++++++++++++++++++++++++++++
>   drivers/net/vxlan/vxlan_private.h |   2 +
>   3 files changed, 153 insertions(+)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


