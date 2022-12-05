Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ECD3E80BB3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3BB4680B90
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8/CyNdrc1NG+SiV/WyFqFX763UJgr1kiBYK1y29Dd3Q=;
 b=WovpQAkmjcZCSOQ+lMsEsETG7brsFoL+2ZXQibGwumzD52tGEerBqsmtc1QbxA7Iui
 CeOckv807i5mMP8Jw1Um0uzfeXJxwzBMUFhtgDpkDfvNROwobmscG9jDh88WzhsYo9Pq
 HjM8jF1p8h7gLq2L1Sv0HMvWUl/d8Ary9vu83Fn7pCZ+TpzwRTp7v3XoM7XCJDdtVGRD
 RX4rMM+XxWB9kdsqlEG7XROAHyoXnAn8s+WW6PGZza8LqBFjy7xlosvx9coy8JovqQGf
 l7OSGUUj631c1RX43qlmuvkh8VPxKVn+w1bz5It+tLJumScqW1f7DnPs/uQZuhx5d/Jc
 moZQ==
Message-ID: <3d7da3fd-53ca-c321-0b00-b79948b85993@blackwall.org>
Date: Mon, 5 Dec 2022 13:43:29 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20221205074251.4049275-1-idosch@nvidia.com>
 <20221205074251.4049275-8-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20221205074251.4049275-8-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 7/8] bridge: mcast: Move checks out of
 critical section
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

On 05/12/2022 09:42, Ido Schimmel wrote:
> The checks only require information parsed from the RTM_NEWMDB netlink
> message and do not rely on any state stored in the bridge driver.
> Therefore, there is no need to perform the checks in the critical
> section under the multicast lock.
> 
> Move the checks out of the critical section.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  net/bridge/br_mdb.c | 36 ++++++++++++++++++------------------
>  1 file changed, 18 insertions(+), 18 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


