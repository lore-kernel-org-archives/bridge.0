Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B213641F30
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EAD9341F2F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1698301398; x=1698906198;
 darn=lists.linux-foundation.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9KQrkDY9cLbzOIPZ1XItMMko64XHXu+1s55t9JoUn1k=;
 b=q1aUtHCPePfr+DdQPc/ErYdQGX1Sak8YNCObVBLIzDzrEWOE0rcHV2GhpkQi2wNXcV
 o/lPvTVs/bA0/sj6W3kXB3iRLMiF9HMgRypnliBm4Wzc4zVG6AL4mnU95URWhyuOTmAn
 A3/D2F1dzySPxEbFtaGybjqJ7lAonDtU35UFOibnWj0XDHD0fY8qXe0HoJV7ij6TKjTf
 7J/J/a1kY3oaJ3blKxTQlsIASwfBkjoQ7P1XCUJnSV/f9zrb95ACVSzUgitqEQqoTiDs
 q+XfVS2Cyvfmruf/RxAYXsBfzC/tGEOP2zNhOLrBGwF1KRIo+nXe5JDO7/oAwNcLiR1O
 0NJQ==
Message-ID: <dbd33fe5-7b27-5454-6808-c975638c8321@blackwall.org>
Date: Thu, 26 Oct 2023 09:23:16 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <20231025123020.788710-1-idosch@nvidia.com>
 <20231025123020.788710-10-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231025123020.788710-10-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v2 09/13] bridge: mcast: Add MDB get
	support
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

On 10/25/23 15:30, Ido Schimmel wrote:
> Implement support for MDB get operation by looking up a matching MDB
> entry, allocating the skb according to the entry's size and then filling
> in the response. The operation is performed under the bridge multicast
> lock to ensure that the entry does not change between the time the reply
> size is determined and when the reply is filled in.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
> 
> Notes:
>      v2:
>      * Add a comment above spin_lock_bh().
> 
>   net/bridge/br_device.c  |   1 +
>   net/bridge/br_mdb.c     | 158 ++++++++++++++++++++++++++++++++++++++++
>   net/bridge/br_private.h |   9 +++
>   3 files changed, 168 insertions(+)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


