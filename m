Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5DDD960B23
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A6C0960D95
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20221208.gappssmtp.com; s=20221208; t=1685371729; x=1687963729;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JKlNcGPxl9mlN8rwjzjxvcvFuvq/iuxFaFEW8rQumgw=;
 b=2+ehGTQDV5i5XJKBMKEJVAhpQenFILVf+B4gsexsUA5Um9FxW43qvQqvOrdqirhTEh
 ahCo3yiNK4qUcuNG84897QIHQEkj3azmE9Jt2axQJTuFpucPSFSppGjhSv2FApgi8B4G
 wzDVZs3vr4mRQTvehmPNDW26wmFKvq90rAEfWzFBkVFBSRcm8c+m+18OvDfUZmcIlO7J
 MM+CpI6DKSzIR8+Tgl9BT3UooNwsRct8Kn5tsgmmMdd55oYm3LIYDyKCgI8cQ9Fdadjk
 hU9HZz0lxCjl/ARgVd7UfC8N6Z+Z+f5N3XapYLTuzBHPbbiFh3akqI1glxSm0oMA6KjX
 UENw==
Message-ID: <098121b7-7118-5605-e701-0c47c759ee6c@blackwall.org>
Date: Mon, 29 May 2023 17:48:46 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <20230529114835.372140-1-idosch@nvidia.com>
 <20230529114835.372140-9-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20230529114835.372140-9-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v2 8/8] selftests: forwarding: Add
 layer 2 miss test cases
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: taras.chornyi@plvision.eu, petrm@nvidia.com, alexandre.belloni@bootlin.com, jiri@resnulli.us, leon@kernel.org, vladimir.oltean@nxp.com, roopa@nvidia.com, claudiu.manoil@nxp.com, UNGLinuxDriver@microchip.com, edumazet@google.com, jhs@mojatatu.com, xiyou.wangcong@gmail.com, simon.horman@corigine.com, kuba@kernel.org, pabeni@redhat.com, saeedm@nvidia.com, davem@davemloft.net

On 29/05/2023 14:48, Ido Schimmel wrote:
> Add test cases to verify that the bridge driver correctly marks layer 2
> misses only when it should and that the flower classifier can match on
> this metadata.
> 
> Example output:
> 
>  # ./tc_flower_l2_miss.sh
>  TEST: L2 miss - Unicast                                             [ OK ]
>  TEST: L2 miss - Multicast (IPv4)                                    [ OK ]
>  TEST: L2 miss - Multicast (IPv6)                                    [ OK ]
>  TEST: L2 miss - Link-local multicast (IPv4)                         [ OK ]
>  TEST: L2 miss - Link-local multicast (IPv6)                         [ OK ]
>  TEST: L2 miss - Broadcast                                           [ OK ]
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
> 
> Notes:
>     v2:
>     * Test that broadcast does not hit miss filter.
> 
>  .../testing/selftests/net/forwarding/Makefile |   1 +
>  .../net/forwarding/tc_flower_l2_miss.sh       | 350 ++++++++++++++++++
>  2 files changed, 351 insertions(+)
>  create mode 100755 tools/testing/selftests/net/forwarding/tc_flower_l2_miss.sh

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


