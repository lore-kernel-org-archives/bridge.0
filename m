Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 387BD60FEF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8880B60FEB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0r0CEcLzdsN43NZU3heQZC4qAAFpuw6sOVS1maYA6DQ=;
 b=kg/V4I4ASB09J7gYLUa/gilZUDLGVdLNMAycukH5jFUSl0VvTO+ZzwHyE6/Goz4/cs
 QK4W0TXDkNQwIBj/yB2sBe/zLQdNagY0v/PLCjvQxu1e5jwdp8Q6Jni0TFQxk5KhBGt2
 AQUyiGnzfE5suUPbgUJmYzsFbPpfR8eTP1IWzxu/zEmvCAT5UqQVQhvFsee6QWxcn8N0
 NRWp/Va/RKQUt4JickpDloreBm8vwNDzXlYb7c5REu62D/UzzA/7nnPYRqv+EBlC7gb8
 5+5SYr21pI66uIm++99fDREbhlj+o1OHi+4hFXPYKboAM+fFkBvt7sdFd6+jslS2WfEq
 uzAw==
Message-ID: <b22a460d-88bb-f159-c75a-acd635430167@blackwall.org>
Date: Tue, 18 Oct 2022 11:37:16 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <20221018064001.518841-1-idosch@nvidia.com>
 <20221018064001.518841-3-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20221018064001.518841-3-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 2/4] selftests: bridge_igmp: Remove
 unnecessary address deletion
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

On 18/10/2022 09:39, Ido Schimmel wrote:
> The test group address is added and removed in v2reportleave_test().
> There is no need to delete it again during cleanup as it results in the
> following error message:
> 
>  # bash -x ./bridge_igmp.sh
>  [...]
>  + cleanup
>  + pre_cleanup
>  [...]
>  + ip address del dev swp4 239.10.10.10/32
>  RTNETLINK answers: Cannot assign requested address
>  + h2_destroy
> 
> Solve by removing the unnecessary address deletion.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  tools/testing/selftests/net/forwarding/bridge_igmp.sh | 3 ---
>  1 file changed, 3 deletions(-)

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


