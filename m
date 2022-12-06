Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 69BEF40A03
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 626F8409FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UBQgxqUKfCeoRJwO5X9i5iROVCc9Ze5aifdNi+9+nK0=;
 b=60obe3wn8ih/Uj7kSxFY+m0RxFLo54cM0gyi0FOiEqw6dLyhg7SWhHKqDwdEJUrzM5
 bvvAb6OHLMnC/AstRbPOunffIBj8LP2a893XiHPvfjbA10N7ZEtqOnA5V9LUgs/BGJh1
 OEznEGwlxacgR65Ra+Z9FSHYiqR+RCqg6/4MaqXX4ajJF9M/vWmEFIINVwMo8mnmxf1W
 XsUNC+1TRXUttrczNQU8MWWv8oYBcNd6I3WaKbksiPdOYss5dzkPzXqQL1DbTdFAu6+E
 HZeANEspCm7/hgKmPS7K/9ciaI0MFs8rILewgp81yhOFmVypnliE3AvIPVRvFmuYLHqd
 FR7A==
Message-ID: <35aefd47-937d-c4c9-8cab-697ea07d098f@blackwall.org>
Date: Tue, 6 Dec 2022 14:32:01 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20221206105809.363767-1-idosch@nvidia.com>
 <20221206105809.363767-2-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20221206105809.363767-2-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v2 1/9] bridge: mcast: Centralize
 netlink attribute parsing
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

On 06/12/2022 12:58, Ido Schimmel wrote:
> Netlink attributes are currently passed deep in the MDB creation call
> chain, making it difficult to add new attributes. In addition, some
> validity checks are performed under the multicast lock although they can
> be performed before it is ever acquired.
> 
> As a first step towards solving these issues, parse the RTM_{NEW,DEL}MDB
> messages into a configuration structure, relieving other functions from
> the need to handle raw netlink attributes.
> 
> Subsequent patches will convert the MDB code to use this configuration
> structure.
> 
> This is consistent with how other rtnetlink objects are handled, such as
> routes and nexthops.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
> 
> Notes:
>     v2:
>     * Remove 'skb' argument from br_mdb_config_init()
>     * Mark 'nlh' argument as 'const'.
> 

Thanks,
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


