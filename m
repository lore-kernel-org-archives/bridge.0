Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4317060E4D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AAEEB605B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc; bh=0BQC7ztdjoYB/4v5qeCyLiMyRnHfJxj5E3xif1QgE+s=;
 b=WtihCL79/iOXyOmDf5JkST8Z0eK9w4M590s7E8csWckLrVZRAfYaAYr3J7uWTXLg1L
 XDVxg5QjIXMy83XQhAJDQPbaytxEcjapeiBoukUlSHGdlqebVGDsY9jvqY+XuaKPBOUF
 Jf+aF7pnJK/HhD/pkOO1j7sZPIfD7Uqp0iD7IWS4fN1nPA5fOX58HRVe9CfLz8aqf9tL
 697JLhLr/trHae02me2CdJkE8sChwI31rt/PE2zqnUuaH7BiMdMzv/6ctZcHIgfUBiu6
 z/FwBG/DyeKseCtTpdS8mKko6LtY8jqf/GjSfen6Sw+jn9avfKYcTcwiyx/TLMODq+eN
 sBnQ==
Message-ID: <f7ede054-f0b3-558a-091f-04b4f7139564@blackwall.org>
Date: Sat, 30 Jul 2022 19:21:52 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <cover.1659195179.git.sevinj.aghayeva@gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <cover.1659195179.git.sevinj.aghayeva@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 0/3] net: vlan: fix bridge binding
 behavior and add selftests
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Sevinj Aghayeva <sevinj.aghayeva@gmail.com>, aroulin@nvidia.com
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, sbrivio@redhat.com, Eric Dumazet <edumazet@google.com>, roopa@nvidia.com, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>

On 7/30/22 19:03, Sevinj Aghayeva wrote:
> When bridge binding is enabled for a vlan interface, it is expected
> that the link state of the vlan interface will track the subset of the
> ports that are also members of the corresponding vlan, rather than
> that of all ports.
> 
> Currently, this feature works as expected when a vlan interface is
> created with bridge binding enabled:
> 
>    ip link add link br name vlan10 type vlan id 10 protocol 802.1q \
>          bridge_binding on
> 
> However, the feature does not work when a vlan interface is created
> with bridge binding disabled, and then enabled later:
> 
>    ip link add link br name vlan10 type vlan id 10 protocol 802.1q \
>          bridge_binding off
>    ip link set vlan10 type vlan bridge_binding on
> 
> After these two commands, the link state of the vlan interface
> continues to track that of all ports, which is inconsistent and
> confusing to users. This series fixes this bug and introduces two
> tests for the valid behavior.
> 
> Sevinj Aghayeva (3):
>    net: bridge: export br_vlan_upper_change
>    net: 8021q: fix bridge binding behavior for vlan interfaces
>    selftests: net: tests for bridge binding behavior
> 
>   include/linux/if_bridge.h                     |   9 ++
>   net/8021q/vlan.h                              |   2 +-
>   net/8021q/vlan_dev.c                          |  21 ++-
>   net/bridge/br_vlan.c                          |   7 +-
>   tools/testing/selftests/net/Makefile          |   1 +
>   .../selftests/net/bridge_vlan_binding_test.sh | 143 ++++++++++++++++++
>   6 files changed, 176 insertions(+), 7 deletions(-)
>   create mode 100755 tools/testing/selftests/net/bridge_vlan_binding_test.sh
> 

Hmm.. I don't like this and don't think this bridge function should be 
exported at all.

Calling bridge state changing functions from 8021q module is not the 
proper way to solve this. The problem is that the bridge doesn't know 
that the state has changed, so you can process NETDEV_CHANGE events and 
check for the bridge vlan which got its state changed and react based on 
it. I haven't checked in detail, but I think it should be doable. So all
the logic is kept inside the bridge.

Cheers,
  Nik
