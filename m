Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3E2DC8272D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 75FC382897
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20221208.gappssmtp.com; s=20221208; t=1689240843; x=1691832843;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lMHT6UoXyT7yXa5NMQkYocKiTnpdFIDZ2yGmogMbjUw=;
 b=wAk1AWpzrbDeO7yqVK9IzXCcRdWswZfk3XyO72KiL17HaSy2JkRQThpYEX0JUpRVhO
 X+dnIvcbPWNUzOa9+/a7ou+f5x6K/r5mtKp58UORIA4U4kJST7lE2mnrhZP+r6R67vLN
 N2sq26vGqiJHLSZdrdGTENOwn2PN80WiryBg7UKOPpHuaVuxaY8v0fj+7NKOAyN95lMh
 7rjJyAmQUfdbHEL8bkG/1KlGEGuycuobPQDGJdwmWoeot6cG4Ok9LW2Fpw/hLUNe4RSS
 TNh8+P/+H6XyZFQF03/hElOLSrlH8XUPCvSRgui7u66rraMU08A/TGYA3b3M9MzNkEA8
 XddQ==
Message-ID: <c50ea6d9-2741-8dd3-a176-bee35388d229@blackwall.org>
Date: Thu, 13 Jul 2023 12:34:01 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <20230713070925.3955850-1-idosch@nvidia.com>
 <20230713070925.3955850-5-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20230713070925.3955850-5-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [RFC PATCH net-next 4/4] selftests: net: Add bridge
 backup port and backup nexthop ID test
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: petrm@nvidia.com, taspelund@nvidia.com, roopa@nvidia.com, edumazet@google.com, dsahern@gmail.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

On 13/07/2023 10:09, Ido Schimmel wrote:
> Add test cases for bridge backup port and backup nexthop ID, testing
> both good and bad flows.
> 
> Example truncated output:
> 
>   # ./test_bridge_backup_port.sh
>   [...]
>   Tests passed:  83
>   Tests failed:   0
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>   tools/testing/selftests/net/Makefile          |   1 +
>   .../selftests/net/test_bridge_backup_port.sh  | 759 ++++++++++++++++++
>   2 files changed, 760 insertions(+)
>   create mode 100755 tools/testing/selftests/net/test_bridge_backup_port.sh
> 

Well explained
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

