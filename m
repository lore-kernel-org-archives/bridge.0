Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BF13160C22
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0093260C20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=El/eQRB9yhNDVbsyMGqKU4oQ0Q74MtAF8R0BcKylaqk=;
 b=3v5R4qiBVq9xM6wLqd0c+DpbRhP9+tZtjDzbvwbfeoPESvrF4juCtFgGyLrP+Zfs9E
 /LILszyUzaEEC+48igySPuXXMfC8m1m1d0aP+gp9pUpz0cTNX2hLDRLixS7lC/0hTu9F
 GDN7gbqvP6vXL3j7MVmQzX2XS3UaJixA+3bUQJuz0iOVl16s9lHfGbVJ3KqOZ2Sdrctn
 EhsZtWxk3oZVhnHf3V/xLXYBGKAn6MTkG2L+Kw0DS66OlXjaNUIR3UfcpCONlidkfRQz
 EWWaqAP9aDdLaoTafn6pTNugqWs2ceVbVs15xLojebZQ4ru7pMubAHWfvXsf6l/DW0CO
 h3Ag==
Message-ID: <e69754d3-dead-5477-266b-8618f567ac34@blackwall.org>
Date: Thu, 9 Feb 2023 09:24:11 +0100
MIME-Version: 1.0
Content-Language: en-US
References: <20230209071852.613102-1-idosch@nvidia.com>
 <20230209071852.613102-5-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20230209071852.613102-5-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 4/4] selftests: forwarding: Add MDB
 dump test cases
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: petrm@nvidia.com, mlxsw@nvidia.com, edumazet@google.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

On 2/9/23 09:18, Ido Schimmel wrote:
> The kernel maintains three markers for the MDB dump:
> 
> 1. The last bridge device from which the MDB was dumped.
> 2. The last MDB entry from which the MDB was dumped.
> 3. The last port-group entry that was dumped.
> 
> Add test cases for large scale MDB dump to make sure that all the
> configured entries are dumped and that the markers are used correctly.
> 
> Specifically, create 2 bridges with 32 ports and add 256 MDB entries in
> which all the ports are member of. Test that each bridge reports 8192
> (256 * 32) permanent entries. Do that with IPv4, IPv6 and L2 MDB
> entries.
> 
> On my system, MDB dump of the above is contained in about 50 netlink
> messages.
> 
> Example output:
> 
>   # ./bridge_mdb.sh
>   [...]
>   INFO: # Large scale dump tests
>   TEST: IPv4 large scale dump tests                                   [ OK ]
>   TEST: IPv6 large scale dump tests                                   [ OK ]
>   TEST: L2 large scale dump tests                                     [ OK ]
>   [...]
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> ---
>   .../selftests/net/forwarding/bridge_mdb.sh    | 99 +++++++++++++++++++
>   1 file changed, 99 insertions(+)
> 

Nice!
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

