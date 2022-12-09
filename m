Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AB1B04021C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CA1774014A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YCP7yxwum67RO4mEmEfrq5efv1zflTsiTTb912/2Cfo=;
 b=1VWPNBAAOBd8w1VrQChHA0FhUz/nP/HQtm/dEuGg4NC0jn5kKCgyqPgAwrjvF5de2d
 1P/tjbrdPGHukbd3bFmy2oQmeh8E9Si4WPMhcICddwdyrq/aJ1kGgXOXNUhbzd6kjsWx
 AUnWRkN1xIn6Hy2Wxf63rlc67d3RjlZo4b5O5te2FCCUKuiaL2m+VChM4GPQe5YKWjla
 huxFM4+WuUDNNz2FA8YrZnnM7hIzzZEgYRONYGF7iPyha0bIFBwk5r4x8BPW46nvUkYg
 Yy/lUAwCFZS8amN+HSkMVa/afBXp2HM3II3ji46a2/VLL+bIMiYCNa5wzoOwqTKdFW6X
 08PA==
Message-ID: <23a7a5b5-1fba-b1e0-cbe1-8b1e3b9dbab9@blackwall.org>
Date: Fri, 9 Dec 2022 10:09:55 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20221208152839.1016350-1-idosch@nvidia.com>
 <20221208152839.1016350-15-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20221208152839.1016350-15-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 14/14] selftests: forwarding: Add
	bridge MDB test
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

On 08/12/2022 17:28, Ido Schimmel wrote:
> Add a selftests that includes the following test cases:
> 
> 1. Configuration tests. Both valid and invalid configurations are
>    tested across all entry types (e.g., L2, IPv4).
> 
> 2. Forwarding tests. Both host and port group entries are tested across
>    all entry types.
> 
> 3. Interaction between user installed MDB entries and IGMP / MLD control
>    packets.
> 
> Example output:
> 
> INFO: # Host entries configuration tests
> TEST: Common host entries configuration tests (IPv4)                [ OK ]
> TEST: Common host entries configuration tests (IPv6)                [ OK ]
> TEST: Common host entries configuration tests (L2)                  [ OK ]
> 
> INFO: # Port group entries configuration tests - (*, G)
> TEST: Common port group entries configuration tests (IPv4 (*, G))   [ OK ]
> TEST: Common port group entries configuration tests (IPv6 (*, G))   [ OK ]
> TEST: IPv4 (*, G) port group entries configuration tests            [ OK ]
> TEST: IPv6 (*, G) port group entries configuration tests            [ OK ]
> 
> INFO: # Port group entries configuration tests - (S, G)
> TEST: Common port group entries configuration tests (IPv4 (S, G))   [ OK ]
> TEST: Common port group entries configuration tests (IPv6 (S, G))   [ OK ]
> TEST: IPv4 (S, G) port group entries configuration tests            [ OK ]
> TEST: IPv6 (S, G) port group entries configuration tests            [ OK ]
> 
> INFO: # Port group entries configuration tests - L2
> TEST: Common port group entries configuration tests (L2 (*, G))     [ OK ]
> TEST: L2 (*, G) port group entries configuration tests              [ OK ]
> 
> INFO: # Forwarding tests
> TEST: IPv4 host entries forwarding tests                            [ OK ]
> TEST: IPv6 host entries forwarding tests                            [ OK ]
> TEST: L2 host entries forwarding tests                              [ OK ]
> TEST: IPv4 port group "exclude" entries forwarding tests            [ OK ]
> TEST: IPv6 port group "exclude" entries forwarding tests            [ OK ]
> TEST: IPv4 port group "include" entries forwarding tests            [ OK ]
> TEST: IPv6 port group "include" entries forwarding tests            [ OK ]
> TEST: L2 port entries forwarding tests                              [ OK ]
> 
> INFO: # Control packets tests
> TEST: IGMPv3 MODE_IS_INCLUE tests                                   [ OK ]
> TEST: MLDv2 MODE_IS_INCLUDE tests                                   [ OK ]
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  .../testing/selftests/net/forwarding/Makefile |    1 +
>  .../selftests/net/forwarding/bridge_mdb.sh    | 1164 +++++++++++++++++
>  2 files changed, 1165 insertions(+)
>  create mode 100755 tools/testing/selftests/net/forwarding/bridge_mdb.sh
> 

Nice set of tests!
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


